USE [AvaleoAnalytics_Staging_AVA]
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareBTP]    Script Date: 11/15/2010 14:07:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[usp_PrepareBTP]
		@DestinationDB as varchar(200),
		@SourceVagtplan as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS

DECLARE @cmd as varchar(max)

if @ExPart=1 
begin
       
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep1'' AND type = ''U'') DROP TABLE FactBTPStep1'
if @debug = 1 print @cmd
exec (@cmd)

--hent udført tid
set @cmd = 'SELECT ' +char(13)+ 
           '  MEDID, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  UDFOERT_TID+MOBIL_TID AS UDFOERTTID ' +char(13)+
           'INTO FactBTPStep1 ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' --Skal være fra FactPlanlagtUdfoert
exec (@cmd)           

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep2'' AND type = ''U'') DROP TABLE FactBTPStep2'
exec (@cmd)

--sæt BTP definition på
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep1.MEDID, ' +char(13)+
           '  FactBTPStep1.MED_ORG, ' +char(13)+
           '  FactBTPStep1.PK_DATE, ' +char(13)+
           '  FactBTPStep1.UDFOERTTID, ' +char(13)+
           '  COALESCE('+@DestinationDB+'.dbo.DimPakkeTyper.BTP, 9999) AS BTPDEFINITION, ' +char(13)+  --måske 9999
           '  '+@DestinationDB+'.dbo.DimBrugerTidsProcent.SORTERING '+char(13)+
           'INTO FactBTPStep2 ' +char(13)+
           'FROM FactBTPStep1 ' +char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimPakkeTyper ON FactBTPStep1.JOBID='+@DestinationDB+'.dbo.DimPakkeTyper.JOBID '+char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimBrugerTidsProcent ON '+@DestinationDB+'.dbo.DimPakkeTyper.BTP='+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID'  
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep3'' AND type = ''U'') DROP TABLE FactBTPStep3'
exec (@cmd)

----gruppér og summér
set @cmd = 'SELECT ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  BTPDEFINITION, ' +char(13)+
        --   '  BTPKATEGORI, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  SUM(UDFOERTTID) AS UDFOERTTID, ' +char(13)+
           '  SORTERING ' +char(13)+ 
           'INTO FactBTPStep3 ' +char(13)+
           'FROM factbtpstep2 ' +char(13)+
           'GROUP BY MEDID, MED_ORG, BTPDEFINITION, PK_DATE, SORTERING ' +char(13)+
           'ORDER BY MEDID,PK_DATE'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep4'' AND type = ''U'') DROP TABLE FactBTPStep4'
exec (@cmd)

--sæt tjenestetid på SKAL TILPASSES HVIS KMD VAGTPLAN
set @cmd = 'SELECT ' +char(13)+
           '  FactBTPStep3.MEDID, ' +char(13)+
           '  FactBTPStep3.MED_ORG, ' +char(13)+
           '  FactBTPStep3.BTPDEFINITION, ' +char(13)+
           '  FactBTPStep3.PK_DATE, ' +char(13)+
           '  FactBTPStep3.UDFOERTTID, ' +char(13)+
           '  COALESCE(('+@SourceVagtplan+'.dbo.FactVAgtplanBTPFremmoede.TJENESTETID_MINUTTER),0) AS TJENESTETID, ' +char(13)+
          -- '  COALESCE((AvaleoAnalyticsDW.dbo.FactTimerPlan.PlanlagtTimer*60),0) AS TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep3.SORTERING ' +char(13)+
           'INTO FactBTPStep4  ' +char(13)+
           'FROM FactBTPStep3' +char(13)+
           'JOIN '+@SourceVagtplan+'.dbo.FactVAgtplanBTPFremmoede ON FactBTPStep3.MEDID='+@SourceVagtplan+'.dbo.FactVAgtplanBTPFremmoede.MEDID AND' +char(13)+
           '  FactBTPStep3.PK_DATE='+@SourceVagtplan+'.dbo.FactVAgtplanBTPFremmoede.PK_DATE AND '+@SourceVagtplan+'.dbo.FactVAgtplanBTPFremmoede.TJENESTETID_MINUTTER IS NOT NULL' --skal muligvis fjernse           
           --'JOIN AvaleoAnalyticsDW.dbo.FactTimerPlan ON FactBTPStep3.MEDID=AvaleoAnalyticsDW.dbo.FactTimerPlan.MEDID AND' +char(13)+
           --'  FactBTPStep3.PK_DATE=AvaleoAnalyticsDW.dbo.FactTimerPlan.PK_DATE AND AvaleoAnalyticsDW.dbo.FactTimerPlan.PlanlagtTimer IS NOT NULL' --skal muligvis fjernes
