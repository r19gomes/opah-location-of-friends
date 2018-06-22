﻿/*
 Modelo de Script Pré-Implantação							
--------------------------------------------------------------------------------------
 Este arquivo contém instruções SQL que serão executadas antes do script de compilação.	
 Use a sintaxe SQLCMD para incluir um arquivo no script pré-implantação.			
 Exemplo:      :r .\myfile.sql								
 Use a sintaxe SQLCMD para referenciar uma variável no script pré-implantação.		
 Exemplo:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

USE OPAH_REDE
GO

SET NOCOUNT ON;

----	
----	FOREIGN KEY
----

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Usuario_UsuarioTipoId_UsuarioTipo_Id]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Usuario]
	DROP CONSTRAINT [FK_Usuario_UsuarioTipoId_UsuarioTipo_Id]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_Usuario_UsuarioTipoId_UsuarioTipo_UsuarioTipoId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[Usuario]
	DROP CONSTRAINT [FK_Usuario_UsuarioTipoId_UsuarioTipo_UsuarioTipoId]
END
GO

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

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_UsuarioTipo_UsuarioTipoId]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[UsuarioTipo]
	DROP CONSTRAINT [PK_UsuarioTipo_UsuarioTipoId]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsuarioTipo]') AND type in (N'U')) BEGIN
	DROP TABLE [dbo].[UsuarioTipo]
END
GO
