using AspNetMvc.Api.Models;
using System;
using System.Linq;
using System.Net;
using System.Web.Http;

namespace AspNetMvc.Api.Controllers
{
    public class UsuariosTiposController : ApiController
    {
        private OpahRedeContext db = new OpahRedeContext();

        [HttpGet]
        public IHttpActionResult Get(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um numero maior que zero.");

            var usuarioTipo = db.UsuariosTipos.Find(id);

            if (usuarioTipo == null)
                return NotFound(); // Erro 404

            return Ok(usuarioTipo); // Sucesso 200
        }

        [HttpGet]
        public IHttpActionResult Get(int pagina = 1, int tamanhoPagina = 10)
        {
            if (pagina <= 0 || tamanhoPagina <= 0)
                return BadRequest("Os parâmetros página e tamanhoPagina devem ser maiores que zero.");

            if (tamanhoPagina > 10)
                return BadRequest("O tamanho máximo de página permitido é 10.");

            int totalPaginas = (int)Math.Ceiling
                (db.UsuariosTipos.Count() / Convert.ToDecimal(tamanhoPagina));

            if (pagina > totalPaginas)
                return BadRequest("A páginas solicitada não existe.");

            System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-TotalPages", totalPaginas.ToString());

            if (pagina > 1)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-PreviousPage",
                    Url.Link("DefaultApi", new { pagina = pagina - 1, tamanhoPagina = tamanhoPagina }));

            if (pagina < totalPaginas)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-NextPage",
                    Url.Link("DefaultApi", new { pagina = pagina + 1, tamanhoPagina = tamanhoPagina }));

            var usuariosTipos = db.UsuariosTipos
                .OrderBy(c => c.CadastroDataHora)
                    .Skip(tamanhoPagina * (pagina - 1)).Take(tamanhoPagina);

            return Ok(usuariosTipos);
        }

        [HttpPost]
        public IHttpActionResult Post(UsuarioTipo usuarioTipo)
        {
            //  Retorna o erro 400.
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            //  Se valido, adiciona o registro.
            db.UsuariosTipos.Add(usuarioTipo);
            db.SaveChanges();

            //  Retorna 201
            return CreatedAtRoute("DefaultApi", new
            {
                id = usuarioTipo.UsuarioTipoId
            }, usuarioTipo);
        }

        [HttpPut]
        public IHttpActionResult Put(int id, UsuarioTipo usuarioTipo)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState); // Erro 400

            if (id != usuarioTipo.UsuarioTipoId)
                return BadRequest("O id informado a URL é diferente do id informado no corpo da requisição");

            if (db.UsuariosTipos.Count(c => c.UsuarioTipoId == id) == 0)
                return NotFound();

            db.Entry(usuarioTipo).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpDelete]
        public IHttpActionResult Delete(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um número maior que zero.");

            var usuarioTipo = db.UsuariosTipos.Find(id);

            if (usuarioTipo == null)
                return NotFound();

            db.UsuariosTipos.Remove(usuarioTipo);
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

    }
}
