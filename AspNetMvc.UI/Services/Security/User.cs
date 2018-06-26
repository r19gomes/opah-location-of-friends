using AspNetMvc.UI.Models.Security;
using AspNetMvc.UI.Services.Common;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Web.Script.Serialization;

namespace AspNetMvc.UI.Services.Security
{
    public class User
    {
        public static IList<Models.Security.User> UserList(Models.Security.User filter = null)
        {
            var urlApi = ConfigurationManager.AppSettings["Api_Rede"];
            var request = new Models.Security.User();

            urlApi = @"http://localhost:49344/api/";

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
                                    = item.Key.ToLower().Trim() == "cadastrodatahora" ? DateTime.Parse(item.Value) : register.CadastroDataHora;
                                register.CadastroUsuarioId
                                    = item.Key.ToLower().Trim() == "cadastrousuarioid" ? int.Parse(item.Value) : register.CadastroUsuarioId;
                                register.AtualizacaoDataHora
                                    = item.Key.ToLower().Trim() == "atualizacaodatahora" ? DateTime.Parse(item.Value) : register.AtualizacaoDataHora;
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

        /// <summary>
        /// Cria um novo usuário.
        /// </summary>
        /// <param name="model">Modelo dos usuários</param>
        /// <returns></returns>
        public static UserViewModel UserCreate(UserViewModel model)
        {
            var urlApi = ConfigurationManager.AppSettings["Api_Rede"];
            var request = new Models.Security.User();
            UserViewModel ret = new UserViewModel();

            try
            {
                urlApi = @"http://localhost:49344//api";

                if (model != null)
                {
                    if (model.User != null)
                    {
                        request = model.User;
                    }
                }

                if (request != null)
                {
                    if (request.CadastroDataHora == null || request.CadastroDataHora <= DateTime.Now)
                        request.CadastroDataHora = DateTime.Now;
                    if (request.CadastroUsuarioId == 0)
                        request.CadastroUsuarioId = 1;
                }

                string reqString = JsonConvert.SerializeObject(request);
                var retApiString = CallWebApi.CallWebApiPost(reqString, urlApi + "/usuarios/post");

                ret.Message = "Processado com sucesso!";
                ret = ConvertJsonStringToUser(retApiString);
                ret.Success = true;
                ret.PersistFields = false;
            }
            catch (Exception ex)
            {
                ret.Success = false;
                ret.PersistFields = true;
                ret.Message = ex.Message.ToString();
            }

            return ret;
        }

        public static Models.Security.UserViewModel ConvertJsonStringToUser(string json)
        {
            var jss = new JavaScriptSerializer();
            Dictionary<string, string> data = jss.Deserialize<Dictionary<string, string>>(json);
            var result = new Models.Security.UserViewModel();
            if (!string.IsNullOrEmpty(data["Apelido"]))
            {
                result.User.Apelido = data["Apelido"].ToString();
            }
            if (!string.IsNullOrEmpty(data["AtualizacaoDataHora"]))
            {
                result.User.AtualizacaoDataHora = DateTime.Parse(data["AtualizacaoDataHora"].ToString());
            }
            if (!string.IsNullOrEmpty(data["AtualizacaoUsuarioId"]))
            {
                result.User.AtualizacaoUsuarioId = int.Parse(data["AtualizacaoUsuarioId"].ToString());
            }
            result.User.CadastroDataHora = DateTime.Parse(data["CadastroDataHora"].ToString());
            result.User.CadastroUsuarioId = int.Parse(data["CadastroUsuarioId"].ToString());
            if (!string.IsNullOrEmpty(data["Email"]))
            {
                result.User.Email = data["Email"].ToString().Trim().ToLower();
            }
            if (!string.IsNullOrEmpty(data["Login"]))
            {
                result.User.Login = data["Login"].ToString().Trim().ToUpper();
            }
            if (!string.IsNullOrEmpty(data["Nome"]))
            {
                result.User.Nome = data["Nome"].ToString().Trim();
            }
            if (!string.IsNullOrEmpty(data["Senha"]))
            {
                result.User.Senha = data["Senha"].ToString().Trim();
            }
            result.User.UsuarioId = int.Parse(data["UsuarioId"].ToString());
            if (!string.IsNullOrEmpty(data["UsuarioTipoId"]))
            {
                result.User.UsuarioTipoId = int.Parse(data["UsuarioTipoId"].ToString());
            }

            return result;
        }
    }
}