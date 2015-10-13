USE AvaleoAnalytics_STA
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HDJ Avaleo
-- Create date: 2010.11.16
-- Description: Genererer historik på borgere (sager)
-- =============================================
ALTER PROCEDURE [DBO].[usp_LavBorgerHistorik]
                 @Debug  as bit = 1 
                       
AS
DECLARE @cmd as varchar(max)
BEGIN

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_HJ'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_HJ'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  HJEMMEPLEJE_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  1 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_HJ ' +char(13)+ 
           'FROM SAGSHISTORIK ' +char(13)+
           'WHERE HJEMMEPLEJE_GRUPPEID is not null ' +char(13)+
           'ORDER BY SAGSID,HJEMMEPLEJE_GRUPPEID,IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_SP'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_SP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  SYGEPLEJE_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  5 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_SP ' +char(13)+ 
           'FROM SAGSHISTORIK ' +char(13)+
           'WHERE SYGEPLEJE_GRUPPEID is not null ' +char(13)+
           'ORDER BY SAGSID,SYGEPLEJE_GRUPPEID,IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_TP'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_TP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  TERAPEUT_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  3 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_TP ' +char(13)+ 
           'FROM SAGSHISTORIK ' +char(13)+
           'WHERE TERAPEUT_GRUPPEID is not null ' +char(13)+
           'ORDER BY SAGSID,TERAPEUT_GRUPPEID,IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_MAD'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_MAD'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  7777 AS BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_MAD ' +char(13)+ 
           'FROM SAGSHISTORIK ' +char(13)+
           'WHERE MADVISI_STATUSID is not null ' +char(13)+
           'ORDER BY SAGSID,IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''BORGER_TILHOER_HISTORIK'' AND type = ''U'') DROP TABLE dbo.BORGER_TILHOER_HISTORIK'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'INTO BORGER_TILHOER_HISTORIK ' +char(13)+ 
           'FROM SAGSHISTORIK_HJ ' +char(13)+
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_SP ' +char(13)+
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_SP ' +char(13)+         
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_MAD ' +char(13)+              
           ' '
if @debug = 1 print @cmd
exec (@cmd)
      
END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=3)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (3,GETDATE())           
end

