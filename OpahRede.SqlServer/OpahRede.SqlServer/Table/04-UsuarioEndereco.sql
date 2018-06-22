CREATE TABLE 
[dbo].[UsuarioEndereco] 
(
	[UsuarioEnderecoId] INT IDENTITY(1,1) NOT NULL
,	[UsuarioId] INT NOT NULL
,	[EnderecoId] INT NULL
,	[FlagStatus] bit not null
,	[CadastroDataHora] datetime not null
,	[CadastroUsuarioId] int not null
,	[AtualizacaoDataHora] datetime null
,	[AtualizacaoUsuarioId] int null
,	CONSTRAINT [PK_UsuarioEndereco_UsuarioEnderecoId] PRIMARY KEY CLUSTERED 
	(
		[UsuarioEnderecoId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
,	CONSTRAINT [FK_UsuarioEndereco_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[CadastroUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_UsuarioEndereco_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[AtualizacaoUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_UsuarioEndereco_UsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[UsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_UsuarioEndereco_EnderecoId_Endereco_EnderecoId] FOREIGN KEY
	(	
		[EnderecoId]
	) REFERENCES [dbo].[Endereco] (
		[EnderecoId]
	) 
) ON [PRIMARY]
GO