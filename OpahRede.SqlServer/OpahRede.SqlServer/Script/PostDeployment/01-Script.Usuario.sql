/*
Modelo de Script Pós-Implantação							
--------------------------------------------------------------------------------------
 Este arquivo contém instruções SQL que serão acrescentadas ao script de compilação.		
 Use sintaxe SQLCMD para incluir um arquivo no script pós-implantação.			
 Exemplo:      :r .\myfile.sql								
 Use sintaxe SQLCMD para referenciar uma variável no script pós-implantação.		
 Exemplo:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'Usuario') 
BEGIN
	DECLARE
		@USUARIO_ID INT 
	,	@USUARIO_NOME VARCHAR(200)

	SET @USUARIO_ID = 0;
	SET @USUARIO_NOME = 'Admin'
	IF NOT EXISTS(SELECT * FROM Usuario where UsuarioId > 0 AND Nome = @USUARIO_NOME) 
	BEGIN
		INSERT [dbo].Usuario 
		(
			Nome
		,	Apelido
		,	Email
		,	Login
		,	Senha
		,	CadastroDataHora
		,	CadastroUsuarioId
		,	AtualizacaoDataHora
		,	AtualizacaoUsuarioId
		)
		SELECT 
			Nome = @USUARIO_NOME
		,	Apelido = 'Verde'
		,	Email = 'verde@teste.com.br'
		,	Login = 'SANDRA'
		,	Senha = '123'
		,	CadastroDataHora = getdate()
		,	CadastroUsuarioId = 1
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @USUARIO_ID = SCOPE_IDENTITY();
	END


	SET @USUARIO_ID = 0;
	SET @USUARIO_NOME = 'Sandra Costa Verde'
	IF NOT EXISTS(SELECT * FROM Usuario where UsuarioId > 0 AND Nome = @USUARIO_NOME) 
	BEGIN
		INSERT [dbo].Usuario 
		(
			Nome
		,	Apelido
		,	Email
		,	Login
		,	Senha
		,	CadastroDataHora
		,	CadastroUsuarioId
		,	AtualizacaoDataHora
		,	AtualizacaoUsuarioId
		)
		SELECT 
			Nome = @USUARIO_NOME
		,	Apelido = 'Verde'
		,	Email = 'verde@teste.com.br'
		,	Login = 'SANDRA'
		,	Senha = '123'
		,	CadastroDataHora = getdate()
		,	CadastroUsuarioId = 1
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @USUARIO_NOME = SCOPE_IDENTITY();
	END

END
GO