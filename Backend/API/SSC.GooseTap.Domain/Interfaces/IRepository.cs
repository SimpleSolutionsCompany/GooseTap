namespace SSC.GooseTap.Domain.Interfaces;

public interface IRepository<T> where T : class
{
    public Task<T?> GetByIdAsync(Guid id);
    public Task<IEnumerable<T>?> GetAllAsync();
    public Task<Guid> AddAsync(T entity);
    public Task<bool>  UpdateAsync(Guid id,T entity);
    public Task<bool> DeleteAsync(T entity);
}