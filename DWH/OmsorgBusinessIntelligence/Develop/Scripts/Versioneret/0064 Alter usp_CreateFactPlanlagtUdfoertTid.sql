USE [AvaleoAnalytics_Sta] 
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateFactPlanlagtUdfoertTid]    Script Date: 02/17/2011 10:38:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Henrik Due Jensen
-- Create date: 2010-10-08
-- Description:	Planlagt og udført tid fra Tkorttavle
-- OBS OBS bruges til BTP beregning - PAS PÅ ændringer
-- =============================================
ALTER PROCEDURE [dbo].[usp_CreateFactPlanlagtUdfoertTid] 
                    @DestinationDB as varchar(200),@ExPart as Int=0,@Debug  as bit = 1
AS
DECLARE @cmd as varchar(max)
DECLARE @vejtidibesoeg as varchar(1)

SET @vejtidibesoeg = (select * from openquery(OMSORG,'select tkvejtid from opsatning'))
print @vejtidibesoeg

if @ExPart=1 or @ExPart=0
begin
set @cmd = 'DELETE FROM SAGSPLAN WHERE STARTDATO > SLUTDATO'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep1'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep1'
if @debug = 1 print @cmd
exec (@cmd)
--hent alle data fra sagsplan
set @cmd = 'SELECT ' +char(13)+
           '  SP.ID AS SERIEID, ' +char(13)+
           '  SA.SAGSID, ' +char(13)+
           '  SA.CPRNR, ' +char(13)+
           '  SA.SAGSTYPE,' +char(13)+
           '  SP.STARTDATO, ' +char(13)+
           '  SP.SLUTDATO, ' +char(13)+
           '  COALESCE((SELECT MEDARBEJDERTYPE FROM MEDARBEJDERE WHERE MEDARBEJDERID=SP.MEDID),1) AS MEDARB_TYPE,' +char(13)+
           '  COALESCE(SP.MEDID,9999) AS MEDID, ' +char(13)+
           '  SP.VEJTID, ' +char(13)+
           '  SP.FREKVENS, ' +char(13)+
           '  SP.FREKTYPE, ' +char(13)+
           '  SP.FREKVALGTEDAGE, ' +char(13)+
           '  SP.YDELSESTID, ' +char(13)+
           '  (SELECT COUNT(*) FROM SAGSPDET WHERE SP.ID = SAGSPDET.SAGSPID) AS ANTAL_INDSATSE, ' +char(13)+
           '  dbo.Udf_SaetDoegninddeling(SP.STARTMINEFTERMIDNAT) AS DOEGNINDDELING ' +char(13)+
           'INTO PlanlagtUdfoertStep1 ' +char(13)+
           'FROM SAGSPLAN SP ' +char(13)+
           'JOIN SAGER SA ON SA.SAGSID=SP.SAGSID ' +char(13)+
           'WHERE (SP.SLUTDATO>=CONVERT(DATETIME,''2009-01-01 00:00:00'',102))' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep2'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep2'
if @debug = 1 print @cmd
exec (@cmd)
--rul besøg ud, MEN kun besøg der ikke er rettet
set @cmd = 'SELECT' +char(13)+  --HUSK
           '  Dim_Time.PK_DATE, ' +char(13)+
           '  A.SERIEID, ' +char(13)+
           '  A.SAGSID, ' +char(13)+                   
           '  A.SAGSTYPE,' +char(13)+
           '  dbo.Age(A.CPRNR,Dim_Time.PK_DATE) AS ALDER, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  COALESCE((SELECT UAFDELINGID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS MED_ORG, ' +char(13)+ 
           '  COALESCE((SELECT MEDARBEJDER_STATUSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS MEDARBEJDER_STATUSID, ' +char(13)+
           '  COALESCE((SELECT STILLINGSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS STILLINGSID, ' +char(13)+                        
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.ANTAL_INDSATSE, ' +char(13)+
           '  A.VEJTID, ' +char(13)+  
           '  A.YDELSESTID,' +char(13)+ --denne skal IKKE tælles med da det er hele besøget
           '  1 AS BESOEGSSTATUSID '+char(13)+
           'INTO PlanlagtUdfoertStep2 ' +char(13)+
           'FROM PlanlagtUdfoertStep1 A ' +char(13)+
           'JOIN Dim_Time ON Dim_Time.PK_Date between ''2009.01.01'' and GETDATE() ' +char(13)+ 
           'WHERE dbo.SERIES_OCCURS_ON_DAY(Dim_Time.PK_Date,FREKVENS,FREKTYPE,FREKVALGTEDAGE,STARTDATO) = 1 AND ' +char(13)+
           '  NOT EXISTS(SELECT * FROM SAGSPLANRET WHERE SERIEID=A.SERIEID AND SERIEDATO=PK_DATE) AND ' +char(13)+
           '  A.STARTDATO<=PK_DATE AND A.SLUTDATO>PK_DATE ' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep3'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep3'
