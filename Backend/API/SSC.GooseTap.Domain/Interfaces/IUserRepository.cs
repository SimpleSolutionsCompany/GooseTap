using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Domain.Interfaces;

public interface IUserRepository: IGenericRepository<ApplicationUser>
{
    Task<IEnumerable<ApplicationUser>> GetUserByTgIdAsync(string tgId);
    Task<ApplicationUser?> GetByTgIdAsync(string tgId);
}