exec (@cmd)  

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPAnvendtDefinition'' AND type = ''U'') DROP TABLE FactBTPAnvendtDefinition'
exec (@cmd)

--find anvendte btpdefinitioner
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  BTPID AS BTPDEFINITION, ' +char(13)+
           '  SORTERING ' +char(13)+
           'INTO FactBTPAnvendtDefinition ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.DimBrugerTidsProcent' +char(13)+
           'JOIN JOBTYPER ON '+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID=JOBTYPER.BTP ' +char(13)+
           'JOIN AvaleoAnalyticsDW_AVA.dbo.FactPlanlagtUdfoert ON JOBTYPER.JOBID=AvaleoAnalyticsDW_AVA.dbo.FactPlanlagtUdfoert.JOBID '
if @debug = 1 print @cmd           
exec (@cmd)  

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPTommeRaekker'' AND type = ''U'') DROP TABLE FactBTPTommeRaekker'
exec (@cmd)  

--indsæt tomme rækker i union tabel så summéring passer
set @cmd = 'SELECT DISTINCT ' +char(13)+ 
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+
           '  B.BTPDEFINITION, ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  A.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  0 AS SORTERING ' +char(13)+
           'INTO FactBTPTommeRaekker ' +char(13)+
           'FROM FactBTPStep4 A' +char(13)+
           'RIGHT OUTER JOIN FactBTPAnvendtDefinition B ON A.BTPDEFINITION<>B.BTPDEFINITION'
exec (@cmd)

--slet dubletter
set @cmd = 'DELETE FROM FactBTPTommeRaekker ' +char(13)+  
           'WHERE EXISTS(SELECT * FROM FactBTPStep4 WHERE ' +char(13)+
           '  FactBTPTommeRaekker.MEDID=FactBTPStep4.MEDID AND ' +char(13)+  
           '  FactBTPTommeRaekker.PK_DATE=FactBTPStep4.PK_DATE AND ' +char(13)+
           '  FactBTPTommeRaekker.BTPDEFINITION=FactBTPStep4.BTPDEFINITION)'
exec (@cmd)           

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep5FremMoedeArbTid'' AND type = ''U'') DROP TABLE FactBTPStep5FremMoedeArbTid'
exec (@cmd) 

--mødetid og arbejdstid til union        
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  8888 AS BTPDEFINITION, ' +char(13)+  --8888 = btp fremmødetid
         --  '  8888 AS BTPKATEGORI, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS TJENESTETID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS ARBEJDSTID,' +char(13)+
           '  14 AS SORTERING ' +char(13)+
           'INTO FactBTPStep5FremMoedeArbTid ' +char(13)+
           'FROM FactBTPStep4' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep6TotalUdfoert'' AND type = ''U'') DROP TABLE FactBTPStep6TotalUdfoert'
exec (@cmd)

--summér udførttid til ledigtid til union
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep3.MEDID, ' +char(13)+ 
           '  FactBTPStep3.MED_ORG,' +char(13)+ 
           '  7777 AS BTPDEFINITION, ' +char(13)+ --7777 = btp ledigtid
        --   '  7777 AS BTPKATEGORI, ' +char(13)+
           '  FactBTPStep3.PK_DATE, ' +char(13)+ 
           '  SUM(FactBTPStep3.UDFOERTTID) AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep5FremMoedeArbTid.TJENESTETID, ' +char(13)+  
           '  0 AS ARBEJDSTID, ' +char(13)+ 
           '  12 AS SORTERING ' +char(13)+
           'INTO  FactBTPStep6TotalUdfoert' +char(13)+ 
           'FROM FactBTPStep3' +char(13)+ 
           'JOIN FactBTPStep5FremMoedeArbTid ON FactBTPStep3.MEDID=FactBTPStep5FremMoedeArbTid.MEDID AND ' +char(13)+
           '  FactBTPStep3.PK_DATE=FactBTPStep5FremMoedeArbTid.PK_DATE ' +char(13)+
           'GROUP BY FactBTPStep3.MEDID, FactBTPStep3.MED_ORG, FactBTPStep3.PK_DATE, FactBTPStep5FremMoedeArbTid.TJENESTETID' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBTP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBTP'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep7Vejtid'' AND type = ''U'') DROP TABLE FactBTPStep7Vejtid'