if @debug = 1 print @cmd
exec (@cmd)
--hent detaljer på sagsplan         
set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE ,' +char(13)+
           '  A.SAGSID, ' +char(13)+     
           '  A.ALDER, ' +char(13)+  
           '  CASE WHEN (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPD.JOBID)=1 THEN ' +char(13)+
           '    (SELECT PLEJETYPE FROM JOBTYPER WHERE JOBID=SPD.JOBID)' +char(13)+
           '  ELSE ' +char(13)+
           '    (SELECT PARAGRAF_GRUPPERING.ID FROM JOBTYPER ' +char(13)+
           '    JOIN PARATYPER ON JOBTYPER.PARAGRAF=PARATYPER.ID AND JOBTYPER.FALLES_SPROG_ART=2 AND JOBTYPER.JOBID=SPD.JOBID' +char(13)+
           '    JOIN PARAGRAF_GRUPPERING ON PARATYPER.PARAGRAF_GRUPPERING_ID=PARAGRAF_GRUPPERING.ID)' +char(13)+
           '  END AS PLEJETYPE,' +char(13)+
           '  (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPD.JOBID) AS FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.VEJTID AS SPVEJTID, ' +char(13)+ 
           '  A.ANTAL_INDSATSE, ' +char(13)+
           '  CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '    Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '  ELSE ' +char(13)+ 
           '    A.VEJTID' +char(13)+ 
           '  END AS VEJTID, ' +char(13)+ 
           '  SPD.JOBID, ' +char(13)+ 
           '  SPD.NORMTID AS VISITERET_TID, ' +char(13)+ --visiterede tid
           '  SPD.YDELSESTID AS PLANLAGT_TID , ' +char(13)+  --planlagte tid 
           '  SPD.VISITYPE, ' +char(13)+
           '  A.BESOEGSSTATUSID, ' +char(13)+
           '  ''Planlagt + Udført'' AS STATISTIKTYPE ' +char(13)+
           'INTO PlanlagtUdfoertStep3 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep2 A ' +char(13)+
           'JOIN SAGSPDET SPD ON A.SERIEID = SPD.SAGSPID ' 
exec (@cmd)

set @cmd = 'UPDATE PlanlagtUdfoertStep3 SET PLEJETYPE=1 WHERE PLEJETYPE IN (1,2,8)'
exec (@cmd)
set @cmd = 'UPDATE PlanlagtUdfoertStep3 SET PLEJETYPE=3 WHERE PLEJETYPE IN (3,4)'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep4'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep4'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.ALDER, ' +char(13)+ 
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK ' +char(13)+
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND ' +char(13)+
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND ' +char(13)+
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND ' +char(13)+
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG,  ' +char(13)+   
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+ 
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+           
           '  A.PLEJETYPE, ' +char(13)+
           '  A.FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.MED_ORG, ' +char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.VEJTID AS PLANLAGT_VEJTID, ' +char(13)+
           '  A.VEJTID AS UDFOERT_VEJTID, ' +char(13)+
           '  A.JOBID, ' +char(13)+
           '  A.VISITERET_TID, ' +char(13)+
           '  A.PLANLAGT_TID, ' +char(13)+
           '  A.VISITYPE, ' +char(13)+
           '  A.BESOEGSSTATUSID, ' +char(13)+
           '  A.STATISTIKTYPE ' +char(13)+
           'INTO PlanlagtUdfoertStep4 ' +char(13)+
           'FROM PlanlagtUdfoertStep3 A' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep5'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep5'
