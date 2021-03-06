USE [AvaleoAnalytics_Staging]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_SagsPlan]    Script Date: 11/15/2010 13:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1. Laver Sagsplan (_Fact_Sagsplan_step1) - Definer gruppering på doegnindeling (STARTMINEFTERMIDNAT er antallet af minutter fra kl. 00.00 den pågældende dag)
--2. Laver Sagsplan (_fact_Sagsplan_step1A1_job) - Henter yderligere information fra SAGSPDET (SAGSPDET indeholder "Aftale serie dele" og er en undertabel til SAGSPLAN og JOBTYPER tabellerne) 
--3. Laver Sagsplan (_fact_Sagsplan_step1A_job) - Joiner OrgTable på så man kan se hvilken paragraf som jobbet er i.
--4. Laver Sagsplan (_Fact_Sagsplan_step1B_job) - Håndterer frekvens type
--5. Laver Sagsplan (_Fact_Sagsplan_step2_medarb) - Tilføj medarbejder historik
--6. Laver Sagsplan (_Fact_Sagsplan_step3_medarb)
--7. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_HJ)
--8. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_SP)
--9. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_TP)
--10. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_other)
--11. Laver Sagsplan (_Fact_sagsplan_step5_sum)
--12. Laver Sagsplan (_Fact_sagsplan_step6_Specifikation)
--13. Laver FactSagsplan i PGEDW (FactSagsplan)
--14. Test_sagsplan
--15. Laver sagsplanrettelser (_Fact_SagsplanMedarbRett_step1)
--16. Laver sagsplanrettelser (_Fact_SagsplanMedarbRett_step2)
--17. Laver Fact_SagsplanRettelser (Fact_SagsplanRettelser)
--18. Laver Fact_RettelserBesoegsserier (Fact_RettelserBesoegsserier)
--19. Laver FACT_MEDARBEJDERE **********SKAL FLYTTES TIL usp_PrepareAnalysisdata***********

ALTER PROCEDURE [dbo].[usp_Create_FactTables_SagsPlan]
@DestinationDB as varchar(200),
@ExPart as Int = 0,
@Debug  as bit = 1

AS
DECLARE @cmd as varchar(max)
DECLARE @Debugcmd as nvarchar(4000)

---------------------------------------------------------------------------------------------------
--1. Laver Sagsplan Step1 (_Fact_Sagsplan_step1) - Definer gruppering på doegnindeling (STARTMINEFTERMIDNAT er antallet af minutter fra kl. 00.00 den pågældende dag)
---------------------------------------------------------------------------------------------------
if (@ExPart=1 or @ExPart=0  or (@ExPart>100 and @ExPart<=101))
begin --Part 1.

	--Debug kode
	-- if (@debug=1)  set @DebugCmd = 'where dbo.SAGSPLAN.medid in (select medid from dbo.FireBirdTestUser) ' + CHAR(13)
	-- else set @DebugCmd=''


if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '1. Laver Sagsplan Step1 (_Fact_Sagsplan_step1)'
	print '---------------------------------------------------------------------------------------------'
end --Print step txt

Delete from sagsplan where startdato > slutdato
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step1' AND type = 'U') DROP TABLE _Fact_Sagsplan_step1


SELECT	ID, 
		SAGSID, 
		case when STARTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102) then CONVERT(DATETIME, '2009-01-01 00:00:00', 102) else STARTDATO end as Startdato, 
		SLUTDATO as SLUTDATO, 
		MEDID, 
		YDELSESTID, 
		VEJTID, --coalesce(BKVAL, 9999) as BKVAL,
		case WHEN STARTMINEFTERMIDNAT> 420 and STARTMINEFTERMIDNAT <= 540 THEN 1 
			WHEN STARTMINEFTERMIDNAT > 540 and STARTMINEFTERMIDNAT<= 660 THEN 2 
			WHEN STARTMINEFTERMIDNAT > 660 and STARTMINEFTERMIDNAT <= 780 THEN 3 
			WHEN STARTMINEFTERMIDNAT > 780 and STARTMINEFTERMIDNAT <= 900 THEN 4 
			WHEN STARTMINEFTERMIDNAT > 900 and STARTMINEFTERMIDNAT <= 1020 THEN 5 
			WHEN STARTMINEFTERMIDNAT > 1020 and STARTMINEFTERMIDNAT <= 1140 THEN 6 
			WHEN STARTMINEFTERMIDNAT > 1140 and STARTMINEFTERMIDNAT <= 1260 THEN 7 
			WHEN STARTMINEFTERMIDNAT > 1260 and STARTMINEFTERMIDNAT <= 1380 THEN 8 
			WHEN STARTMINEFTERMIDNAT > 1380 and STARTMINEFTERMIDNAT <= 1440 OR STARTMINEFTERMIDNAT <= 60 THEN 9 
			WHEN STARTMINEFTERMIDNAT> 60 and STARTMINEFTERMIDNAT <= 180 THEN 10 
			WHEN STARTMINEFTERMIDNAT > 180 and STARTMINEFTERMIDNAT <= 300 THEN 11 
			WHEN STARTMINEFTERMIDNAT > 300 and STARTMINEFTERMIDNAT <= 420 THEN 12 
		end as doegninddeling ,
		STARTMINEFTERMIDNAT,
		frekvens, 
		FREKTYPE,
		frekvalgtedage
into _Fact_Sagsplan_step1
FROM dbo.SAGSPLAN
WHERE     (SLUTDATO >= CONVERT(DATETIME, '2009-01-01 00:00:00', 102))


end --Part 1.

-----------------------------------------------------------------------------------------------------
--1A.  Laver tmp_Vagtplan - Henter vagtplansdata vedr. OMKOST_GRUPPE til brug i forb. med Tværgående afløsertimer 
-----------------------------------------------------------------------------------------------------

if (@ExPart=1 or @ExPart=0  or (@ExPart>100 and @ExPart<=101))
begin --Part 1A.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '1. Laver Tmp_Vagtplan_Til_Sagsplan
	print '---------------------------------------------------------------------------------------------'
end --Print step txt

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_Til_Sagsplan'' AND type = ''U'') DROP TABLE dbo.Tmp_Vagtplan_Til_Sagsplan'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+ 
           '  CONVERT(CHAR(24),A.STARTTIDSPUNKT,120) AS VAGT_START, ' +char(13)+ 
           '  CONVERT(CHAR(24),A.SLUT,120) AS VAGT_SLUT, ' +char(13)+
           '  A.MEDARBEJDER, ' +char(13)+ 
           '  A.MEDARB_GRUPPE, ' +char(13)+
           '  A.OMKOST_GRUPPE ' +char(13)+
           'INTO Tmp_Vagtplan_Til_Sagsplan ' +char(13)+
           'FROM VPL_TJENESTER A ' +char(13)+
           'JOIN VPL_TJENESTETYPER B ON A.TJENESTE=B.ID' +char(13)+
           'WHERE A.ANNULLERET=0 AND A.OMKOST_GRUPPE IS NOT NULL AND A.FAKTISK_TID>0 AND B.PAA_ARBEJDE=1'
           
if @debug = 1 print @cmd    
exec (@cmd)

end --Part 1A.

-----------------------------------------------------------------------------------------------------
--2. Laver Sagsplan (_fact_Sagsplan_step1A1_job) - Henter yderligere information fra SAGSPDET (SAGSPDET indeholder "Aftale serie dele" og er en undertabel til SAGSPLAN og JOBTYPER tabellerne) 
-----------------------------------------------------------------------------------------------------
if (@ExPart=2 or @ExPart=0  or (@ExPart>100 and @ExPart<=102))
begin --Part 2.

if @Debug = 1
begin --Print step txt
print '---------------------------------------------------------------------------------------------'
print '2. Laver Sagsplan (_fact_Sagsplan_step1A1_job)'
print '---------------------------------------------------------------------------------------------'
end --Print step txt

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step1A1_job' AND type = 'U') DROP TABLE _Fact_Sagsplan_step1A1_Job
SELECT	 a.ID as sagspID,
		 b.ID as sagspdetID, 
		 a.SAGSID, 
		 a.STARTDATO, 
		 a.SLUTDATO, 
		 a.MEDID, 
		 a.doegninddeling, 
		 a.frekvens, 
		 a.FREKTYPE, 
		 a.frekvalgtedage, 
		 b.JOBID, 
		 b.VISITYPE, 
		 b.NORMTID, 
		 b.YDELSESTID, 
		 b.VISIID
Into _fact_Sagsplan_step1A1_job
FROM _Fact_Sagsplan_step1 a INNER JOIN
SAGSPDET b ON a.ID = b.SAGSPID


end --Part 2.

-----------------------------------------------------------------------------------------------------
--3. Laver Sagsplan (_fact_Sagsplan_step1A_job) - Joiner OrgTable på så man kan se hvilken paragraf som jobbet er i. OrgTable er en manuel oprettet og vedligeholdt tabel
--					Paragraf angiver hvilke type som jobbet er (Terapuetisk, Hjemmepleje, sygepleje eller ukendt) - ligger i kolonnen ORg_REPORT 
-----------------------------------------------------------------------------------------------------
if (@ExPart=3 or @ExPart=0  or (@ExPart>100 and @ExPart<=103))
begin --Part 3.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '3. Laver Sagsplan (_fact_Sagsplan_step1A_job)'
	print '---------------------------------------------------------------------------------------------'
end --Print step txt
	

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step1A_job' AND type = 'U') DROP TABLE _Fact_Sagsplan_step1A_Job

