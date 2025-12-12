

using System.Linq.Expressions;

namespace SSC.GooseTap.Domain.Interfaces;

    public interface IGenericRepository<T> 
    {
        Task<T?> GetByIdAsync(Guid id);
        Task<IEnumerable<T>> GetAllAsync();

        Task AddAsync(T entity);

        Task UpdateAsync(T entity);

        Task DeleteAsync(T entity);

        

       



    }

