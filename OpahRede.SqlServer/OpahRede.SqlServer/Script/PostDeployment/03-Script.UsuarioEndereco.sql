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

BEGIN
	
	DECLARE 
		@USUARIO_ID INT
	,	@USUARIO_NOME VARCHAR(200)
	,	@USUARIO_ADMIN_ID INT
	,	@ENDERECO_ID INT
	,	@DATA_HORA_ATUAL DATETIME
	,	@ENDERECO_NOME VARCHAR(100)
	,	@ENDERECO_NUMERO INT
	,	@ENDERECO_BAIRRO VARCHAR(150)
	,	@ENDERECO_CIDADE VARCHAR(50)
	,	@ENDERECO_ESTADO VARCHAR(100)
	,	@ENDERECO_CEP VARCHAR(8)
	,	@ENDERECO_PAIS VARCHAR(100)
	,	@ENDERECO_LATITUDE VARCHAR(50)
	,	@ENDERECO_LONGITUDE VARCHAR(50)
	,	@USUARIO_ENDERECO_ID INT

	SET @USUARIO_ID = 0;
	SET @USUARIO_NOME = '';
	SET @USUARIO_ADMIN_ID = 0;
	SET @ENDERECO_ID = 0;
	SET @DATA_HORA_ATUAL = GETDATE();
	SET @ENDERECO_NOME = '';
	SET @ENDERECO_NUMERO = 0;
	SET @ENDERECO_BAIRRO = '';
	SET @ENDERECO_CIDADE = '';
	SET @ENDERECO_ESTADO = '';
	SET @ENDERECO_CEP = '';
	SET @ENDERECO_PAIS = '';
	SET @ENDERECO_LATITUDE = '';
	SET @ENDERECO_LONGITUDE = '';
	SET @USUARIO_ENDERECO_ID = 0;

	IF	EXISTS(SELECT * FROM sys.tables WHERE Name = 'Usuario') BEGIN
		--	OBTÉM O IDENTIFICADOR DO USUÁRIO ADMINISTRADOR.
		SELECT 
			@USUARIO_ADMIN_ID = UsuarioId
		FROM
			Usuario WITH (NOLOCK)
		WHERE
			UsuarioId > 0 
		AND
			Nome = 'Admin'
		;
		IF	@USUARIO_ADMIN_ID IS NULL BEGIN
			SET @USUARIO_ADMIN_ID = 0;
		END
		--	SE EXISTIR O USUÁRIO ADMIN, ADICIONA.
		IF	@USUARIO_ADMIN_ID > 0 BEGIN
			--	OBTÉM O IDENTIFICADOR DO USUÁRIO
			SET @USUARIO_ID = 0;
			SET @USUARIO_NOME = 'Jonas Bernardo Olanda';
			SELECT 
				@USUARIO_ID = UsuarioId
			FROM 
				Usuario WITH (NOLOCK)
			WHERE
				UsuarioId > 0 
			AND
				Nome = @USUARIO_NOME
			;
			IF	@USUARIO_ID IS NULL BEGIN
				SET @USUARIO_ID = 0;
			END
			--	ADICIONA O USUÁRIO SE NÃO ESTIVER CADASTRADO.
			IF	@USUARIO_ID = 0 BEGIN
				INSERT Usuario
				(
					Nome
				,	Apelido
				,	Email
				,	Login
				,	Senha
				,	UsuarioTipoId
				,	CadastroDataHora
				,	CadastroUsuarioId
				,	AtualizacaoDataHora
				,	AtualizacaoUsuarioId
				)
				SELECT 
					Nome = @USUARIO_NOME
				,	Apelido = 'Olanda'
				,	Email = 'jonas.olanda@teste.com.br'
				,	Login = 'jolanda'
				,	Senha = '123'
				,	UsuarioTipoId = NULL
				,	CadastroDataHora = @DATA_HORA_ATUAL
				,	CadastroUsuarioId = @USUARIO_ADMIN_ID
				,	AtualizacaoDataHora = NULL
				,	AtualizacaoUsuarioId= NULL					
				;	 
				SET @USUARIO_ID = SCOPE_IDENTITY();
			END
			--	ADICIONA O ENDEREÇO DO USUÁRIO.
			IF	@USUARIO_ID > 0 BEGIN
				--	OBTÉM O ENDEREÇO DO USUÁRIO OU ADICIONA O ENDEREÇO PARA VINCULAR AO USUÁRIO.
				SET @ENDERECO_NOME = 'Av. K';
				SET @ENDERECO_NUMERO = 249;
				SET @ENDERECO_BAIRRO = 'Francisco Peres I';
				SET @ENDERECO_CIDADE = 'Montes Claros';
				SET @ENDERECO_ESTADO = 'Minas Gerais';
				SET @ENDERECO_CEP = '39402230';
				SET @ENDERECO_PAIS = 'Brasil';
				SET @ENDERECO_LATITUDE = '-16.74036910867707';
				SET @ENDERECO_LONGITUDE = '-43.82935058765389';
				SELECT
					@ENDERECO_ID = EnderecoId
				FROM
					Endereco WITH (NOLOCK)
				WHERE
					EnderecoId > 0 
				AND
					Nome = @ENDERECO_NOME
				AND
					Numero = @ENDERECO_NUMERO
				;
				IF	@ENDERECO_ID IS NULL BEGIN
					SET @ENDERECO_ID = 0;
				END
				--	ADICIONA O ENDEREÇO SE NÃO EXISTE.
				IF	@ENDERECO_ID = 0 BEGIN
					INSERT Endereco 
					(
						Nome 
					,	Numero
					,	Complemento
					,	Cep
					,	Pais
					,	Estado
					,	Cidade
					,	Bairro
					,	Latitude
					,	Longitude
					,	Observacao
					,	FlagStatus
					,	CadastroDataHora
					,	CadastroUsuarioId
					,	AtualizacaoDataHora
					,	AtualizacaoUsuarioId
					)
					SELECT
						Nome = @ENDERECO_NOME
					,	Numero = @ENDERECO_NUMERO
					,	Complemento = NULL
					,	Cep = @ENDERECO_CEP
					,	Pais = @ENDERECO_PAIS
					,	Estado = @ENDERECO_ESTADO
					,	Cidade = @ENDERECO_CIDADE
					,	Bairro = @ENDERECO_BAIRRO
					,	Latitude = @ENDERECO_LATITUDE
					,	Longitude = @ENDERECO_LONGITUDE
					,	Observacao = NULL 
					,	FlagStatus = 1
					,	CadastroDataHora = @DATA_HORA_ATUAL
					,	CadastroUsuarioId = @USUARIO_ADMIN_ID
					,	AtualizacaoDataHora = NULL
					,	AtualizacaoUsuarioId = NULL
					;
					SET @ENDERECO_ID = SCOPE_IDENTITY();
				END
				IF	@ENDERECO_ID > 0 BEGIN
					SET @USUARIO_ENDERECO_ID = 0;
					IF	EXISTS(SELECT * FROM SYS.tables WHERE name = 'UsuarioEndereco') BEGIN
						SELECT
							@USUARIO_ENDERECO_ID = UsuarioEnderecoId
						FROM
							UsuarioEndereco WITH (NOLOCK)
						WHERE
							UsuarioEnderecoId > 0 
						AND
							EnderecoId = @ENDERECO_ID
						;
						IF	@USUARIO_ENDERECO_ID IS NULL BEGIN
							SET @USUARIO_ENDERECO_ID = 0;
						END
						IF	@USUARIO_ENDERECO_ID = 0 BEGIN
							INSERT UsuarioEndereco
							(
								UsuarioId
							,	EnderecoId
							,	FlagStatus
							,	CadastroDataHora
							,	CadastroUsuarioId
							,	AtualizacaoDataHora
							,	AtualizacaoUsuarioId
							)
							SELECT
								UsuarioId = @USUARIO_ID
							,	EnderecoId = @ENDERECO_ID
							,	FlagStatus = 1
							,	CadastroDataHora = @DATA_HORA_ATUAL
							,	CadastroUsuarioId = @USUARIO_ADMIN_ID
							,	AtualizacaoDataHora = NULL
							,	AtualizacaoUsuarioId = NULL	
							;
							SET @USUARIO_ENDERECO_ID = SCOPE_IDENTITY();
						END
					END
				END
			END
		END
	END
END
GO	