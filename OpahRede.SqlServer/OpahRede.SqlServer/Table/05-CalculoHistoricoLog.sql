CREATE TABLE [dbo].[CalculoHistoricoLog]
(
	[CalculoHistoricoLogId] INT IDENTITY(1,1) NOT NULL	
,	[UsuarioId] INT NOT NULL
,	[Latitude] VARCHAR(50) NOT NULL
,	[Longitude] VARCHAR(50) NOT NULL
,	[NumeroIp] VARCHAR(100) NULL
,	[Endereco] VARCHAR(200) NULL
,	[EnderecoNumero] INT NULL
,	[EnderecoComplemento] VARCHAR(1000) NULL
,	[EnderecoCep] VARCHAR(8) NULL
,	[EnderecoPais] VARCHAR(100) NULL	
,	[EnderecoEstado] VARCHAR(150) NULL
,	[EnderecoCidade] VARCHAR(150) NULL
,	[EnderecoBairro] VARCHAR(200) NULL
,	[FlagStatus] BIT NOT NULL
,	[CadastroDataHora] DATETIME NOT NULL
,	[CadastroUsuarioId] INT NOT NULL
,	[AtualizacaoDataHora] DATETIME NULL
,	[AtualizacaoUsuarioId] INT NULL
,	CONSTRAINT [PK_CalculoHistoricoLog_CalculoHistoricoId] PRIMARY KEY CLUSTERED 
	(
		[CalculoHistoricoLogId] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
,	CONSTRAINT [FK_CalculoHistoricoLog_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[CadastroUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_CalculoHistoricoLog_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[AtualizacaoUsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
,	CONSTRAINT [FK_CalculoHistoricoLog_UsuarioId_Usuario_UsuarioId] FOREIGN KEY
	(	
		[UsuarioId]
	) REFERENCES [dbo].[Usuario] (
		[UsuarioId]
	) 
) ON [PRIMARY]
GO