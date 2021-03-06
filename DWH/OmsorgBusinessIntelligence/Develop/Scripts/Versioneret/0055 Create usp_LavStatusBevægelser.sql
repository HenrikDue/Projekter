USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavStatusBevægelser]    Script Date: 11/21/2011 08:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_LavStatusBevægelser]
                       @DestinationDB as varchar(200)= 'AvaleoAnalytics_DW',
		               @ExPart as Int=0,  
                       @Debug  as bit = 1              
                       
AS
DECLARE @cmd as varchar(max)
BEGIN

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_SagsstatusHistorik'' AND type = ''U'') DROP TABLE dbo.tmp_SagsstatusHistorik'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd='SELECT'+char(13)+ -- hjemmepleje
         '  SH.ID HISTORIK_ID,'+char(13)+
         '  SH.SAGSID,'+char(13)+
         '  SH.IKRAFTDATO,'+char(13)+
         '  SH.SLUTDATO,'+char(13)+
         '  (SH.HJEMMEPLEJE_STATUSID*10000000)+SH.SAGSID DIST_STATUS_COUNT,'+char(13)+ --til distinct count
         '  10000000+SH.SAGSID PLEJETYPE_SAGSID,'+char(13)+ --differentier mellem plejetype på borger
         '  1 PLEJETYPE,'+char(13)+  --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
         '  SH.HJEMMEPLEJE_STATUSID FAGFANESTATUSID,'+char(13)+
         '  SS.SAGAKTIV, '+char(13)+
         '  COALESCE(SH.HJEMMEPLEJE_GRUPPEID,9999) BORGER_ORG'+char(13)+
         'INTO tmp_SagsstatusHistorik'+char(13)+
         'FROM SAGSHISTORIK SH'+char(13)+
         'JOIN SAGSSTATUS SS ON SH.HJEMMEPLEJE_STATUSID=SS.SAGSSTATUSID '+char(13)+
         'JOIN DimSager DS ON SH.SAGSID=DS.SAGSID AND DS.SAGSTYPE=1'+char(13)+ 
         'where SH.HJEMMEPLEJE_STATUSID is not null'+char(13)+
         'UNION ALL'+char(13)+
         'SELECT'+char(13)+ -- sygepleje
         '  SH.ID HISTORIK_ID,'+char(13)+
         '  SH.SAGSID,'+char(13)+
         '  SH.IKRAFTDATO,'+char(13)+
         '  SH.SLUTDATO,'+char(13)+
         '  (SH.SYGEPLEJE_STATUSID*10000000)+SH.SAGSID DIST_STATUS_COUNT,'+char(13)+ --til distinct count
         '  50000000+SH.SAGSID PLEJETYPE_SAGSID,'+char(13)+
         '  5 PLEJETYPE,'+char(13)+
         '  SH.SYGEPLEJE_STATUSID FAGFANESTATUSID,'+char(13)+
         '  SS.SAGAKTIV, '+char(13)+
         '  COALESCE(SH.SYGEPLEJE_GRUPPEID,9999) BORGER_ORG'+char(13)+
         'FROM SAGSHISTORIK SH'+char(13)+
         'JOIN SAGSSTATUS SS ON SH.HJEMMEPLEJE_STATUSID=SS.SAGSSTATUSID '+char(13)+
         'JOIN DimSager DS ON SH.SAGSID=DS.SAGSID AND DS.SAGSTYPE=1 '+char(13)+ 
         'where SH.SYGEPLEJE_STATUSID is not null'+char(13)+
         'UNION ALL'+char(13)+
         'SELECT'+char(13)+ -- træning
         '  SH.ID HISTORIK_ID,'+char(13)+
         '  SH.SAGSID,'+char(13)+
         '  SH.IKRAFTDATO,'+char(13)+
         '  SH.SLUTDATO,'+char(13)+
         '  (SH.TERAPEUT_STATUSID*10000000)+SH.SAGSID DIST_STATUS_COUNT,'+char(13)+ --til distinct count
         '  30000000+SH.SAGSID PLEJETYPE_SAGSID,'+char(13)+
         '  3 PLEJETYPE,'+char(13)+
         '  SH.TERAPEUT_STATUSID FAGFANESTATUSID,'+char(13)+
         '  SS.SAGAKTIV, '+char(13)+
         '  COALESCE(SH.TERAPEUT_GRUPPEID,9999) BORGER_ORG'+char(13)+
         'FROM SAGSHISTORIK SH'+char(13)+
         'JOIN SAGSSTATUS SS ON SH.HJEMMEPLEJE_STATUSID=SS.SAGSSTATUSID '+char(13)+
         'JOIN DimSager DS ON SH.SAGSID=DS.SAGSID AND DS.SAGSTYPE=1 '+char(13)+ 
         'where SH.TERAPEUT_STATUSID is not null'+char(13)+   
         'UNION ALL'+char(13)+
         'SELECT'+char(13)+ -- mad
         '  SH.ID HISTORIK_ID,'+char(13)+
         '  SH.SAGSID,'+char(13)+
         '  SH.IKRAFTDATO,'+char(13)+
         '  SH.SLUTDATO,'+char(13)+
         '  (SH.MADVISI_STATUSID*10000000)+SH.SAGSID DIST_STATUS_COUNT,'+char(13)+ --til distinct count
         '  60000000+SH.SAGSID PLEJETYPE_SAGSID,'+char(13)+
         '  6 PLEJETYPE,'+char(13)+
         '  SH.MADVISI_STATUSID FAGFANESTATUSID,'+char(13)+
         '  SS.SAGAKTIV, '+char(13)+
         '  7777 BORGER_ORG'+char(13)+
         'FROM SAGSHISTORIK SH'+char(13)+
         'JOIN SAGSSTATUS SS ON SH.HJEMMEPLEJE_STATUSID=SS.SAGSSTATUSID '+char(13)+
         'JOIN DimSager DS ON SH.SAGSID=DS.SAGSID AND DS.SAGSTYPE=1 '+char(13)+ 
         'where SH.MADVISI_STATUSID is not null'+char(13)+     
         'ORDER BY SH.SAGSID,PLEJETYPE,SH.ID'+char(13)
         
