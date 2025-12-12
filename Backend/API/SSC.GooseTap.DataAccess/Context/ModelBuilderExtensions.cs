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
                    Description = "Фанати з Італії приносять дохід.",
                    BaseCost = 15000,
                    BaseProfitPerHour = 1610
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Grechka",
                    Description = "Стратегічні запаси гречки.",
                    BaseCost = 30000,
                    BaseProfitPerHour = 2200
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Defense Brain",
                    Description = "Захист від шкідливого впливу.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Bench press 100kg",
                    Description = "Сила - це прибуток.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Winter Arc",
                    Description = "Щось холодне і прибуткове.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Dungeon Master",
                    Description = "Контроль над підземеллям.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                }
            );
        }
    }
}
