using Migrator.Framework;
using System.Data;

namespace Infrastructure.Database.Migrations
{
    [Migration(200906071500)]
    public class Migr001CreateSampleTable : Migration
    {

        public override void Up()
        {
            Database.AddTable("Sample",
                              new Column("Id", DbType.Int32, ColumnProperty.PrimaryKeyWithIdentity),
                              new Column("Name", DbType.String, 50, ColumnProperty.NotNull),
                              new Column("Description", DbType.String, 200),
                              new Column("Url", DbType.String, 200, ColumnProperty.NotNull),
                              new Column("IsActive", DbType.Boolean, ColumnProperty.NotNull, true),
                              new Column("IsDeleted", DbType.Boolean, ColumnProperty.NotNull, false)
                );
        }

        public override void Down()
        {
            Database.RemoveTable("Sample");
        }
    }
}