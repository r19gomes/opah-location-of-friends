using AspNetMvc.Api.Models;
using System;
using System.Linq;
using System.Net;
using System.Web.Http;

namespace AspNetMvc.Api.Controllers
{
    public class UsuariosController : ApiController
    {
        private OpahRedeContext db = new OpahRedeContext();

        [HttpGet]
        public IHttpActionResult Get(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um numero maior que zero.");

            var usuario = db.Usuarios.Find(id);

            if (usuario == null)
                return NotFound(); // Erro 404

            return Ok(usuario); // Sucesso 200
        }

        [HttpGet]
        public IHttpActionResult Get(int pagina = 1, int tamanhoPagina = 10)
        {
            if (pagina <= 0 || tamanhoPagina <= 0)
                return BadRequest("Os parâmetros página e tamanhoPagina devem ser maiores que zero.");

            if (tamanhoPagina > 10)
                return BadRequest("O tamanho máximo de página permitido é 10.");

            int totalPaginas = (int)Math.Ceiling(db.Usuarios.Count() / Convert.ToDecimal(tamanhoPagina));

            if (pagina > totalPaginas)
                return BadRequest("A páginas solicitada não existe.");

            System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-TotalPages", totalPaginas.ToString());

            if (pagina > 1)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-PreviousPage",
                    Url.Link("DefaultApi", new { pagina = pagina - 1, tamanhoPagina = tamanhoPagina }));

            if (pagina < totalPaginas)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-NextPage",
                    Url.Link("DefaultApi", new { pagina = pagina + 1, tamanhoPagina = tamanhoPagina }));

            var usuarios = db.Usuarios.OrderBy(c => c.CadastroDataHora).Skip(tamanhoPagina * (pagina - 1)).Take(tamanhoPagina);

            return Ok(usuarios);
        }

        [HttpPost]
        public IHttpActionResult Post(Usuario usuario)
        {
            //  Retorna o erro 400.
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            //  Se valido, adiciona o registro.
            db.Usuarios.Add(usuario);
            db.SaveChanges();

            //  Retorna 201
            return CreatedAtRoute("DefaultApi", new
            {
                id = usuario.UsuarioId
            }, usuario);
        }

        [HttpPut]
        public IHttpActionResult Put(int id, Usuario usuario)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState); // Erro 400

            if (id != usuario.UsuarioId)
                return BadRequest("O id informado a URL é diferente do id informado no corpo da requisição");

            if (db.Usuarios.Count(c => c.UsuarioId == id) == 0)
                return NotFound();

            db.Entry(usuario).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpDelete]
        public IHttpActionResult Delete(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um número maior que zero.");

            var usuario = db.Usuarios.Find(id);

            if (usuario == null)
                return NotFound();

            db.Usuarios.Remove(usuario);
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

    }
}