SELECT	A1.sagspID, 
		A1.sagspdetID, 
		A1.SAGSID, 
		A1.STARTDATO, 
		A1.SLUTDATO, 
		A1.MEDID, 
		A1.doegninddeling, 
		A1.frekvens, 
		A1.FREKTYPE, 
		A1.frekvalgtedage, 
		A1.JOBID, 
		JOBTYPER.PLEJETYPE AS visitype, 
		A1.NORMTID, 
		A1.YDELSESTID, 
		A1.VISIID, 
		JOBTYPER.PARAGRAF, 
		OrgTable.ORG_REPORT
Into _fact_Sagsplan_step1A_job
FROM OrgTable INNER JOIN JOBTYPER ON OrgTable.PARAGRAFID = JOBTYPER.PARAGRAF RIGHT OUTER JOIN _fact_Sagsplan_step1A1_job A1 ON JOBTYPER.JOBID = A1.JOBID
 
end --Part 3.


-----------------------------------------------------------------------------------------------------
-- 4. Laver Sagsplan (_Fact_Sagsplan_step1B_job) - Håndterer frekvens type
-----------------------------------------------------------------------------------------------------
if (@ExPart=4 or @ExPart=0  or (@ExPart>100 and @ExPart<=104))
begin --Part 4.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '4. Laver Sagsplan (_Fact_Sagsplan_step1B_job)'
	print '---------------------------------------------------------------------------------------------'
end --Print step txt


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step1B_job' AND type = 'U') DROP TABLE _Fact_Sagsplan_step1B_Job

SELECT	sagspID, 
		sagspdetID, 
		SAGSID, 
		STARTDATO as sagsplan_start, 
		SLUTDATO as sagsplan_slut, 
		MEDID, 
		doegninddeling, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		VISIID, 
		--ORG_REPORT,
		case	when frekvens > 0 then YDELSESTID / frekvens
				when frekvens < 0 then Ydelsestid + (YDELSESTID / frekvens)
		end as Planlagt_uge 
Into _Fact_Sagsplan_step1B_job
FROM _fact_Sagsplan_step1A_job
where frektype = 0
union all
SELECT	sagspID, 
		sagspdetID,
		SAGSID, 
		STARTDATO, 
		SLUTDATO, 
		MEDID, 
		doegninddeling, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		VISIID, 
		--ORG_REPORT,
		case	when frekvens > 0 then Ydelsestid * 7 / frekvens
				when frekvens <0 then (ydelsestid * 7) + (ydelsestid*7/frekvens)
		end as planlagt_uge
FROM _fact_Sagsplan_step1A_job
where frektype = 1
union all
SELECT	sagspID, 
		sagspdetID,
		SAGSID, 
		STARTDATO, 
		SLUTDATO, 
		MEDID, 
		doegninddeling, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		VISIID,
		--ORG_REPORT, 
		case when frekvens > 0 then Ydelsestid * 5 / frekvens
			when frekvens <0 then (ydelsestid * 5) + (ydelsestid*5/frekvens)
		end as planlagt_uge
FROM _fact_Sagsplan_step1A_job
where frektype = 2
union all
SELECT	sagspID, 
		sagspdetID, 
		SAGSID, 
		STARTDATO, 
		SLUTDATO, 
		MEDID, 
		doegninddeling, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		VISIID,
		--ORG_REPORT, 
		case when frekvens > 0 then Ydelsestid * 2 / frekvens
			when frekvens <0 then (ydelsestid * 2) + (ydelsestid*2/frekvens)
		end as planlagt_uge
FROM _fact_Sagsplan_step1A_job
where frektype = 3
union all
SELECT	sagspID, 
		sagspdetID, 
		SAGSID, 
		STARTDATO, 
		SLUTDATO, 
		MEDID, 
		doegninddeling, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		JOBID, 
		VISITYPE, 
		NORMTID, 
		YDELSESTID, 
		VISIID,
		--ORG_REPORT, 
		case when frekvens > 0 then (ydelsestid * dbo.BinDayCounter(frekvalgtedage))/Frekvens
			when frekvens <0 then ((ydelsestid * 7) - (ydelsestid * dbo.BinDayCounter(frekvalgtedage)))/-Frekvens
		end as planlagt_uge
FROM _fact_Sagsplan_step1A_job
where frektype = 4
 
end --Part 4.


-----------------------------------------------------------------------------------------------------
--5. Laver Sagsplan (_Fact_Sagsplan_step2_medarb) - Tilføj medarbejder historik
-----------------------------------------------------------------------------------------------------
if (@ExPart=5 or @ExPart=0  or (@ExPart>100 and @ExPart<=105))
begin --Part 5.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '5. Laver Sagsplan (_Fact_Sagsplan_step2_medarb)'
	print '---------------------------------------------------------------------------------------------'
end --Print step txt

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step2_medarb' AND type = 'U') DROP TABLE _Fact_Sagsplan_step2_medarb

SELECT  A.sagspID, 
		A.sagspdetID,
		A.SAGSID,
		A.sagsplan_start, 
		A.sagsplan_slut, 
		--A.Org_Report,
		A.MEDID, 
		A.doegninddeling, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.JOBID, 
		A.VISITYPE, 
		A.NORMTID, 
		A.YDELSESTID, 
		A.VISIID, 
		A.Planlagt_uge, 
		COALESCE (MEDHISTORIK.MEDARBEJDERID, 9999) AS Medarbejderid, 
		COALESCE (MEDHISTORIK.IKRAFTDATO, 9999) AS medarb_ikraft, 
		COALESCE (MEDHISTORIK.SLUTDATO, 9999) AS medarb_slut, 
		COALESCE (MEDHISTORIK.MEDARBEJDER_STATUS, 9999) AS MEDARBEJDER_STATUS, 
		COALESCE (MEDHISTORIK.MEDARBEJDER_STATUSID, 9999) AS MEDARBEJDER_STATUSID, 
		COALESCE (MEDHISTORIK.STILLINGSID, 9999) AS STILLINGSID, 
		COALESCE (MEDHISTORIK.UAFDELINGID, 9999) AS UAFDELINGID
into _Fact_Sagsplan_step2_medarb
FROM _Fact_Sagsplan_step1B_job A LEFT OUTER JOIN
MEDHISTORIK ON A.MEDID = MEDHISTORIK.MEDARBEJDERID AND 
MEDHISTORIK.SLUTDATO >= A.sagsplan_start AND 
MEDHISTORIK.IKRAFTDATO <= A.sagsplan_slut

end --part 5

 -----------------------------------------------------------------------------------------------------
 --6. Laver Sagsplan (_Fact_Sagsplan_step3_medarb)
 -----------------------------------------------------------------------------------------------------
if (@ExPart=6 or @ExPart=0  or (@ExPart>100 and @ExPart<=106))
begin --Part 6.

if @Debug = 1
begin --Print step txt 
	print '---------------------------------------------------------------------------------------------'
	print '6. Laver Sagsplan (_Fact_Sagsplan_step3_medarb)'
	print '---------------------------------------------------------------------------------------------'
end --print step txt
 
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_Sagsplan_step3_medarb' AND type = 'U') DROP TABLE _Fact_Sagsplan_step3_medarb
 
SELECT	sagspID, 
		sagspdetID, 
		SAGSID, 
		Sagsplan_start, 
		sagsplan_slut, 
		MEDID,-- YDELSESTID, VEJTID, --BKVAL, 
		doegninddeling, 
		Medarb_ikraft, 
		--Org_Report,
		Medarb_slut, 
		STILLINGSID, 
		jobid, 
		UAFDELINGID, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID,
		1 AS type, 
		Sagsplan_start as start, 
		sagsplan_slut as slut,
		frekvens,
		FREKTYPE,
		frekvalgtedage, 
		Planlagt_uge
into _Fact_Sagsplan_step3_medarb
FROM dbo._Fact_Sagsplan_step2_medarb 
WHERE (Sagsplan_start >= Medarb_ikraft) AND (Medarb_slut >= sagsplan_slut)
UNION ALL
SELECT	sagspID, 
		sagspdetID,
		SAGSID, 
		Sagsplan_start, 
		sagsplan_slut, 
		MEDID,
		doegninddeling, 
		Medarb_ikraft,
	--	Org_Report, 
		Medarb_slut, 
		STILLINGSID, 
		jobid, 
		UAFDELINGID, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID,
		1 AS type, 
		Sagsplan_start as start, 
		Medarb_slut as slut,
		frekvens,
		FREKTYPE,
		frekvalgtedage, 
		Planlagt_uge
FROM dbo._Fact_Sagsplan_step2_medarb 
WHERE (Sagsplan_start >= Medarb_ikraft) AND (Medarb_slut < sagsplan_slut)
UNION ALL
SELECT	sagspID, 
		sagspdetID,
		SAGSID, 
		Sagsplan_start, 
		sagsplan_slut, 
		MEDID,
		doegninddeling, 
		Medarb_ikraft, 
	--	Org_Report,
		Medarb_slut, 
		STILLINGSID, 
		jobid, 
		UAFDELINGID, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID,
		1 AS type, 
		Medarb_ikraft as start, 
		Medarb_slut as slut,
		frekvens,
		FREKTYPE,
		frekvalgtedage, 
		Planlagt_uge
FROM dbo._Fact_Sagsplan_step2_medarb 
WHERE (Sagsplan_start < Medarb_ikraft) AND (Medarb_slut < sagsplan_slut)
UNION ALL
SELECT	sagspID, 
		sagspdetID,
		SAGSID, 
		Sagsplan_start, 
		sagsplan_slut, 
		MEDID,
		doegninddeling, 
		Medarb_ikraft, 
	--	Org_Report,
		Medarb_slut, 
		STILLINGSID, 
		jobid, 
		UAFDELINGID, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID,
		1 AS type, 
		Medarb_ikraft as start, 
		sagsplan_slut as slut,
		frekvens,
		FREKTYPE,
		frekvalgtedage, 
		Planlagt_uge
