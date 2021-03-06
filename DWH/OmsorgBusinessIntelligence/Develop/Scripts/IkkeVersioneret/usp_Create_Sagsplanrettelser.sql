USE [AvaleoAnalytics_Staging]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Sagsplanrettelser]    Script Date: 11/15/2010 13:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1. Laver _temp_SagsplanrettelserBorger_1
--2. Laver _temp_SagsplanrettelserBorger_2
--3. Laver _temp_SagsplanrettelserBorger_3
--4. Laver FactSagsplanRettelserPlanlagt
--5. Inputter slutkorrigeringer i FactSagsplanRettelserPlanlagt fra tabellen [Slutkorr_udenforStartSlut Step2]
--6. Laver Fact_Sagsplanrettelser_udført
--7. Laver Fact_Sagsplanrettelser_IngenStatistik
--8. Laver Fact_Sagsplanrettelser_regtid_Step1
--9. Laver Fact_Sagsplanrettelser_regtid_Step3 (Fact_Sagsplanrettelser_regtid_Step2 er implementeret som et view)
--10. Laver Fact_Sagsplanrettelser_regtid
--11. Kopierer Fact_RettelserBesoegsserier til DW

ALTER PROCEDURE [dbo].[usp_Create_Sagsplanrettelser]
@DestinationDB as varchar(200),
@ExPart as Int = 0,
@Debug  as bit = 1


AS
--DECLARE @DestinationDB as varchar(200)
DECLARE @cmd as varchar(max)


-----------------------------------------------------------------------------------------------------
--1. Laver _temp_SagsplanrettelserBorger_1
-----------------------------------------------------------------------------------------------------
if (@ExPart=1 or @ExPart=0  or (@ExPart>100 and @ExPart<=101))
begin --Part 1.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '1. Laver _temp_SagsplanrettelserBorger_1'
	print '---------------------------------------------------------------------------------------------'
end



set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''_temp_SagsplanrettelserBorger_1'' AND type = ''U'') DROP TABLE dbo._temp_SagsplanrettelserBorger_1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.id as sagsplanretID, '+char(13)+
		   ''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.Serieid,  '+char(13)+
		   ''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.SAGSID, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.MEDID, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.STATUSID, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.doegninddeling, '+char(13)+ 
			''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.Time, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.IKRAFTDATO, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.SLUTDATO, '+char(13)+
''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.MEDARBEJDER_STATUSID, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.TIMER, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.STILLINGSID, '+char(13)+
''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.Medarb_uafdeling, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.VAGTER, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.JOBID, '+char(13)+
''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.VISITYPE, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.NORMTID, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.YDELSESTID, '+char(13)+
''+@DestinationDB+'.dbo.Fact_SagsplanRettelser.AFVIGELSE, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.ALDER, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.specifikation, '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.CPRNR, '+char(13)+
''+@DestinationDB+'.dbo.DimPakkeTyperJob.PLEJETYPE '+char(13)+
'into _temp_SagsplanrettelserBorger_1 '+char(13)+
'FROM '+@DestinationDB+'.dbo.Fact_SagsplanRettelser INNER JOIN '+char(13)+
''+@DestinationDB+'.dbo.DimPakkeTyperJob ON '+@DestinationDB+'.dbo.Fact_SagsplanRettelser.JOBID = '+@DestinationDB+'.dbo.DimPakkeTyperJob.JOBID ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

end --Part 1.

-----------------------------------------------------------------------------------------------------
--2. Laver _temp_SagsplanrettelserBorger_2
-----------------------------------------------------------------------------------------------------
if (@ExPart=2 or @ExPart=0  or (@ExPart>100 and @ExPart<=102))
begin --Part 2.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '2. Laver _temp_SagsplanrettelserBorger_2'
	print '---------------------------------------------------------------------------------------------'
end


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''_temp_SagsplanrettelserBorger_2'' AND type = ''U'') DROP TABLE dbo._temp_SagSplanrettelserBorger_2'
if @debug = 1 print @cmd
exec (@cmd)

