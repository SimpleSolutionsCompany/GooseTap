using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Persistence.Context;

namespace SSC.GooseTap.Persistence.Repositories
{
    public class UnitOfWork(ApplicationDbContext applicationDbContext) : IUnitOfWork
    {
        public async Task<int> SaveChangesAsync()
        {
            
            return await applicationDbContext.SaveChangesAsync();
        }
    }
}
