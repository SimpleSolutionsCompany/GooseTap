using Microsoft.EntityFrameworkCore;
using SSC.GooseTap.DataAccess.Context;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.DataAccess.Repositories
{
    public class UpgradeRepository(ApplicationDbContext applicationDbContext) : GenericRepository<Upgrade>(applicationDbContext), IUpgradeRepository
    {
        // Add specific methods here if needed in the future
    }
}
