using Domain.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistence.Context
{
    public class ApplicationDbContext:IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
        {
        
        }

      
        public DbSet<Upgrade> Upgrades { get; set; }
        public DbSet<UserUpgrade> UserUpgrades { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {

            base.OnModelCreating(builder);


            builder.Entity<ApplicationUser>(entity =>
            {
                entity.HasIndex(u => u.TelegramId).IsUnique();
            });
            
            builder.Entity<Upgrade>(entity =>
            {
                entity.HasKey(u => u.Id);
            });

            
            builder.Entity<UserUpgrade>(entity =>
            {
                entity.HasKey(uu => new { uu.ApplicationUserId, uu.UpgradeId });

                entity.HasOne(uu => uu.ApplicationUser)
                    .WithMany(u => u.UserUpgrades)
                    .HasForeignKey(uu => uu.ApplicationUserId);

                entity.HasOne(uu => uu.Upgrade)
                    .WithMany(u => u.UserUpgrades)
                    .HasForeignKey(uu => uu.UpgradeId);
            });

            builder.Entity<Upgrade>().HasData(
                new Upgrade
                {
                    Id = "italia",
                    Name = "ITALLIIAAA!!!",
                    Description = "Фанати з Італії приносять дохід.",
                    BaseCost = 15000,
                    BaseProfitPerHour = 1610
                },
                new Upgrade
                {
                    Id = "grechka",
                    Name = "Grechka",
                    Description = "Стратегічні запаси гречки.",
                    BaseCost = 30000,
                    BaseProfitPerHour = 2200
                },
                new Upgrade
                {
                    Id = "defense_brain",
                    Name = "Defense Brain",
                    Description = "Захист від шкідливого впливу.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = "bench_press_100kg",
                    Name = "Bench press 100kg",
                    Description = "Сила - це прибуток.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = "winter_arc",
                    Name = "Winter Arc",
                    Description = "Щось холодне і прибуткове.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                },
                new Upgrade
                {
                    Id = "dungeon_master",
                    Name = "Dungeon Master",
                    Description = "Контроль над підземеллям.",
                    BaseCost = 50000,
                    BaseProfitPerHour = 5500
                }
            );
        


        }
    }
}
