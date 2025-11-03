using Application.Contracts.Infrastructure;
using Application.Contracts.Persistence;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.BackgroundServices
{
    public class TappedCoinsFlushBackgroundService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly ILogger<TappedCoinsFlushBackgroundService> _logger;

        public TappedCoinsFlushBackgroundService(
            IServiceProvider serviceProvider,
            ILogger<TappedCoinsFlushBackgroundService> logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("💰 TappedCoins Flush Service started");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await Task.Delay(TimeSpan.FromMinutes(5), stoppingToken);

                    using var scope = _serviceProvider.CreateScope();
                    var redis = scope.ServiceProvider.GetRequiredService<IRedisCacheService>();
                    var unitOfWork = scope.ServiceProvider.GetRequiredService<IUnitOfWork>();

                    // TODO: Логіка синхронізації tapped_coins → SQL
                    _logger.LogInformation("Flushing tapped coins to database...");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error in TappedCoins Flush Service");
                }
            }
        }
    }
}
