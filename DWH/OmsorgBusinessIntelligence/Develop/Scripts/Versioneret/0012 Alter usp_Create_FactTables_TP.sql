USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_TP]    Script Date: 11/26/2010 14:02:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER PROCEDURE [dbo].[usp_Create_FactTables_TP]
					  @DestinationDB as  varchar(200),
					  @Afregnet as bit,
					  @Debug    as bit =0
					 
AS

DECLARE @cmd as varchar(max)
DECLARE @dagfactor as varchar(1)
set @dagfactor='7'


DECLARE @tablePrefix as varchar(200)
if @afregnet = 0
	set @tablePrefix = 'FACT_TPVisiSag'
if @afregnet = 1
	set @tablePrefix = 'FACT_TPVisiSag_Afregnet'

--først ryddes der op i SAGSHISTORIK og _tmp_SP_SAGSHISTORIK skabes
set @cmd = 'exec usp_TP_SAGSHISTORIK '+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd 
exec (@cmd)

--UPDATE    _tmp_TP_SAGSHISTORIK
--SET       SLUTDATO = DATEADD(day, - 1, SLUTDATO) 
--WHERE     (DATEPART(year, SLUTDATO) NOT IN (9999))

declare @DebugCmd as nvarchar(4000)

--Debug kode
 if (@debug=1)  set @DebugCmd = 'and sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''


Delete from dbo.TPVISITATION
where (SLUTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102))

Update  dbo.TPVISITATION
set IKRAFTDATO = CONVERT(DATETIME, '2009-01-01 00:00:00', 102)
WHERE     (IKRAFTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102)) and (SLUTDATO >= CONVERT(DATETIME, '2009-01-01 00:00:00', 102))


--lav _tmp_sp_visitation 
-- Påsætter dognindeling ved at kigge i de relevante felter. Til sidst sættes dem som ikke fundet til morgen
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_TBVISITATION_TB' AND type = 'U') DROP TABLE _tmp_TBVISITATION_TB
set @cmd = 'Select * into _tmp_TBVISITATION_TB  from ( ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 1 AS dogninddeling, TB_MORGEN AS TPVISI ' +char(13)+
			'FROM  dbo.TPVISITATION ' +char(13)+
			'WHERE (TB_MORGEN <> 0) ' +char(13)+
			
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 2 AS dogninddeling, TB_FORMIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_11 ' +char(13)+
			'WHERE (TB_FORMIDDAG <> 0) ' +char(13)+
		
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 3 AS dogninddeling, TB_MIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_10 ' +char(13)+
			'WHERE (TB_MIDDAG <> 0) ' +char(13)+
		
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 4 AS dogninddeling, TB_EFTERMIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_9 ' +char(13)+
			'WHERE  (TB_EFTERMIDDAG <> 0) ' +char(13)+
		
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 5 AS dogninddeling, TB_AFTEN1 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_8 ' +char(13)+
			'WHERE  (TB_AFTEN1 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 6 AS dogninddeling, TB_AFTEN2 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_7 ' +char(13)+
			'WHERE  (TB_AFTEN2 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 7 AS dogninddeling, TB_AFTEN3 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_6 ' +char(13)+
			'WHERE  (TB_AFTEN3 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 8 AS dogninddeling, TB_AFTEN4 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_5 ' +char(13)+
			'WHERE  (TB_AFTEN4 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9 AS dogninddeling, TB_NAT1 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_4 ' +char(13)+
			'WHERE  (TB_NAT1 <> 0) ' +char(13)+

			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 10 AS dogninddeling, TB_NAT2 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_3 ' +char(13)+
			'WHERE  (TB_NAT2 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 11 AS dogninddeling, TB_NAT3 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_2 ' +char(13)+
			'WHERE  (TB_NAT3 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, TB_NAT4 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_2 ' +char(13)+
			'WHERE  (TB_NAT4 <> 0) ' +char(13)+

			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, 0 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_1 ' +char(13)+
			'where (TB_MORGEN = 0) ' +char(13)+
			'and   (TB_FORMIDDAG = 0) ' +char(13)+
			'and   (TB_MIDDAG = 0) ' +char(13)+
			'and   (TB_EFTERMIDDAG = 0) ' +char(13)+
			'and   (TB_AFTEN1 = 0) ' +char(13)+
			'and   (TB_AFTEN2 = 0) ' +char(13)+
			'and   (TB_AFTEN3 = 0) ' +char(13)+
			'and   (TB_AFTEN4 = 0) ' +char(13)+
			'and   (TB_NAT1 = 0) ' +char(13)+
			'and   (TB_NAT2 = 0) ' +char(13)+
			'and   (TB_NAT3 = 0) ' +char(13)+
			'and   (TB_NAT4 = 0) ' +char(13)+ 
			') as tmp where (SAGSID IN ' +char(13)+
			'				   (SELECT SAGSID FROM  dbo.DIMSAGER AS DIM_SAGER_1) ) ' 

			

   
