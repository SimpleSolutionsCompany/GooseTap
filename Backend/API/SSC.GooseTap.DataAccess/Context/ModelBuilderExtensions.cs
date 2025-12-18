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
                    BaseCost = 15,
                    
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Grechka",
                    Description = "Стратегічні запаси гречки.",
                    BaseCost = 3,
                    
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Defense Brain",
                    Description = "Захист від шкідливого впливу.",
                    BaseCost = 5,
                    
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Bench press 100kg",
                    Description = "Сила - це прибуток.",
                    BaseCost = 5,
                    
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Winter Arc",
                    Description = "Щось холодне і прибуткове.",
                    BaseCost = 10,
                    
                },
                new Upgrade
                {
                    Id = Guid.NewGuid(),
                    Name = "Dungeon Master",
                    Description = "Контроль над підземеллям.",
                    BaseCost = 5,
                    
                }
            );
        }
    }
}
