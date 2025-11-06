using Application.Contracts.Infrastructure;
using Microsoft.Extensions.Caching.Distributed;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Services
{
    public class RedisCacheService : IRedisCacheService
    {
        private readonly IDistributedCache _cache;

        public RedisCacheService(IDistributedCache cache)
        {
            _cache = cache;
        }

        public async Task<string?> GetAsync(string key)
        {
            return await _cache.GetStringAsync(key);
        }

        public async Task SetAsync(string key, string value, TimeSpan? expiry = null)
        {
            var options = new DistributedCacheEntryOptions();
            if (expiry.HasValue)
                options.AbsoluteExpirationRelativeToNow = expiry;

            await _cache.SetStringAsync(key, value, options);
        }

        public async Task<bool> DeleteAsync(string key)
        {
            await _cache.RemoveAsync(key);
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
