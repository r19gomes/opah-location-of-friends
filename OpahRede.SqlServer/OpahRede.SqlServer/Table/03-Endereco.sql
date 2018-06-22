CREATE TABLE [dbo].[Endereco] 
(
	[EnderecoId] int identity not null
,	[Nome] varchar(200) not null
,	[Numero] int null
,	[Complemento] varchar(1000) null
,	[Cep] varchar(8) null
,	[Pais] varchar(100) null
,	[Estado] varchar(150) null
,	[Cidade] varchar(150) null
,	[Bairro] varchar(200) null
,	[Latitude] varchar(50) null
,	[Longitude] varchar(50) null
,	[Observacao] varchar(2000) null
,	[FlagStatus] bit not null
,	[CadastroDataHora] datetime not null
,	[CadastroUsuarioId] int not null
,	[AtualizacaoDataHora] datetime null
,	[AtualizacaoUsuarioId] int null
,	CONSTRAINT [PK_Endereco_Id] PRIMARY KEY CLUSTERED 
	(
		[EnderecoId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
,	CONSTRAINT [FK_Endereco_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[CadastroUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_Endereco_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[AtualizacaoUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
) ON [PRIMARY]
GO
