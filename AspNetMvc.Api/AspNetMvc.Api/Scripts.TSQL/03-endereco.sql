/*
   quarta-feira, 20 de junho de 201815:46:18
   User: 
   Server: DESKTOP-JLGBVQK\SQLEXPRESS2014
   Database: Opah_Rede
   Application: 
*/

USE OPAH_REDE
GO

SET NOCOUNT ON;

----	
----	FOREIGN KEY
----

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Endereco_CadastroUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [FK_Endereco_CadastroUsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Endereco_AtualizacaoUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [FK_Endereco_AtualizacaoUsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Endereco_CadastroUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [FK_Endereco_CadastroUsuarioId_Usuario_Id]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Endereco_AtualizacaoUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [FK_Endereco_AtualizacaoUsuarioId_Usuario_Id]
END
GO

--
--	DROP PRIMARY KEY & DROP TABLE
--

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_Endereco_EnderecoId]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [PK_Endereco_EnderecoId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_Endereco_Id]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[Endereco]
	DROP CONSTRAINT [PK_Endereco_Id]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Endereco]') AND type in (N'U')) BEGIN
	DROP TABLE [dbo].[Endereco]
END
GO

--
--	CREATE TABLE
--

USE [Opah_Rede]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

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
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Endereco] ADD
CONSTRAINT [FK_Endereco_CadastroUsuarioId_Usuario_UsuarioId] FOREIGN KEY
(	
	[CadastroUsuarioId]
) REFERENCES [dbo].[Usuario] (
	[UsuarioId]
) 
GO

ALTER TABLE [dbo].[Endereco] ADD
CONSTRAINT [FK_Endereco_AtualizacaoUsuarioId_Usuario_UsuarioId] FOREIGN KEY
(	
	[AtualizacaoUsuarioId]
) REFERENCES [dbo].[Usuario] (
	[UsuarioId]
) 
GO