SELECT dbo._temp_SagsplanrettelserBorger_1.sagsplanretID,dbo._temp_SagsplanrettelserBorger_1.Serieid
, dbo._temp_SagsplanrettelserBorger_1.SAGSID, dbo._temp_SagsplanrettelserBorger_1.MEDID
, dbo._temp_SagsplanrettelserBorger_1.STATUSID, 
dbo._temp_SagsplanrettelserBorger_1.doegninddeling, dbo._temp_SagsplanrettelserBorger_1.Time
, dbo._temp_SagsplanrettelserBorger_1.IKRAFTDATO, 
dbo._temp_SagsplanrettelserBorger_1.SLUTDATO, dbo._temp_SagsplanrettelserBorger_1.MEDARBEJDER_STATUSID, 
dbo._temp_SagsplanrettelserBorger_1.TIMER, dbo._temp_SagsplanrettelserBorger_1.STILLINGSID
, dbo._temp_SagsplanrettelserBorger_1.Medarb_uafdeling, 
dbo._temp_SagsplanrettelserBorger_1.VAGTER, dbo._temp_SagsplanrettelserBorger_1.JOBID
, dbo._temp_SagsplanrettelserBorger_1.VISITYPE, 
dbo._temp_SagsplanrettelserBorger_1.NORMTID, dbo._temp_SagsplanrettelserBorger_1.YDELSESTID
, dbo._temp_SagsplanrettelserBorger_1.AFVIGELSE, 
dbo._temp_SagsplanrettelserBorger_1.ALDER, dbo._temp_SagsplanrettelserBorger_1.specifikation
, dbo._temp_SagsplanrettelserBorger_1.CPRNR, 
dbo._temp_SagsplanrettelserBorger_1.PLEJETYPE, dbo.SAGSHISTORIK.ID, dbo.SAGSHISTORIK.IKRAFTDATO AS borger_start, 
dbo.SAGSHISTORIK.SLUTDATO AS borger_slut, dbo.SAGSHISTORIK.HJEMMEPLEJE_GRUPPEID AS borgerorganisation
into _temp_SagsplanrettelserBorger_2
FROM dbo.SAGSHISTORIK INNER JOIN
dbo._temp_SagsplanrettelserBorger_1 ON dbo.SAGSHISTORIK.SAGSID = dbo._temp_SagsplanrettelserBorger_1.SAGSID
WHERE (dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 0) or(dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 1) OR
 (dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 2) or (dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 6) OR
 (dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 7) OR
 (dbo._temp_SagsplanrettelserBorger_1.VISITYPE = 8)
UNION ALL
SELECT _temp_SagsplanrettelserBorger_1_1.Sagsplanretid,_temp_SagsplanrettelserBorger_1_1.Serieid,_temp_SagsplanrettelserBorger_1_1.SAGSID, _temp_SagsplanrettelserBorger_1_1.MEDID, _temp_SagsplanrettelserBorger_1_1.STATUSID, 
_temp_SagsplanrettelserBorger_1_1.doegninddeling, _temp_SagsplanrettelserBorger_1_1.Time, _temp_SagsplanrettelserBorger_1_1.IKRAFTDATO, 
_temp_SagsplanrettelserBorger_1_1.SLUTDATO, _temp_SagsplanrettelserBorger_1_1.MEDARBEJDER_STATUSID, _temp_SagsplanrettelserBorger_1_1.TIMER, 
_temp_SagsplanrettelserBorger_1_1.STILLINGSID, _temp_SagsplanrettelserBorger_1_1.Medarb_uafdeling, _temp_SagsplanrettelserBorger_1_1.VAGTER, 
_temp_SagsplanrettelserBorger_1_1.JOBID, _temp_SagsplanrettelserBorger_1_1.VISITYPE, _temp_SagsplanrettelserBorger_1_1.NORMTID, 
_temp_SagsplanrettelserBorger_1_1.YDELSESTID, _temp_SagsplanrettelserBorger_1_1.AFVIGELSE, _temp_SagsplanrettelserBorger_1_1.ALDER, 
_temp_SagsplanrettelserBorger_1_1.specifikation, _temp_SagsplanrettelserBorger_1_1.CPRNR, _temp_SagsplanrettelserBorger_1_1.PLEJETYPE, 
SAGSHISTORIK_1.ID, SAGSHISTORIK_1.IKRAFTDATO AS borger_start, SAGSHISTORIK_1.SLUTDATO AS borger_slut, 
SAGSHISTORIK_1.TERAPEUT_GRUPPEID AS borgerorganisation
FROM dbo.SAGSHISTORIK AS SAGSHISTORIK_1 INNER JOIN
dbo._temp_SagsplanrettelserBorger_1 AS _temp_SagsplanrettelserBorger_1_1 ON 
SAGSHISTORIK_1.SAGSID = _temp_SagsplanrettelserBorger_1_1.SAGSID
WHERE (_temp_SagsplanrettelserBorger_1_1.VISITYPE = 3) OR
 (_temp_SagsplanrettelserBorger_1_1.VISITYPE = 4)
