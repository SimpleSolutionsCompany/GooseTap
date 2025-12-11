using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Contracts
{
    public interface IUpgradeService
    {
        Task<Guid> CreateUpgradeAsync(Upgrade upgrade);
        Task<IEnumerable<Upgrade>> GetAllUpgradesAsync();
        Task<Upgrade?> GetUpgradeByIdAsync(Guid id);
        Task UpdateUpgradeAsync(Upgrade upgrade);
        Task DeleteUpgradeAsync(Guid id);
    }
}