if @debug = 1 print @cmd
exec (@cmd)


--laver _FACT_SPVisiSag_Step1
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TBVisiSag_Step1_TB' AND type = 'U') DROP TABLE _FACT_TBVisiSag_Step1_TB

set @cmd = 'SELECT dbo._tmp_TP_SAGSHISTORIK.SAGSID,  ' +char(13)+		   
			'dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO AS sagikraft,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.SLUTDATO AS sagslut,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUS,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUSID,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_GRUPPEID,  ' +char(13)+
			'dbo._tmp_TBVISITATION_TB.dogninddeling,  ' +char(13)+
			'dbo._tmp_TBVISITATION_TB.IKRAFTDATO AS visiikraft,  ' +char(13)+
			'dbo._tmp_TBVISITATION_TB.SLUTDATO AS visislut,  ' +char(13)+
			'dbo._tmp_TBVISITATION_TB.ID AS visiid,  ' +char(13)+
			'dbo._tmp_TBVISITATION_TB.TPVISI ' +char(13)+
		    ' into _FACT_TBVisiSag_Step1_TB ' +char(13)+
			'FROM  dbo._tmp_TP_SAGSHISTORIK INNER JOIN ' +char(13)+
			'dbo._tmp_TBVISITATION_TB ON dbo._tmp_TP_SAGSHISTORIK.SAGSID = dbo._tmp_TBVISITATION_TB.SAGSID AND  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.SLUTDATO > dbo._tmp_TBVISITATION_TB.IKRAFTDATO AND  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO < dbo._tmp_TBVISITATION_TB.SLUTDATO '
if @debug = 1 print @cmd
exec (@cmd)
--laver _FACT_SPVisiSag_Step 2
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TBVisiSag_Step2_TB' AND type = 'U') DROP TABLE _FACT_TBVisiSag_Step2_TB

set @cmd = 'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,   visiid, sagikraft AS start, ' +char(13)+
			'			   sagslut AS slut, TPVISI, 1 AS type ' +char(13)+
			'into  _FACT_TBVisiSag_Step2_TB ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_Step1_TB ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, TPVISI, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_Step1_TB AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, TPVISI, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_Step1_TB AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, TPVISI, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_Step1_TB AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)
 
--laver _FACT_SPVisiSag_Step 3

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'_TB'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'_TB'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT SAGSID, start AS dato, TERAPEUT_STATUS, TERAPEUT_STATUSID, ' +char(13)+
			'TERAPEUT_GRUPPEID AS organization, dogninddeling, 2 AS specifikation, 1 AS count, cast(TPVISI  / 7 as float) as TPVISI_TB, start, slut  ' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +'_TB ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_step2_TB ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID AS organization, ' +char(13)+
		    'dogninddeling, 3 AS specifikation, - 1 AS count, cast((TPVISI * - 1) / 7 as float) AS Expr1, start, slut  ' +char(13)+
			'FROM  dbo._FACT_TBVisiSag_step2_TB AS VisiSag_step2_1 ' +char(13)+
			'WHERE (DATEPART(year, slut) NOT IN (9999)) ' 
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'usp_Birthddays '''+@tablePrefix +'_TB'', '''+@DestinationDB+''',''TPVISI_TB'''
if @debug = 1 print @cmd
exec (@cmd)

