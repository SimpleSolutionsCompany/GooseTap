using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UnitOfWork(ApplicationDbContext context,
        IUserRepository userRepository,
        IUpgradeRepository upgradeRepository) : IUnitOfWork
    {
        
        public IUserRepository Users => userRepository;
        public IUpgradeRepository Upgrades => upgradeRepository;

        public async Task<int> SaveChangesAsync()
        {
            return await context.SaveChangesAsync();
        }
    }
}
