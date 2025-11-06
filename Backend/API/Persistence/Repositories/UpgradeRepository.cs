using Application.Contracts.Persistence;
using Domain.Models;
using Microsoft.EntityFrameworkCore;
using Persistence.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Persistence.Repositories
{
    public class UpgradeRepository:IGenericRepository<Upgrade>
    {
        private readonly ApplicationDbContext _context;





        public UpgradeRepository(ApplicationDbContext applicationDbContext) {
            _context = applicationDbContext;
        }

        public Task<bool> AddAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        public Task<bool> DeleteAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        

        public async Task<IEnumerable<Upgrade>> GetByCondition(Func<Upgrade, bool> predicate)
        {
            throw new NotImplementedException();
        }

        public  async Task<Upgrade> GetByIdAsync(string id)
        {
            return await _context.Upgrades.FirstOrDefaultAsync(u => u.Id == id);
        }

        public Task SaveChangesAsync()
        {
            throw new NotImplementedException();
        }

        public Task<bool> UpdateAsync(Upgrade entity)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Upgrade>> GetAllAsync()
        {
            return await _context.Upgrades.ToListAsync();
        }
    }
}
