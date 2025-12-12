using SSC.GooseTap.Business.Contracts;
using SSC.GooseTap.Domain.Interfaces;
using SSC.GooseTap.Domain.Models;

namespace SSC.GooseTap.Business.Services
{
    public class UserService(IUnitOfWork unitOfWork) : IUserService
    {
        public async Task<ApplicationUser?> GetUserByTgIdAsync(string tgId)
            => await unitOfWork.UserRepository.GetByTgIdAsync(tgId);

        public async Task<ApplicationUser?> GetUserByIdAsync(Guid id)
            => await unitOfWork.UserRepository.GetByIdAsync(id);

        public async Task UpdateUserAsync(ApplicationUser applicationUser)
        {
            await unitOfWork.UserRepository.UpdateAsync(applicationUser);
            // Assuming the repo implementation calls SaveChangesAsync internally for specific user updates or we need to call it here.
            // In the GenericRepo implementation, UpdateAsync just sets the state. 
            // So we MUST call unitOfWork.SaveChangesAsync().
            // Wait, previous UserRepository.UpdateAsync DID call SaveChangesAsync.
            // My NEW GenericRepository implementation does NOT call SaveChangesAsync.
            // My NEW UserRepository.UpdateAsync OVERRIDE (which I decided NOT to override but rely on generic? No I KEPT the manual one but commented out... wait).
            
            // Let's recall Step 59 where I overwrote UserRepository.
            // I REMOVED the specific UpdateAsync implementation and relied on GenericRepository.
            // GenericRepository.UpdateAsync: _context.Entry(entity).State = EntityState.Modified; return Task.CompletedTask;
            
            // SO: The Service MUST call SaveChangesAsync.
            
            await unitOfWork.SaveChangesAsync();
        }

        public async Task DeleteUserAsync(Guid id)
        {
            var user = await unitOfWork.UserRepository.GetByIdAsync(id);
            if (user != null)
            {
                await unitOfWork.UserRepository.DeleteAsync(user);
                await unitOfWork.SaveChangesAsync();
            }
        }

        public async Task<IEnumerable<ApplicationUser>> GetAllUsersAsync()
        {
            return await unitOfWork.UserRepository.GetAllAsync();
        }
    }
}
