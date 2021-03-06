USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Forbrugsafvigelsesrapport]    Script Date: 11/03/2011 12:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER PROCEDURE [dbo].[usp_Forbrugsafvigelsesrapport]
	@DestinationDB as varchar(200),
	@debug as bit
				 
AS
DECLARE @cmd as varchar(max)
DECLARE @StartDate as varchar(max)
DECLARE @EndDate as varchar(max)

BEGIN

set @StartDate='(SELECT convert(date,MIN(PK_Date),101) FROM '+@DestinationDB+'.dbo.DimTimeExtended)'
set @EndDate='(SELECT convert(date,MAX(PK_Date),101) FROM '+@DestinationDB+'.dbo.DimTimeExtended)'

   ---sagsstatus
	set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser '
	if @debug = 1 print @cmd
	exec (@cmd)

	set @cmd = 'SELECT top 1000' +char(13)+   
	           '  dbo.SAGSPLANRET.ID, ' +char(13)+
	           '  dbo.SAGSPLANRET.SERIEID, ' +char(13)+
	           '  dbo.SAGSPLANRET.SAGSID, ' +char(13)+ 
	           '  dbo.SAGSPLANRET.MEDID, ' +char(13)+
	           '  dbo.SAGSPLANRET.RETDATO, '+char(13)+
               '  dbo.SAGSPLANRET.STARTMINEFTERMIDNAT As START, ' +char(13)+
               '  dbo.SAGSPLANRET.TID, ' +char(13)+
               '  dbo.SAGSPLANRET.VEJTID, ' +char(13)+
               '  dbo.SAGSPLANRET.YDELSESTID, ' +char(13)+
               '  dbo.SAGSPLANRET.STATUSID, '+char(13)+
               '  dbo.SAGSPLANRET.RSTART, ' +char(13)+
               '  dbo.SAGSPLANRET.RTID, ' +char(13)+
               '  dbo.SAGSPLANRET.RVEJTID, ' +char(13)+
               '  dbo.SAGSPLANRET.REGBES, ' +char(13)+
               '  dbo.BESOGSTATUS.STAT_TYPE, ' +char(13)+
               '  dbo.SAGSPLANRET.SERIEDATO, '+char(13)+
               '  dbo.SAGSPLANRET.VISISTART, ' +char(13)+
               '  dbo.SAGSPLANRET.VISISLUT, '+char(13)+
               '  CASE When regbes = 1  THEN  ''Registreret'' ELSE  ''Ej registreret''  END AS Målt, ' +char(13)+
               '  CASE WHEN sagsplanret.rstart <> 0 AND '+char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid > sagsplanret.ydelsestid THEN ''Merforbrug'' ' +char(13)+
               '       WHEN sagsplanret.rstart <> 0 AND '+char(13)+
               '   (sagsplanret.rtid - sagsplanret.rvejtid < sagsplanret.ydelsestid  and ' +char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid > 1) THEN ''Mindreforbrug''' +char(13)+
               '       WHEN sagsplanret.rtid - sagsplanret.rvejtid <= 1 and ' +char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid < sagsplanret.ydelsestid and ' +char(13)+
               '    (sagsplanret.regbes = 1 and stat_type <> 2 ) THEN ''Mindreforbrug lig planlagt''' +char(13)+
               '       WHEN stat_type = 2 then ''Ej gennemført''' +char(13)+
               '  ELSE ''Neutral'' END AS Forbrugsstatus, '+char(13)+
               '  CASE WHEN sagsplanret.regbes = 1  and   sagsplanret.rtid - sagsplanret.rvejtid > 1  THEN ' +char(13)+
               '    sagsplanret.RTID-RVejtid - sagsplanret.YDELSESTID ELSE NULL END AS Samlet_Forbrugsafvigelse, '+char(13)+
               '  dbo.SAGSPRETDET.JOBID, ' +char(13)+
               '  dbo.SAGSPRETDET.YDELSESTID AS Normtid_ydelse, '+char(13)+
               '  Case WHEN  sagsplanret.rtid - sagsplanret.rvejtid > 1 and (regbes = 1 ) then '+char(13)+
               '    (dbo.SAGSPLANRET.RTID -  dbo.SAGSPLANRET.RVEJTID ) * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID  '+char(13)+
               '       WHEN stat_type = 2 then null '+char(13)+
               '  else  dbo.SAGSPRETDET.YDELSESTID end  AS Fordelt_Forbrug, '+char(13)+
               '  Case WHEN  sagsplanret.rtid - sagsplanret.rvejtid > 1 and (regbes=1 ) then ' +char(13)+
               '    (dbo.SAGSPLANRET.RTID -dbo.SAGSPLANRET.RVEJTID - dbo.SAGSPLANRET.YDELSESTID) * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID '+char(13)+
               '       WHEN stat_type = 2 then dbo.SAGSPRETDET.YDELSESTID '+char(13)+
               '  else 0 end AS Fordelt_Forbrugsafvigelse, '+char(13)+
               '    dbo.SAGSPLANRET.RVEJTID   * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID AS Fordelt_vejtid, '+char(13)+
               '  Dbo.SAGSPRETDET.VISITYPE   '+char(13)+
               'into _Forbrugsafvigelser       '+char(13)+
               'FROM         dbo.SAGSPLANRET ' +char(13)+
               'INNER JOIN dbo.SAGSPRETDET ON dbo.SAGSPLANRET.ID = dbo.SAGSPRETDET.SAGSPRETID ' +char(13)+
               'INNER JOIN BESOGSTATUS ON SAGSPLANRET.STATUSID = BESOGSTATUS.BESOGID '+char(13)+
               'where dbo.SAGSPLANRET.YDELSESTID <> 0 and '+char(13)+ 
               'SAGSPLANRET.RETDATO BETWEEN '+@StartDate+' AND '+@EndDate+' '             
               --'SAGSPLANRET.RETDATO BETWEEN ''2007-01-01'' AND ''2015-12-31'' '+char(13) --original

	if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'INSERT INTO _Forbrugsafvigelser' +char(13)+
           '  (ID, SERIEID, SAGSID, MEDID, RETDATO, TID, VEJTID, YDELSESTID, STATUSID, RSTART, RTID, RVEJTID, ' +char(13)+
           '   REGBES, SERIEDATO, VISISTART, VISISLUT, Målt, Forbrugsstatus, Samlet_Forbrugsafvigelse, JOBID, ' +char(13)+
           '   Normtid_ydelse, Fordelt_Forbrug, Fordelt_Forbrugsafvigelse, Fordelt_vejtid, VISITYPE, Start,STAT_TYPE )' +char(13)+
           'SELECT ID, SERIEID, SAGSID, MEDID, RETDATO, TID, VEJTID, YDELSESTID, STATUSID, RSTART, RTID, RVEJTID, ' +char(13)+
           '   REGBES, SERIEDATO, VISISTART, VISISLUT, Målt, Forbrugsstatus, Samlet_Forbrugsafvigelse, jobid, ' +char(13)+
           '   Normtid_ydelse, fordelt_forbrug, Fordelt_forbrugsafvigelse, fordelt_vejtid, visitype, STARTMINEFTERMIDNAT, STAT_TYPE ' +char(13)+
           'FROM _vForbrugsafvigelserUdenYdelse '+char(13)+
           'WHERE RETDATO BETWEEN '+@StartDate+' AND '+@EndDate+' ' --original ''2007-01-01'' AND ''2015-12-31''


