using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.DataAccess.Repositories;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UserRepository(ApplicationDbContext context) : GenericRepository<ApplicationUser>(context), IUserRepository
    {
        public async Task<ApplicationUser?> GetByTgIdAsync(string tgId)
        {
            // Include UserUpgrades so we know what they have bought
            return await _context.Users
                .Include(u => u.UserUpgrades)
                .FirstOrDefaultAsync(u => u.TelegramId == tgId);
        }

        public async Task<IEnumerable<ApplicationUser>> GetUserByTgIdAsync(string tgId)
        {
             // This interface method seems slightly redundant with GetByTgIdAsync but keeping for interface compliance
             // Logic suggests finding "User" by ID, but return type is IEnumerable. 
             // Assuming match by substring or just exact match in a list? 
             // Implementing strict match for now.
             var user = await GetByTgIdAsync(tgId);
             return user != null ? new List<ApplicationUser> { user } : new List<ApplicationUser>();
        }

        public async Task<ApplicationUser?> GetByIdWithUpgradesAsync(Guid id)
        {
            return await _context.Users
                .Include(u => u.UserUpgrades)
                .FirstOrDefaultAsync(u => u.Id == id);
        }
    }
}