if @debug = 1 print @cmd         
exec(@cmd) 

--generer primo/ultimo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_SagsstatusBevaegelser'' AND type = ''U'') DROP TABLE dbo.tmp_SagsstatusBevaegelser'
if @debug = 1 print @cmd
exec (@cmd)        

set @cmd='SELECT'+char(13)+
         '  A.*,'+char(13)+
         --'  B.PK_DATE,'+char(13)+
         '  (B.PK_DATE+1) AS PK_DATE,'+char(13)+
         '  1 AS SPECIFIKATION_NY '+char(13)+ -- 1=primo 2=tilgang 3=afgang 4=ultimo
         'INTO tmp_SagsstatusBevaegelser'+char(13)+
         'FROM tmp_SagsstatusHistorik A'+char(13)+
         'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND'+char(13)+
      --   'JOIN DimWeekendHelligdag B ON (A.IKRAFTDATO>=(B.PK_DATE-B.DAYSINMONTH+1)) AND (A.IKRAFTDATO<=B.PK_DATE) AND'+char(13)+
         '  (B.PK_DATE BETWEEN ''2007-12-31'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH AND'+char(13)+
         '  SAGAKTIV IN (1,2)'+char(13)+
         'UNION ALL '+char(13)+
         'SELECT'+char(13)+
         '  A.*,'+char(13)+
         '  B.PK_DATE,'+char(13)+
         '  4 AS SPECIFIKATION_NY '+char(13)+ --ultimo 
         'FROM tmp_SagsstatusHistorik A'+char(13)+
         'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND'+char(13)+
       --  'JOIN DimWeekendHelligdag B ON (A.IKRAFTDATO>=(B.PK_DATE-B.DAYSINMONTH+1)) AND (A.IKRAFTDATO<=B.PK_DATE) AND'+char(13)+
         '  (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH AND'+char(13)+    
         '  SAGAKTIV IN (1,2)'+char(13)+    
         'ORDER BY SAGSID,PK_DATE'+char(13)
if @debug = 1 print @cmd         
exec(@cmd)

SET NOCOUNT ON; 