UNION ALL
SELECT _temp_SagsplanrettelserBorger_1_1.SagsplanretID, _temp_SagsplanrettelserBorger_1_1.SerieID,_temp_SagsplanrettelserBorger_1_1.SAGSID, _temp_SagsplanrettelserBorger_1_1.MEDID
, _temp_SagsplanrettelserBorger_1_1.STATUSID, 
_temp_SagsplanrettelserBorger_1_1.doegninddeling, _temp_SagsplanrettelserBorger_1_1.Time, _temp_SagsplanrettelserBorger_1_1.IKRAFTDATO, 
_temp_SagsplanrettelserBorger_1_1.SLUTDATO, _temp_SagsplanrettelserBorger_1_1.MEDARBEJDER_STATUSID, _temp_SagsplanrettelserBorger_1_1.TIMER, 
_temp_SagsplanrettelserBorger_1_1.STILLINGSID, _temp_SagsplanrettelserBorger_1_1.Medarb_uafdeling, _temp_SagsplanrettelserBorger_1_1.VAGTER, 
_temp_SagsplanrettelserBorger_1_1.JOBID, _temp_SagsplanrettelserBorger_1_1.VISITYPE, _temp_SagsplanrettelserBorger_1_1.NORMTID, 
_temp_SagsplanrettelserBorger_1_1.YDELSESTID, _temp_SagsplanrettelserBorger_1_1.AFVIGELSE, _temp_SagsplanrettelserBorger_1_1.ALDER, 
_temp_SagsplanrettelserBorger_1_1.specifikation
--,_temp_SagsplanrettelserBorger_1_1.Org_REport
, _temp_SagsplanrettelserBorger_1_1.CPRNR, _temp_SagsplanrettelserBorger_1_1.PLEJETYPE, 
SAGSHISTORIK_1.ID, SAGSHISTORIK_1.IKRAFTDATO AS borger_start, SAGSHISTORIK_1.SLUTDATO AS borger_slut, 
SAGSHISTORIK_1.SYGEPLEJE_GRUPPEID AS borgerorganisation
FROM dbo.SAGSHISTORIK AS SAGSHISTORIK_1 INNER JOIN
dbo._temp_SagsplanrettelserBorger_1 AS _temp_SagsplanrettelserBorger_1_1 ON 
SAGSHISTORIK_1.SAGSID = _temp_SagsplanrettelserBorger_1_1.SAGSID
WHERE (_temp_SagsplanrettelserBorger_1_1.VISITYPE = 5)
--where (Org_REport = 'SPL')
-- Håndtere andet
UNION ALL
SELECT _temp_SagsplanrettelserBorger_1_1.SagsplanretID, _temp_SagsplanrettelserBorger_1_1.SerieID,_temp_SagsplanrettelserBorger_1_1.SAGSID, _temp_SagsplanrettelserBorger_1_1.MEDID
, _temp_SagsplanrettelserBorger_1_1.STATUSID, 
_temp_SagsplanrettelserBorger_1_1.doegninddeling, _temp_SagsplanrettelserBorger_1_1.Time, _temp_SagsplanrettelserBorger_1_1.IKRAFTDATO, 
_temp_SagsplanrettelserBorger_1_1.SLUTDATO, _temp_SagsplanrettelserBorger_1_1.MEDARBEJDER_STATUSID, _temp_SagsplanrettelserBorger_1_1.TIMER, 
_temp_SagsplanrettelserBorger_1_1.STILLINGSID, _temp_SagsplanrettelserBorger_1_1.Medarb_uafdeling, _temp_SagsplanrettelserBorger_1_1.VAGTER, 
_temp_SagsplanrettelserBorger_1_1.JOBID, _temp_SagsplanrettelserBorger_1_1.VISITYPE, _temp_SagsplanrettelserBorger_1_1.NORMTID, 
_temp_SagsplanrettelserBorger_1_1.YDELSESTID, _temp_SagsplanrettelserBorger_1_1.AFVIGELSE, _temp_SagsplanrettelserBorger_1_1.ALDER, 
_temp_SagsplanrettelserBorger_1_1.specifikation
, _temp_SagsplanrettelserBorger_1_1.CPRNR, _temp_SagsplanrettelserBorger_1_1.PLEJETYPE,
-- _temp_SagsplanrettelserBorger_1_1.Org_Report,
SAGSHISTORIK_1.ID, SAGSHISTORIK_1.IKRAFTDATO AS borger_start, SAGSHISTORIK_1.SLUTDATO AS borger_slut, 
SAGSHISTORIK_1.SYGEPLEJE_GRUPPEID AS borgerorganisation
FROM dbo.SAGSHISTORIK AS SAGSHISTORIK_1 INNER JOIN
dbo._temp_SagsplanrettelserBorger_1 AS _temp_SagsplanrettelserBorger_1_1 ON 
SAGSHISTORIK_1.SAGSID = _temp_SagsplanrettelserBorger_1_1.SAGSID
WHERE (_temp_SagsplanrettelserBorger_1_1.VISITYPE = 5)
 
