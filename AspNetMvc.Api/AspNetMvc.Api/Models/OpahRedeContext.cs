using System.Data.Entity;

namespace AspNetMvc.Api.Models
{
    public class OpahRedeContext : DbContext
    {
        public OpahRedeContext() : base("OpahRedeLocal")
        {
            {
                #if DEBUG
                    Database.Log = d => System.Diagnostics.Debug.WriteLine(d);
                #endif
            }
        }

        public DbSet<UsuarioTipo> UsuariosTipos { get; set; }
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Endereco> Enderecos { get; set; }
        public DbSet<UsuarioEndereco> UsuariosEnderecos { get; set; }
        public DbSet<CalculoHistoricoLog> CalculosHistoricosLogs { get; set; }

    }
}