using PagedList;
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace AspNetMvc.UI.Models.Security
{
    [Serializable]
    public class UserViewModel
    {
        public UserViewModel()
        {
            User = new User();
            Users = new List<User>().ToPagedList(1, 1);
            Mensagem = "";
        }

        public User User { get; set; }

        public String Mensagem { get; set; }

        public IPagedList<User> Users { get; set; }

    }
}