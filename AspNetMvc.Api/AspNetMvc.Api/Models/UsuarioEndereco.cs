using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetMvc.Api.Models
{
    [Table("UsuarioEndereco")]
    public class UsuarioEndereco
    {
        [Required(ErrorMessage = "Identificador tipo de endereço do usuário deve ser preenchido.")]
        [Key]
        public int UsuarioEnderecoId { get; set; }

        [Required(ErrorMessage ="Identificador do usuário deve ser preenchido.")]
        public int UsuarioId { get; set; }

        [Required(ErrorMessage ="Identificador do endereço deve ser preenchido.")]
        public int EnderecoId { get; set; }

        [Required(ErrorMessage = "Status de ativo ou inativo deve ser preenchido.")]
        public bool FlagStatus { get; set; }

        [Required(ErrorMessage = "Data e hora de cadastro do tipo de usuário deve ser preenchido.")]
        public DateTime CadastroDataHora { get; set; }

        [Required(ErrorMessage = "Usuário responsável pelo cadastro do tipo de usuário deve ser preenchido.")]
        public int CadastroUsuarioId { get; set; }

        public DateTime? AtualizacaoDataHora { get; set; }

        public int? AtualizacaoUsuarioId { get; set; }

    }
}