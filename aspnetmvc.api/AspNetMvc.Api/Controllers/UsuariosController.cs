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

        [Route("usuarios")]
        [HttpGet]
        public IHttpActionResult Get()
        {
            var user = db.Usuarios;

            return Ok(user); // Sucesso 200
        }

        [Route("usuarios/{id:int}")]
        [HttpGet]
        public IHttpActionResult GetUserById(int id)
        {
            if (id <= 0)
                return BadRequest("O id deve ser um numero maior que zero.");

            var usuario = db.Usuarios.Find(id);

            if (usuario == null)
                return NotFound(); // Erro 404

            return Ok(usuario); // Sucesso 200
        }

        [Route("usuarios")]
        [HttpPost]
        public IHttpActionResult GetUser(Models.Usuario user)
        {
            var name = string.Empty;

            var usuario = db.Usuarios;
            if (user != null)
            {
                //  Pesquisar po ID?
                if (user.UsuarioId > 0)
                {
                    var result = usuario.Where(u => u.UsuarioId == user.UsuarioId);
                    return Ok(result);
                }
                //  Pesquisar por nome?
                else if (!string.IsNullOrEmpty(user.Nome))
                {
                    if (user.Nome.Trim().Length > 0)
                    {
                        name = user.Nome.Trim();
                    }
                    var result = usuario.Where(u => u.UsuarioId > 0 && u.Nome == name);
                    return Ok(result);
                }
                else
                {
                    return Ok(usuario);
                }
            }
            else
            {
                return Ok(usuario);
            }

        }

        [Route("usuarios/{page:int}/{pagesize:int}")]
        [HttpGet]
        public IHttpActionResult GetUserPage(int page = 1, int pageSize = 10)
        {
            if (page <= 0 || pageSize <= 0)
                return BadRequest("Os parâmetros página e tamanhoPagina devem ser maiores que zero.");

            if (pageSize > 10)
                return BadRequest("O tamanho máximo de página permitido é 10.");

            int totalPaginas = (int)Math.Ceiling(db.Usuarios.Count() / Convert.ToDecimal(pageSize));

            if (page > totalPaginas)
                return BadRequest("A páginas solicitada não existe.");

            System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-TotalPages", totalPaginas.ToString());

            if (page > 1)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-PreviousPage",
                    Url.Link("DefaultApi", new
                    {
                        page = page - 1,
                        pageSize = pageSize
                    }));

            if (page < totalPaginas)
                System.Web.HttpContext.Current.Response.AddHeader("X-Pagination-NextPage",
                    Url.Link("DefaultApi", new
                    {
                        pagina = page + 1,
                        pageSize = pageSize
                    }));

            var usuarios = db.Usuarios.OrderBy(c => c.CadastroDataHora).Skip(pageSize * (page - 1)).Take(pageSize);

            return Ok(usuarios);
        }

        [Route("usuarios")]
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

        [Route("usuarios")]
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

        [Route("usuarios")]
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
