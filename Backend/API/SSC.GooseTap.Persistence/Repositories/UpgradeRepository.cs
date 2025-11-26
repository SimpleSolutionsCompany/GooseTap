using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Persistence.Context;


namespace SSC.GooseTap.Persistence.Repositories
{
    public class UpgradeRepository(ApplicationDbContext applicationDbContext) : IGenericRepository<Upgrade>
    {
        public Task AddAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        public Task DeleteAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        

        public Task<IEnumerable<Upgrade>> GetByCondition(Expression<Func<Upgrade, bool>> predicate)
        {
            throw new NotImplementedException();
        }

        public  async Task<Upgrade?> GetByIdAsync(string id)
        {
            return await applicationDbContext.Upgrades.Where(u => u.Id == id).AsNoTracking().FirstOrDefaultAsync();
        }

        

        public Task UpdateAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Upgrade>> GetAllAsync()
        {
            return await applicationDbContext.Upgrades.ToListAsync();
        }
    }
}