exec (@cmd)

--saml det hele i FactBTP
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+ 
           '  FactBTPStep4.BTPDEFINITION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+ 
           '  FactBTPStep4.UDFOERTTID, ' +char(13)+ 
           '  FactBTPStep4.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep4.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep4.SORTERING '  +char(13)+
           'INTO '+@DestinationDB+'.dbo.FactBTP ' +char(13)+ 
           'FROM FactBTPStep4' +char(13)+ 
           'UNION ALL ' +char(13)+ 
           'SELECT ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.MEDID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.MED_ORG, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.BTPDEFINITION, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.PK_DATE, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.UDFOERTTID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.SORTERING ' +char(13)+ 
           'FROM FactBTPStep5FremMoedeArbTid' +char(13)+ 
           'UNION ALL ' +char(13)+ 
           'SELECT ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.MEDID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.MED_ORG, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.BTPDEFINITION, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.PK_DATE, ' +char(13)+
           'CASE WHEN FactBTPStep6TotalUdfoert.TJENESTETID>0 THEN ' +char(13)+
           ''+char(13)+
           ''+char(13)+ 
           '  (FactBTPStep6TotalUdfoert.TJENESTETID-FactBTPStep6TotalUdfoert.UDFOERTTID)  ' +char(13)+ 
           ''+char(13)+
           'ELSE 0 '+char(13)+
           'END AS UDFOERTTID, '+char(13)+
           '  FactBTPStep6TotalUdfoert.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.SORTERING ' +char(13)+
           'FROM FactBTPStep6TotalUdfoert ' +char(13)+  
           'UNION ALL' +char(13)+ 
           'SELECT ' +char(13)+
           '  FactBTPTommeRaekker.MEDID, ' +char(13)+
           '  FactBTPTommeRaekker.MED_ORG, ' +char(13)+
           '  FactBTPTommeRaekker.BTPDEFINITION, ' +char(13)+
           '  FactBTPTommeRaekker.PK_DATE, ' +char(13)+
           '  FactBTPTommeRaekker.UDFOERTTID, ' +char(13)+
           '  FactBTPTommeRaekker.TJENESTETID, ' +char(13)+
           '  FactBTPTommeRaekker.ARBEJDSTID, ' +char(13)+
           '  FactBTPTommeRaekker.SORTERING ' +char(13)+
           'FROM FactBTPTommeRaekker' +char(13)+
           'UNION ALL ' +char(13)+ --direkte borgertid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  6666 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  1 AS SORTERING ' +char(13)+
           'FROM FactBTPStep4 ' +char(13)+
           'UNION ALL ' +char(13)+ --indirekte borgertid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  5555 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  4 AS SORTERING ' +char(13)+
           'FROM   FactBTPStep4 ' +char(13)+
          'UNION ALL ' +char(13)+ --kvalifikationstid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  4444 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  8 AS SORTERING ' +char(13)+
           'FROM   FactBTPStep4 '          
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (9,10,11) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 4444' 
           
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (6,7,8) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 5555' 
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (1,2) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 6666' 
exec (@cmd)   
           
set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET SORTERING= ' +char(13)+
           '  (SELECT SORTERING FROM '+@DestinationDB+'.dbo.DimBrugerTidsProcent ' +char(13)+
           '   WHERE '+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID='+@DestinationDB+'.DBO.FactBTP.BTPDEFINITION) '
exec (@cmd)                            
           
           
--if @debug = 1 print @cmd
exec (@cmd)
end
