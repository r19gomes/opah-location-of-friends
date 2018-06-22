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


IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CalculoHistoricoLog_UsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[CalculoHistoricoLog]
	DROP CONSTRAINT [FK_CalculoHistoricoLog_UsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CalculoHistoricoLog_CadastroUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[CalculoHistoricoLog]
	DROP CONSTRAINT [FK_CalculoHistoricoLog_CadastroUsuarioId_Usuario_UsuarioId]
END
GO

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_CalculoHistoricoLog_AtualizacaoUsuarioId_Usuario_UsuarioId]') AND type in (N'F')) BEGIN
	ALTER TABLE [dbo].[CalculoHistoricoLog]
	DROP CONSTRAINT [FK_CalculoHistoricoLog_AtualizacaoUsuarioId_Usuario_UsuarioId]
END
GO

--
--	DROP PRIMARY KEY & DROP TABLE
--

IF	EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_CalculoHistoricoLog_CalculoHistoricoLogId]') AND type in (N'PK')) BEGIN
	ALTER TABLE [dbo].[CalculoHistoricoLog]
	DROP CONSTRAINT [PK_CalculoHistoricoLog_CalculoHistoricoLogId]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CalculoHistoricoLog]') AND type in (N'U')) BEGIN
	DROP TABLE [dbo].[CalculoHistoricoLog]
END
GO
