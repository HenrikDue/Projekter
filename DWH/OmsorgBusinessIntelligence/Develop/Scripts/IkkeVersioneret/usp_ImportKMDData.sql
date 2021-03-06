USE [AvaleoAnalyticsVagtplan_Staging]
GO
/****** Object:  StoredProcedure [dbo].[usp_ImportKMDData]    Script Date: 11/15/2010 14:03:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_ImportKMDData]
                 @DestinationDB as varchar(200),@ExPart as Int=0,@Debug  as bit = 1
AS

DECLARE @cmd as varchar(max)
DECLARE @LinkedServer as varchar(50)
DECLARE @BiUser as varchar(10)
DECLARE @DageFrem as varchar(2)
DECLARE @DageTilbage as varchar(10)
DECLARE @FraDato as varchar(20)

SET @LinkedServer = 'VAGTPLAN'
SET @BiUser = 'STATISTIK'
SET @DageFrem = '14'
SET @DageTilbage  = datediff(dd,CONVERT(DATE,'2009-01-01'),GETDATE())
SET @FraDato = '2010/06/01'

if @debug = 1 print @DageTilbage

if @ExPart=1
begin
--OBS!! LÆS DETTE hent TJENESTE_TYPE fra KMD kun en gang med bruger:vagtplan og password:sql på linked server
--set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VAGTPLAN_TJENESTE_TYPE'' AND type = ''U'') DROP TABLE dbo.VAGTPLAN_TJENESTE_TYPE'
--if @debug = 1 print @cmd
--exec (@cmd)

--set @cmd = 'SELECT *,GETDATE() AS LAST_IMPORTDATE ' +char(13)+
--           'INTO VAGTPLAN_TJENESTE_TYPE ' +char(13)+
--           'FROM OPENQUERY('+@LinkedServer+',''SELECT * FROM VAGTPLAN.TJENESTE_TYPE_NEW'')' 
--exec (@cmd) 
--hent VP_MEDARB_V
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VP_MEDARB_V'' AND type = ''U'') DROP TABLE dbo.VP_MEDARB_V'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT *,GETDATE() AS LAST_IMPORTDATE ' +char(13)+
           'INTO VP_MEDARB_V ' +char(13)+
           'FROM OPENQUERY('+@LinkedServer+',''SELECT * FROM VP_MEDARB_V'') ' +char(13)+
           'WHERE (ADM_START<=GETDATE()) AND ' +char(13)+
           '  (ADM_STOP>GETDATE()-'+@DageTilbage+')' 
if @debug = 1 print @cmd           
exec (@cmd)
         
end

if @ExPart=2
BEGIN

--lav tmp tabel og indsæt data i KMD KOMME_GAA_IND tabel 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VAGTPLAN_KOMME_GAA_IND_TMP'' AND type = ''U'') DROP TABLE dbo.VAGTPLAN_KOMME_GAA_IND_TMP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '  +char(13)+
           '  '''+@BiUser+''' AS BRUGER_ID, ' +char(13)+
           '  MED.CPRNR AS PERSONNR,' +char(13)+
           '  MED.PERSONNR_EKSTRA, ' +char(13)+
           '  VP_MED.ADM_ENHEDS_ID, ' +char(13)+
           '  VP_MED.AFLONNINGSFORM, ' +char(13)+
           '  CONVERT(DATE,GETDATE()-'+@DageTilbage+') AS DATO_FRA, ' +char(13)+
           '  CONVERT(DATE,GETDATE()) AS DATO_TIL ' +char(13)+
           'INTO VAGTPLAN_KOMME_GAA_IND_TMP ' +char(13)+
           'FROM AvaleoAnalytics_Staging.dbo.MEDARBEJDERE MED ' +char(13)+
           'JOIN VP_MEDARB_V VP_MED ON MED.CPRNR=VP_MED.PERSONNR ' +char(13)+
           'WHERE MED.MEDARBEJDERTYPE=0 AND MED.MEDARBEJDER_STATUS=1 '           
if @debug = 1 print @cmd           
exec (@cmd) 

--ryd op i KOMME_GAA_IND tabel
set @cmd = 'DELETE OPENQUERY('+@LinkedServer+',''SELECT * FROM KOMME_GAA_IND WHERE BRUGER_ID='''''+@BiUser+''''' '')' 
if @debug = 1 print @cmd             
exec (@cmd) 

DECLARE @bruger_id VARCHAR(50)
DECLARE @adm_enheds_id INT
DECLARE @personnr VARCHAR(50)
DECLARE @personnr_ekstra VARCHAR(50)
DECLARE @aflonningsform INT
DECLARE @dato_fra DATE
DECLARE @dato_til DATE

DECLARE FindMedarbejder CURSOR FAST_FORWARD FOR
SELECT BRUGER_ID,ADM_ENHEDS_ID,PERSONNR,PERSONNR_EKSTRA,AFLONNINGSFORM,DATO_FRA,DATO_TIL FROM VAGTPLAN_KOMME_GAA_IND_TMP

OPEN FindMedarbejder
FETCH NEXT FROM FindMedarbejder
INTO @bruger_id,@adm_enheds_id,@personnr,@personnr_ekstra,@aflonningsform,@dato_fra,@dato_til
 
WHILE @@fetch_status = 0
BEGIN
  -- Perform Operations
  INSERT OPENQUERY(VAGTPLAN,'SELECT BRUGER_ID,ADM_ENHEDS_ID,PERSONNR,PERSONNR_EKSTRA,AFLONNINGSFORM,DATO_FRA,DATO_TIL FROM VAGTPLAN.KOMME_GAA_IND') 
    VALUES (@bruger_id,@adm_enheds_id,@personnr,@personnr_ekstra,@aflonningsform,@dato_fra,@dato_til)
  
  -- Advance the Cursor
  FETCH NEXT FROM FindMedarbejder
  INTO @bruger_id,@adm_enheds_id,@personnr,@personnr_ekstra,@aflonningsform,@dato_fra,@dato_til

END
 
CLOSE FindMedarbejder
DEALLOCATE FindMedarbejder

end

if @ExPart=3
begin                               
--eksekver stored procedure i KMD db

declare @rc int       
execute('begin sp_komme_gaa_tider.find_person (''STATISTIK'',?);end;',@rc output) at vagtplan 
if @debug = 1 print @rc   
 
end

if @ExPart=4
begin  
--flyt data fra KMD KOMME_GAA_UD til staging

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VAGTPLAN_KOMME_GAA_UD_IMPORT'' AND type = ''U'') DROP TABLE DBO.VAGTPLAN_KOMME_GAA_UD_IMPORT'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * ' +char(13)+
           'INTO VAGTPLAN_KOMME_GAA_UD_IMPORT ' +char(13)+
           'FROM OPENQUERY('+@LinkedServer+',''SELECT * FROM KOMME_GAA_UD WHERE BRUGER_ID=''''STATISTIK'''' '')'
if @debug = 1 print @cmd           
exec (@cmd)       

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VAGTPLAN_KOMME_GAA_UD'' AND type = ''U'') DROP TABLE DBO.VAGTPLAN_KOMME_GAA_UD'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  BRUGER_ID, ' +char(13)+
           '  ADM_ENHEDS_ID, ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  PERSONNR_EKSTRA, ' +char(13)+
           '  AFLONNINGSFORM, ' +char(13)+
           '  convert(char,DATO_FRA) AS DATO_FRA, ' +char(13)+
           '  convert(char,DATO_TIL) AS DATO_TIL, ' +char(13)+
           '  RULLEDATO, ' +char(13)+
           '  INDIVID_TYPE, ' +char(13)+
           '  SKEMAENHED_ID, ' +char(13)+
           '  TJENESTE_TYPE, ' +char(13)+
           '  AFV_ADM_ENHEDS_ID, ' +char(13)+
           '  DATO_BA_GG_OS, ' +char(13)+
           '  OMSORGSDAGE, ' +char(13)+
           '  AKTIVITETS_TEKST ' +char(13)+
           '  INTO VAGTPLAN_KOMME_GAA_UD FROM VAGTPLAN_KOMME_GAA_UD_IMPORT  WHERE DATO_FRA IS NOT NULL'  
exec (@cmd)          
                      
           
END
