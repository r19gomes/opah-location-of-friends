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
		@USUARIO_ADMIN_ID INT
	,	@USUARIO_ID INT 
	,	@ENDERECO_ID INT 
	,	@CALCULO_HISTORICO_LOG_ID INT
	,	@ENDERECO VARCHAR(200)
	,	@ENDERECO_NUMERO INT
	,	@ENDERECO_COMPLEMENTO VARCHAR(1000)
	,	@ENDERECO_CEP VARCHAR(1)
	,	@ENDERECO_PAIS VARCHAR(100)
	,	@ENDERECO_ESTADO VARCHAR(150)
	,	@ENDERECO_CIDADE VARCHAR(150)
	,	@ENDERECO_BAIRRO VARCHAR(200)
	,	@ENDERECO_LATITUDE VARCHAR(50)
	,	@ENDERECO_LONGITUDE VARCHAR(50)
	,	@DATA_HORA_ATUAL DATETIME

	SET @USUARIO_ADMIN_ID = 0;
	SET @USUARIO_ID = 0;
	SET @ENDERECO_ID = 0;
	SET @CALCULO_HISTORICO_LOG_ID = 0;
	SET @ENDERECO = NULL;
	SET @ENDERECO_NUMERO = NULL;
	SET @ENDERECO_COMPLEMENTO = NULL;
	SET @ENDERECO_CEP = NULL;
	SET @ENDERECO_PAIS = NULL;
	SET @ENDERECO_ESTADO = NULL;
	SET @ENDERECO_CIDADE = NULL;
	SET @ENDERECO_BAIRRO = NULL;
	SET @ENDERECO_LATITUDE = NULL;
	SET @ENDERECO_LONGITUDE = NULL;
	SET @DATA_HORA_ATUAL  = GETDATE();

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

	IF	EXISTS(SELECT * FROM sys.tables WHERE Name = 'CalculoHistoricoLog') BEGIN
		IF	@USUARIO_ADMIN_ID > 0 BEGIN
			--	OBTÉM O USUÁRIO
			SELECT 
				@USUARIO_ID = UsuarioId
			FROM
				Usuario WITH (NOLOCK)
			WHERE
				UsuarioId > 0 
			AND
				Email = 'jonas.olanda@teste.com.br'
			;
			IF	@USUARIO_ID IS NULL BEGIN
				SET @USUARIO_ID = 0;
			END
			--	OBTÉM O ENDEREÇO DO USUÁRIO PARA PROSSEGUIR COM O LANÇAMENTO.
			IF	@USUARIO_ID > 0 BEGIN
				SET @CALCULO_HISTORICO_LOG_ID = 0;
				SET @ENDERECO = NULL;
				SET @ENDERECO_NUMERO = NULL;
				SET @ENDERECO_COMPLEMENTO = NULL;
				SET @ENDERECO_CEP = NULL;
				SET @ENDERECO_PAIS = NULL;
				SET @ENDERECO_ESTADO = NULL;
				SET @ENDERECO_CIDADE = NULL;
				SET @ENDERECO_BAIRRO = NULL;
				SET @ENDERECO_LATITUDE = NULL;
				SET @ENDERECO_LONGITUDE = NULL;
				SELECT
					@ENDERECO_ID = E.EnderecoId
				,	@ENDERECO = E.Nome
				,	@ENDERECO_NUMERO = E.Numero
				,	@ENDERECO_COMPLEMENTO = E.Complemento
				,	@ENDERECO_CEP = E.Cep
				,	@ENDERECO_PAIS = E.Pais
				,	@ENDERECO_ESTADO = E.Estado
				,	@ENDERECO_CIDADE = E.Cidade
				,	@ENDERECO_BAIRRO = E.Bairro
				,	@ENDERECO_LATITUDE = E.Latitude
				,	@ENDERECO_LONGITUDE = e.Longitude
				FROM
					Endereco AS E WITH (NOLOCK)
				INNER JOIN
					UsuarioEndereco AS UE WITH (NOLOCK)
				ON
					E.EnderecoId = UE.EnderecoId
				INNER JOIN
					Usuario AS U WITH (NOLOCK)
				ON
					UE.UsuarioId = U.UsuarioId
				WHERE
					E.EnderecoId > 0 
				AND
					UE.UsuarioEnderecoId > 0 
				AND
					U.UsuarioId = @USUARIO_ID
				;
			END
			--	VERIFICA SE O LANÇAMENTO DO LOG DO CÁLCULO DO HISTÓRICO.
			SET @CALCULO_HISTORICO_LOG_ID = 0;
			SELECT
				@CALCULO_HISTORICO_LOG_ID = L.CalculoHistoricoLogId
			FROM
				CalculoHistoricoLog as L WITH (NOLOCK)
			WHERE
				L.CalculoHistoricoLogId > 0 
			;
			IF	@CALCULO_HISTORICO_LOG_ID IS NULL BEGIN
				SET @CALCULO_HISTORICO_LOG_ID = 0;
			END
			IF	@CALCULO_HISTORICO_LOG_ID = 0 BEGIN
				INSERT CalculoHistoricoLog
				(
					UsuarioId
				,	Latitude
				,	Longitude
				,	NumeroIp
				,	Endereco
				,	EnderecoNumero
				,	EnderecoComplemento
				,	EnderecoCep
				,	EnderecoPais
				,	EnderecoEstado
				,	EnderecoCidade
				,	EnderecoBairro
				,	FlagStatus
				,	CadastroDataHora
				,	CadastroUsuarioId
				,	AtualizacaoDataHora
				,	AtualizacaoUsuarioId		
				)
				SELECT
					UsuarioId = @USUARIO_ID
				,	Latitude = @ENDERECO_LATITUDE
				,	Longitude = @ENDERECO_LONGITUDE
				,	NumeroIp = NULL
				,	Endereco = @ENDERECO
				,	EnderecoNumero = @ENDERECO_NUMERO
				,	EnderecoComplemento = @ENDERECO_COMPLEMENTO
				,	EnderecoCep = @ENDERECO_CEP
				,	EnderecoPais = @ENDERECO_PAIS
				,	EnderecoEstado = @ENDERECO_PAIS
				,	EnderecoCidade = @ENDERECO_CIDADE
				,	EnderecoBairro = @ENDERECO_BAIRRO
				,	FlagStatus = 1
				,	CadastroDataHora = @DATA_HORA_ATUAL 
				,	CadastroUsuarioId = @USUARIO_ADMIN_ID
				,	AtualizacaoDataHora = NULL
				,	AtualizacaoUsuarioId = NULL	
			END
		END
	END

END
GO