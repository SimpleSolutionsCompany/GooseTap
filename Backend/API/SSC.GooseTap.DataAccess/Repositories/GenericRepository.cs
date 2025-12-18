using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class GenericRepository<TEntity>(ApplicationDbContext context) : IRepository<TEntity>
        where TEntity : class
    {
        protected readonly ApplicationDbContext _context = context;
        protected readonly DbSet<TEntity> _dbSet = context.Set<TEntity>();

        public async Task<IEnumerable<TEntity>?> GetAllAsync()
        {
            return await _dbSet.ToListAsync();
        }

        public async Task<TEntity?> GetByIdAsync(Guid id)
        {
            return await _dbSet.FindAsync(id);
        }

        public async Task<Guid> AddAsync(TEntity entity)
        {
            var entry = await _dbSet.AddAsync(entity);
            // Assuming the entity has an Id property of type Guid. 
            // Since TEntity is just 'class', we can use reflection or EF Entry to get key.
            // But relying on "Id" property convention is common.
            try 
            {
                var idProperty = entry.Property("Id");
                if (idProperty != null && idProperty.CurrentValue != null)
                {
                    return (Guid)idProperty.CurrentValue;
                }
            }
            catch {}
            
            return Guid.Empty;
        }

        public async Task<bool> UpdateAsync(Guid id, TEntity entity)
        {
            var existing = await _dbSet.FindAsync(id);
            if (existing == null) return false;

            _context.Entry(existing).CurrentValues.SetValues(entity);
            return true;
        }

        public async Task<bool> DeleteAsync(TEntity entity)
        {
            _dbSet.Remove(entity);
            return Task.FromResult(true).Result;
        }
    }
}