--lav _tmp_sp_visitation 
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_TPVISITATION_TP' AND type = 'U') DROP TABLE _tmp_TPVISITATION_TP
set @cmd = 'Select * into _tmp_TPVISITATION_TP  from ( ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 1 AS dogninddeling, TP_MORGEN AS TPVISI ' +char(13)+
			'FROM  dbo.TPVISITATION ' +char(13)+
			'WHERE (TP_MORGEN <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 2 AS dogninddeling, TP_FORMIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_11 ' +char(13)+
			'WHERE (TP_FORMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 3 AS dogninddeling, TP_MIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_10 ' +char(13)+
			'WHERE (TP_MIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 4 AS dogninddeling, TP_EFTERMIDDAG ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_9 ' +char(13)+
			'WHERE  (TP_EFTERMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 5 AS dogninddeling, TP_AFTEN1 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_8 ' +char(13)+
			'WHERE  (TP_AFTEN1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 6 AS dogninddeling, TP_AFTEN2 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_7 ' +char(13)+
			'WHERE  (TP_AFTEN2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 7 AS dogninddeling, TP_AFTEN3 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_6 ' +char(13)+
			'WHERE  (TP_AFTEN3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 8 AS dogninddeling, TP_AFTEN4 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_5 ' +char(13)+
			'WHERE  (TP_AFTEN4 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9 AS dogninddeling, TP_NAT1 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_4 ' +char(13)+
			'WHERE  (TP_NAT1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 10 AS dogninddeling, TP_NAT2 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_3 ' +char(13)+
			'WHERE  (TP_NAT2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 11 AS dogninddeling, TP_NAT3 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_2 ' +char(13)+
			'WHERE  (TP_NAT3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, TP_NAT4 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_2 ' +char(13)+
			'WHERE  (TP_NAT4 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, 0 ' +char(13)+
			'FROM  dbo.TPVISITATION AS TPVISITATION_1 ' +char(13)+
			'where (TB_MORGEN = 0) ' +char(13)+
			'and   (TB_FORMIDDAG = 0) ' +char(13)+
			'and   (TB_MIDDAG = 0) ' +char(13)+
			'and   (TB_EFTERMIDDAG = 0) ' +char(13)+
			'and   (TB_AFTEN1 = 0) ' +char(13)+
			'and   (TB_AFTEN2 = 0) ' +char(13)+
			'and   (TB_AFTEN3 = 0) ' +char(13)+
			'and   (TB_AFTEN4 = 0) ' +char(13)+
			'and   (TB_NAT1 = 0) ' +char(13)+
			'and   (TB_NAT2 = 0) ' +char(13)+
			'and   (TB_NAT3 = 0) ' +char(13)+
			'and   (TB_NAT4 = 0) ' +char(13)+
			') as tmp where (SAGSID IN ' +char(13)+
			'				   (SELECT SAGSID FROM  dbo.DIMSAGER AS DIM_SAGER_1) ) ' 

   
if @debug = 1 print @cmd
exec (@cmd)

if @afregnet = 1 begin --hvis afregnet skal datoer skydes frem til følgende mandag
	IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '__tmp_TPVISITATION_TP' AND type = 'U') DROP TABLE __tmp_TPVISITATION_TP

	select 
	ID, 
	SAGSID, 
	dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, ikraftdato -1 ), 7 ))) as IKRAFTDATO, 
	case  when slutdato != '9999-01-01' then dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, SLUTDATO -1 ), 7 ))) 
	else slutdato end as SLUTDATO, 
	dogninddeling, 
	TPVISI 
	into __tmp_TPVISITATION_TP
	from _tmp_TPVISITATION_TP

	drop table _tmp_TPVISITATION_TP

	exec sp_rename '__tmp_TPVISITATION_TP','_tmp_TPVISITATION_TP'
end

--laver _FACT_SPVisiSag_Step1
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TPVisiSag_Step1_TP' AND type = 'U') DROP TABLE _FACT_TPVisiSag_Step1_TP

