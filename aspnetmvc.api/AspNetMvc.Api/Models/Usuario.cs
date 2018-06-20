using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace AspNetMvc.Api.Models
{
    [Table("Usuarios")]
    public class Usuario
    {
        [Required(ErrorMessage ="Identificador do usuário deveser preenchido.")]
        public int UsuarioId { get; set; }

        [Required(ErrorMessage ="Nome do usuário deve ser preenchido.")]
        [MaxLength(200, ErrorMessage ="O nome do usuário só pode conter até 200 caracteres.")]
        public string Nome { get; set; }

        public string Apelido { get; set; }

        public string Email { get; set; }

        [Required(ErrorMessage ="Login de acesso deve ser preenchido.")]
        [MaxLength(30, ErrorMessage ="Login de acesso só pode conter até 30 caracteres.")]
        public string Login { get; set; }

        [Required(ErrorMessage ="Senha de acesso deve ser preenchida.")]
        [MaxLength(20, ErrorMessage ="Senha de acesso só pode conter até 20 caracteres.")]
        public string Senha { get; set; }

        public UsuarioTipo UsuarioTipo { get; set; }

        [Required(ErrorMessage ="Data e hora de cadastro do usuário deve ser preenchida.")]
        public DateTime CadastroDataHora { get; set; }

        [Required(ErrorMessage ="Identificador do usuário deve ser preenchido.")]
        public int CadastroUsuarioId { get; set; }

        public DateTime AtualizacaoDataHora { get; set; }

        public int AtualizacaoUsuarioId { get; set; }
    }
}