end --Part 2.
 
 
 -----------------------------------------------------------------------------------------------------
 --3. Laver _temp_SagsplanrettelserBorger_3
 -----------------------------------------------------------------------------------------------------
if (@ExPart=3 or @ExPart=0  or (@ExPart>100 and @ExPart<=103))
begin --Part 3.

if @Debug = 1
	begin --Print step txt 
	print '---------------------------------------------------------------------------------------------'
	print '3. Laver _temp_SagsplanrettelserBorger_3'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''_temp_SagsplanrettelserBorger_3'' AND type = ''U'') DROP TABLE _temp_SagSplanrettelserBorger_3'
if @debug = 1 print @cmd
exec (@cmd)

SELECT sagsplanretID, 
		serieid, 
		SAGSID, 
		MEDID, 
		STATUSID, 
		doegninddeling, 
		(SELECT STARTMINEFTERMIDNAT FROM SAGSPLANRET WHERE ID=_temp_SagsplanrettelserBorger_2.sagsplanretID) AS STARTMINEFTERMIDNAT,
		Time, 
		IKRAFTDATO, 
		SLUTDATO, 
		MEDARBEJDER_STATUSID, 
		TIMER, 
		STILLINGSID, 
		Medarb_uafdeling, 
		VAGTER, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		AFVIGELSE, 
		ALDER, 
		specifikation, 
		CPRNR, 
		PLEJETYPE, 
		ID, 
		borger_start, 
		borger_slut, 
		borgerorganisation
into _temp_SagsplanrettelserBorger_3
FROM dbo._temp_SagsplanrettelserBorger_2
WHERE (Time >= borger_start) AND (Time < borger_slut)

end --Part 3.


-----------------------------------------------------------------------------------------------------
 --4. Laver FactSagsplanRettelserPlanlagt
