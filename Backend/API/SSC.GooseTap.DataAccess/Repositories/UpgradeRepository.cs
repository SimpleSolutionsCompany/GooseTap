using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UpgradeRepository(ApplicationDbContext context) : GenericRepository<Upgrade>(context), IUpgradeRepository
    {
    }
}
