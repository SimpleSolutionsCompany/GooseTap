using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Domain.Interfaces;

namespace SSC.GooseTap.Business.Services
{
    public class UpgradeService(IGenericRepository<Upgrade> repository)
    {
        

        public async Task<IEnumerable<Upgrade>> GetAllUpgrades()
        {
            return await repository.GetAllAsync();
        }
    }
}