if @debug = 1 print @cmd
exec (@cmd)
--hent alle data fra sagsplanret 
set @cmd = 'SELECT' +char(13)+  --HUSK
           '  SPR.RETDATO AS PK_DATE,' +char(13)+
           '  SPR.ID AS SPRID, ' +char(13)+
           '  SA.SAGSID, ' +char(13)+ 
           '  dbo.Age(SA.CPRNR,SPR.RETDATO) AS ALDER, ' +char(13)+
           '  SA.SAGSTYPE,' +char(13)+         
           '  COALESCE(SPR.MEDID,9999) AS MEDID,' +char(13)+
           '  COALESCE((SELECT UAFDELINGID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS MED_ORG, ' +char(13)+ 
           '  COALESCE((SELECT MEDARBEJDER_STATUSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  COALESCE((SELECT STILLINGSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS STILLINGSID, ' +char(13)+ 
           '  SPR.VEJTID, ' +char(13)+
           '  SPR.RVEJTID AS MOB_VEJTID, ' +char(13)+ 
           '  (SELECT COUNT(*) FROM SAGSPRETDET WHERE SPR.ID = SAGSPRETDET.SAGSPRETID) AS ANTAL_INDSATSE, ' +char(13)+
           '  SPR.YDELSESTID, ' +char(13)+
           '  dbo.Udf_SaetDoegninddeling(SPR.STARTMINEFTERMIDNAT) AS DOEGNINDDELING, ' +char(13)+
           '  SPR.REGBES, '  +char(13)+ 
           '  SPR.RSTART, ' +char(13)+ 
           '  dbo.Udf_SaetDoegninddeling(SPR.RSTART) AS MOBIL_DOEGNINDDELING, ' +char(13)+
           '  BES.STAT_TYPE AS BESOEG_STAT_TYPE, ' +char(13)+
           '  BES.STATUS AS BESOEG_STATUS, '+char(13)+
           '  SPR.STATUSID AS BESOEGSSTATUSID ' +char(13)+ 
           'INTO PlanlagtUdfoertStep5 ' +char(13)+
           'FROM SAGSPLANRET SPR ' +char(13)+
           'JOIN SAGER SA ON SA.SAGSID=SPR.SAGSID ' +char(13)+  
           'JOIN BESOGSTATUS BES ON BES.BESOGID=SPR.STATUSID ' +char(13)+ 
           'WHERE (SPR.RETDATO>=CONVERT(DATETIME,''2009-01-01 00:00:00'',102)) AND '  +char(13)+ 
           '  SPR.RETDATO<GETDATE() '
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep6'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep6'
if @debug = 1 print @cmd
exec (@cmd)
--hent PLANLAGTE detaljer på sagsplanret         
set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE ,' +char(13)+
           '  A.SAGSID, ' +char(13)+  
           '  A.ALDER, ' +char(13)+ 
           '  CASE WHEN (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPRD.JOBID)=1 THEN ' +char(13)+
           '    (SELECT PLEJETYPE FROM JOBTYPER WHERE JOBID=SPRD.JOBID)' +char(13)+
           '  ELSE ' +char(13)+
           '    (SELECT PARAGRAF_GRUPPERING.ID FROM JOBTYPER ' +char(13)+
           '    JOIN PARATYPER ON JOBTYPER.PARAGRAF=PARATYPER.ID AND JOBTYPER.FALLES_SPROG_ART=2 AND JOBTYPER.JOBID=SPRD.JOBID' +char(13)+
           '    JOIN PARAGRAF_GRUPPERING ON PARATYPER.PARAGRAF_GRUPPERING_ID=PARAGRAF_GRUPPERING.ID)' +char(13)+
           '  END AS PLEJETYPE,' +char(13)+ 
           '  (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPRD.JOBID) AS FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.MOBIL_DOEGNINDDELING, ' +char(13)+ 
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,2) THEN ' +char(13)+ --Planlagte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS PLANLAGT_VEJTID, ' +char(13)+     
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,3) THEN ' +char(13)+  --Udførte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS UDFOERT_VEJTID, ' +char(13)+ 
           '  CASE WHEN A.REGBES=1 THEN ' +char(13)+  --Mobil udførte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.MOB_VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.MOB_VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS MOB_VEJTID, ' +char(13)+                              
           '  A.REGBES, ' +char(13)+ 
           '  SPRD.JOBID, ' +char(13)+ 
           '  SPRD.STATUSID, ' +char(13)+
           '  SPRD.NORMTID AS VISITERET_TID, ' +char(13)+ --visiterede tid
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,2) THEN ' +char(13)+ --Planlagte besøg
           '    SPRD.YDELSESTID ' +char(13)+ 
           '  ELSE 0 ' +char(13)+ 
           '  END AS PLANLAGT_TID, ' +char(13)+  --planlagte tid 
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,3) THEN ' +char(13)+ --udført tid
           '    CASE WHEN SPRD.STATUSID=1 THEN ' +char(13)+  
           '      SPRD.YDELSESTID ' +char(13)+ 
           '    ELSE ' +char(13)+ 
           '      SPRD.AFVIGELSE ' +char(13)+  
           '    END ' +char(13)+ 
           '  ELSE 0 ' +char(13)+    
           '  END AS UDFOERT_TID, ' +char(13)+            
           '  SPRD.VISITYPE, ' +char(13)+
           '  A.BESOEG_STAT_TYPE, ' +char(13)+
           '  A.BESOEG_STATUS, ' +char(13)+
           '  A.BESOEGSSTATUSID ' +char(13)+
           'INTO PlanlagtUdfoertStep6 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep5 A ' +char(13)+
           'JOIN SAGSPRETDET SPRD ON A.SPRID = SPRD.SAGSPRETID '
