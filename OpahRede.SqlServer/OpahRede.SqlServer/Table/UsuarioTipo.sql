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

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioTipo_CadastroUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioTipo]
	DROP CONSTRAINT [FK_UsuarioTipo_CadastroUsuarioId_Usuario_Id]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioTipo_AtualizacaoUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioTipo]
	DROP CONSTRAINT [FK_UsuarioTipo_AtualizacaoUsuarioId_Usuario_Id]
END
GO

--
--	DROP PRIMARY KEY & DROP TABLE
--

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_UsuarioTipo_Id]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[UsuarioTipo]
	DROP CONSTRAINT [PK_UsuarioTipo_Id]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsuarioTipo]') AND type in (N'U')) BEGIN
	DROP TABLE [dbo].[UsuarioTipo]
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

CREATE TABLE [dbo].[UsuarioTipo]
(
	[Id] int identity(1,1) not null
,	[Nome] varchar(50) not null
,	[FlagStatus] bit not null
,	[CadastroDataHora] datetime not null
,	[CadastroUsuarioId] int not null
,	[AtualizacaoDataHora] datetime null
,	[AtualizacaoUsuarioId] int null
,	CONSTRAINT [PK_UsuarioTipo_Id] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[UsuarioTipo] ADD
CONSTRAINT [FK_UsuarioTipo_CadastroUsuarioId_Usuario_Id] FOREIGN KEY
(	
	[CadastroUsuarioId]
) REFERENCES [dbo].[Usuario] (
	[Id]
) 
GO

ALTER TABLE [dbo].[UsuarioTipo] ADD
CONSTRAINT [FK_UsuarioTipo_AtualizacaoUsuarioId_Usuario_Id] FOREIGN KEY
(	
	[AtualizacaoUsuarioId]
) REFERENCES [dbo].[Usuario] (
	[Id]
) 
GO