--loop igennem historik og find statusskift til til- og afgang
DECLARE @historik_id integer
DECLARE @plejetype_sagsid integer
DECLARE @fagfanestatusid integer
DECLARE @old_historik_id integer
DECLARE @old_plejetype_sagsid integer
DECLARE @old_fagfanestatusid integer
DECLARE @ikraftdato date

DECLARE FindStatusSkift CURSOR FAST_FORWARD FOR
SELECT HISTORIK_ID,PLEJETYPE_SAGSID,FAGFANESTATUSID,IKRAFTDATO 
FROM tmp_SagsstatusHistorik  

set @old_plejetype_sagsid=0

OPEN FindStatusSkift
FETCH NEXT FROM FindStatusSkift
INTO @historik_id,@plejetype_sagsid,@fagfanestatusid,@ikraftdato

WHILE @@fetch_status = 0
BEGIN
  -- 1=primo 2=tilgang 3=afgang 4=ultimo
  --  tilgang, find første gang borger figurerer i historik og indsæt  
  IF (@ikraftdato>='2008-01-01') 
  BEGIN
    
  IF (@plejetype_sagsid<>@old_plejetype_sagsid) 
  BEGIN
    INSERT INTO tmp_SagsstatusBevaegelser
    SELECT HISTORIK_ID,SAGSID,IKRAFTDATO,SLUTDATO,DIST_STATUS_COUNT,PLEJETYPE_SAGSID,PLEJETYPE,FAGFANESTATUSID,SAGAKTIV,BORGER_ORG,IKRAFTDATO,2 --IKRAFTDATO som pk_date, 2=tilgang
    FROM tmp_SagsstatusHistorik WHERE HISTORIK_ID=@historik_id AND PLEJETYPE_SAGSID=@plejetype_sagsid 
  END
  --  til- og afgang, find statusskift og indsæt som tilgang på ny status og afgang på tidligere status
  ELSE IF (@fagfanestatusid<>@old_fagfanestatusid)
  BEGIN
    INSERT INTO tmp_SagsstatusBevaegelser
    SELECT HISTORIK_ID,SAGSID,IKRAFTDATO,SLUTDATO,DIST_STATUS_COUNT,PLEJETYPE_SAGSID,PLEJETYPE,FAGFANESTATUSID,SAGAKTIV,BORGER_ORG,IKRAFTDATO,2 --IKRAFTDATO som pk_date, 2=tilgang
    FROM tmp_SagsstatusHistorik WHERE HISTORIK_ID=@historik_id AND PLEJETYPE_SAGSID=@plejetype_sagsid   
    INSERT INTO tmp_SagsstatusBevaegelser
    SELECT HISTORIK_ID,SAGSID,IKRAFTDATO,SLUTDATO,DIST_STATUS_COUNT,PLEJETYPE_SAGSID,PLEJETYPE,FAGFANESTATUSID,SAGAKTIV,BORGER_ORG,SLUTDATO,3 --SLUTDATO som pk_date, 3=afgang
    FROM tmp_SagsstatusHistorik WHERE HISTORIK_ID=@old_historik_id AND PLEJETYPE_SAGSID=@plejetype_sagsid 
  END
  
  END
     
  set @old_historik_id=@historik_id
  set @old_plejetype_sagsid=@plejetype_sagsid
  set @old_fagfanestatusid=@fagfanestatusid
  
  FETCH NEXT FROM FindStatusSkift 
  INTO @historik_id,@plejetype_sagsid,@fagfanestatusid,@ikraftdato

END
 
CLOSE FindStatusSkift
DEALLOCATE FindStatusSkift

set @cmd = 'DELETE FROM dbo.tmp_SagsstatusBevaegelser where PK_DATE<''2008-01-01'''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_StatusBevaegelser'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_StatusBevaegelser'
if @debug = 1 print @cmd
exec (@cmd)

--overfør nødvendige data til DW

set @cmd = 'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  DIST_STATUS_COUNT, '+char(13)+
           '  FAGFANESTATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'INTO '+@DestinationDB+'.DBO.Fact_StatusBevaegelser'+char(13)+
           'FROM tmp_SagsstatusBevaegelser'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)                   

END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=55)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (55,GETDATE())           
end
