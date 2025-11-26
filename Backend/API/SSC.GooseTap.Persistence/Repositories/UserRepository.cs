using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Persistence.Context;

namespace SSC.GooseTap.Persistence.Repositories
{
    
    
    
    public class UserRepository(ApplicationDbContext applicationDbContext) : IGenericRepository<ApplicationUser>
    {
        public Task AddAsync(ApplicationUser entity)
        {
            throw new NotImplementedException();
        }

        public Task DeleteAsync(ApplicationUser entity)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ApplicationUser>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ApplicationUser>> GetByCondition(Expression<Func<ApplicationUser, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public async Task<ApplicationUser?> GetByIdAsync(string id)
        {
            return await applicationDbContext.Users.FirstOrDefaultAsync(x => x.Id == id);
        }

       

        // public async Task<bool> UpdateAsync(ApplicationUser entity)
        // {
        //     applicationDbContext.Users.Update(entity);
        //     return await applicationDbContext.SaveChangesAsync() > 0;
        // }

        public async Task UpdateAsync(ApplicationUser entity)
        {
            var user = await applicationDbContext.Users.FindAsync(entity.Id);
            if (user != null)
            {
                user.TelegramId = entity.TelegramId;
                user.RefreshToken = entity.RefreshToken;
                user.RefreshTokenExpiryTime = entity.RefreshTokenExpiryTime;
                user.Balance = entity.Balance;
                user.ProfitPerHour = entity.ProfitPerHour;
                user.LastPassiveIncomeClaim = entity.LastPassiveIncomeClaim;
                user.MaxEnergy = entity.MaxEnergy;
                user.CurrentEnergy = entity.CurrentEnergy;
                user.EnergyRestorePerSecond = entity.EnergyRestorePerSecond;
                user.LastEnergyRestoreTime = entity.LastEnergyRestoreTime;
                user.ProfitPerClick = entity.ProfitPerClick;
                user.UserUpgrades = entity.UserUpgrades;

                applicationDbContext.Entry(user).State = EntityState.Modified;
                await applicationDbContext.SaveChangesAsync();
            }
            

        }
    }
}