FROM dbo._Fact_Sagsplan_step2_medarb 
WHERE (Sagsplan_start < Medarb_ikraft) AND (Medarb_slut >= sagsplan_slut)
 
 end --part 6
 
 -----------------------------------------------------------------------------------------------------
 --7. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_HJ) - denormaliserer samt tilføjer borger data for HjemmePlejen
 -----------------------------------------------------------------------------------------------------
if (@ExPart=7 or @ExPart=0  or (@ExPart>100 and @ExPart<=107))
begin --Part 7.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '7. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_HJ)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagsplanMedarb_step4_jobid_HJ' AND type = 'U') DROP TABLE _Fact_SagsplanMedarb_step4_jobid_HJ


SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.HJEMMEPLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		A.slut as slut_final
INTO _Fact_SagsplanMedarb_step4_jobid_HJ
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_HJ_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut <= B.SLUTDATO
--where (A.Org_Report = 'HJ.PLE')
--Tabellen hvor man mapper paragrafID indeholder notationen som der her ledes efter
WHERE A.VISITYPE IN (0,1,2,6,7,8)
union all
SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.HJEMMEPLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		B.IKRAFTDATO as start_final, 
		A.slut as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_HJ_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut < B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'HJ.PLE')
WHERE A.VISITYPE IN (0,1,2,6,7,8)
union all
SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.HJEMMEPLEJE_GRUPPEID AS borgerorg ,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		B.IKRAFTDATO as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_HJ_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut >= B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'HJ.PLE')
WHERE A.VISITYPE IN (0,1,2,6,7,8)
union all
SELECT A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.HJEMMEPLEJE_GRUPPEID AS borgerorg ,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_HJ_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut >B.SLUTDATO AND 
A.start < B.slutdato
--where (A.Org_Report = 'HJ.PLE')
WHERE A.VISITYPE IN (0,1,2,6,7,8)

end --part 7.


-----------------------------------------------------------------------------------------------------
--8. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_SP) - denormaliserer samt tilføjer borger data
-----------------------------------------------------------------------------------------------------
if (@ExPart=8 or @ExPart=0  or (@ExPart>100 and @ExPart<=108))
begin --Part 8.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '8. Laver Sagsplan (_Fact_SagsplanMedarb_step4_jobid_SP)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagsplanMedarb_step4_jobid_SP' AND type = 'U') DROP TABLE _Fact_SagsplanMedarb_step4_jobid_SP

SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.SygePLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		A.slut as slut_final
INTO _Fact_SagsplanMedarb_step4_jobid_SP
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_SP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut <= B.SLUTDATO
--where (A.Org_Report = 'SPL')
WHERE A.VISITYPE = '5'
union all
SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.SygePLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		B.IKRAFTDATO as start_final, 
		A.slut as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_SP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut < B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'SPL')
WHERE A.VISITYPE = '5'
union all
SELECT  A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.SygePLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		B.IKRAFTDATO as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_SP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut >= B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'SPL')
WHERE A.VISITYPE = '5'
union all
SELECT A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		B.SygePLEJE_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_Sagsplan_step3_medarb A INNER JOIN
_tmp_SP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut > B.SLUTDATO AND 
A.start < B.slutdato
--where (A.Org_Report = 'SPL')
WHERE A.VISITYPE = '5'


end --part 8

-----------------------------------------------------------------------------------------------------
--9. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_TP)
-----------------------------------------------------------------------------------------------------
if (@ExPart=9 or @ExPart=0  or (@ExPart>100 and @ExPart<=109))
begin --Part 9.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '9. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_TP)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagSPlanMedarb_step4_jobid_TP' AND type = 'U') DROP TABLE _Fact_SagSPlanMedarb_step4_jobid_TP

SELECT	A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		--B.SygePLEJE_GRUPPEID AS borgerorg,
		B.TERAPEUT_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		A.slut as slut_final
INTO _Fact_SagSPlanMedarb_step4_jobid_TP
FROM _Fact_SagSPlan_step3_medarb A INNER JOIN
_tmp_TP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut <= B.SLUTDATO
--where (A.Org_Report = 'TER')
WHERE A.VISITYPE IN (3,4)
union all
SELECT  A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		--B.SygePLEJE_GRUPPEID AS borgerorg,
		B.TERAPEUT_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		B.IKRAFTDATO as start_final, 
		A.slut as slut_final
FROM _Fact_SagSPlan_step3_medarb A INNER JOIN
_tmp_TP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut < B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'TER')
WHERE A.VISITYPE IN (3,4)
union all
SELECT  A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		--B.SYGEPLEJE_GRUPPEID AS borgerorg,
		B.TERAPEUT_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO,
		B.IKRAFTDATO as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_SagSPlan_step3_medarb A INNER JOIN
_tmp_TP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start < B.IKRAFTDATO AND 
A.slut >= B.SLUTDATO AND 
A.slut > B.ikraftDATO
--where (A.Org_Report = 'TER')
WHERE A.VISITYPE IN (3,4)
union all
SELECT  A.sagspID, 
		A.sagspdetID,
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE,
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		--B.SygePLEJE_GRUPPEID AS borgerorg,
		B.TERAPEUT_GRUPPEID AS borgerorg,
		B.IKRAFTDATO, 
		B.SLUTDATO, 
		A.start as start_final, 
		B.SLUTDATO as slut_final
FROM _Fact_SagSPlan_step3_medarb A INNER JOIN
_tmp_TP_SAGSHISTORIK B ON A.SAGSID = B.SAGSID AND 
A.start >= B.IKRAFTDATO AND 
A.slut > B.SLUTDATO AND 
A.start < B.slutdato
--where (A.Org_Report = 'TER')
WHERE A.VISITYPE IN (3,4)

end -- Part 9.

-----------------------------------------------------------------------------------------------------
--10. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_other)
-----------------------------------------------------------------------------------------------------
if (@ExPart=10 or @ExPart=0  or (@ExPart>100 and @ExPart<=110))
begin --Part 10.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '10. Laver Sagsplan (_Fact_SagSPlanMedarb_step4_jobid_other)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagSPlanMedarb_step4_jobid_Other' AND type = 'U') DROP TABLE _Fact_SagSPlanMedarb_step4_jobid_other
SELECT	A.sagspID, 
		A.sagspdetID, 
		A.SAGSID, 
		A.MEDID, 
		A.doegninddeling, 
		A.jobid, 
		A.STILLINGSID, 
		A.UAFDELINGID, 
		A.VISITYPE, 
		A.VISIID, 
		A.MEDARBEJDERID, 
		A.MEDARBEJDER_STATUS, 
		A.MEDARBEJDER_STATUSID, 
		A.start, 
		A.slut, 
		A.frekvens, 
		A.FREKTYPE, 
		A.frekvalgtedage, 
		A.Planlagt_uge, 
		9999 AS borgerorg, 
		A.start as start_final, 
		A.slut as slut_final
INTO _Fact_SagSPlanMedarb_step4_jobid_other
FROM _Fact_SagSPlan_step3_medarb A
where visitype is null
--where (A.Org_Report is null) --Dummy where statement til at danne tom tabel
--where (A.Org_Report = 'Ukendt') OR (A.Org_Report is null)

 

Update _Fact_SagSPlanMedarb_step4_jobid_HJ
set BORGERORG = 9999
where BORGERORG is null
Update _Fact_SagSPlanMedarb_step4_jobid_sp
set BORGERORG = 9999
where BORGERORG is null
Update _Fact_SagSPlanMedarb_step4_jobid_TP
set BORGERORG = 9999
where BORGERORG is null

end --Part 10.

-----------------------------------------------------------------------------------------------------
--11. Laver Sagsplan (_Fact_sagsplan_step5_sum)
-----------------------------------------------------------------------------------------------------
if (@ExPart=11 or @ExPart=0  or (@ExPart>100 and @ExPart<=111))
begin --Part 11.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '11. Laver Sagsplan (_Fact_sagsplan_step5_sum)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_sagsplan_step5_sum' AND type = 'U') DROP TABLE _Fact_sagsplan_step5_sum

SELECT	sagspID, 
		SagspdetID, 
		SAGSID, 
		MEDID, 
		doegninddeling, 
		jobid, 
		STILLINGSID, 
		UAFDELINGID AS medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		Planlagt_uge, 
		borgerorg, 
		start_final, 
		slut_final
INTO _Fact_sagsplan_step5_sum
FROM _Fact_SagsplanMedarb_step4_jobid_HJ
union all
SELECT	sagspID, 
		SagspdetID, 
		SAGSID, 
		MEDID, 
		doegninddeling, 
		jobid, 
		STILLINGSID, 
		UAFDELINGID AS medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		Planlagt_uge, 
		borgerorg, 
		start_final, 
		slut_final
FROM _Fact_SagsplanMedarb_step4_jobid_TP
union all
SELECT  sagspID, 
		SagspdetID, 
		SAGSID, 
		MEDID, 
		doegninddeling, 
		jobid, 
		STILLINGSID, 
		UAFDELINGID AS medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		Planlagt_uge, 
		borgerorg, 
		start_final, 
		slut_final
FROM _Fact_SagsplanMedarb_step4_jobid_SP
union all
SELECT  sagspID, 
		SagspdetID, 
		SAGSID, 
		MEDID, 
		doegninddeling, 
		jobid, 
		STILLINGSID, 
		UAFDELINGID AS medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		Planlagt_uge, 
		borgerorg, 
		start_final, 
		slut_final
FROM _Fact_SagsplanMedarb_step4_jobid_other

end --Part 11.

