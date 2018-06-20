using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetMvc.Api.Models
{
    public class UsuarioTipo
    {
        [Required(ErrorMessage ="Identificador tipo de usuário deve ser preenchido.")]
        public int UsuarioTipoId { get; set; }

        [Required(ErrorMessage ="Nome do tipo de usuário deve ser preenchido")]
        [MaxLength(50,ErrorMessage ="Nome do tipo de usuário deve conter até 50 caracteres.")]
        public string Nome { get; set; }

        [Required(ErrorMessage ="Status de ativo ou inativo deve ser preenchido.")]
        public bool FlagStatus { get; set; }

        [Required(ErrorMessage ="Data e hora de cadastro do tipo de usuário deve ser preenchido.")]
        public DateTime CadastroDataHora { get; set; }

        [Required(ErrorMessage ="Usuário responsável pelo cadastro do tipo de usuário deve ser preenchido.")]
        public int CadastroUsuarioId {get;set;}

        public DateTime AtualizacaoDataHora { get; set; }

        public int AtualizacaoUsuarioId { get; set; }

    }
}