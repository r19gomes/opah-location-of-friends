/*
   quarta-feira, 20 de junho de 201815:46:18
   User: 
   Server: DESKTOP-JLGBVQK\SQLEXPRESS2014
   Database: Opah_Rede
   Application: 
*/


------	
------	FOREIGN KEY
------

--IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Usuario_UsuarioTipoId_UsuarioTipo_Id]') AND type in (N'F')) BEGIN
--	ALTER TABLE [dbo].[Usuario]
--	DROP CONSTRAINT [FK_Usuario_UsuarioTipoId_UsuarioTipo_Id]
--END

--IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Usuario_CadastroUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
--	ALTER TABLE [dbo].[Usuario]
--	DROP CONSTRAINT [FK_Usuario_CadastroUsuarioId_Usuario_Id]
--END

--IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Usuario_AtualizacaoUsuarioId_Usuario_Id]') AND type in (N'F')) BEGIN
--	ALTER TABLE [dbo].[Usuario]
--	DROP CONSTRAINT [FK_Usuario_AtualizacaoUsuarioId_Usuario_Id]
--END

----
----	DROP PRIMARY KEY & DROP TABLE
----

--IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_Usuario_Id]') AND type in (N'PK')) BEGIN
--	ALTER TABLE [dbo].[Usuario]
--	DROP CONSTRAINT [PK_Usuario_Id]
--END

--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuario]') AND type in (N'U')) BEGIN
--	DROP TABLE [dbo].[Usuario]
--END

----
----	CREATE TABLE
----

--SET ANSI_NULLS ON

--SET QUOTED_IDENTIFIER ON

--SET ANSI_PADDING ON

--CREATE TABLE [dbo].[Usuario] 
--(
--	[Id] int identity not null
--,	[Nome] varchar(200) not null
--,	[Apelido] varchar(50) null
--,	[Email] varchar(200) null
--,	[Login] varchar(30) null
--,	[Senha] varchar(20) null
--,	[UsuarioTipoId] int null
--,	[CadastroDataHora] datetime not null
--,	[CadastroUsuarioId] int not null
--,	[AtualizacaoDataHora] datetime null
--,	[AtualizacaoUsuarioId] int null
--,	CONSTRAINT [PK_Usuario_Id] PRIMARY KEY CLUSTERED 
--	(
--		[Id] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--) ON [PRIMARY]

--ALTER TABLE [dbo].[Usuario] ADD
--CONSTRAINT [FK_Usuario_CadastroUsuarioId_Usuario_Id] FOREIGN KEY
--(	
--	[CadastroUsuarioId]
--) REFERENCES [dbo].[Usuario] (
--	[Id]
--); 

--ALTER TABLE [dbo].[Usuario] ADD
--CONSTRAINT [FK_Usuario_AtualizacaoUsuarioId_Usuario_Id] FOREIGN KEY
--(	
--	[AtualizacaoUsuarioId]
--) REFERENCES [dbo].[Usuario] (
--	[Id]
--); 

--ALTER TABLE [dbo].[Usuario] ADD
--CONSTRAINT [FK_Usuario_UsuarioTipoId_UsuarioTipo_Id] FOREIGN KEY
--(	
--	[UsuarioTipoId]
--) REFERENCES [dbo].[UsuarioTipo] (
--	[Id]
--);
