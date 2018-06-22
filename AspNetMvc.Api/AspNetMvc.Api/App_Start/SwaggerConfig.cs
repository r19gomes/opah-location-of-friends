using System.Web.Http;
using WebActivatorEx;
using VisualTurismo.APIs.Services.Service;
using Swashbuckle.Application;
using System.Configuration;

[assembly: PreApplicationStartMethod(typeof(SwaggerConfig), "Register")]

namespace VisualTurismo.APIs.Services.Service
{
    public class SwaggerConfig
    {
        public static void Register()
        {
            bool disableSwagger = true;
            try
            {
                disableSwagger = bool.Parse(ConfigurationManager.AppSettings["DisableSwagger"]);
            }
            catch
            {
                disableSwagger = true;
            }

            if (disableSwagger)
                return;

            var thisAssembly = typeof(SwaggerConfig).Assembly;

            GlobalConfiguration.Configuration
                .EnableSwagger(c =>
                {
                    c.SingleApiVersion("v1", "AspNetMvc.Api");
                })
                .EnableSwaggerUi(c =>
                {
                });
        }
    }
}
