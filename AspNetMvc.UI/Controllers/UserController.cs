using AspNetMvc.UI.Models.Security;
using PagedList;
using System;
using System.Configuration;
using System.Web.Mvc;

namespace AspNetMvc.UI.Controllers
{
    public class UserController : Controller
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
            return View();
        }

        [HttpPost]
        [ActionName("Create")]
        public ActionResult Create(UserViewModel model)
        {
            if (ModelState.IsValid)
            {
                var ret = Services.Security.User.UserCreate(model);
                if (!ret.Success)
                {
                    return View(ret);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            else
            {
                return View(model);
            }
        }

        [HttpGet]
        public ActionResult Edit(User user)
        {
            if (user == null)
                user = new User();

            var UsuarioId = user.UsuarioId;

            return View(new UserViewModel
            {
                Message = string.Empty,
                Success = false,
                PersistFields = false,
                User = user
            });
        }

        [HttpGet]
        public ActionResult Delete(int id)
        {
            return View();
        }
    }
}