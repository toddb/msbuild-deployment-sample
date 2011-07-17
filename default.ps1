$framework = '4.0x64'

properties { 
  $revision = 0
  $version = "0.1.0"
  
  $solution = "Sample"
  
  $base_dir  = resolve-path .
  $configuration = "bin\x64\Release"
  $lib_dir = "$base_dir\lib"
  $tools_dir = "$base_dir\tools"
  $build_dir = "$base_dir\CodeToDeploy" 
  $release_dir = "$build_dir\Release"
  $extract_dir = "$build_dir\Deploy"
  $publish_dir = "$build_dir\Publish"
  
  $sln_file = "$base_dir\src\$solution.sln"

  $provider = "SqlLite"
  $migrationsAssembly = "$base_dir\src\Infrastructure\$configuration\Infrastructure.dll"
  $to = -1
}

Task Install -Depends Package, Extract, Deploy

Task Package -Description "Compiles and Packages the solution into a zip file"{

  Write-Host Building version: "$version.$revision"
  Write-Host Running: exec {msbuild /t:package /p:Revision=$revision}	
  exec {msbuild /t:package /p:Revision=$revision } "Error packaging: msbuild /t:package /p:Revision=$revision"
}

Task Extract -Description "Unzips the packing zip archive" {
  exec {msbuild /t:extract /p:Revision=$revision } 
}

Task Deploy -Description "Runs the Install.bat file" {
  exec {msbuild /t:deploy }
}

Task Migrate -Description "Apply migrations to a specific version - default is latest" -Depends Migrate-Setup {
  exec { .\CodeToDeploy\Publish\lib\migratordotnet\Migrator.Console.exe $provider $migrationsAssembly -version $to }
}

Task Migrate-Reset -Depends Migrate-Down, Migrate-Up -Description "Removes all migrates and then up to the latest version" 

Task Migrate-Down -Description "Removes all migrations" {
  exec { .\CodeToDeploy\Publish\lib\migratordotnet\Migrator.Console.exe $provider $migrationsAssembly -version 0 }
}

Task Migrate-Up -Description "Migrates to latest version" {
  exec { .\CodeToDeploy\Publish\lib\migratordotnet\Migrator.Console.exe $provider $migrationsAssembly -version -1 }
}