exec (@cmd)

set @cmd = 'UPDATE PlanlagtUdfoertStep6 SET PLEJETYPE=1 WHERE PLEJETYPE IN (1,2,8)'
exec (@cmd)
set @cmd = 'UPDATE PlanlagtUdfoertStep6 SET PLEJETYPE=3 WHERE PLEJETYPE IN (3,4)'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep7'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep7'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE, ' +char(13)+ 
           '  A.SAGSID, ' +char(13)+ 
           '  A.ALDER, ' +char(13)+ 
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK ' +char(13)+
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND ' +char(13)+
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND ' +char(13)+
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND ' +char(13)+
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG,  ' +char(13)+  
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+ 
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+           
           '  A.PLEJETYPE, ' +char(13)+ 
           '  A.FALLES_SPROG_ART, '  +char(13)+
           '  A.SAGSTYPE, ' +char(13)+ 
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.MOBIL_DOEGNINDDELING, ' +char(13)+
           '  A.PLANLAGT_VEJTID, ' +char(13)+ 
           '  A.UDFOERT_VEJTID, ' +char(13)+ 
           '  A.MOB_VEJTID, ' +char(13)+ 
           '  A.REGBES, ' +char(13)+ 
           '  A.JOBID, ' +char(13)+ 
           '  A.VISITERET_TID, ' +char(13)+ 
           '  A.PLANLAGT_TID, ' +char(13)+ 
           '  A.UDFOERT_TID, '+char(13)+
           '  A.VISITYPE, ' +char(13)+ 
           '  A.BESOEG_STAT_TYPE, ' +char(13)+
           '  CASE WHEN A.BESOEG_STATUS=1 THEN '+char(13)+
           '    CASE A.BESOEG_STAT_TYPE ' +char(13)+
           '      WHEN 1 THEN ''Planlagt + Udført'' ' +char(13)+
           '      WHEN 2 THEN ''Planlagt'' ' +char(13)+
           '      WHEN 3 THEN ''Udført'' ' +char(13)+
           '    ELSE ''Statistiktype ikke defineret'' ' +char(13)+
           '    END ' +char(13)+ 
           '  ELSE ''Statistiktype ikke defineret'' ' +char(13)+
           '  END AS STATISTIKTYPE, ' +char(13)+         
           '  A.BESOEGSSTATUSID ' +char(13)+
           'INTO PlanlagtUdfoertStep7 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep6 A'
