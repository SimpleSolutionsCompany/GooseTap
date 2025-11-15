using Application.Contracts.Persistence;
using Domain.Models;
using Microsoft.EntityFrameworkCore;
using Persistence.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Persistence.Repositories
{
    public class UserRepository : IGenericRepository<ApplicationUser>
    {
        private readonly ApplicationDbContext _context;

        public UserRepository(ApplicationDbContext applicationDbContext)
        {
            _context = applicationDbContext;
        }

        public Task<bool> AddAsync(ApplicationUser entity)
        {
            throw new NotImplementedException();
        }

        public Task<bool> DeleteAsync(ApplicationUser entity)
        {
            throw new NotImplementedException();
        }

        public Task<IEnumerable<ApplicationUser>> GetAllAsync()
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<ApplicationUser>> GetByCondition(Func<ApplicationUser, bool> predicate)
        {
            throw new NotImplementedException();
        }

        public async Task<ApplicationUser> GetByIdAsync(string id)
        {
            return await _context.Users.FirstOrDefaultAsync(x => x.Id == id);
        }

        public Task SaveChangesAsync()
        {
            throw new NotImplementedException();
        }

        public async Task<bool> UpdateAsync(ApplicationUser entity)
        {
            _context.Users.Update(entity);
            return await _context.SaveChangesAsync() > 0;
        }

        public async Task<bool> UpdateAsync(ApplicationUser entity)
        {
            var user = await _context.Users.FindAsync(entity.Id);
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

                _context.Entry(user).State = EntityState.Modified;
                await _context.SaveChangesAsync();
            }

        }
    }
}