set @cmd = 'SELECT dbo._tmp_TP_SAGSHISTORIK.SAGSID,  ' +char(13)+		   
			'dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO AS sagikraft,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.SLUTDATO AS sagslut,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUS,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUSID,  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_GRUPPEID,  ' +char(13)+
			'dbo._tmp_TPVISITATION_TP.dogninddeling,  ' +char(13)+
			'dbo._tmp_TPVISITATION_TP.IKRAFTDATO AS visiikraft,  ' +char(13)+
			'dbo._tmp_TPVISITATION_TP.SLUTDATO AS visislut,  ' +char(13)+
			'dbo._tmp_TPVISITATION_TP.ID AS visiid,  ' +char(13)+
			'dbo._tmp_TPVISITATION_TP.TPVISI ' +char(13)+
		    ' into _FACT_TPVisiSag_Step1_TP ' +char(13)+
			'FROM  dbo._tmp_TP_SAGSHISTORIK INNER JOIN ' +char(13)+
			'dbo._tmp_TPVISITATION_TP ON dbo._tmp_TP_SAGSHISTORIK.SAGSID = dbo._tmp_TPVISITATION_TP.SAGSID AND  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.SLUTDATO > dbo._tmp_TPVISITATION_TP.IKRAFTDATO AND  ' +char(13)+
			'dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO < dbo._tmp_TPVISITATION_TP.SLUTDATO '
if @debug = 1 print @cmd
exec (@cmd)
--laver _FACT_SPVisiSag_Step 2
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TPVisiSag_Step2_TP' AND type = 'U') DROP TABLE _FACT_TPVisiSag_Step2_TP

set @cmd = 'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,   visiid, sagikraft AS start, ' +char(13)+
			'			   sagslut AS slut, TPVISI, 1 AS type ' +char(13)+
			'into  _FACT_TPVisiSag_Step2_TP ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_Step1_TP ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, TPVISI, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_Step1_TP AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, TPVISI, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_Step1_TP AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, TPVISI, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_Step1_TP AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tpvisiJobDogninddeling' AND type = 'U') DROP TABLE _tpvisiJobDogninddeling

SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 1 AS dogninddeling
into _tpvisiJobDogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_MORGEN <> 0)
union all
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER,NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 2 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_FORMIDDAG <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 3 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_MIDDAG <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 4 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_EFTERMIDDAG <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 5 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_AFTEN1 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 6 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_AFTEN2 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 7 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_AFTEN3 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 8 AS dogninddeling
FROM dbo.TPVISIJOB
WHERE (YD_AFTEN4 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 9 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_NAT1 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 10 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_NAT2 <> 0)
UNION ALL
SELECT ID, TPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 11 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_NAT3 <> 0)
UNION ALL
SELECT ID, 
       TPVISIID,
       JOBID, 
       HYPPIGHED,
   case when YD_GANGE = 0 then 1 else YD_GANGE end as YD_GANGE,
    PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 12 AS dogninddeling
FROM  dbo.TPVISIJOB
WHERE (YD_NAT4 <> 0)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tpvisiJobDogninddelingJobType' AND type = 'U') DROP TABLE _tpvisiJobDogninddelingJobType
SELECT _tpvisiJobDogninddeling.*, coalesce(JOBTYPER.NORMTID1, 1) AS NORMTIDJobType
into _tpvisiJobDogninddelingJobType
FROM  _tpvisiJobDogninddeling LEFT OUTER JOIN
               JOBTYPER ON _tpvisiJobDogninddeling.JOBID = JOBTYPER.JOBID

--_FACT_TPVisiSag_Step2_TP
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TPVisiSag_Step2_TBTP' AND type = 'U') DROP TABLE _FACT_TPVisiSag_Step2_TBTP
SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, dogninddeling, visiikraft, visislut, visiid, start, slut, 
               TPVISI, type
into _FACT_TPVisiSag_Step2_TBTP
FROM  dbo._FACT_TBVisiSag_Step2_TB
UNION ALL
SELECT SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, dogninddeling, visiikraft, visislut, visiid, start, slut, 
               1 TPVISI, type
FROM  dbo._FACT_TPVisiSag_Step2_TP

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TPVisiSag_Step2_TBTP_Distinct' AND type = 'U') DROP TABLE _FACT_TPVisiSag_Step2_TBTP_Distinct
SELECT DISTINCT 
                      SAGSID, sagikraft, sagslut, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, dogninddeling, visiikraft, visislut, visiid, start, slut, 
                      type
into _FACT_TPVisiSag_Step2_TBTP_Distinct
FROM         _FACT_TPVisiSag_Step2_TBTP