if @debug = 1 print @cmd
exec (@cmd)           

end 

if @ExPart=2 or @ExPart=0
BEGIN
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep9'' AND type = ''U'') DROP TABLE DBO.PlanlagtUdfoertStep9'
if @debug = 1 print @cmd
exec (@cmd)
                                --fra SAGSPLAN
set @cmd = 'SELECT ' +char(13)+ --vejtid fra PLANLAGTE seriebesøg   --HUSK PLANLAGT OG UDFOERT VEJTID
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000001 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000004 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  PLANLAGT_VEJTID AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID,' +char(13)+ 
           '  0 AS REGBES, '+char(13)+  
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+  --til fejlsøgning
           'INTO PlanlagtUdfoertStep9' +char(13)+
           'FROM PlanlagtUdfoertStep4 ' +char(13)+
           'UNION ALL ' +char(13)+  
           'SELECT ' +char(13)+ --vejtid fra UDFØRTE seriebesøg   --HUSK PLANLAGT OG UDFOERT VEJTID
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000002 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000005 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_VEJTID AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID,' +char(13)+ 
           '  0 AS REGBES, '+char(13)+  
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+  
           'FROM PlanlagtUdfoertStep4 ' +char(13)+
           'UNION ALL ' +char(13)+  --fra SAGSPDET
           'SELECT ' +char(13)+  --detaljer på PLANLAGTE og UDFØRTE seriebesøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  PLANLAGT_TID, ' +char(13)+
           '  PLANLAGT_TID AS UDFOERT_TID,' +char(13)+ --alle seriebesøg der ikke er rettet er også udført
           '  0 AS MOBIL_TID,' +char(13)+
           '  0 AS REGBES, '+char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep4' +char(13)+ 
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid PLANLAGTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000001 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000004 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  PLANLAGT_VEJTID AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid UDFØRTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000002 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000005 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_VEJTID AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'WHERE REGBES=0 ' +char(13)+    
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid MOBIL UDFØRTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000003 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000006 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID, ' +char(13)+
           '  MOB_VEJTID AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'WHERE REGBES=1 ' +char(13)+                    
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på PLANLAGTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID,' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på UDFØRTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_TID,' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'WHERE REGBES=0 ' +char(13)+   
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på MOBIL UDFØRTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID,' +char(13)+
           '  UDFOERT_TID AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'WHERE REGBES=1 '                                                 