-----------------------------------------------------------------------------------------------------
--12. Laver Sagsplan (_Fact_sagsplan_step6_Specifikation)
-----------------------------------------------------------------------------------------------------
if (@ExPart=12 or @ExPart=0  or (@ExPart>100 and @ExPart<=112))
begin --Part 12.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '12. Laver Sagsplan (_Fact_sagsplan_step6_Specifikation)'
	print '---------------------------------------------------------------------------------------------'
end
--HDJ###
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_sagsplan_step6_specifikation' AND type = 'U') DROP TABLE _Fact_sagsplan_step6_specifikation

SELECT sagspID, 
		SagspdetID,
		SAGSID, 
		MEDID, 
		doegninddeling, 
		(SELECT STARTMINEFTERMIDNAT FROM SAGSPLAN WHERE ID=_Fact_sagsplan_step5_sum.SAGSPID) AS STARTMINEFTERMIDNAT,
		coalesce(JOBID, 9999) as jobid, 
		STILLINGSID, 
		medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		Planlagt_uge, 
		borgerorg,
		start_final as start, 
		slut_final as slut, 
		start_final AS date, 
		2 AS specifikation
INTO _Fact_sagsplan_step6_Specifikation
FROM _Fact_sagsplan_step5_sum
WHERE (start_final IN(SELECT PK_Date FROM dbo.DIM_TIME))
union all
SELECT sagspID, 
		SagspdetID,
		SAGSID, 
		MEDID, 
		doegninddeling, 
		(SELECT STARTMINEFTERMIDNAT FROM SAGSPLAN WHERE ID=_Fact_sagsplan_step5_sum.SAGSPID) AS STARTMINEFTERMIDNAT,
		coalesce(JOBID, 9999) as jobid, 
		STILLINGSID, 
		medarb_org, 
		VISITYPE, 
		VISIID, 
		MEDARBEJDERID, 
		MEDARBEJDER_STATUS, 
		MEDARBEJDER_STATUSID, 
		frekvens, 
		FREKTYPE, 
		frekvalgtedage, 
		-Planlagt_uge, 
		borgerorg, 
		start_final as start, 
		slut_final as slut, 
		slut_final AS date, 
		3 AS specifikation
FROM _Fact_sagsplan_step5_sum
WHERE (slut_final IN(SELECT PK_Date FROM dbo.DIM_TIME))
 
 end --Part 12.
 
-----------------------------------------------------------------------------------------------------
--13. Laver FactSagsplan i PGEDW (FactSagsplan)
-----------------------------------------------------------------------------------------------------
if (@ExPart=13 or @ExPart=0  or (@ExPart>100 and @ExPart<=113))
begin --Part 13.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '13. Laver FactSagsplan i PGEDW (FactSagsplan)'
	print '---------------------------------------------------------------------------------------------'
end


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''FactSagsplan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactSagsplan'
if @debug = 1 print @cmd
exec (@cmd)
--set @cmd = 'usp_Birthddays ''_Fact_sagsplan_step6_Specifikation'', '''+DB_NAME() +''',''Planlagt_uge'''
--if @debug = 1 print @cmd
--exec (@cmd)
set @cmd = 'SELECT *, 1 as Besoegsstatusid into '+@DestinationDB+'.dbo.FactSagsplan FROM _Fact_sagsplan_step6_Specifikation'
if @debug = 1 print @cmd
exec (@cmd)

end --Part 13.
 
 
----------------------------------------------------------------------------------------------------- 
--14. Test_sagsplan
-----------------------------------------------------------------------------------------------------
if (@ExPart=14 or @ExPart=0  or (@ExPart>100 and @ExPart<=114))
begin --Part 14.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '14. FactGrundplan'
	print '---------------------------------------------------------------------------------------------'
end 

--opdater MEDARB_ORG fra vagtplan hvis gruppeskift (tværgående afløsertimer)
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tmp_FactGrundplan'' AND type = ''U'') DROP TABLE dbo.Tmp_FactGrundplan'
exec (@cmd)
--Lav STARTMINEFTERMIDNAT om til BESOEGSSTART
set @cmd = 'SELECT '+char(13)+ 
           '  sagspID, '+char(13)+
           '  SagspdetID, '+char(13)+
           '  SAGSID, '+char(13)+
           '  MEDID, '+char(13)+
           '  doegninddeling, '+char(13)+
           '  DATEADD(MINUTE,STARTMINEFTERMIDNAT,PK_DATE) AS BESOEGSSTART, '+char(13)+
           '  jobid, '+char(13)+
           '  STILLINGSID, '+char(13)+
           '  MEDARB_ORG, '+char(13)+
           '  VISITYPE, '+char(13)+
           '  VISIID, '+char(13)+
           '  MEDARBEJDERID, '+char(13)+
           '  MEDARBEJDER_STATUS, '+char(13)+
           '  MEDARBEJDER_STATUSID, '+char(13)+
           '  frekvens, '+char(13)+
           '  FREKTYPE, '+char(13)+
           '  frekvalgtedage, '+char(13)+
           '  Planlagt_uge, '+char(13)+
           '  borgerorg, '+char(13)+
           '  start, '+char(13)+
           '  slut, '+char(13)+
           '  date, '+char(13)+
           '  specifikation, '+char(13)+
           '  PK_Date '+char(13)+
           'INTO Tmp_FactGrundplan '+char(13)+
           'FROM '+@DestinationDB+'.dbo._FactGrundplan' --view

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''FactGrundplan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactGrundplan'
exec (@cmd)
--join med tmp_vagtplan og sæt omkost_gruppe på som medarb_org
set @cmd = 'SELECT '+char(13)+ 
           '  A.sagspID, '+char(13)+
           '  A.SagspdetID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.MEDID, '+char(13)+
           '  A.doegninddeling, '+char(13)+
           '  A.jobid, '+char(13)+
           '  A.STILLINGSID, '+char(13)+
           '  COALESCE(B.OMKOST_GRUPPE,A.medarb_org) AS MEDARB_ORG, '+char(13)+
           '  A.VISITYPE, '+char(13)+
           '  A.VISIID, '+char(13)+
           '  A.MEDARBEJDERID, '+char(13)+
           '  A.MEDARBEJDER_STATUS, '+char(13)+
           '  A.MEDARBEJDER_STATUSID, '+char(13)+
           '  A.frekvens, '+char(13)+
           '  A.FREKTYPE, '+char(13)+
           '  A.frekvalgtedage, '+char(13)+
           '  A.Planlagt_uge, '+char(13)+
           '  A.borgerorg, '+char(13)+
           '  A.start, '+char(13)+
           '  A.slut, '+char(13)+
           '  A.date, '+char(13)+
           '  A.specifikation, '+char(13)+
           '  A.PK_Date '+char(13)+
           'INTO '+@DestinationDB+'.dbo.FactGrundplan '+char(13)+
           'FROM Tmp_FactGrundplan A' +char(13)+ --view
           'LEFT JOIN Tmp_Vagtplan_Til_Sagsplan B ON A.MEDID=B.MEDARBEJDER AND '+char(13)+
           '  (A.BESOEGSSTART>=B.VAGT_START AND A.BESOEGSSTART<B.VAGT_SLUT) '
           
if @debug = 1 print @cmd
exec (@cmd)


 
end --Part 14.

--HDJ### 
 
-------------------------------------------------------------------------------------------------------
----15. Lav sagsplanrettelser (_Fact_SagsplanMedarbRett_step1)
-------------------------------------------------------------------------------------------------------
if (@ExPart=15 or @ExPart=0  or (@ExPart>100 and @ExPart<=115))
begin --Part 15.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '15. Lav sagsplanrettelser (_Fact_SagsplanMedarbRett_step1)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagsplanMedarbRett_step1' AND type = 'U') DROP TABLE _Fact_SagsplanMedarbRett_step1
SELECT ID as ID, serieid, SAGSID, MEDID, VEJTID, YDELSESTID, rtid, rvejtid, STATUSID, --coalesce(BKVAL, 9999) as BKVAL
RETDATO AS Time,
case WHEN STARTMINEFTERMIDNAT > 420 and STARTMINEFTERMIDNAT <= 540 THEN 1 
WHEN STARTMINEFTERMIDNAT > 540 and STARTMINEFTERMIDNAT <= 660 THEN 2 
WHEN STARTMINEFTERMIDNAT > 660 and STARTMINEFTERMIDNAT <= 780 THEN 3 
WHEN STARTMINEFTERMIDNAT > 780 and STARTMINEFTERMIDNAT <= 900 THEN 4 
WHEN STARTMINEFTERMIDNAT > 900 and STARTMINEFTERMIDNAT <= 1020 THEN 5 
WHEN STARTMINEFTERMIDNAT > 1020 and STARTMINEFTERMIDNAT <= 1140 THEN 6 
WHEN STARTMINEFTERMIDNAT > 1140 and STARTMINEFTERMIDNAT<= 1260 THEN 7 
WHEN STARTMINEFTERMIDNAT > 1260 and STARTMINEFTERMIDNAT <= 1380 THEN 8 
WHEN STARTMINEFTERMIDNAT > 1380 and STARTMINEFTERMIDNAT <= 1440 OR STARTMINEFTERMIDNAT <= 60 THEN 9 
WHEN STARTMINEFTERMIDNAT > 60 and STARTMINEFTERMIDNAT <= 180 THEN 10 
WHEN STARTMINEFTERMIDNAT > 180 and STARTMINEFTERMIDNAT <= 300 THEN 11 
WHEN STARTMINEFTERMIDNAT > 300 and STARTMINEFTERMIDNAT <= 420 THEN 12 
end as doegninddeling 
into _Fact_SagsplanMedarbRett_step1
FROM dbo.SAGSPLANRET
where datepart(year, retdato) >=2009

