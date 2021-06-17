using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        class User
        {
            public static String CNIC = "";
            public static String Email = "";
            public static String Password = "";
        }

        public ActionResult HomePage()
        {
            return View();
        }
        public ActionResult aboutUs()
        {
            return View();
        }
        public ActionResult Index()
        {
            return View("Login");
        }


        [HttpGet]
        public ActionResult Login()
        {
            using(zionRecruitEntities1 z = new zionRecruitEntities1())
            {
                string e, p;
                e = Request.QueryString["email"];
                p = Request.QueryString["password"];
                var UserDets = z.Users.Where(v => v.Email == e && v.Password == p).FirstOrDefault();
                if(UserDets == null)
                {
                    return View();
                }
                else
                {
                    return View("Dashboard");
                }
            }
        }

        public ActionResult dashboard()
        {
            return View();
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpGet]
        public ActionResult RegisterUser() 
        {
            using (zionRecruitEntities1 x = new zionRecruitEntities1())
            {
                WebApplication1.User u = new WebApplication1.User();
                u.UserName = Request.QueryString["name"];
                u.Email = Request.QueryString["email"];
                u.Password = Request.QueryString["password"];
                u.Qualification = Request["qaulification"];
                u.MobileNumber = Request.QueryString["phone"];
                u.IsCvUploaded = false;
                u.UserId = 20;

                x.Users.Add(u);
                int r = x.SaveChanges();

                if(r > 0)
                {
                    return View("Dashboard");
                }
                else
                {
                    return View("Register");
                }
            }
            return View();
        }

        public ActionResult AddJob()
        {
            using(zionRecruitEntities1 z = new zionRecruitEntities1())
            {
                WebApplication1.JobDetail j = new WebApplication1.JobDetail();
            }
        }
    }
}