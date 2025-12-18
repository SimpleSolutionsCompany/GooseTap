using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Domain.Interfaces;

public interface IUserRepository: IRepository<ApplicationUser>
{
    Task<IEnumerable<ApplicationUser>> GetUserByTgIdAsync(string tgId);
    Task<ApplicationUser?> GetByTgIdAsync(string tgId);
    Task<ApplicationUser?> GetByIdWithUpgradesAsync(Guid id);
}