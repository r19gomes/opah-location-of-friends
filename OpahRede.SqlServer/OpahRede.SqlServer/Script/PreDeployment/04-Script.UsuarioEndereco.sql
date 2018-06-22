/*
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

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioEndereco_EnderecoId_Endereco_EnderecoId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [FK_UsuarioEndereco_EnderecoId_Endereco_EnderecoId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioEndereco_UsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [FK_UsuarioEndereco_UsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioEndereco_CadastroUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [FK_UsuarioEndereco_CadastroUsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioEndereco_AtualizacaoUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [FK_UsuarioEndereco_AtualizacaoUsuarioId_Usuario_UsuarioId]
END
GO

----
----	DROP PRIMARY KEY & DROP TABLE
----

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_UsuarioEndereco_UsuarioEnderecoId]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [PK_UsuarioEndereco_UsuarioEnderecoId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_UsuarioEndereco_UsuarioEnderecoId]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[UsuarioEndereco]
	DROP CONSTRAINT [PK_UsuarioEndereco_UsuarioEnderecoId]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsuarioEndereco]') AND type in (N'U')) BEGIN
	DROP TABLE [dbo].[UsuarioEndereco]
END
GO
