
namespace SSC.GooseTap.Domain.Interfaces
{
    public interface IUnitOfWork
    {
        IUserRepository UserRepository { get; }
        IUpgradeRepository UpgradeRepository { get; }
        Task<int> SaveChangesAsync();
    }
}
