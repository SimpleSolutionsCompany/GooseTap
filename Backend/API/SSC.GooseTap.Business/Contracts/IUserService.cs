using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Contracts
{
    public interface IUserService
    {
        Task<ApplicationUser?> GetUserByIdAsync(Guid id);
        Task<ApplicationUser?> GetUserByTgIdAsync(string tgId);
        // Task CreateUserAsync(ApplicationUser user); // Usually auth handles creation, but for CRUD completeness
        Task UpdateUserAsync(ApplicationUser user);
        Task DeleteUserAsync(Guid id);
        Task<IEnumerable<ApplicationUser>> GetAllUsersAsync();
    }
}
