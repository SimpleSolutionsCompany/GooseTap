using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UnitOfWork(ApplicationDbContext applicationDbContext) : IUnitOfWork
    {
        private IUserRepository? _userRepository;
        private IUpgradeRepository? _upgradeRepository;

        public IUserRepository UserRepository => _userRepository ??= new UserRepository(applicationDbContext);
        public IUpgradeRepository UpgradeRepository => _upgradeRepository ??= new UpgradeRepository(applicationDbContext);

        public async Task<int> SaveChangesAsync()
        {
            return await applicationDbContext.SaveChangesAsync();
        }
    }
}
