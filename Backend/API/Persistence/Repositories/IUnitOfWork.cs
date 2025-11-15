using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Domain.Models;
using Persistence.Repositories;

namespace Application.Contracts.Persistence
{
    public interface IUnitOfWork
    {
        IGenericRepository<Upgrade> UpgradeReposiotry { get; }
        IGenericRepository<ApplicationUser> UserRepository { get; }
        //TODO: Add other repositories
    }
}
