
namespace SSC.GooseTap.Domain.Interfaces
{
    public interface IUnitOfWork
    {
        IUserRepository Users { get; }
        IUpgradeRepository Upgrades { get; }
        Task<int> SaveChangesAsync();
    }
}
