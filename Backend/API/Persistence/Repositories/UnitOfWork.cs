using Application.Contracts.Persistence;
using Domain.Models;
using Persistence.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace Persistence.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext _context;
        private  IGenericRepository<Upgrade> _upgradeRepository;
        private IGenericRepository<ApplicationUser> _userRepository;
        public UnitOfWork(ApplicationDbContext applicationDbContext)
        {
            _context = applicationDbContext;
           
        }
        public IGenericRepository<Upgrade> UpgradeReposiotry {
            get { return _upgradeRepository ??= new UpgradeRepository(_context); }
        }
        public IGenericRepository<ApplicationUser> UserRepository
        {
            get { return _userRepository ??= new UserRepository(_context); }
        }
    }
}
