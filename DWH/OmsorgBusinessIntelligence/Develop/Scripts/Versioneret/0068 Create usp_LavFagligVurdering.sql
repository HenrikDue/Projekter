USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavFagligVurdering]    Script Date: 08/13/2012 13:44:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[usp_LavFagligVurdering] 
                @DestinationDB as varchar(200) ,
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

/*create dimension*/
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFagligvurdering'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFagligvurdering'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  ID AS DIM_FAGLIGVURD_ID, '+char(13)+
           '  CONVERT(varchar(5),AKTIVNIVEAU1)+ '+'''   '''+'+ CONVERT(varchar(100),AKTIVITET) AS AKTIVITET_NIVEAU '+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimFagligvurdering '+char(13)+ 
           'FROM AKTIVITETER '+char(13)+
           'WHERE FALLES_SPROG_ART=2 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)  

/*create fact*/  
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''aFagligVurdering_1'' AND type = ''U'') DROP TABLE dbo.aFagligVurdering_1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.ID AS VISI_ID, '+char(13)+
           'HJ.SAGSID, '+char(13)+
           '(SELECT CPRNR from SAGER SA WHERE HJ.SAGSID=SA.SAGSID) CPRNR, '+char(13)+   
           'HJ.IKRAFTDATO VISI_IKRAFTDATO, '+char(13)+
           'HJ.SLUTDATO VISI_SLUTDATO, '+char(13)+
           'AK.ID AS DIM_FAGLIGVURD_ID, '+char(13)+
           'FA.RELEVANT, '+char(13)+
           'VU.NIVEAU '+char(13)+
           'INTO aFagligVurdering_1 '+char(13)+ 
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN FAGLIGVURDERING FA ON HJ.ID=FA.VISI_ID AND FA.VISI_TYPE=0 '+char(13)+
           'JOIN VURDERINGSNIV VU ON FA.VURDNIV_ID=VU.ID AND VU.FALLES_SPROG_ART=2 '+char(13)+
           'JOIN AKTIVITETER AK ON FA.AKTIVITET_ID=AK.ID AND AK.FALLES_SPROG_ART=2 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
 
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''aFagligVurdering_2'' AND type = ''U'') DROP TABLE dbo.aFagligVurdering_2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'DWH.PK_DATE, '+char(13)+
           'A.SAGSID, '+char(13)+
           'A.CPRNR, '+char(13)+
           'A.VISI_IKRAFTDATO, '+char(13)+
           'A.VISI_SLUTDATO, '+char(13)+
           'A.DIM_FAGLIGVURD_ID, '+char(13)+
           'CAST(A.NIVEAU AS NUMERIC(10,2)) AS NIVEAU '+char(13)+
           'INTO aFagligVurdering_2 '+char(13)+ 
           'FROM aFagligVurdering_1 A '+char(13)+
           'JOIN DimWeekendHelligdag DWH ON DWH.PK_DATE>=A.VISI_IKRAFTDATO AND DWH.PK_DATE<A.VISI_SLUTDATO AND '+char(13)+
           '  DWH.PK_DATE > ''2008-01-01'' AND DWH.PK_DATE < GETDATE() '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_FagligVurdering'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_FagligVurdering'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'A.PK_DATE, '+char(13)+
           'A.SAGSID, '+char(13)+
           'COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           'COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           'COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+  
           'COALESCE(DBO.AGE((A.CPRNR),A.PK_DATE),0) AS ALDER, '+char(13)+ 
           'A.DIM_FAGLIGVURD_ID, '+char(13)+
           'A.NIVEAU '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_FagligVurdering '+char(13)+ 
           'FROM aFagligVurdering_2 A '+char(13)+
           'LEFT JOIN BORGER_TILHOER_HISTORIK BTH ON A.SAGSID=BTH.SAGSID AND '+char(13)+
           '  A.PK_DATE>=BTH.IKRAFTDATO AND A.PK_DATE<BTH.SLUTDATO AND BTH.PLEJETYPE=1 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_Sta.dbo.VERSION WHERE VERSION=68)
if @version is null
begin
INSERT INTO AvaleoAnalytics_Staa.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (68,GETDATE())           
end

END 