end --Part 15.


-------------------------------------------------------------------------------------------------------
----16. lav sagsplanrettelser (_Fact_SagsplanMedarbRett_step2)
-------------------------------------------------------------------------------------------------------
if (@ExPart=16 or @ExPart=0  or (@ExPart>100 and @ExPart<=116))
begin --Part 16.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '16. lav sagsplanrettelser (_Fact_SagsplanMedarbRett_step2)'
	print '---------------------------------------------------------------------------------------------'
end

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = '_Fact_SagsplanMedarbRett_step2' AND type = 'U') DROP TABLE _Fact_SagsplanMedarbRett_step2


SELECT A.ID, 
		A.Serieid, 
		A.SAGSID, 
		A.MEDID, 
		A.STATUSID, 
		-- _Fact_SagsplanMedarbRett_step1.BKVAL, 
		A.doegninddeling, 
		A.Time, 
		MEDHISTORIK.IKRAFTDATO, 
		MEDHISTORIK.SLUTDATO, 
		coalesce(MEDHISTORIK.MEDARBEJDER_STATUSID,9999) as MEDARBEJDER_STATUSID, 
		MEDHISTORIK.TIMER, 
		MEDHISTORIK.STILLINGSID, 
		MEDHISTORIK.UAFDELINGID as 'Medarb_uafdeling' , 
		MEDHISTORIK.VAGTER, 
		SAGSPRETDET.JOBID, 
		SAGSPRETDET.VISITYPE, 
		SAGSPRETDET.NORMTID, 
		SAGSPRETDET.YDELSESTID, 
		SAGSPRETDET.AFVIGELSE, 
		dbo.age( SAGER.CPRNR, A.Time) as ALDER, 
		4 as specifikation, 
		SAGER.CPRNR
into _Fact_SagsplanMedarbRett_step2
FROM MEDHISTORIK INNER JOIN
_Fact_SagsplanMedarbRett_step1 A ON MEDHISTORIK.MEDARBEJDERID = A.MEDID AND 
MEDHISTORIK.IKRAFTDATO <= A.Time AND MEDHISTORIK.SLUTDATO >= A.Time INNER JOIN
SAGSPRETDET ON A.ID = SAGSPRETDET.SAGSPRETID LEFT OUTER JOIN
SAGER ON A.SAGSID = SAGER.SAGSID
WHERE (A.Time IN
(SELECT PK_Date
FROM Dim_Time)) 
 
end --Part 16.


-------------------------------------------------------------------------------------------------------
----17. Laver Fact_SagsplanRettelser (Fact_SagsplanRettelser)
-------------------------------------------------------------------------------------------------------
if (@ExPart=17 or @ExPart=0  or (@ExPart>100 and @ExPart<=117))
begin --Part 17.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '17. Laver Fact_SagsplanRettelser (Fact_SagsplanRettelser)'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_SagsplanRettelser'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_SagsplanRettelser'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT * into '+@DestinationDB+'.dbo.Fact_SagsplanRettelser FROM _Fact_SagsplanMedarbRett_step2'
if @debug = 1 print @cmd
exec (@cmd)

end --Part 17.


-----------------------------------------------------------------------------------------------------
--18. Laver Fact_RettelserBesoegsserier (Fact_RettelserBesoegsserier)
-----------------------------------------------------------------------------------------------------
if (@ExPart=18 or @ExPart=0  or (@ExPart>100 and @ExPart<=118))
begin --Part 18.

if @Debug = 1
begin --Print step txt
	print '---------------------------------------------------------------------------------------------'
	print '18. Laver Fact_RettelserBesoegsserier (Fact_RettelserBesoegsserier)'
	print '---------------------------------------------------------------------------------------------'
end

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Sagsplan_rettelserTilBesoegsserier'' AND type = ''U'') DROP TABLE dbo.Sagsplan_rettelserTilBesoegsserier'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     dbo.SAGSPLAN.ID AS sagsplanID, dbo.SAGSPLAN.SAGSID, dbo.SAGSPLAN.MEDID, dbo.SAGSPLAN.STARTDATO, dbo.SAGSPLAN.SLUTDATO, 
                      dbo.SAGSPLAN.STARTMINEFTERMIDNAT, dbo.SAGSPLAN.TID, dbo.SAGSPLAN.FREKVENS, dbo.SAGSPDET.JOBID, dbo.SAGSPDET.VISITYPE, 
                      dbo.SAGSPDET.NORMTID, dbo.SAGSPDET.YDELSESTID, dbo.SAGSPLANRET.SERIEID, dbo.SAGSPLANRET.RETDATO, dbo.SAGSPLANRET.ID AS Sagpretid, 
                      dbo.SAGSPRETDET.SAGSPRETID, dbo.SAGSPDET.ID AS sagpdetId
Into Sagsplan_rettelserTilBesoegsserier                      
FROM         dbo.SAGSPDET INNER JOIN
                      dbo.SAGSPLAN ON dbo.SAGSPDET.SAGSPID = dbo.SAGSPLAN.ID INNER JOIN
                      dbo.SAGSPLANRET INNER JOIN
                      dbo.SAGSPRETDET ON dbo.SAGSPLANRET.ID = dbo.SAGSPRETDET.SAGSPRETID ON dbo.SAGSPLAN.ID = dbo.SAGSPLANRET.SERIEID
WHERE     (dbo.SAGSPLANRET.RETDATO > CONVERT(DATETIME, '2009-01-01 00:00:00', 102))

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Fact_RettelserBesoegsserier'' AND type = ''U'') DROP TABLE dbo.Fact_RettelserBesoegsserier'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT DISTINCT '+char(13)+
           '           '+@DestinationDB+'.dbo.FactGrundplan.sagspID, '+@DestinationDB+'.dbo.FactGrundplan.SagspdetID, '+@DestinationDB+'.dbo.FactGrundplan.SAGSID, '+char(13)+
            '          '+@DestinationDB+'.dbo.FactGrundplan.MEDID, '+@DestinationDB+'.dbo.FactGrundplan.doegninddeling, '+@DestinationDB+'.dbo.FactGrundplan.jobid, '+char(13)+
           '           '+@DestinationDB+'.dbo.FactGrundplan.STILLINGSID, '+@DestinationDB+'.dbo.FactGrundplan.medarb_org, '+@DestinationDB+'.dbo.FactGrundplan.VISITYPE, '+char(13)+
           '           '+@DestinationDB+'.dbo.FactGrundplan.VISIID, '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDERID, '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDER_STATUS, '+char(13)+
           '           '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDER_STATUSID, '+@DestinationDB+'.dbo.FactGrundplan.frekvens, '+@DestinationDB+'.dbo.FactGrundplan.FREKTYPE, '+char(13)+
           '           '+@DestinationDB+'.dbo.FactGrundplan.frekvalgtedage, '+@DestinationDB+'.dbo.FactGrundplan.borgerorg, '+@DestinationDB+'.dbo.FactGrundplan.start, '+char(13)+
            '          '+@DestinationDB+'.dbo.FactGrundplan.slut, dbo.Sagsplan_RettelserTilBesoegsserier.RETDATO, 9 AS specifikation, - dbo.SAGSPDET.YDELSESTID AS rettelse, '+char(13)+
           '           1 AS statusid  '+char(13)+
                 '     Into dbo.Fact_RettelserBesoegsserier   '+char(13)+
'FROM         '+@DestinationDB+'.dbo.FactGrundplan INNER JOIN   '+char(13)+
   '                   dbo.Sagsplan_RettelserTilBesoegsserier ON '+@DestinationDB+'.dbo.FactGrundplan.SagspdetID = dbo.Sagsplan_RettelserTilBesoegsserier.sagpdetId INNER JOIN  '+char(13)+
     '                 dbo.SAGSPDET ON '+@DestinationDB+'.dbo.FactGrundplan.SagspdetID = dbo.SAGSPDET.ID INNER JOIN'+char(13)+
        '              dbo.Dim_Time ON dbo.Sagsplan_RettelserTilBesoegsserier.RETDATO = dbo.Dim_Time.PK_Date'+char(13)+
' GROUP BY '+@DestinationDB+'.dbo.FactGrundplan.sagspID, '+@DestinationDB+'.dbo.FactGrundplan.SagspdetID, '+@DestinationDB+'.dbo.FactGrundplan.SAGSID, '+char(13)+
    '                  '+@DestinationDB+'.dbo.FactGrundplan.MEDID, '+@DestinationDB+'.dbo.FactGrundplan.doegninddeling, '+@DestinationDB+'.dbo.FactGrundplan.jobid, '+char(13)+
     '                 '+@DestinationDB+'.dbo.FactGrundplan.STILLINGSID, '+@DestinationDB+'.dbo.FactGrundplan.medarb_org, '+@DestinationDB+'.dbo.FactGrundplan.VISITYPE, '+char(13)+
     '                 '+@DestinationDB+'.dbo.FactGrundplan.VISIID, '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDERID, '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDER_STATUS, '+char(13)+
      '                '+@DestinationDB+'.dbo.FactGrundplan.MEDARBEJDER_STATUSID, '+@DestinationDB+'.dbo.FactGrundplan.frekvens, '+@DestinationDB+'.dbo.FactGrundplan.FREKTYPE, '+char(13)+
      '                '+@DestinationDB+'.dbo.FactGrundplan.frekvalgtedage, '+@DestinationDB+'.dbo.FactGrundplan.borgerorg, '+@DestinationDB+'.dbo.FactGrundplan.start, '+char(13)+
      '                '+@DestinationDB+'.dbo.FactGrundplan.slut, dbo.Sagsplan_RettelserTilBesoegsserier.RETDATO, '+@DestinationDB+'.dbo.FactGrundplan.Planlagt_uge, '+char(13)+
      '                '+@DestinationDB+'.dbo.FactGrundplan.specifikation, dbo.SAGSPDET.YDELSESTID'+char(13)+
