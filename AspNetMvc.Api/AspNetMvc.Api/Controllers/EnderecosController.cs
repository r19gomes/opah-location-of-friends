using AspNetMvc.Api.Models;
using System;
using System.Linq;
using System.Net;
using System.Web.Http;

namespace AspNetMvc.Api.Controllers
{
    public class EnderecosController : ApiController
    {
        private OpahRedeContext db = new OpahRedeContext();

        [HttpGet]
        public IHttpActionResult Get(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um numero maior que zero.");

            var enderecos = db.Enderecos.Find(id);

            if (enderecos == null)
                return NotFound(); // Erro 404

            return Ok(enderecos); // Sucesso 200
        }

        [HttpGet]
        public IHttpActionResult Get(int pagina = 1, int tamanhoPagina = 10)
        {
            if (pagina <= 0 || tamanhoPagina <= 0)
                return BadRequest("Os parâmetros página e tamanhoPagina devem ser maiores que zero.");

            if (tamanhoPagina > 10)
                return BadRequest("O tamanho máximo de página permitido é 10.");

            int totalPaginas = (int)Math.Ceiling
                (db.Enderecos.Count() / Convert.ToDecimal(tamanhoPagina));

            if (pagina > totalPaginas)
                return BadRequest("A páginas solicitada não existe.");

            System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-TotalPages", totalPaginas.ToString());

            if (pagina > 1)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-PreviousPage",
                    Url.Link("DefaultApi", new { pagina = pagina - 1, tamanhoPagina = tamanhoPagina }));

            if (pagina < totalPaginas)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-NextPage",
                    Url.Link("DefaultApi", new { pagina = pagina + 1, tamanhoPagina = tamanhoPagina }));

            var enderecos = db.Enderecos
                .OrderBy(c => c.CadastroDataHora)
                    .Skip(tamanhoPagina * (pagina - 1)).Take(tamanhoPagina);

            return Ok(enderecos);
        }

    }
}