exec (@cmd)   

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactPlanlagtUdfoert'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactPlanlagtUdfoert'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+  
           '  A.PK_DATE, ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.ALDER, ' +char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.STATUSID, '+char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.MED_ORG, ' +char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.JOBID, ' +char(13)+
           '  A.PLANLAGT_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 THEN PLANLAGT_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS PLANLAGT_TID_HVERDAG, ' +char(13)+ 
		   '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
		   '    CASE WHEN B.WEEKEND=1 then PLANLAGT_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS PLANLAGT_TID_WEEKEND, ' + char (13) +
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    PLANLAGT_TID ' +char(13)+
		   '  ELSE 0 END AS PLANLAGT_TID_HELLIGDAG, ' +char(13)+		
           '  UDFOERT_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 then UDFOERT_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' + char (13) +
		   '  END AS UDFOERT_TID_HVERDAG, ' + char (13) +
		   '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
		   '    CASE WHEN B.WEEKEND=1 then UDFOERT_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '  END ' + char(13)+
		   '  END AS UDFOERT_TID_WEEKEND, ' + char (13) +	
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    UDFOERT_TID ' +char(13)+
		   '  ELSE 0 END AS UDFOERT_TID_HELLIGDAG, ' +char(13)+		   
           '  MOBIL_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 then MOBIL_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+ 
		   '  END AS MOBIL_TID_HVERDAG, ' + char (13) +
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=1 then MOBIL_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS MOBIL_TID_WEEKEND, ' + char (13) +	 
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    MOBIL_TID ' +char(13)+
		   '  ELSE 0 END AS MOBIL_TID_HELLIGDAG, ' +char(13)+        
           '  A.REGBES, ' +char(13)+ 
           '  A.BESOEGSSTATUSID, '+char(13)+
           '  A.STATISTIKTYPE, '+char(13)+
           '  A.STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactPlanlagtUdfoert ' +char(13)+   
           'FROM PlanlagtUdfoertStep9 A ' +char(13)+
           'JOIN DimWeekendHelligdag B on A.PK_DATE=B.PK_DATE'   
if @debug = 1 print @cmd
exec (@cmd)      
END

if @ExPart=3 or @ExPart=0  
BEGIN
  

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactPlanlagtTid'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactPlanlagtTid'
if @debug = 1 print @cmd
exec (@cmd)   

set @cmd = 'SELECT ' +char(13)+ 
           ' PK_DATE, ' +char(13)+
           ' SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           ' BORGER_ORG AS BORGERORG, '+char(13)+
           '  STATUSID, '+char(13)+
           ' SAGSTYPE, ' +char(13)+
           ' MEDID, ' +char(13)+
           ' MED_ORG AS MEDARB_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           ' DOEGNINDDELING, ' +char(13)+
           ' JOBID, ' +char(13)+
           ' PLANLAGT_TID, ' +char(13)+
           ' PLANLAGT_TID_HVERDAG, ' +char(13)+
           ' PLANLAGT_TID_WEEKEND, ' +char(13)+
           ' PLANLAGT_TID_HELLIGDAG, ' +char(13)+
           ' REGBES, ' +char(13)+
           ' BESOEGSSTATUSID, '+char(13)+
           ' STATISTIKTYPE, '+char(13)+
           ' STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactPlanlagtTid ' +char(13)+ 
           ' FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' 
           
exec (@cmd)           
           
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactUdfoertTid'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactUdfoertTid'
if @debug = 1 print @cmd
exec (@cmd)   

set @cmd = 'SELECT ' +char(13)+ 
           ' PK_DATE, ' +char(13)+
           ' SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           ' BORGER_ORG AS BORGERORG, '+char(13)+
           '  STATUSID, '+char(13)+
           ' SAGSTYPE, ' +char(13)+
           ' MEDID, ' +char(13)+
           ' MED_ORG AS MEDARB_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           ' DOEGNINDDELING, ' +char(13)+
           ' JOBID, ' +char(13)+
           ' UDFOERT_TID, ' +char(13)+
           ' UDFOERT_TID_HVERDAG, ' +char(13)+
           ' UDFOERT_TID_WEEKEND, ' +char(13)+
           ' UDFOERT_TID_HELLIGDAG, ' +char(13)+
           ' MOBIL_TID, ' +char(13)+
           ' MOBIL_TID_HVERDAG, ' +char(13)+
           ' MOBIL_TID_WEEKEND, ' +char(13)+
           ' MOBIL_TID_HELLIGDAG, ' +char(13)+
           ' REGBES, ' +char(13)+
           ' BESOEGSSTATUSID, '+char(13)+
           ' STATISTIKTYPE, '+char(13)+
           ' STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactUdfoertTid ' +char(13)+ 
           ' FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' 
exec (@cmd) 

END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=64)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (64,GETDATE())           
end
         

