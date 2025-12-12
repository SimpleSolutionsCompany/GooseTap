
using Microsoft.Extensions.Caching.Distributed;
using SSC.GooseTap.Business.Contracts.Infrastructure;
namespace SSC.GooseTap.Infrastructure.Services
{
    public class RedisCacheService(IDistributedCache cache) : IRedisCacheService
    {
        public async Task<string?> GetAsync(string key)
        {
            return await cache.GetStringAsync(key);
        }

        public async Task SetAsync(string key, string value, TimeSpan? expiry = null)
        {
            var options = new DistributedCacheEntryOptions();
            if (expiry.HasValue)
                options.AbsoluteExpirationRelativeToNow = expiry;

            await cache.SetStringAsync(key, value, options);
        }

        public async Task<bool> DeleteAsync(string key)
        {
            await cache.RemoveAsync(key);
            return true;
        }

        public async Task<long> IncrementAsync(string key, long value = 1)
        {
            var current = await GetAsync(key);
            var newValue = (long.TryParse(current, out var num) ? num : 0) + value;
            await SetAsync(key, newValue.ToString());
            return newValue;
        }

        public async Task<long> DecrementAsync(string key, long value = 1)
        {
            return await IncrementAsync(key, -value);
        }

        public async Task<bool> ExistsAsync(string key)
        {
            var value = await GetAsync(key);
            return value != null;
        }
    }
}
