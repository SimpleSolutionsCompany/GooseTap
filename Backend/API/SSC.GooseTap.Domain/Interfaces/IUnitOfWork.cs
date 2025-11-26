
namespace SSC.GooseTap.Domain.Interfaces
{
    public interface IUnitOfWork
    {
        
       
        Task<int> SaveChangesAsync();
    }
}
