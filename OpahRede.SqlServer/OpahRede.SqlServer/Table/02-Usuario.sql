CREATE TABLE [dbo].[Usuario] 
(
	[UsuarioId] int identity not null
,	[Nome] varchar(200) not null
,	[Apelido] varchar(50) null
,	[Email] varchar(200) null
,	[Login] varchar(30) null
,	[Senha] varchar(20) null
,	[UsuarioTipoId] int null
,	[CadastroDataHora] datetime not null
,	[CadastroUsuarioId] int not null
,	[AtualizacaoDataHora] datetime null
,	[AtualizacaoUsuarioId] int null
,	CONSTRAINT [PK_Usuario_Id] PRIMARY KEY CLUSTERED 
	(
		[UsuarioId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
,	CONSTRAINT [FK_Usuario_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[CadastroUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_Usuario_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[AtualizacaoUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_Usuario_UsuarioTipoId_UsuarioTipo_UsuarioTipoId] FOREIGN KEY
	(	
		[UsuarioTipoId]
	) REFERENCES [dbo].[UsuarioTipo] (
		[UsuarioTipoId]
	) 
) ON [PRIMARY]
GO
