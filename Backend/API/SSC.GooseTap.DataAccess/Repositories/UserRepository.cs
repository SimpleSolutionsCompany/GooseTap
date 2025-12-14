using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UserRepository(ApplicationDbContext applicationDbContext) : GenericRepository<ApplicationUser>(applicationDbContext), IUserRepository
    {
        public async Task<IEnumerable<ApplicationUser>> GetUserByTgIdAsync(string tgId)
        {
             return await _dbSet.Where(x => x.TelegramId == tgId).ToListAsync();
        }

        public async Task<ApplicationUser?> GetByTgIdAsync(string id)
        {
            return await _dbSet
                .Include(u => u.UserUpgrades)!
                .ThenInclude(uu => uu.Upgrade)
                .FirstOrDefaultAsync(u => u.TelegramId == id);
        }

        public override async Task<ApplicationUser?> GetByIdAsync(Guid id)
        {
            return await _dbSet
                .Include(u => u.UserUpgrades)!
                .ThenInclude(uu => uu.Upgrade)
                .FirstOrDefaultAsync(u => u.Id == id);
        }
    }
}
