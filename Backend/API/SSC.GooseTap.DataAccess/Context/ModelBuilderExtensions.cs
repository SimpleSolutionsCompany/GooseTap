using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.DataAccess.Context
{
    public static class ModelBuilderExtensions
    {
        public static void Seed(this ModelBuilder builder)
        {
            builder.Entity<Upgrade>().HasData(
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "ITALLIIAAA!!!",
                    Description = "Multitap",
                    BaseCost = 15,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Grechka",
                    Description = "Multitap",
                    BaseCost = 3,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Defense Brain",
                    Description = "Multitap",
                    BaseCost = 5,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Bench press 100kg",
                    Description = "Multitap",
                    BaseCost = 5,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Winter Arc",
                    Description = "Multitap",
                    BaseCost = 10,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Dungeon Master",
                    Description = "Multitap",
                    BaseCost = 5,
                    BoosterType = BoosterType.Multitap
                }
            );
        }
    }
}
