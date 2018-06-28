﻿using Swashbuckle.Application;
using System.Web.Http;

namespace AspNetMvc.Api
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.Routes.MapHttpRoute(
                 name: "RotaSwagger",
                 routeTemplate: "",
                 defaults: null,
                 constraints: null,
                 handler: new RedirectHandler((message => message.RequestUri.ToString()), "swagger"));

            // Rotas da API da Web
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