-----------------------------------------------------------------------------------------------------
if (@ExPart=4 or @ExPart=0  or (@ExPart>100 and @ExPart<=104))
begin --Part 4.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '4. Laver FactSagsplanRettelserPlanlagt'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''.dbo.FactSagsplanRettelserPlanlagt'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Truncate TABLE '+@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Insert into '+@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt ' +char(13)+
'SELECT dbo._temp_SagsplanrettelserBorger_3.sagsplanretID, dbo._temp_SagsplanrettelserBorger_3.SERIEID, dbo._temp_SagsplanrettelserBorger_3.SAGSID, dbo._temp_SagsplanrettelserBorger_3.MEDID, dbo._temp_SagsplanrettelserBorger_3.STATUSID, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.doegninddeling, dbo._temp_SagsplanrettelserBorger_3.Time, dbo._temp_SagsplanrettelserBorger_3.IKRAFTDATO, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.SLUTDATO, dbo._temp_SagsplanrettelserBorger_3.MEDARBEJDER_STATUSID, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.TIMER, dbo._temp_SagsplanrettelserBorger_3.STILLINGSID, dbo._temp_SagsplanrettelserBorger_3.Medarb_uafdeling, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.VAGTER, dbo._temp_SagsplanrettelserBorger_3.JOBID, dbo._temp_SagsplanrettelserBorger_3.VISITYPE, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.NORMTID, dbo._temp_SagsplanrettelserBorger_3.YDELSESTID, dbo._temp_SagsplanrettelserBorger_3.AFVIGELSE, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.ALDER, dbo._temp_SagsplanrettelserBorger_3.specifikation, dbo._temp_SagsplanrettelserBorger_3.CPRNR, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.PLEJETYPE, dbo._temp_SagsplanrettelserBorger_3.ID, dbo._temp_SagsplanrettelserBorger_3.borger_start, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.borger_slut, dbo._temp_SagsplanrettelserBorger_3.borgerorganisation, '+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE'+char(13)+
'FROM dbo._temp_SagsplanrettelserBorger_3 INNER JOIN '+char(13)+
''+@DestinationDB+'.dbo.DimBesogStatus ON dbo._temp_SagsplanrettelserBorger_3.STATUSID = '+@DestinationDB+'.dbo.DimBesogStatus.BESOGID '+char(13)+
'WHERE ('+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE = 1) OR '+char(13)+
'('+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE = 2)'+char(13)

if @debug = 1 print @cmd
exec (@cmd)

end --Part 4.


-----------------------------------------------------------------------------------------------------
 --5. Inputter slutkorrigeringer i FactSagsplanRettelserPlanlagt fra tabellen [Slutkorr_udenforStartSlut Step2]
 -----------------------------------------------------------------------------------------------------
if (@ExPart=5 or @ExPart=0  or (@ExPart>100 and @ExPart<=105))
begin --Part 5.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '5. Inputter slutkorrektioner udenfor startslut i FactSagsplanRettelserPlanlagt'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Slutkorr_udenforStartSlut_step1'' AND type = ''U'') DROP TABLE dbo.Slutkorr_udenforStartSlut_step1'
if @debug = 1 print @cmd
exec (@cmd)


SELECT     dbo.SAGSPLANRET.ID, dbo.SAGSPLANRET.SERIEID, dbo.SAGSPLANRET.SAGSID, dbo.SAGSPLANRET.RETDATO, 
                      dbo.SAGSPLANRET.STARTMINEFTERMIDNAT, dbo.SAGSPLANRET.TID, dbo.SAGSPLANRET.VEJTID, 
                      dbo.SAGSPLANRET.YDELSESTID,dbo.SAGSPLANRET.STATUSID, dbo.SAGSPLANRET.RSTART, 
                      dbo.SAGSPLANRET.RTID, dbo.SAGSPLANRET.RVEJTID, dbo.SAGSPLANRET.REGBES, 
                      dbo.SAGSPLANRET.SERIEDATO, dbo.SAGSPLANRET.VISISTART, dbo.SAGSPLANRET.VISISLUT, 
                      dbo.SAGSPLANRET.MEDID, dbo.SAGSPLAN.STARTDATO, dbo.SAGSPLAN.SLUTDATO
                      Into [Slutkorr_udenforStartSlut_step1]
FROM         dbo.SAGSPLANRET LEFT OUTER JOIN
                     dbo.SAGSPLAN ON dbo.SAGSPLANRET.SERIEID = dbo.SAGSPLAN.ID
