using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AspNetMvc.UI.Models.Security;
using PagedList;

namespace AspNetMvc.UI.Controllers
{
    public class UsersController : Controller
    {
        // GET: Users
        public ActionResult Index(int page = 1)
        {
            var vw = new UserViewModel();
            int pageSize = Convert.ToInt16
                (ConfigurationManager.AppSettings["QuantityRegistrationPage"]);
            int pageNumber = page;

            var users = Services.Security.User.UserList(new Models.Security.User
            {
            });
            if (users != null)
                vw.Users = users.ToPagedList(pageNumber, pageSize);

            return View(vw);
        }
    }
}