if @debug = 1 print @cmd
	exec (@cmd)
	
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger1 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger1 '
	if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  dbo._Forbrugsafvigelser.ID, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISITYPE, '+char(13)+
           '  dbo._Forbrugsafvigelser.SERIEID, '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID, '+char(13)+
           '  dbo._Forbrugsafvigelser.MEDID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO, '+char(13)+
           '  dbo._Forbrugsafvigelser.START, '+char(13)+
           '  dbo._Forbrugsafvigelser.TID, '+char(13)+
           '  dbo._Forbrugsafvigelser.VEJTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.YDELSESTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.STATUSID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RSTART, '+char(13)+
           '  dbo._Forbrugsafvigelser.RTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RVEJTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.REGBES, '+char(13)+
           '  dbo._Forbrugsafvigelser.SERIEDATO, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISISTART, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISISLUT,  '+char(13)+
           '  dbo._Forbrugsafvigelser.Målt, '+char(13)+
           '  dbo._Forbrugsafvigelser.Forbrugsstatus, '+char(13)+
           '  dbo._Forbrugsafvigelser.Samlet_Forbrugsafvigelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.JOBID, '+char(13)+
           '  dbo._Forbrugsafvigelser.Normtid_Ydelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Forbrugsafvigelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Forbrug, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Vejtid, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_STATUS, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_STATUSID, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_GRUPPEID, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_STATUS, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_STATUSID, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_GRUPPEID, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUS, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUSID, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_GRUPPEID '+char(13)+
           'into _Forbrugsafvigelser_Borger1 ' +char(13)+
           'FROM dbo._Forbrugsafvigelser LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK ON dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_TP_SAGSHISTORIK.SLUTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_TP_SAGSHISTORIK.SAGSID LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK ON dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_SP_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_SP_SAGSHISTORIK.SLUTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_SP_SAGSHISTORIK.SAGSID LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK ON dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_HJ_SAGSHISTORIK.SAGSID AND   '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_HJ_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_HJ_SAGSHISTORIK.SLUTDATO  '+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger2 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger2 '
	if @debug = 1 print @cmd
	exec (@cmd)
  

