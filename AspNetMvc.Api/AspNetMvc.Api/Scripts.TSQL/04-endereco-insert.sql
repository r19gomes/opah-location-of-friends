BEGIN

	DECLARE
		@USUARIO_ADMIN_ID INT
	,	@DATA_HORA_ATUALIZACAO DATETIME
	,	@NOME VARCHAR(200)
	,	@ENDERECO_ID INT
	,	@NUMERO INT

	SET @DATA_HORA_ATUALIZACAO = GETDATE();
	SET @NOME = '';
	SET @ENDERECO_ID = 0;
	SET @NUMERO = NULL;

	--	OBTÉM O IDENTIFICADOR DO USUÁRIO ADMIN
	SELECT 
		@USUARIO_ADMIN_ID = UsuarioId
	FROM
		Usuario WITH (NOLOCK)
	WHERE
		UsuarioId > 0 
	AND
		Nome = 'Admin'
	;
	IF @USUARIO_ADMIN_ID <= 0 BEGIN
		SET @USUARIO_ADMIN_ID = NULL;
	END


	SET @NOME = 'Unnamed Road';
	SELECT 
		@ENDERECO_ID = EnderecoId
	FROM
		Endereco WITH (NOLOCK)
	WHERE
		EnderecoId > 0 
	AND
		Nome = @NOME
	;
	IF @ENDERECO_ID IS NULL BEGIN
		SET @ENDERECO_ID = 0;
	END		
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
			Nome = @NOME
		,	Numero = null
		,	Complemento = null
		,	Cep = null
		,	Pais = 'Sudão'
		,	Estado = 'Berber'
		,	Cidade = null
		,	Bairro = null
		,	Latitude = 18.01013930032997
		,	Longitude = 33.990244787928646
		,	Observacao = null
		,	FlagStatus = 1
		,	CadastroDataHora = @DATA_HORA_ATUALIZACAO
		,	CadastroUsuarioId = @USUARIO_ADMIN_ID
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @ENDERECO_ID =SCOPE_IDENTITY();
	END


	SET @NOME = 'BA-850';
	SET @ENDERECO_ID = 0;
	SELECT 
		@ENDERECO_ID = EnderecoId
	FROM
		Endereco WITH (NOLOCK)
	WHERE
		EnderecoId > 0 
	AND
		Nome = @NOME
	;
	IF @ENDERECO_ID IS NULL BEGIN
		SET @ENDERECO_ID = 0;
	END		
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
			Nome = @NOME
		,	Numero = null
		,	Complemento = null
		,	Cep = '46960000'
		,	Pais = 'Brasil'
		,	Estado = 'Lençóis'
		,	Cidade = 'Bahia'
		,	Bairro = null
		,	Latitude = -12.522266832754212
		,	Longitude = -41.415821987175036
		,	Observacao = null
		,	FlagStatus = 1
		,	CadastroDataHora = @DATA_HORA_ATUALIZACAO
		,	CadastroUsuarioId = @USUARIO_ADMIN_ID
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @ENDERECO_ID =SCOPE_IDENTITY();
	END

	SET @NOME = 'BA-144';
	SET @ENDERECO_ID = 0;
	SELECT 
		@ENDERECO_ID = EnderecoId
	FROM
		Endereco WITH (NOLOCK)
	WHERE
		EnderecoId > 0 
	AND
		Nome = @NOME
	;
	IF @ENDERECO_ID IS NULL BEGIN
		SET @ENDERECO_ID = 0;
	END		
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
			Nome = @NOME
		,	Numero = null
		,	Complemento = null
		,	Cep = '46960000'
		,	Pais = 'Brasil'
		,	Estado = 'Lençóis'
		,	Cidade = 'Bahia'
		,	Bairro = null
		,	Latitude = -12.515727791465979
		,	Longitude = -41.36408207283006
		,	Observacao = null
		,	FlagStatus = 1
		,	CadastroDataHora = @DATA_HORA_ATUALIZACAO
		,	CadastroUsuarioId = @USUARIO_ADMIN_ID
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @ENDERECO_ID =SCOPE_IDENTITY();
	END

	SET @NOME = 'R. Itaberaba';
	SET @NUMERO = 2;
	SET @ENDERECO_ID = 0;
	SELECT 
		@ENDERECO_ID = EnderecoId
	FROM
		Endereco WITH (NOLOCK)
	WHERE
		EnderecoId > 0 
	AND
		Nome = @NOME
	AND
		Numero = @NUMERO
	;
	IF @ENDERECO_ID IS NULL BEGIN
		SET @ENDERECO_ID = 0;
	END		
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
			Nome = @NOME
		,	Numero = @NUMERO
		,	Complemento = null
		,	Cep = '46960000'
		,	Pais = 'Brasil'
		,	Estado = 'Lençóis'
		,	Cidade = 'Bahia'
		,	Bairro = null
		,	Latitude = -12.516722042486204
		,	Longitude = -41.28750459499423
		,	Observacao = null
		,	FlagStatus = 1
		,	CadastroDataHora = @DATA_HORA_ATUALIZACAO
		,	CadastroUsuarioId = @USUARIO_ADMIN_ID
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @ENDERECO_ID =SCOPE_IDENTITY();
	END

	SET @NOME = 'Unnamed Road';
	SET @NUMERO = NULL;
	SET @ENDERECO_ID = 0;
	SELECT 
		@ENDERECO_ID = EnderecoId
	FROM
		Endereco WITH (NOLOCK)
	WHERE
		EnderecoId > 0 
	AND
		Nome = @NOME
	AND
		Numero = @NUMERO
	;
	IF @ENDERECO_ID IS NULL BEGIN
		SET @ENDERECO_ID = 0;
	END		
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
			Nome = @NOME
		,	Numero = @NUMERO
		,	Complemento = null
		,	Cep = '46800000'
		,	Pais = 'Brasil'
		,	Estado = 'Ruy Barbosa'
		,	Cidade = 'Bahia'
		,	Bairro = null
		,	Latitude = -12.41635594858222
		,	Longitude = -40.6108805780504
		,	Observacao = null
		,	FlagStatus = 1
		,	CadastroDataHora = @DATA_HORA_ATUALIZACAO
		,	CadastroUsuarioId = @USUARIO_ADMIN_ID
		,	AtualizacaoDataHora = null
		,	AtualizacaoUsuarioId = null
		;
		SET @ENDERECO_ID =SCOPE_IDENTITY();
	END

END
GO