WHERE     (dbo.SAGSPLANRET.RETDATO < dbo.SAGSPLAN.STARTDATO) OR
                      (dbo.SAGSPLANRET.RETDATO > dbo.SAGSPLAN.SLUTDATO)
                      
  
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Slutkorr_udenforStartSlut_step2'' AND type = ''U'') DROP TABLE dbo.Slutkorr_udenforStartSlut_step2'
if @debug = 1 print @cmd
exec (@cmd)                      

set @cmd ='SELECT     ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.SAGSID, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.MEDID, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.STATUSID, '+char(13)+
             '         ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.doegninddeling, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.MEDARBEJDER_STATUSID, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.STILLINGSID, '+char(13)+
              '        ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.Medarb_uafdeling, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.JOBID, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.ALDER, '+char(13)+
              '        dbo.[Slutkorr_udenforStartSlut_step1].RETDATO, ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.specifikation, dbo.[Slutkorr_udenforStartSlut_step1].TID   '+char(13)+
' into dbo.[Slutkorr_udenforStartSlut_step2]  '+char(13)+
'FROM         dbo.[Slutkorr_udenforStartSlut_step1] INNER JOIN  '+char(13)+
              '        ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt ON dbo.[Slutkorr_udenforStartSlut_step1].ID = ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt.sagsplanretID   '+char(13)           
                      
    
if @debug = 1 print @cmd
exec (@cmd)
                      

set @cmd ='INSERT INTO ' +@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt'+char(13)+
' (SAGSID, MEDID, STATUSID, doegninddeling, MEDARBEJDER_STATUSID, STILLINGSID, Medarb_uafdeling, JOBID, ALDER,Time, specifikation,Ydelsestid)'+char(13)+
'SELECT SAGSID, MEDID,STATUSID, doegninddeling, MEDARBEJDER_STATUSID, STILLINGSID, Medarb_uafdeling, JOBID, ALDER, RETDATO,specifikation, TID'+char(13)+
'FROM  dbo.[Slutkorr_udenforStartSlut_Step2]'+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'update '+@DestinationDB+'.dbo.FactSagsplanRettelserPlanlagt set borgerorganisation = 9999 where borgerorganisation is null' 
if @debug = 1 print @cmd
exec (@cmd)
 
end --Part 5.

-----------------------------------------------------------------------------------------------------
 --6. Laver Fact_Sagsplanrettelser_udført
 -----------------------------------------------------------------------------------------------------
if (@ExPart=6 or @ExPart=0  or (@ExPart>100 and @ExPart<=106))
begin --Part 6.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '6. Laver Fact_Sagsplanrettelser_udført'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tmp_FactSagsplanrettelserudført'' AND type = ''U'') DROP TABLE dbo.Tmp_FactSagsplanrettelserudført'
if @debug = 1 print @cmd
exec (@cmd)                               -- 


set @cmd = 'SELECT dbo._temp_SagsplanrettelserBorger_3.SagsplanretID,dbo._temp_SagsplanrettelserBorger_3.SERIEID,dbo._temp_SagsplanrettelserBorger_3.SAGSID, dbo._temp_SagsplanrettelserBorger_3.MEDID, dbo._temp_SagsplanrettelserBorger_3.STATUSID, '+char(13)+ 
'dbo._temp_SagsplanrettelserBorger_3.doegninddeling, dbo._temp_SagsplanrettelserBorger_3.Time, dbo._temp_SagsplanrettelserBorger_3.IKRAFTDATO, '+char(13)+ 
'dbo._temp_SagsplanrettelserBorger_3.SLUTDATO, dbo._temp_SagsplanrettelserBorger_3.MEDARBEJDER_STATUSID, '+char(13)+
'DATEADD(MINUTE,dbo._temp_SagsplanrettelserBorger_3.STARTMINEFTERMIDNAT,dbo._temp_SagsplanrettelserBorger_3.TIME) AS BESOEGSSTART, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.TIMER, dbo._temp_SagsplanrettelserBorger_3.STILLINGSID, dbo._temp_SagsplanrettelserBorger_3.Medarb_uafdeling, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.VAGTER, dbo._temp_SagsplanrettelserBorger_3.JOBID, dbo._temp_SagsplanrettelserBorger_3.VISITYPE, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.NORMTID, dbo._temp_SagsplanrettelserBorger_3.YDELSESTID, dbo._temp_SagsplanrettelserBorger_3.AFVIGELSE, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.ALDER, dbo._temp_SagsplanrettelserBorger_3.specifikation, dbo._temp_SagsplanrettelserBorger_3.CPRNR, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.PLEJETYPE, dbo._temp_SagsplanrettelserBorger_3.ID, dbo._temp_SagsplanrettelserBorger_3.borger_start, '+char(13)+
'dbo._temp_SagsplanrettelserBorger_3.borger_slut, dbo._temp_SagsplanrettelserBorger_3.borgerorganisation, '+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE '+char(13)+
'into Tmp_FactSagsplanrettelserudført '+char(13)+
'FROM dbo._temp_SagsplanrettelserBorger_3 INNER JOIN '+char(13)+
''+@DestinationDB+'.dbo.DimBesogStatus ON dbo._temp_SagsplanrettelserBorger_3.STATUSID = '+@DestinationDB+'.dbo.DimBesogStatus.BESOGID '+char(13)+
'WHERE ('+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE = 1) OR '+char(13)+
'('+@DestinationDB+'.dbo.DimBesogStatus.STAT_TYPE = 3) '+char(13)