set @cmd = 'SELECT  *, ' +char(13)+
           '  CASE ' +char(13)+
           '    WHEN VISITYPE = 0 or VISITYPE =1 OR VISITYPE = 2 THEN HJEMMEPLEJE_GRUPPEID ' +char(13)+
           '    WHEN VISITYPE = 3 OR VISITYPE =4 THEN TERAPEUT_GRUPPEID ' +char(13)+
           '    WHEN VISITYPE = 5 THEN SYGEPLEJE_GRUPPEID ' +char(13)+
           '  ELSE 9999 ' +char(13)+
           '  END AS GRUPPEID' +char(13)+
           'INTO _Forbrugsafvigelser_Borger2' +char(13)+
           'From _Forbrugsafvigelser_Borger1'+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger3 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger3 '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	
-- **************************************************************************************************************************
-- Joiner med MEDHISTORIK tabellen for at finde StatusID (som bruges i Stillingsbetegnelse dimensionen)
-- **************************************************************************************************************************

set @cmd = 'SELECT  ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.ID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISITYPE, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SERIEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SAGSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.MEDID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RETDATO, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.START, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.TID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VEJTID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.YDELSESTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.STATUSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RSTART, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.RTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RVEJTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.REGBES, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.SERIEDATO, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISISTART, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISISLUT, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.Målt, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Forbrugsstatus, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Samlet_Forbrugsafvigelse, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.JOBID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Normtid_Ydelse, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Forbrug,' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Forbrugsafvigelse, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Vejtid, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_STATUS, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_STATUSID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_GRUPPEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_STATUS, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_STATUSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_GRUPPEID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_STATUS, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_STATUSID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_GRUPPEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.GRUPPEID, ' +char(13)+
           '  MEDHISTORIK.MEDARBEJDER_STATUS, '+char(13)+
           '  MEDHISTORIK.MEDARBEJDER_STATUSID, ' +char(13)+
           '  MEDHISTORIK.STILLINGSID, ' +char(13)+
           '  MEDHISTORIK.UAFDELINGID AS MedarbGrp   '+char(13)+
           'into _Forbrugsafvigelser_borger3   '+char(13)+
           'FROM _Forbrugsafvigelser_Borger2 ' +char(13)+
           'LEFT OUTER JOIN MEDHISTORIK ON _Forbrugsafvigelser_Borger2.MEDID = MEDHISTORIK.MEDARBEJDERID AND  '+char(13)+
           '  _Forbrugsafvigelser_Borger2.RETDATO >= MEDHISTORIK.IKRAFTDATO AND _Forbrugsafvigelser_Borger2.RETDATO < MEDHISTORIK.SLUTDATO '+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactForbrugsafvigelse'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactForbrugsafvigelse'
	if @debug = 1 print @cmd
	exec (@cmd)

	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.FactForbrugsafvigelse from _Forbrugsafvigelser_borger3'
	if @debug = 1 print @cmd
	exec (@cmd)
	

-- Sætter GruppeID til 8888 hvor der er en visitype, men ikke et gruppe tilhørsforhold borger Organisation
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set GRUPPEID=8888 where GRUPPEID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	-- Sætter GruppeID til 8888 hvor der er en visitype, men ikke et gruppe tilhørsforhold på Medarb Organisation
		set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set medarbGrp=8888 where medarbGrp is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
-- Opdatere Stillingsbetegnelse, da ikke alle får en (bliver sat til 9999)	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set STILLINGSID=9999 where STILLINGSID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
-- Opdatere MedarbejderStatus (Der er nogle som falder forbi). Bliver sat til ukendt (9999) 	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set MEDARBEJDER_STATUSID=9999 where MEDARBEJDER_STATUSID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	
-- Opdatere MEDID, hvor den ikke eksisterer og sætter den til ukendt (9999). 	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set MEDID=9999 where MEDID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=56)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (56,GETDATE())           
--end	


END