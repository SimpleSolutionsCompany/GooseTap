using Application.Contracts.Persistence;
using Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Services
{
    public class UpgradeService
    {
        private readonly IUnitOfWork _unitOfWork;
        public UpgradeService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<IEnumerable<Upgrade>> GetAllUpgrades()
        {
            return await _unitOfWork.UpgradeReposiotry.GetAllAsync();
        }
    }
}