set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job_TPTB'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_TPTB'
if @debug = 1 print @cmd
exec (@cmd)

-- Det sidste laves til at kunne blive lagt sammen i fact tabellen
set @cmd = 'SELECT  ' +char(13)+
			'd.SAGSID,  ' +char(13)+
			'd.sagikraft,  ' +char(13)+
			'd.sagslut,  ' +char(13)+
			'd.TERAPEUT_STATUS,  ' +char(13)+
			'd.TERAPEUT_STATUSID,  ' +char(13)+
			'd.TERAPEUT_GRUPPEID AS organization,  ' +char(13)+
			'd.dogninddeling,  ' +char(13)+
			'd.visiikraft,  ' +char(13)+
			'd.visislut,  ' +char(13)+
			'd.visiid,  ' +char(13)+
			'd.start,  ' +char(13)+
			'd.slut,  ' +char(13)+
			'case when b.HYPPIGHED = 2 then (b.NORMTID/convert(decimal(18,10),YD_GANGE))/'+@dagfactor+' ' +char(13)+		
			'     when  b.HYPPIGHED = 1 then (b.NORMTID*convert(decimal(18,10),YD_GANGE))  /'+@dagfactor+' ' +char(13)+
			'     when  b.HYPPIGHED = 0 then (b.NORMTID*convert(decimal(18,10),YD_GANGE)*7) /'+@dagfactor+' ' +char(13)+
			'end as TPVISI_TP,  ' +char(13)+
			'd.type, ' +char(13)+	
			'case when b.HYPPIGHED = 0 then (((coalesce( c.INT_DAG,0) * NORMTIDJobType) /60.0) * 7.0 * (YD_GANGE * 1.0))/'+@dagfactor+' ' +char(13)+
			'  when b.HYPPIGHED = 1 then (((coalesce( c.INT_DAG,0) * NORMTIDJobType) /60.0) * (YD_GANGE * 1.0))  /'+@dagfactor+' ' +char(13)+	
			'  when b.HYPPIGHED = 2 then (((coalesce( c.INT_DAG,0) * NORMTIDJobType) /60.0) / (YD_GANGE * 1.0))/'+@dagfactor+' ' +char(13)+		
		    'end as Pris,c.startdato as pstart,  ' +char(13)+
			'c.slutdato as Pslut,  ' +char(13)+
			'2 AS specifikation, ' +char(13)+
			'case   when b.HYPPIGHED = 2 then (b.NORMTID/convert(decimal(18,10),YD_GANGE))  /'+@dagfactor+' ' +char(13)+
			'  when  b.HYPPIGHED = 1 then (b.NORMTID*convert(decimal(18,10),YD_GANGE))  /'+@dagfactor+' ' +char(13)+	
			'  when  b.HYPPIGHED = 0 then (b.NORMTID*convert(decimal(18,10),YD_GANGE)) *7 /'+@dagfactor+' ' +char(13)+		
			'end as TPVISIJOB, ' +char(13)+	
			
			--Hverdag
			'case ' +char(13)+ 
			'  when b.Hyppighed = 0 then (b.NormTid*convert(decimal(18,10),YD_GANGE)*Personer) ' +char(13)+		--Dagligt 
			'  when b.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when b.YD_WEEKEND is null then (b.NormTid*convert(decimal(18,10),YD_GANGE)*Personer)/5 ' +char(13)+
			'    else ' +char(13)+
			'    (b.NormTid*(convert(decimal(18,10),YD_GANGE)-YD_WEEKEND)*Personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when b.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when b.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    (b.NormTid/convert(decimal(18,10),YD_GANGE)*personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as TPVISIJOBHverdag, ' +char(13)+				
			
			--Weekend
			'case ' +char(13)+ 
			'  when b.Hyppighed = 0 then (b.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when b.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when b.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (b.NormTid*YD_WEEKEND*Personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'  when b.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when b.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (b.NormTid/YD_WEEKEND*personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'end as TPVISIJOBWeekend, ' +char(13)+			
			
			'case   when b.HYPPIGHED = 2 then (1/convert(decimal(18,10),YD_GANGE))  /'+@dagfactor+' ' +char(13)+	
			'   when  b.HYPPIGHED = 1 then (convert(decimal(18,10),YD_GANGE))  /'+@dagfactor+' ' +char(13)+	
			'   when  b.HYPPIGHED = 0 then (convert(decimal(18,10),YD_GANGE)) *7 /'+@dagfactor+' ' +char(13)+		
			'end as TPVISIJOBantal, ' +char(13)+	
			'slut as Dato,b.jobid,b.FRITVALGLEV ' +char(13)+		
			'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_TPTB ' +char(13)+
			'FROM  JOBTYPER                       a  RIGHT OUTER JOIN  ' +char(13)+
		    '_tpvisiJobDogninddelingJobType b         ON  a.JOBID = b.JOBID LEFT OUTER JOIN ' +char(13)+
		    'JOBPRISER c                              ON  b.JOBID = c.JOBID RIGHT OUTER JOIN ' +char(13)+
		    '_FACT_TPVisiSag_Step2_TBTP  d            ON  b.dogninddeling = d.dogninddeling   ' +char(13)+
		    '                                         and b.TPVISIID = d.visiid ' +char(13)+
	'union all ' +char(13)+
			'SELECT 	d.SAGSID,  ' +char(13)+
			'd.sagikraft,  ' +char(13)+
			'd.sagslut,  ' +char(13)+
			'd.TERAPEUT_STATUS,' +char(13)+
			'd.TERAPEUT_STATUSID,  ' +char(13)+
			'd.TERAPEUT_GRUPPEID AS organization,  ' +char(13)+
			'd.dogninddeling,' +char(13)+
			'd.visiikraft,  ' +char(13)+
			'd.visislut,  ' +char(13)+
			'd.visiid,  ' +char(13)+
			'd.start,' +char(13)+
			'd.slut,  ' +char(13)+
			'case   when b.HYPPIGHED = 2 then (b.NORMTID/YD_GANGE) /'+@dagfactor+' ' +char(13)+			
			'when  b.HYPPIGHED = 1 then (b.NORMTID*YD_GANGE)/'+@dagfactor+' ' +char(13)+		
			'when  b.HYPPIGHED = 0 then (b.NORMTID*YD_GANGE*7)/'+@dagfactor+' ' +char(13)+		
			'end as TPVISI_TP,  ' +char(13)+
			'd.type, ' +char(13)+		
			'case when b.HYPPIGHED = 0 then (((coalesce( c.INT_DAG,0) * -1 * NORMTIDJobType) /60.0) * 7.0 * (YD_GANGE * 1.0)) /'+@dagfactor+' ' +char(13)+		
			'when b.HYPPIGHED = 1 then (((coalesce( c.INT_DAG,0) * -1 * NORMTIDJobType) /60.0) * (YD_GANGE * 1.0))/'+@dagfactor+' ' +char(13)+		
            'when b.HYPPIGHED = 2 then (((coalesce( c.INT_DAG,0) * -1 * NORMTIDJobType) /60.0) / (YD_GANGE * 1.0)) /'+@dagfactor+' ' +char(13)+				
            'end as Pris,  ' +char(13)+
			'c.startdato as pstart,  ' +char(13)+
			'c.slutdato as pslut,  ' +char(13)+
			'3 AS specifikation  ' +char(13)+
			',case   when b.HYPPIGHED = 2 then (b.NORMTID/YD_GANGE)*-1  /'+@dagfactor+' ' +char(13)+				
            'when  b.HYPPIGHED = 1 then (b.NORMTID*YD_GANGE) *-1/'+@dagfactor+' ' +char(13)+				
            'when  b.HYPPIGHED = 0 then (b.NORMTID*YD_GANGE) *7 *-1/'+@dagfactor+' ' +char(13)+		
		    'end as TPVISIJOB, ' +char(13)+	
		    
		    --Hverdage
			'case '  +char(13)+
			'  when b.HYPPIGHED = 0 then ((b.NormTid*convert(decimal(18,10),YD_GANGE)*Personer)*-1) ' +char(13)+
			'  when b.HYPPIGHED = 1 then ' +char(13)+
			'    case when b.YD_WEEKEND is null then ((b.NormTid*convert(decimal(18,10),YD_GANGE)*Personer)*-1)/5 ' +char(13)+
			'    else ' +char(13)+
			'    ((b.NormTid*(convert(decimal(18,10),YD_GANGE)-YD_WEEKEND)*Personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when b.HYPPIGHED = 2 then ' +char(13)+
			'    case when b.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((b.NormTid/convert(decimal(18,10),YD_GANGE)*personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as TPVISIJOBHverdag, ' +char(13)+			    
		    
		    --Weekend
			'case '  +char(13)+
			'  when b.HYPPIGHED = 0 then ((b.NormTid*convert(decimal(18,10),YD_GANGE)*Personer)*-1) ' +char(13)+
			'  when b.HYPPIGHED = 1 then ' +char(13)+
			'    case when b.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((b.NormTid*convert(decimal(18,10),YD_WEEKEND)*Personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'  when b.HYPPIGHED = 2 then ' +char(13)+
			'    case when b.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((b.NormTid/convert(decimal(18,10),YD_WEEKEND)*personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'end as TPVISIJOBWeekend, ' +char(13)+			    
		    
		    'case   when b.HYPPIGHED = 2 then (1/YD_GANGE)*-1 /'+@dagfactor+' ' +char(13)+				
            'when  b.HYPPIGHED = 1 then (YD_GANGE) *-1/'+@dagfactor+' ' +char(13)+			
            'when  b.HYPPIGHED = 0 then (YD_GANGE) *7 *-1/'+@dagfactor+' ' +char(13)+		
		    'end as TPVISIJOBantal, ' +char(13)+
		    'slut as Dato,  ' +char(13)+
			'b.jobid,  ' +char(13)+
			'b.FRITVALGLEV  ' +char(13)+
			'FROM  JOBTYPER a RIGHT OUTER JOIN  ' +char(13)+
			'_tpvisiJobDogninddelingJobType b ON a.JOBID = b.JOBID LEFT OUTER JOIN  ' +char(13)+
			'JOBPRISER c ON b.JOBID = c.JOBID RIGHT OUTER JOIN  ' +char(13)+
			'_FACT_TPVisiSag_Step2_TBTP_Distinct d ON b.dogninddeling = d.dogninddeling AND  ' +char(13)+
			'b.TPVISIID = d.visiid  ' +char(13)+
			'WHERE (DATEPART(year, slut) NOT IN (9999))  ' 






if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job_TPTB'', '''+@DestinationDB+''',''TPVISIJOB'''
if @debug = 1 print @cmd
exec (@cmd)


/* Remove jge. 090930
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_TPVisiSag_Step3' AND type = 'U') DROP TABLE _FACT_TPVisiSag_Step3

SELECT [SAGSID]
      ,[sagikraft]
      ,[sagslut]
      ,[TERAPEUT_STATUS]
      ,[TERAPEUT_STATUSID]
      ,[TERAPEUT_GRUPPEID]
      ,[dogninddeling]
      ,[visiikraft]
      ,[visislut]
      ,[visiid]
      ,[start]
      ,[slut]
      ,[TPVISI]
      ,[type]
  into [_FACT_TPVisiSag_Step3]
  FROM [_FACT_TPVisiSag_Step2_TBTP]
  group by [SAGSID]
      ,[sagikraft]
      ,[sagslut]
      ,[TERAPEUT_STATUS]
      ,[TERAPEUT_STATUSID]
      ,[TERAPEUT_GRUPPEID]
      ,[dogninddeling]
      ,[visiikraft]
      ,[visislut]
      ,[visiid]
      ,[start]
      ,[slut]
      ,[TPVISI]
      ,[type]


--Set @cmd = 'update '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_TPTB set TPVISIJOB = -TPVISIJOB where specifikation = 7'
--laver _FACT_SPVisiSag_Step 3


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'_pakker'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'_pakker'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT      _FACT_TPVisiSag_Step3.SAGSID, _FACT_TPVisiSag_Step3.sagikraft, _FACT_TPVisiSag_Step3.sagslut, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.Terapeut_STATUS, _FACT_TPVisiSag_Step3.TERAPEUT_STATUSID, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.TERAPEUT_GRUPPEID as organization, _FACT_TPVisiSag_Step3.dogninddeling, _FACT_TPVisiSag_Step3.visiikraft, '  +char(13)+
             '         _FACT_TPVisiSag_Step3.visislut,_FACT_TPVisiSag_Step3.visiid, _FACT_TPVisiSag_Step3.start, _FACT_TPVisiSag_Step3.slut, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.TPVISI, _FACT_TPVisiSag_Step3.type, VISI_PAKKER_BEREGN.Pakke_Visitype, '  +char(13)+
           '           VISI_PAKKER_BEREGN.Pakke_Ugentlig_Leveret, VISI_PAKKER_BEREGN.Pakke_ID, VISI_PAKKER_BEREGN.Pakke_Lev_ID, 2 as specifikation, _FACT_TPVisiSag_Step3.start as dato'  +char(13)+
	'into '+@DestinationDB+'.dbo.'+@tablePrefix +'_Pakker ' +char(13)+
'FROM         _FACT_TPVisiSag_Step3 INNER JOIN  '  +char(13)+
'                      VISI_PAKKER_BEREGN ON _FACT_TPVisiSag_Step3.visiid = VISI_PAKKER_BEREGN.Pakke_Visi_ID '  +char(13)+
 '                     Union all  '  +char(13)+
  'SELECT      _FACT_TPVisiSag_Step3.SAGSID, _FACT_TPVisiSag_Step3.sagikraft, _FACT_TPVisiSag_Step3.sagslut, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.Terapeut_STATUS, _FACT_TPVisiSag_Step3.TERAPEUT_STATUSID, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.TERAPEUT_GRUPPEID as organization, _FACT_TPVisiSag_Step3.dogninddeling, _FACT_TPVisiSag_Step3.visiikraft, '  +char(13)+
             '         _FACT_TPVisiSag_Step3.visislut,_FACT_TPVisiSag_Step3.visiid, _FACT_TPVisiSag_Step3.start, _FACT_TPVisiSag_Step3.slut, '  +char(13)+
            '          _FACT_TPVisiSag_Step3.TPVISI, _FACT_TPVisiSag_Step3.type, VISI_PAKKER_BEREGN.Pakke_Visitype, '  +char(13)+
           '           VISI_PAKKER_BEREGN.Pakke_Ugentlig_Leveret, VISI_PAKKER_BEREGN.Pakke_ID, VISI_PAKKER_BEREGN.Pakke_Lev_ID, 3 as specifikation, _FACT_TPVisiSag_Step3.start as dato'  +char(13)+
'FROM         _FACT_TPVisiSag_Step3 INNER JOIN  '  +char(13)+
'                      VISI_PAKKER_BEREGN ON _FACT_TPVisiSag_Step3.visiid = VISI_PAKKER_BEREGN.Pakke_Visi_ID '  +char(13)


if @debug = 1 print @cmd
exec (@cmd)          


set @cmd = 'usp_Birthddays '''+@tablePrefix +'_pakker'', '''+@DestinationDB+''',''Pakke_Ugentlig_Leveret'''
if @debug = 1 print @cmd
exec (@cmd)      






set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'_TP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'_TP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT SAGSID, start AS dato, TERAPEUT_STATUS, TERAPEUT_STATUSID, ' +char(13)+
			'TERAPEUT_GRUPPEID AS organization, dogninddeling, 2 AS specifikation, 1 AS count, cast(TPVISI  / 7.0 as float) as TPVISI_TP, start, slut  ' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +'_TP ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_step2_TP ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID AS organization, ' +char(13)+
		    'dogninddeling, 3 AS specifikation, - 1 AS count, cast((TPVISI * - 1) / 7.0 as float) AS Expr1, start, slut  ' +char(13)+
			'FROM  dbo._FACT_TPVisiSag_step2_TP AS VisiSag_step2_1 ' +char(13)+
			'WHERE (DATEPART(year, slut) NOT IN (9999)) ' 
if @debug = 1 print @cmd
exec (@cmd)

/*set @cmd = 'usp_Birthddays '''+@tablePrefix +'_TP'', '''+@DestinationDB+''',''TPVISI_TP'''
if @debug = 1 print @cmd
exec (@cmd)
*/
*/
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=12)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (12,GETDATE())           
end