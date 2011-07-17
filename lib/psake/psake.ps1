# wrapper for build servers
# ./psake.ps1 Install 0   - invoke target "Install" with revision "0"

import-module .\scripts\psake.psm1

Start-Transcript -Path .\install.log
Write-Host "Using args (revision, application): $args"
invoke-psake $args[0] -properties @{revision=$args[1];application=$args[2]} 

if ($Error -ne '') {
  Write-Host "ERROR: $error";
  exit $error.Count
}

Stop-Transcript

remove-module psake