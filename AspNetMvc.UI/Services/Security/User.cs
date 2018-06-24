using AspNetMvc.UI.Services.Common;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace AspNetMvc.UI.Services.Security
{
    public class User
    {
        public static IList<Models.Security.User> UserList(Models.Security.User filter = null)
        {
            var urlApi = ConfigurationManager.AppSettings["Api_Rede"];
            var request = new Models.Security.User();

            urlApi = @"http://localhost/opah.aspnetmvc.api/api/";

            if (filter != null)
            {
                request = filter;
            }

            string reqString = JsonConvert.SerializeObject(request);
            var retApiString = CallWebApi.CallWebApiGet(null, urlApi + "/usuarios/");
            var retApi = retApiString.Result;
            var ret = new List<Models.Security.User>();

            List<Dictionary<string, string>> date = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(retApi);
            foreach (Dictionary<string, string> lst in date)
            {
                var register = new Models.Security.User();
                foreach (KeyValuePair<string, string> item in lst)
                {
                    if (register != null)
                    {
                        if (!string.IsNullOrEmpty(item.Key))
                        {
                            if (item.Value != null)
                            {
                                register.UsuarioId = item.Key.ToLower().Trim() == 
                                    "usuarioid" ? int.Parse(item.Value) : register.UsuarioId;
                                register.Nome = item.Key.ToLower().Trim() == "nome" ? item.Value : register.Nome;
                                register.Apelido = item.Key.ToLower().Trim() == "apelido" ? item.Value : register.Apelido;
                                register.Email = item.Key.ToLower().Trim() == "email" ? item.Value : register.Email;
                                register.Login = item.Key.ToLower().Trim() == "login" ? item.Value : register.Login;
                                register.Senha = item.Key.ToLower().Trim() == "senha" ? item.Value : register.Senha;
                                register.UsuarioTipoId = 
                                    item.Key.ToLower().Trim() == "usuariotipoId" ? int.Parse(item.Value) : register.UsuarioTipoId;
                                register.CadastroDataHora 
                                    = item.Key.ToLower().Trim() =="cadastrodatahora"? DateTime.Parse(item.Value) : register.CadastroDataHora;
                                register.CadastroUsuarioId 
                                    = item.Key.ToLower().Trim() == "cadastrousuarioid" ? int.Parse(item.Value) : register.CadastroUsuarioId;
                                register.AtualizacaoDataHora 
                                    = item.Key.ToLower().Trim() == "atualizacaodatahora"? DateTime.Parse(item.Value) : register.AtualizacaoDataHora;
                                register.AtualizacaoUsuarioId = 
                                    item.Key.ToLower().Trim() == "atualizacaousuarioid" ? int.Parse(item.Value) : register.AtualizacaoUsuarioId;
                            }
                        }
                    }
                }
                ret.Add(register);
            }

            return ret;
        }
    }
}