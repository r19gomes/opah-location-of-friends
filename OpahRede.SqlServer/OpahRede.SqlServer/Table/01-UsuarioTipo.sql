CREATE TABLE [dbo].[UsuarioTipo]
(
	[UsuarioTipoId] int identity(1,1) not null
,	[Nome] varchar(50) not null
,	[FlagStatus] bit not null
,	[CadastroDataHora] datetime not null
,	[CadastroUsuarioId] int not null
,	[AtualizacaoDataHora] datetime null
,	[AtualizacaoUsuarioId] int null
,	CONSTRAINT [PK_UsuarioTipo_Id] PRIMARY KEY CLUSTERED 
	(
		[UsuarioTipoId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
,	CONSTRAINT [FK_UsuarioTipo_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[CadastroUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_UsuarioTipo_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[AtualizacaoUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
) ON [PRIMARY]
GO