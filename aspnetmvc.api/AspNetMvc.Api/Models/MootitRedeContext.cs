using System.Data.Entity;

namespace AspNetMvc.Api.Models
{
    public class MootitRedeContext: DbContext
    {
        public MootitRedeContext(): base("MootitRedeLocal")
        {                
        }
        
        public DbSet<UsuarioTipo> UsuariosTipos { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
    }
}