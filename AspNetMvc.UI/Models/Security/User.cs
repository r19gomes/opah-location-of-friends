using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace AspNetMvc.UI.Models.Security
{
    public class User
    {
        [DisplayName("Identificador")]
        public int UsuarioId { get; set; }

        [Required]
        [StringLength(200, ErrorMessage = @"O nome deve ter tamanho no máximo 200.")]
        public string Nome { get; set; }

        [StringLength(50, ErrorMessage = @"O apelido deve ter tamanho no máximo 50.")]
        public string Apelido { get; set; }

        [StringLength(200, ErrorMessage = @"O endereço eletrônico deve ter tamanho no máximo 200.")]
        public string Email { get; set; }

        [Required]
        [StringLength(30, ErrorMessage = @"O login deve ter tamanho no máximo 20.")]
        public string Login { get; set; }

        [Required]
        [StringLength(20, ErrorMessage = @"A senha deve ter tamanho no máximo 20.")]
        public string Senha { get; set; }

        public int? UsuarioTipoId { get; set; }

        public DateTime CadastroDataHora { get; set; }

        public int CadastroUsuarioId { get; set; }

        public DateTime? AtualizacaoDataHora { get; set; }

        public int? AtualizacaoUsuarioId { get; set; }

    }
}