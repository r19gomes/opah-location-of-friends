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
        [HttpGet]
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

        [HttpGet]
        public ActionResult Create()
        {
            int x = 10;
            return View("~/Views/Users/Create.cshtml");
        }

        [HttpGet]
        public ActionResult Edit()
        {
            return View("Edit.cshtml");
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            return View();
        }
    }
}