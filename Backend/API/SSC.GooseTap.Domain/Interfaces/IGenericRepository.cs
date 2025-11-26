

using System.Linq.Expressions;

namespace SSC.GooseTap.Domain.Interfaces
{
    public interface IGenericRepository<T> where T : class
    {
        Task<T?> GetByIdAsync(string id);
        Task<IEnumerable<T>> GetAllAsync();

        Task AddAsync(T entity);

        Task UpdateAsync(T entity);

        Task DeleteAsync(T entity);

        

        Task<IEnumerable<T>> GetByCondition(Expression<Func<T,bool>> predicate);



    }
}
