using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public class UpgradeService(IUnitOfWork unitOfWork) : IUpgradeService
    {
        public async Task<Guid> CreateUpgradeAsync(Upgrade upgrade)
        {
            await unitOfWork.UpgradeRepository.AddAsync(upgrade);
            await unitOfWork.SaveChangesAsync();
            return upgrade.Id;
        }

        public async Task<IEnumerable<Upgrade>> GetAllUpgradesAsync()
        {
            return await unitOfWork.UpgradeRepository.GetAllAsync();
        }

        public async Task<Upgrade?> GetUpgradeByIdAsync(Guid id)
        {
            return await unitOfWork.UpgradeRepository.GetByIdAsync(id);
        }

        public async Task UpdateUpgradeAsync(Upgrade upgrade)
        {
             await unitOfWork.UpgradeRepository.UpdateAsync(upgrade);
             await unitOfWork.SaveChangesAsync();
        }

        public async Task DeleteUpgradeAsync(Guid id)
        {
            var upgrade = await unitOfWork.UpgradeRepository.GetByIdAsync(id);
            if (upgrade != null)
            {
                await unitOfWork.UpgradeRepository.DeleteAsync(upgrade);
                await unitOfWork.SaveChangesAsync();
            }
        }
    }
}