'HAVING      ('+@DestinationDB+'.dbo.FactGrundplan.specifikation = 2) AND ('+@DestinationDB+'.dbo.FactGrundplan.start <= dbo.Sagsplan_RettelserTilBesoegsserier.RETDATO) AND '+char(13)+
       '               ('+@DestinationDB+'.dbo.FactGrundplan.slut >= dbo.Sagsplan_RettelserTilBesoegsserier.RETDATO)'+char(13)

if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_RettelserBesoegsserier'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_RettelserBesoegsserier'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'select * into '+@DestinationDB+'.dbo.Fact_RettelserBesoegsserier from Fact_RettelserBesoegsserier' 
if @debug = 1 print @cmd
exec (@cmd)

end --Part 18.
 
 
---------------------------------------------------------------------------------------------------------
------19. Laver FACT_MEDARBEJDERE
---------------------------------------------------------------------------------------------------------
----if (@ExPart=19 or @ExPart=0  or (@ExPart>100 and @ExPart<=119))
----begin --Part 19.

----if @Debug = 1
----begin --Print step txt
----	print '---------------------------------------------------------------------------------------------'
----	print '19. Laver FACT_MEDARBEJDERE'
----	print '---------------------------------------------------------------------------------------------'
----end

----set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''FACT_MEDARBEJDERE'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FACT_MEDARBEJDERE'
----if @debug = 1 print @cmd
----exec (@cmd)
----set @cmd = '  SELECT		ID, ' + CHAR(13) +
----						'  MEDARBEJDERID, ' + CHAR(13) + 
----						'  IKRAFTDATO AS dato,  ' + CHAR(13) +						'coalesce(MEDARBEJDER_STATUSID, 9999) as MEDARBEJDER_STATUSID,  ' + CHAR(13) +
----						'  CAST(TIMER as float) as TIMER,  ' + CHAR(13) +
----						'  STILLINGSID, ' + CHAR(13) +
----						'  UAFDELINGID,  ' + CHAR(13) +
----						'  VAGTER, ' + CHAR(13) +
----						'  2 AS specifikation, ' + CHAR(13) +
----						'  1 AS ANTAL_MEDARB, ' + CHAR(13) + 
----						'  cast(round((timer),2) as float)/2220 as FTE ' +char(13)+
----'into '+@DestinationDB+'.dbo.FACT_MEDARBEJDERE ' +char(13)+ 
----'FROM dbo.MEDHISTORIK ' +char(13)+
----'WHERE (MEDARBEJDER_STATUSID IS NOT NULL) ' +char(13)+
----'UNION ALL ' +char(13)+
----			'  SELECT		ID, ' + CHAR(13) +
----			'  MEDARBEJDERID,  ' + CHAR(13) +
----			'  SLUTDATO AS dato, ' + CHAR(13) +
----			'  MEDARBEJDER_STATUSID, ' + CHAR(13) +
----			'  CAST(TIMER as float) as TIMER, ' + CHAR(13) +
----			'  STILLINGSID, ' + CHAR(13) +
----			'  UAFDELINGID, ' + CHAR(13) +
----			'  VAGTER, ' + CHAR(13) +
----			'  3 AS specifikation, ' + CHAR(13) +
----			'  - 1 AS ANTAL_MEDARB, ' + CHAR(13) +
----			'  cast(round((timer),2) * - 1 as float)/2220 as FTE ' +char(13)+
----'FROM dbo.MEDHISTORIK AS MEDHISTORIK_1 ' +char(13)+
----'WHERE (MEDARBEJDER_STATUSID IS NOT NULL) ' +char(13)+
----'UNION ALL ' +char(13)+
----			'  SELECT ID, ' + CHAR(13) +
----			'  MEDARBEJDERID, ' + CHAR(13) +
----			'  IKRAFTDATO AS dato, ' + CHAR(13) +
----			'  1 AS MEDARBEJDER_STATUSID, ' + CHAR(13) +
----			'  CAST(TIMER as float) as TIMER, ' + CHAR(13) +
----			'  STILLINGSID, ' + CHAR(13) +
----			'  UAFDELINGID, ' + CHAR(13) +
----			'  VAGTER, ' + CHAR(13) +
----			'  2 AS specifikation, ' + CHAR(13) +
----			'  1 AS ANTAL_MEDARB, ' + CHAR(13) +
----			'  cast(round((timer),2) as float)/2220 as FTE ' +char(13)+
----'FROM dbo.MEDHISTORIK AS MEDHISTORIK_2 ' +char(13)+
----'WHERE (MEDARBEJDER_STATUSID IS NULL) ' +char(13)+
----'UNION ALL ' +char(13)+
----			'  SELECT ID, ' +char(13)+
----			'  MEDARBEJDERID, ' +char(13)+
----			'  SLUTDATO AS dato, ' +char(13)+ 
----			'  1 AS Expr1, ' +char(13)+ 
----			'  CAST(TIMER as float) as TIMER, ' +char(13)+ 
----			'  STILLINGSID, ' +char(13)+ 
----			'  UAFDELINGID, ' +char(13)+ 
----			'  VAGTER, ' +char(13)+ 
----			'  3 AS specifikation, ' +char(13)+
----			'  - 1 AS ANTAL_MEDARB, ' +char(13)+ 
----			'  cast(round((timer),2) * - 1 as float)/2220 as FTE ' +char(13)+
----'FROM dbo.MEDHISTORIK AS MEDHISTORIK_1 ' +char(13)+
----'WHERE (MEDARBEJDER_STATUSID IS NULL) ' 
----if @debug = 1 print @cmd
----exec (@cmd)
 
 
---- end --Part 19.

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step1_Type0'' AND type = ''U'') DROP TABLE dbo.Afgang_step1_Type0'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
                '      A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+CHAR(13)+
                '      A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
                '    dbo.SAGSPLAN.STARTDATO AS opr_startdato, dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, '+CHAR(13)+
                 '     DIM_TIME_1.Week_Name AS week_name_end  '+CHAR(13)+
'Into dbo.Afgang_step1_Type0   '+CHAR(13)+
'FROM         '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN   '+CHAR(13)+
           '           dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN   '+CHAR(13)+
            '          dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN   '+CHAR(13)+
            '          dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID    '+CHAR(13)+
'WHERE     (A.frekvens > 0) AND (A.FREKTYPE = 0) AND (A.specifikation = 3) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))   '+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step1_Type1'' AND type = ''U'') DROP TABLE dbo.Afgang_step1_Type1'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
             '         A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+CHAR(13)+
           '           A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
             '         dbo.SAGSPLAN.STARTDATO AS opr_startdato, .dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, DIM_TIME_1.Week_Name AS week_name_end, '+CHAR(13)+
              '        dbo.Dim_Time.Week_Name AS week_name_start   '+CHAR(13)+
'Into dbo.Afgang_step1_Type1   '+CHAR(13)+
'FROM         '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN   '+CHAR(13)+
   '                   dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN    '+CHAR(13)+
    '                  dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN    '+CHAR(13)+
    '                  dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID    '+CHAR(13)+
'WHERE     (A.frekvens > 0) AND (A.FREKTYPE = 1) AND (A.specifikation = 3) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))   '+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step1_Type2'' AND type = ''U'') DROP TABLE dbo.Afgang_step1_Type2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
                 '     A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+CHAR(13)+
                  '    A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
                  '    dbo.SAGSPLAN.STARTDATO AS opr_startdato, .dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, DIM_TIME_1.Week_Name AS week_name_end, '+CHAR(13)+
                 '     dbo.Dim_Time.Week_Name AS week_name_start'+CHAR(13)+
                 '     into Afgang_step1_Type2  '+CHAR(13)+
'FROM        '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN   '+CHAR(13)+
                   '   dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN   '+CHAR(13)+
                    '  dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN   '+CHAR(13)+
                    '  dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID   '+CHAR(13)+
'WHERE     (A.frekvens > 0) AND (A.FREKTYPE = 2) AND (A.specifikation = 3) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))  '+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step1_Type3'' AND type = ''U'') DROP TABLE dbo.Afgang_step1_Type3'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
              '        A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+CHAR(13)+
                 '     A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
                  '    dbo.SAGSPLAN.STARTDATO AS opr_startdato, .dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, DIM_TIME_1.Week_Name AS week_name_end, '+CHAR(13)+
                  '    dbo.Dim_Time.Week_Name AS week_name_start'+CHAR(13)+
                    '  into Afgang_step1_Type3'+CHAR(13)+
'FROM        '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+CHAR(13)+
         '             dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN'+CHAR(13)+
         '             dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN'+CHAR(13)+
         '             dbo.SAGSPLAN ON A.sagspID = .dbo.SAGSPLAN.ID ' +CHAR(13)+
'WHERE     (A.frekvens > 0) AND (A.FREKTYPE = 3) AND (A.specifikation = 3) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102)) ' +CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step1_Type4'' AND type = ''U'') DROP TABLE dbo.Afgang_step1_Type4'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
       '               A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, '+CHAR(13)+
        '              dbo.udfConvertBase10NumberToAnyBase(dbo.SAGSPLAN.FREKVALGTEDAGE, 2, 0, 0) AS ValgteDage, '+CHAR(13)+
        '              dbo.BinDayCounter(dbo.SAGSPLAN.FREKVALGTEDAGE) AS DayCounter, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, A.specifikation, '+CHAR(13)+
         '             dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, .dbo.SAGSPLAN.STARTDATO AS opr_startdato, '+CHAR(13)+
          '            dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, DIM_TIME_1.Week_Name AS week_name_end, dbo.Dim_Time.Week_Name AS week_name_start'+CHAR(13)+
 '  into Afgang_step1_Type4'+CHAR(13)+
