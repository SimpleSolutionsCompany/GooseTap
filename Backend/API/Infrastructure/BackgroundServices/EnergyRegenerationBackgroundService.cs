using Application.Contracts.Infrastructure;
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
    public class EnergyRegenerationBackgroundService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private readonly ILogger<EnergyRegenerationBackgroundService> _logger;

        public EnergyRegenerationBackgroundService(
            IServiceProvider serviceProvider,
            ILogger<EnergyRegenerationBackgroundService> logger)
        {
            _serviceProvider = serviceProvider;
            _logger = logger;
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("⚡ Energy Regeneration Service started");

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    await Task.Delay(TimeSpan.FromSeconds(10), stoppingToken);

                    using var scope = _serviceProvider.CreateScope();
                    var redis = scope.ServiceProvider.GetRequiredService<IRedisCacheService>();

                    // TODO: Логіка відновлення енергії
                    _logger.LogInformation("Regenerating energy for active users...");
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Error in Energy Regeneration Service");
                }
            }
        }
    }
}
