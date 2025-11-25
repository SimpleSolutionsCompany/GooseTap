using Application.Contracts.Persistence;
using Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application.Services
{
    public class UserService
    {
        private readonly IUnitOfWork _unitOfWork;
        public UserService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<ApplicationUser> GetUserByIdAsync(string id) 
            => await _unitOfWork.UserRepository.GetByIdAsync(id);

        public async Task<bool> UpdateUserAsync(ApplicationUser applicationUser)
            => await _unitOfWork.UserRepository.UpdateAsync(applicationUser);
    }
}
