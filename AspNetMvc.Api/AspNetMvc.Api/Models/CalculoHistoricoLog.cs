using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetMvc.Api.Models
{
    [Table("CalculoHistoricoLog")]
    public class CalculoHistoricoLog
    {
        [Required(ErrorMessage = "Identificador do log do cálculo do histórico deve ser preenchido.")]
        [Key]
        public int CalculoHistoricoLogId { get; set; }

        [Required(ErrorMessage ="Identificador do usuário deve ser preenchido.")]
        public int UsuarioId { get; set; }

        [Required(ErrorMessage ="Latitude de ser preenchido.")]
        public string Latitude { get; set; }

        [Required(ErrorMessage ="Longitude deve ser preenchido.")]
        public string Longitude { get; set; }

        [Required(ErrorMessage ="Endereço deve ser preenchido.")]
        public string Endereco { get; set; }

        public int EnderecoNumero { get; set; }

        public string EnderecoComplemento { get; set; }

        public string EnderecoCep { get; set; }

        [Required(ErrorMessage ="País deve ser preenchido")]
        public string EnderecoPais { get; set; }

        public string EnderecoEstado { get; set; }

        public string EnderecoCidade { get; set; }
        
        public string EnderecoBairro { get; set; }

        public bool FlagStatus { get; set; }

        [Required(ErrorMessage = "Data e hora de cadastro do usuário deve ser preenchida.")]
        public DateTime CadastroDataHora { get; set; }

        [Required(ErrorMessage = "Identificador do usuário deve ser preenchido.")]
        public int CadastroUsuarioId { get; set; }

        public DateTime? AtualizacaoDataHora { get; set; }

        public int? AtualizacaoUsuarioId { get; set; }

    }
}