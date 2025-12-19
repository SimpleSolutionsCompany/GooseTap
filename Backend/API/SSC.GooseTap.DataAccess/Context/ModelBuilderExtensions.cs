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
                    Description = "Increase profit per tap",
                    BaseCost = 15,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Grechka",
                    Description = "Increase profit per tap",
                    BaseCost = 3,
                    BoosterType = BoosterType.Multitap
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Defense Brain",
                    Description = "Increase maximum energy",
                    BaseCost = 5,
                    BoosterType = BoosterType.EnergyLimit
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Bench press 100kg",
                    Description = "Increase maximum energy",
                    BaseCost = 5,
                    BoosterType = BoosterType.EnergyLimit
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Winter Arc",
                    Description = "Increase energy recovery speed",
                    BaseCost = 10,
                    BoosterType = BoosterType.RestoreEnergyPerSecond
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Dungeon Master",
                    Description = "Increase energy recovery speed",
                    BaseCost = 5,
                    BoosterType = BoosterType.RestoreEnergyPerSecond
                }
            );
        }
    }
}