'FROM       '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+CHAR(13)+
       '               dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN'+CHAR(13)+
       '               dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN'+CHAR(13)+
         '             dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+CHAR(13)+
'WHERE     (A.frekvens > 0) AND (A.FREKTYPE = 4) AND (A.specifikation = 3) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))'+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step2_Type0'' AND type = ''U'') DROP TABLE dbo.Afgang_step2_Type0'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, MEDARBEJDER_STATUS, 
                      MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, specifikation, Day_Week_Start, Day_Week_slut, 
                      opr_startdato, opr_slutdato, Planlagt_uge AS slutkorr
          Into            dbo.Afgang_step2_Type0
FROM         dbo.Afgang_step1_Type0
WHERE     (Day_Week_slut >= Day_Week_Start) AND (frekvens > 0)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step2_Type1'' AND type = ''U'') DROP TABLE dbo.Afgang_step2_Type1'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, MEDARBEJDER_STATUS, 
                      MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, specifikation, Day_Week_Start, Day_Week_slut, 
                      opr_startdato, opr_slutdato, week_name_end, week_name_start, Planlagt_uge / 7 * frekvens * Day_Week_slut AS Slutkorr
 Into            dbo.Afgang_step2_Type1
FROM         dbo.Afgang_step1_Type1

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step2_Type2'' AND type = ''U'') DROP TABLE dbo.Afgang_step2_Type2'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, MEDARBEJDER_STATUS, 
                      MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, specifikation, Day_Week_Start, Day_Week_slut, 
                      opr_startdato, opr_slutdato, week_name_end, week_name_start, 
                      CASE WHEN Day_Week_Slut >= 5 THEN Planlagt_uge / 5 * frekvens * 5 ELSE Planlagt_uge / 5 * frekvens * Day_Week_Slut END AS Slutkorr
 Into            dbo.Afgang_step2_Type2
FROM         dbo.Afgang_step1_Type2

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step2_Type3'' AND type = ''U'') DROP TABLE dbo.Afgang_step2_Type3'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, MEDARBEJDER_STATUS, 
                      MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, specifikation, Day_Week_Start, Day_Week_slut, 
                      opr_startdato, opr_slutdato, week_name_end, week_name_start, (Planlagt_uge / 2 * frekvens) * (Day_Week_slut - 5) AS Slutkorr
into dbo.Afgang_step2_Type3
FROM         dbo.Afgang_step1_Type3
WHERE     (Day_Week_slut > 5) AND (frekvens > 0)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Afgang_step2_Type4'' AND type = ''U'') DROP TABLE dbo.Afgang_step2_Type4'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                      MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, ValgteDage, valgtedage7, DayCounter, Planlagt_uge, borgerorg, start, 
                      slut, date, specifikation, Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, week_name_start, 
                      Planlagt_uge / DayCounter * PGEDW.dbo.CountChar(LEFT(valgtedage7, Day_Week_slut), 1) AS SlutKorr
 Into            dbo.Afgang_step2_Type4
FROM         (SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                                              MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, ValgteDage, CASE WHEN len(CONVERT(varchar, ValgteDage)) 
                                              = 6 THEN '0' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) = 5 THEN '00' + CONVERT(varchar, valgtedage) 
                                              WHEN len(CONVERT(varchar, ValgteDage)) = 4 THEN '000' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) 
                                              = 3 THEN '0000' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) = 2 THEN '00000' + CONVERT(varchar, valgtedage) 
                                              WHEN len(CONVERT(varchar, ValgteDage)) = 1 THEN '000000' + CONVERT(varchar, valgtedage) ELSE CONVERT(varchar, valgtedage) END AS valgtedage7, 
                                              DayCounter, Planlagt_uge, borgerorg, start, slut, date, specifikation, Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, week_name_start
                       FROM          dbo.Afgang_step1_Type4) AS tmp
WHERE     (DayCounter <> 0)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tmp_Fact_SlutPerKorrSagsplan'' AND type = ''U'') DROP TABLE dbo.Tmp_Fact_SlutPerKorrSagsplan'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT     tmp.SAGSID, tmp.MEDID, tmp.doegninddeling, tmp.BESOEGSSTART, tmp.jobid, tmp.STILLINGSID, tmp.medarb_org, tmp.MEDARBEJDER_STATUSID, tmp.MEDARBEJDERID, '+char(13)+
     '                 tmp.Specifikation, tmp.date, tmp.Slutkorr, tmp.borgerorg, tmp.sagspID, tmp.SagspdetID, 1 AS statusid'+char(13)+
               '       into Tmp_Fact_SlutPerKorrSagsplan '+char(13)+
'FROM         (SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, 8 AS Specifikation, date, '+char(13)+
  '                                            - slutkorr AS Slutkorr, borgerorg, sagspID, SagspdetID'+char(13)+
   '                    FROM          dbo.Afgang_step2_Type0'+char(13)+
             '          UNION ALL'+char(13)+
            '           SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, 8 AS Specifikation, date,'+char(13)+ 
              '                               - Slutkorr AS Slutkorr, borgerorg, sagspID, SagspdetID'+char(13)+
              '         FROM         dbo.Afgang_step2_Type1'+char(13)+
              '         UNION ALL'+char(13)+
               '        SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, 8 AS Expr1, date, - Slutkorr AS Slutkorr, '+char(13)+
              '                               borgerorg, sagspID, SagspdetID'+char(13)+
              '         FROM         dbo.Afgang_step2_Type2'+char(13)+
               '        UNION ALL'+char(13)+
               '        SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, 8 AS Expr1, date, - Slutkorr AS Slutkorr, '+char(13)+
                '                             borgerorg, sagspID, SagspdetID'+char(13)+
                '       FROM         dbo.Afgang_step2_Type3'+char(13)+
                 '      UNION ALL'+char(13)+
                 '      SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, 8 AS Expr1, date, - SlutKorr AS Expr2, '+char(13)+
               '                              borgerorg, sagspID, SagspdetID'+char(13)+
                '       FROM         dbo.Afgang_step2_Type4) AS tmp INNER JOIN'+char(13)+
                '      dbo.Dim_Time ON tmp.date = dbo.Dim_Time.PK_Date'+char(13)
                      
                      if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_SlutPerKorrSagsplan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_SlutPerKorrSagsplan'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.doegninddeling, ' +char(13)+
           '  A.jobid, ' +char(13)+
           '  A.STILLINGSID, ' +char(13)+
           '  COALESCE(B.OMKOST_GRUPPE,A.medarb_org) AS MEDARB_ORG, '+char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+
           '  A.MEDARBEJDERID, ' +char(13)+
           '  A.Specifikation, ' +char(13)+
           '  A.date, ' +char(13)+
           '  A.Slutkorr, ' +char(13)+
           '  A.borgerorg, ' +char(13)+
           '  A.sagspID, '+CHAR(13)+
           '  A.SagspdetID ' +char(13)+
           'into '+@DestinationDB+'.dbo.Fact_SlutPerKorrSagsplan'+CHAR(13)+
           'FROM Tmp_Fact_SlutPerKorrSagsplan A '+CHAR(13)+
           'LEFT JOIN Tmp_Vagtplan_Til_Sagsplan B ON A.MEDID=B.MEDARBEJDER AND '+char(13)+
           '  (A.BESOEGSSTART>=B.VAGT_START AND A.BESOEGSSTART<B.VAGT_SLUT) '
if @debug = 1 print @cmd
exec (@cmd)

----------------------------------

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step1_Type0'' AND type = ''U'') DROP TABLE dbo.Tilgang_step1_Type0'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+char(13)+
            '          A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+char(13)+
            '          A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+char(13)+
             '         dbo.SAGSPLAN.STARTDATO AS opr_startdato, dbo.SAGSPLAN.SLUTDATO AS opr_slutdato'+char(13)+
'into dbo.Tilgang_step1_Type0'+char(13)+
'FROM         '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+char(13)+
            '          dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN'+char(13)+
            '          dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN'+char(13)+
            '           dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+char(13)+
'WHERE     (A.frekvens = 1) AND (A.FREKTYPE = 0) AND (A.specifikation = 2) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))'+char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step1_Type1'' AND type = ''U'') DROP TABLE dbo.Tilgang_step1_Type1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+CHAR(13)+
           '           A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+CHAR(13)+
             '         A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
              '       dbo.SAGSPLAN.STARTDATO AS opr_startdato, dbo.SAGSPLAN.SLUTDATO AS opr_slutdato, DIM_TIME_1.Week_Name AS week_name_start, '+CHAR(13)+
               '       dbo.Dim_Time.Week_Name'+CHAR(13)+
               'into dbo.Tilgang_step1_Type1'+char(13)+
'FROM         '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+CHAR(13)+
      '                dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN'+CHAR(13)+
      '                dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN'+CHAR(13)+
       '              dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+CHAR(13)+
'WHERE     (A.FREKTYPE = 1) AND (A.specifikation = 2) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102)) AND (NOT (A.VISIID IS NULL))'+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step1_Type2'' AND type = ''U'') DROP TABLE dbo.Tilgang_step1_Type2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     TOP (100) PERCENT A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, '+CHAR(13)+
             '         A.MEDARBEJDERID, A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut,'+CHAR(13)+
                '       A.date, A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+CHAR(13)+
               '       dbo.SAGSPLAN.STARTDATO AS opr_startdato, dbo.SAGSPLAN.SLUTDATO AS opr_slutdato'+CHAR(13)+
               '       into Tilgang_step1_Type2'+CHAR(13)+
