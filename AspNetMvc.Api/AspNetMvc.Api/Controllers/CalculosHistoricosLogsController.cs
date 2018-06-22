using AspNetMvc.Api.Models;
using System;
using System.Linq;
using System.Net;
using System.Web.Http;

namespace AspNetMvc.Api.Controllers
{
    public class CalculosHistoricosLogsController : ApiController
    {
        private OpahRedeContext db = new OpahRedeContext();

        [HttpGet]
        public IHttpActionResult Get(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um numero maior que zero.");

            var calculoHistoricoLog = db.CalculosHistoricosLogs.Find(id);

            if (calculoHistoricoLog == null)
                return NotFound(); // Erro 404

            return Ok(calculoHistoricoLog); // Sucesso 200
        }

        [HttpGet]
        public IHttpActionResult Get(int pagina = 1, int tamanhoPagina = 10)
        {
            if (pagina <= 0 || tamanhoPagina <= 0)
                return BadRequest("Os parâmetros página e tamanhoPagina devem ser maiores que zero.");

            if (tamanhoPagina > 10)
                return BadRequest("O tamanho máximo de página permitido é 10.");

            int totalPaginas = (int)Math.Ceiling
                (db.CalculosHistoricosLogs.Count() / Convert.ToDecimal(tamanhoPagina));

            if (pagina > totalPaginas)
                return BadRequest("A páginas solicitada não existe.");

            System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-TotalPages", totalPaginas.ToString());

            if (pagina > 1)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-PreviousPage",
                    Url.Link("DefaultApi", new { pagina = pagina - 1, tamanhoPagina = tamanhoPagina }));

            if (pagina < totalPaginas)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-NextPage",
                    Url.Link("DefaultApi", new { pagina = pagina + 1, tamanhoPagina = tamanhoPagina }));

            var calculoHistoricoLog = db.CalculosHistoricosLogs
                .OrderBy(c => c.CadastroDataHora)
                    .Skip(tamanhoPagina * (pagina - 1)).Take(tamanhoPagina);

            return Ok(calculoHistoricoLog);
        }

        [HttpPost]
        public IHttpActionResult Post(CalculoHistoricoLog calculoHistoricoLog)
        {
            //  Retorna o erro 400.
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            //  Se valido, adiciona o registro.
            db.CalculosHistoricosLogs.Add(calculoHistoricoLog);
            db.SaveChanges();

            //  Retorna 201
            return CreatedAtRoute("DefaultApi", new
            {
                id = calculoHistoricoLog.CalculoHistoricoLogId
            }, calculoHistoricoLog);
        }

        [HttpPut]
        public IHttpActionResult Put(int id, CalculoHistoricoLog calculoHistoricoLog)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState); // Erro 400

            if (id != calculoHistoricoLog.CalculoHistoricoLogId)
                return BadRequest("O id informado a URL é diferente do id informado no corpo da requisição");

            if (db.CalculosHistoricosLogs.Count(c => c.CalculoHistoricoLogId == id) == 0)
                return NotFound();

            db.Entry(calculoHistoricoLog).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }

        [HttpDelete]
        public IHttpActionResult Delete(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um número maior que zero.");

            var calculoHistoricoLog = db.CalculosHistoricosLogs.Find(id);

            if (calculoHistoricoLog == null)
                return NotFound();

            db.CalculosHistoricosLogs.Remove(calculoHistoricoLog);
            db.SaveChanges();

            return StatusCode(HttpStatusCode.NoContent);
        }
    }
}
