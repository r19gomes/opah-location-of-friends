using AspNetMvc.Api.Models;
using System.Web.Http;

namespace AspNetMvc.Api.Controllers
{
    public class UsuariosController : ApiController
    {
        private MootitRedeContext db = new MootitRedeContext();

        public IHttpActionResult PostUsuario(Usuario usuario)
        {
            //  Retorna o erro 400.
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            db.Usuarios.Add(usuario);
            db.SaveChanges();

            //  Retorna 201
            return CreatedAtRoute("DefaultApi", new
            {
                id = usuario.UsuarioId
            }, usuario);
        }
    }
}