'FROM          '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+CHAR(13)+
     '                 dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date INNER JOIN'+CHAR(13)+
             '         dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date LEFT OUTER JOIN'+CHAR(13)+
                 '     dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+CHAR(13)+
'WHERE     (A.FREKTYPE = 2) AND (A.specifikation = 2) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102)) AND (A.frekvens > 0)'+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step1_Type3'' AND type = ''U'') DROP TABLE dbo.Tilgang_step1_Type3'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+char(13)+
        '              A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, '+char(13)+
          '            A.specifikation, dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, '+char(13)+
          '           dbo.SAGSPLAN.STARTDATO AS opr_startdato, dbo.SAGSPLAN.SLUTDATO AS opr_slutdato'+char(13)+
           '             into Tilgang_step1_Type3'+CHAR(13)+
'FROM         '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+char(13)+
  '                    dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date INNER JOIN'+char(13)+
   '                   dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date LEFT OUTER JOIN'+char(13)+
   '                   dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+char(13)+
'WHERE     (A.FREKTYPE = 3) AND (A.specifikation = 2) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102))'+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step1_Type4'' AND type = ''U'') DROP TABLE dbo.Tilgang_step1_Type4'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     A.sagspID, A.SagspdetID, A.SAGSID, A.MEDID, A.doegninddeling, A.STARTMINEFTERMIDNAT, A.jobid, A.STILLINGSID, A.medarb_org, A.VISITYPE, A.VISIID, A.MEDARBEJDERID, '+char(13)+
   '                   A.MEDARBEJDER_STATUS, A.MEDARBEJDER_STATUSID, A.frekvens, A.FREKTYPE, A.frekvalgtedage, '+char(13)+
      '                dbo.udfConvertBase10NumberToAnyBase(dbo.SAGSPLAN.FREKVALGTEDAGE, 2, 0, 0) AS ValgteDage, '+char(13)+
         '             dbo.BinDayCounter(dbo.SAGSPLAN.FREKVALGTEDAGE) AS DayCounter, A.Planlagt_uge, A.borgerorg, A.start, A.slut, A.date, A.specifikation, '+char(13)+
         '             dbo.Dim_Time.Day_Of_Week AS Day_Week_Start, DIM_TIME_1.Day_Of_Week AS Day_Week_slut, dbo.SAGSPLAN.STARTDATO AS opr_startdato, '+char(13)+
          '            dbo.SAGSPLAN.SLUTDATO AS opr_slutdato'+char(13)+
          '             into Tilgang_step1_Type4'+CHAR(13)+
'FROM          '+@DestinationDB+'.dbo.FactSagsplan AS A INNER JOIN'+char(13)+
  '                    dbo.Dim_Time ON A.start = dbo.Dim_Time.PK_Date INNER JOIN'+char(13)+
           '           dbo.Dim_Time AS DIM_TIME_1 ON A.slut = DIM_TIME_1.PK_Date LEFT OUTER JOIN'+char(13)+
           '           dbo.SAGSPLAN ON A.sagspID = dbo.SAGSPLAN.ID'+char(13)+
'WHERE     (A.FREKTYPE = 4) AND (A.specifikation = 2) AND (A.date <> CONVERT(DATETIME, ''9999-01-01 00:00:00'', 102)) AND (A.frekvens > 0)'+char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step2_Type1'' AND type = ''U'') DROP TABLE dbo.Tilgang_step2_Type1'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                      MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, 9 AS Specifikation, 
                      Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, week_name_start, Week_Name, - ((Planlagt_uge / 7 * frekvens) * (Day_Week_Start - 1)) 
                      AS PrimoKorr
into dbo.Tilgang_step2_Type1
FROM         dbo.Tilgang_step1_Type1
WHERE     (Day_Week_Start <= 7)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step2_Type2'' AND type = ''U'') DROP TABLE dbo.Tilgang_step2_Type2'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                      MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, 9 AS Specifikation, 
                      Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, - ((Planlagt_uge / 5 * frekvens) * (Day_Week_Start - 1)) AS PrimoKorr
into dbo.Tilgang_step2_Type2
FROM         dbo.Tilgang_step1_Type2
WHERE     (Day_Week_Start <= 5)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step2_Type3'' AND type = ''U'') DROP TABLE dbo.Tilgang_step2_Type3'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                      MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, 9 AS Specifikation, 
                      Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, - ((Planlagt_uge / 2 * frekvens) * (Day_Week_Start - 6)) AS PrimoKorr
into dbo.Tilgang_step2_Type3
FROM         dbo.Tilgang_step1_Type3
WHERE     (frekvens > 0) AND (Day_Week_Start = 7)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tilgang_step2_Type4'' AND type = ''U'') DROP TABLE dbo.Tilgang_step2_Type4'
if @debug = 1 print @cmd
exec (@cmd)

SELECT     sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, jobid, STILLINGSID, BESOEGSSTART, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, MEDARBEJDER_STATUS, 
                      MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, Specifikation, Day_Week_Start, Day_Week_slut, 
                      opr_startdato, opr_slutdato, ValgteDage, DayCounter, valgtedage7, - (Planlagt_uge / DayCounter * PGEDW.dbo.CountChar(LEFT(valgtedage7, Day_Week_Start - 1), 1)) 
                      AS PrimoKorr
into dbo.Tilgang_step2_Type4
FROM         (SELECT     TOP (100) PERCENT sagspID, SagspdetID, SAGSID, MEDID, doegninddeling, DATEADD(MINUTE,STARTMINEFTERMIDNAT,date) AS BESOEGSSTART, jobid, STILLINGSID, medarb_org, VISITYPE, VISIID, MEDARBEJDERID, 
                                              MEDARBEJDER_STATUS, MEDARBEJDER_STATUSID, frekvens, FREKTYPE, frekvalgtedage, Planlagt_uge, borgerorg, start, slut, date, 9 AS Specifikation, 
                                              Day_Week_Start, Day_Week_slut, opr_startdato, opr_slutdato, ValgteDage, DayCounter, CASE WHEN len(CONVERT(varchar, ValgteDage)) 
                                              = 6 THEN '0' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) = 5 THEN '00' + CONVERT(varchar, valgtedage) 
                                              WHEN len(CONVERT(varchar, ValgteDage)) = 4 THEN '000' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) 
                                              = 3 THEN '0000' + CONVERT(varchar, valgtedage) WHEN len(CONVERT(varchar, ValgteDage)) = 2 THEN '00000' + CONVERT(varchar, valgtedage) 
                                              WHEN len(CONVERT(varchar, ValgteDage)) = 1 THEN '000000' + CONVERT(varchar, valgtedage) ELSE CONVERT(varchar, valgtedage) 
                                              END AS valgtedage7
                       FROM          dbo.Tilgang_step1_Type4) AS tmp
WHERE     (DayCounter <> 0)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''Tmp_Fact_PrimoPerKorrSagsplan'' AND type = ''U'') DROP TABLE dbo.Tmp_Fact_PrimoPerKorrSagsplan'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, Specifikation, date, PrimoKorr, borgerorg, sagspID, '+CHAR(13)+
    '                  SagspdetID, 1 AS statusid'+CHAR(13)+
    'into Tmp_Fact_PrimoPerKorrSagsplan'+CHAR(13)+
'FROM         dbo.Tilgang_step2_Type1'+CHAR(13)+

'UNION ALL'+CHAR(13)+
'SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, Specifikation, date, PrimoKorr, borgerorg, sagspID, '+CHAR(13)+
    '                  SagspdetID, 1 AS statusid'+CHAR(13)+
'FROM         dbo.Tilgang_step2_Type2'+CHAR(13)+
'UNION ALL'+CHAR(13)+
'SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, Specifikation, date, PrimoKorr, borgerorg, sagspID, '+CHAR(13)+
 '                     SagspdetID, 1 AS statusid'+CHAR(13)+
'FROM         dbo.Tilgang_step2_Type3'+CHAR(13)+
'UNION ALL'+CHAR(13)+
'SELECT     SAGSID, MEDID, doegninddeling, BESOEGSSTART, jobid, STILLINGSID, medarb_org, MEDARBEJDER_STATUSID, MEDARBEJDERID, Specifikation, date, PrimoKorr, borgerorg, sagspID, '+CHAR(13)+
   '                   SagspdetID, 1 AS statusid'+CHAR(13)+
'FROM         dbo.Tilgang_Step2_Type4'+CHAR(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_PrimoPerKorrSagsplan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_PrimoPerKorrSagsplan'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.doegninddeling, ' +char(13)+
           '  A.jobid, ' +char(13)+
           '  A.STILLINGSID, ' +char(13)+
           '  COALESCE(B.OMKOST_GRUPPE,A.medarb_org) AS MEDARB_ORG, '+char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+
           '  A.MEDARBEJDERID, ' +char(13)+
           '  A.Specifikation, ' +char(13)+
           '  A.date, ' +char(13)+
           '  A.PrimoKorr, ' +char(13)+
           '  A.borgerorg, ' +char(13)+
           '  A.sagspID, '+CHAR(13)+
           '  A.SagspdetID, ' +char(13)+
           '  1 AS statusid'+CHAR(13)+
           'into '+@DestinationDB+'.dbo.Fact_PrimoPerKorrSagsplan'+CHAR(13)+
           'FROM Tmp_Fact_PrimoPerKorrSagsplan A '+CHAR(13)+
           'LEFT JOIN Tmp_Vagtplan_Til_Sagsplan B ON A.MEDID=B.MEDARBEJDER AND '+char(13)+
           '  (A.BESOEGSSTART>=B.VAGT_START AND A.BESOEGSSTART<B.VAGT_SLUT) '
if @debug = 1 print @cmd
exec (@cmd)


