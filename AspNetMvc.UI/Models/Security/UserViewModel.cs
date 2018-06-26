using PagedList;
using System;
using System.Collections.Generic;

namespace AspNetMvc.UI.Models.Security
{
    [Serializable]
    public class UserViewModel
    {
        public UserViewModel()
        {
            User = new User();
            Users = new List<User>().ToPagedList(1, 1);
            Message = string.Empty;
            Success = false;
            PersistFields = false;  
        }

        public User User { get; set; }

        public String Message { get; set; }

        public bool Success { get; set; }

        public bool PersistFields { get; set; }

        public IPagedList<User> Users { get; set; }

    }
}