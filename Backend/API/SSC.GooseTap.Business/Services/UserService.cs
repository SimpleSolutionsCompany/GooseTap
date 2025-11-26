using SSC.GooseTap.Domain.Models;
using SSC.GooseTap.Domain.Interfaces;

namespace SSC.GooseTap.Business.Services
{
    public class UserService(IGenericRepository<ApplicationUser> repository)
    {
        public async Task<ApplicationUser?> GetUserByIdAsync(string id) 
            => await repository.GetByIdAsync(id);

        public async Task UpdateUserAsync(ApplicationUser applicationUser)
            => await repository.UpdateAsync(applicationUser);
    }
}
