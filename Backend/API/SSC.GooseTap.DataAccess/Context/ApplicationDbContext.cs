using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.DataAccess.Context
{
    public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
       : IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>(options)
    {
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

            builder.Seed();
        


        }
    }
}