if @debug = 1 print @cmd
exec (@cmd)
 
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''FactSagsplanrettelserudført'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactSagsplanrettelserudført'
if @debug = 1 print @cmd
exec (@cmd)
--###
set @cmd = 'SELECT '+char(13)+
           '  A.SagsplanretID, '+char(13)+
           '  A.SERIEID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.MEDID, '+char(13)+
           '  A.STATUSID, '+char(13)+
           '  A.doegninddeling, '+char(13)+
           '  A.Time, '+char(13)+
           '  A.IKRAFTDATO, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  A.MEDARBEJDER_STATUSID, '+char(13)+
           '  A.BESOEGSSTART, '+char(13)+
           '  A.TIMER, '+char(13)+
           '  A.STILLINGSID, '+char(13)+
           '  COALESCE(B.OMKOST_GRUPPE,A.Medarb_uafdeling) AS Medarb_uafdeling, '+char(13)+ 
           '  A.VAGTER, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.VISITYPE, '+char(13)+
           '  A.NORMTID, '+char(13)+
           '  A.YDELSESTID, '+char(13)+
           '  A.AFVIGELSE, '+char(13)+
           '  A.ALDER, '+char(13)+
           '  A.specifikation, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  A.ID, '+char(13)+
           '  A.borger_start, '+char(13)+
           '  A.borger_slut, '+char(13)+
           '  A.borgerorganisation, '+char(13)+
           '  A.STAT_TYPE '+char(13)+
           'INTO '+@DestinationDB+'.dbo.FactSagsplanrettelserudført '+char(13)+
           'FROM Tmp_FactSagsplanrettelserudført A '+char(13)+
           'LEFT JOIN Tmp_Vagtplan_Til_Sagsplan B ON A.MEDID=B.MEDARBEJDER AND '+char(13)+
           '  (A.BESOEGSSTART>=B.VAGT_START AND A.BESOEGSSTART<B.VAGT_SLUT) '           
  
if @debug = 1 print @cmd
exec (@cmd)    
 
set @cmd = 'update '+@DestinationDB+'.dbo.FactSagsplanrettelserudført set borgerorganisation = 9999 where borgerorganisation is null' 
if @debug = 1 print @cmd
exec (@cmd)

end --Part 6.
 
-----------------------------------------------------------------------------------------------------
--11. Kopierer Fact_RettelserBesoegsserier til DW
-----------------------------------------------------------------------------------------------------
if (@ExPart=11 or @ExPart=0  or (@ExPart>100 and @ExPart<=111))
begin --Part 11.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '11. Kopierer Fact_RettelserBesoegsserier til DW'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_RettelserBesoegsserier'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_RettelserBesoegsserier'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'select * into '+@DestinationDB+'.dbo.Fact_RettelserBesoegsserier from Fact_RettelserBesoegsserier' 
if @debug = 1 print @cmd
exec (@cmd)
 
end --Part 11

