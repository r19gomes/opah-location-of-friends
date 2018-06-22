using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetMvc.Api.Models
{
    [Table("Endereco")]
    public class Endereco
    {
        [Required(ErrorMessage = "Identificador do endereço deve ser preenchido.")]
        [Key]
        public int EnderecoId { get; set; }

        [Required(ErrorMessage = "Nome do endereço deve ser preenchido.")]
        [MaxLength(50, ErrorMessage = "O endereço só pode conter até 50 caracteres.")]
        public string Nome { get; set; }

        public int? Numero { get; set; }

        public string Complemento { get; set; }

        public string Cep { get; set; }

        public string Pais { get; set; }
        
        public string Estado { get; set; }

        public string Cidade { get; set; }

        public string Bairro { get; set; }

        public string Latitude { get; set; }

        public string Longitude { get; set; }

        public string Observacao { get; set; }

        public bool FlagStatus { get; set; }

        [Required(ErrorMessage = "Data e hora de cadastro do usuário deve ser preenchida.")]
        public DateTime CadastroDataHora { get; set; }

        [Required(ErrorMessage = "Identificador do usuário deve ser preenchido.")]
        public int CadastroUsuarioId { get; set; }

        public DateTime? AtualizacaoDataHora { get; set; }

        public int? AtualizacaoUsuarioId { get; set; }

    }
}