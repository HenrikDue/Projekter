USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_HJ]    Script Date: 08/22/2011 12:01:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER PROCEDURE [dbo].[usp_Create_FactTables_HJ]
					  @DestinationDB as  varchar(200),
					  @Afregnet as bit,
					  @debug    as bit=0
					 
AS

DECLARE @cmd as varchar(max)
DECLARE @tablePrefix as varchar(200)
DECLARE @dagfactor as varchar(1)
DECLARE @DebugCmd AS nvarchar(200)
set @dagfactor='7'

if @afregnet = 0
	set @tablePrefix = 'FACT_HJVisiSag'
if @afregnet = 1
	set @tablePrefix = 'FACT_HJVisiSag_Afregnet'

--først ryddes der op i SAGSHISTORIK og _tmp_SP_SAGSHISTORIK skabes
set @cmd = 'exec usp_HJ_SAGSHISTORIK '+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)



--Debug kode
 if (@debug=1)  set @DebugCmd = 'where sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''

--UPDATE    _tmp_HJ_SAGSHISTORIK
--SET       SLUTDATO = DATEADD(day, - 1, SLUTDATO) 
--WHERE     (DATEPART(year, SLUTDATO) NOT IN (9999))

--opdater startdato på hj_visitationer til 1/1 2007 hvor de er ældre end denne dato


Delete from dbo.HJVISITATION
where (SLUTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102))

Update  dbo.HJVISITATION
set IKRAFTDATO = CONVERT(DATETIME, '2009-01-01 00:00:00', 102)
WHERE     (IKRAFTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102)) and (SLUTDATO >= CONVERT(DATETIME, '2009-01-01 00:00:00', 102))



if @debug = 1 print ' '
if @debug = 1 print '2. Start med pratisk Bistand'
if @debug = 1 print '----------------------------------------------------------------------'


--lav _tmp_hjvisitation_PB 
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_HJVISITATION_PB' AND type = 'U') DROP TABLE _tmp_HJVISITATION_PB
set @cmd = 'Select * into _tmp_HJVISITATION_PB  from ( ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 1 AS dogninddeling, PB_MORGEN AS HJVISI,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION ' +char(13)+ --@DebugCmd+
			'WHERE (PB_MORGEN <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 2 AS dogninddeling, PB_FORMIDDAG ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS PBVISITATION_11 ' +char(13)+
			'WHERE (PB_FORMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 3 AS dogninddeling, PB_MIDDAG ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS PBVISITATION_10 ' +char(13)+
			'WHERE (PB_MIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 4 AS dogninddeling, PB_EFTERMIDDAG ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_9 ' +char(13)+
			'WHERE  (PB_EFTERMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 5 AS dogninddeling, PB_AFTEN1 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_8 ' +char(13)+
			'WHERE  (PB_AFTEN1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 6 AS dogninddeling, PB_AFTEN2 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS SPVISITATION_7 ' +char(13)+
			'WHERE  (PB_AFTEN2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 7 AS dogninddeling, PB_AFTEN3 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_6 ' +char(13)+
			'WHERE  (PB_AFTEN3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 8 AS dogninddeling, PB_AFTEN4 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_5 ' +char(13)+
			'WHERE  (PB_AFTEN4 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9 AS dogninddeling, PB_NAT1 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_4 ' +char(13)+
			'WHERE  (PB_NAT1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 10 AS dogninddeling, PB_NAT2 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_3 ' +char(13)+
			'WHERE  (PB_NAT2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 11 AS dogninddeling, PB_NAT3 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_2 ' +char(13)+
			'WHERE  (PB_NAT3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, PB_NAT4 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_1 ' +char(13)+
			'WHERE (PB_NAT4 <> 0) 
 ) as tmp where (SAGSID IN ' +char(13)+
'				   (SELECT SAGSID FROM  dbo.DimSager AS DIM_SAGER_1) ) '   
if @debug = 1 print @cmd
exec (@cmd)


--laver _FACT_SPVisiSag_Step1

if @debug = 1 print ' '
if @debug = 1 print '3. Samler  Historik og visitationer'
if @debug = 1 print '----------------------------------------------------------------------'
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step1_PB' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step1_PB

set @cmd = 'SELECT a.SAGSID,  ' +char(13)+		   
			'a.IKRAFTDATO AS sagikraft,  ' +char(13)+
			'a.SLUTDATO AS sagslut,  ' +char(13)+
			'a.HJEMMEPLEJE_STATUS,  ' +char(13)+
			'a.HJEMMEPLEJE_STATUSID,  ' +char(13)+
			'a.HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'A.HJPL_AFTENGRP_ID, ' +char(13)+  /*dag, aften og nat gruppe hentes - skal bruges som leverandør på indsats*/
			'A.HJPL_NATGRP_ID, ' +char(13)+ 			
			'A.SYPL_DAGGRP_ID, ' +char(13)+ 
			'A.SYPL_AFTENGRP_ID, ' +char(13)+ 
			'A.SYPL_NATGRP_ID, ' +char(13)+ 			
			'b.dogninddeling,  ' +char(13)+
			'b.HJALPTYPE,  ' +char(13)+
			'b.IKRAFTDATO AS visiikraft,  ' +char(13)+
			'b.SLUTDATO AS visislut,  ' +char(13)+
			'b.ID AS visiid,  ' +char(13)+
			'b.HJVISI ' +char(13)+
		    ' into _FACT_HJVisiSag_Step1_pb ' +char(13)+
			'FROM dbo._tmp_HJ_SAGSHISTORIK a INNER JOIN ' +char(13)+
			'     dbo._tmp_HJVISITATION_PB b ' +char(13)+
			'on  a.SAGSID = b.SAGSID' +char(13)+
			'and a.SLUTDATO > b.IKRAFTDATO ' +char(13)+
			'and a.IKRAFTDATO < b.SLUTDATO '
if @debug = 1 print @cmd
exec (@cmd)

--laver _FACT_SPVisiSag_Step 2

if @debug = 1 print '  '
if @debug = 1 print '4. Laver Tilgang, afgang, primo (Type 1,2,3,4) Hj'
if @debug = 1 print '----------------------------------------------------------------------'


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step2_PB' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step2_PB

set @cmd = 'SELECT SagsID, SagIkraft, SagSlut, HjemmePleje_Status, HjemmePleje_StatusID, HjemmePleje_GruppeID, ' +char(13)+
            'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'Dogninddeling, HJALPTYPE, Visiikraft, Visislut,   Visiid, SagIkraft AS start, ' +char(13)+
			'			   sagslut AS slut, HJVISI, 1 AS Type ' +char(13)+
			'into  _FACT_HJVisiSag_Step2_PB ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PB ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID, ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, HJVISI, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PB AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, HJVISI, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PB AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, HJVISI, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PB AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)



--laver _FACT_SPVisiSag_Step 3
if @debug = 1 print ' '
if @debug = 1 print '5. Laver transaction til at stoppe period som løber ud (DATEPART(year, slut) not IN (9999) '
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'_PB'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'_PB'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT SagsID, start AS Dato, HjemmePleje_Status, HjemmePleje_StatusID, ' +char(13)+
			'HjemmePleje_GruppeID AS Organization, Dogninddeling, HJALPTYPE, 2 AS Specifikation, 1 AS Count, cast(HJVISI as float) as HjVisi_PB, Start, Slut ' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +'_PB ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_step2_PB ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID AS organization, ' +char(13)+
		    'dogninddeling, HJALPTYPE, 3 AS specifikation, - 1 AS count, cast((HJVISI * - 1) as float) AS Expr1,start, slut ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_step2_PB AS VisiSag_step2_1 ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' 
if @debug = 1 print @cmd
exec (@cmd)



if @debug = 1 print ' '
if @debug = 1 print '6. Find alder og laver tilgang og afgang '
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'usp_Birthddays '''+@tablePrefix +'_PB'', '''+@DestinationDB+''',''HJVISI_PB'''
if @debug = 1 print @cmd
--exec (@cmd)



if @debug = 1 print ' '
if @debug = 1 print '7. Personlig Pleje'
if @debug = 1 print '----------------------------------------------------------------------'


--lav _tmp_hjvisitation_PP 
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_HJVISITATION_PP' AND type = 'U') DROP TABLE _tmp_HJVISITATION_PP
set @cmd = 'Select * into _tmp_HJVISITATION_PP  from ( ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 1 AS dogninddeling, PP_MORGEN AS HJVISI, HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION ' +char(13) +
			'WHERE (PP_MORGEN <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 2 AS dogninddeling, PP_FORMIDDAG ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS PPVISITATION_11 ' +char(13)+
			'WHERE (PP_FORMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 3 AS dogninddeling, PP_MIDDAG,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS PBVISITATION_10 ' +char(13)+
			'WHERE (PP_MIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 4 AS dogninddeling, PP_EFTERMIDDAG,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_9 ' +char(13)+
			'WHERE  (PP_EFTERMIDDAG <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 5 AS dogninddeling, PP_AFTEN1,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_8 ' +char(13)+
			'WHERE  (PP_AFTEN1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 6 AS dogninddeling, PP_AFTEN2,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS SPVISITATION_7  WHERE  (PP_AFTEN2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 7 AS dogninddeling, PP_AFTEN3,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_6 ' +char(13)+
			'WHERE  (PP_AFTEN3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 8 AS dogninddeling, PP_AFTEN4,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_5 ' +char(13)+
			'WHERE  (PP_AFTEN4 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9 AS dogninddeling, PP_NAT1 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_4 ' +char(13)+
			'WHERE  (PP_NAT1 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 10 AS dogninddeling, PP_NAT2 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_3 ' +char(13)+
			'WHERE  (PP_NAT2 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 11 AS dogninddeling, PP_NAT3,HJALPTYPE  ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_2 ' +char(13)+
			'WHERE  (PP_NAT3 <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, PP_NAT4 ,HJALPTYPE ' +char(13)+
			'FROM  dbo.HJVISITATION AS HJVISITATION_1 ' +char(13)+
			'WHERE (PP_NAT4 <> 0) 
 ) as tmp where (SAGSID IN ' +char(13)+
			'				   (SELECT SAGSID FROM  dbo.DIMSAGER AS DIM_SAGER_1) ) ' 

   
if @debug = 1 print @cmd
exec (@cmd)


if @debug = 1 print ' '
if @debug = 1 print '8. Samler  Historik og visitationer'
if @debug = 1 print '----------------------------------------------------------------------'

--laver _FACT_SPVisiSag_Step1
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step1_PP' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step1_PP

set @cmd = 'SELECT a.SAGSID,  ' +char(13)+		   
			'a.IKRAFTDATO AS sagikraft,  ' +char(13)+
			'a.SLUTDATO AS sagslut,  ' +char(13)+
			'a.HJEMMEPLEJE_STATUS,  ' +char(13)+
			'a.HJEMMEPLEJE_STATUSID,  ' +char(13)+
			'a.HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'A.HJPL_AFTENGRP_ID, ' +char(13)+  /*dag, aften og nat gruppe hentes - skal bruges som leverandør på indsats*/
			'A.HJPL_NATGRP_ID, ' +char(13)+ 			
			'A.SYPL_DAGGRP_ID, ' +char(13)+ 
			'A.SYPL_AFTENGRP_ID, ' +char(13)+ 
			'A.SYPL_NATGRP_ID, ' +char(13)+ 
			'b.dogninddeling,  ' +char(13)+
			'b.HJALPTYPE, ' +char(13)+
			'b.IKRAFTDATO AS visiikraft,  ' +char(13)+
			'b.SLUTDATO AS visislut,  ' +char(13)+
			'b.ID AS visiid,  ' +char(13)+
			'b.HJVISI ' +char(13)+
		    ' into _FACT_HJVisiSag_Step1_PP ' +char(13)+
			'FROM  dbo._tmp_HJ_SAGSHISTORIK a INNER JOIN ' +char(13)+
			'      dbo._tmp_HJVISITATION_PP b ON a.SAGSID = b.SAGSID  AND  ' +char(13)+
			'a.SLUTDATO > b.IKRAFTDATO AND  ' +char(13)+
			'a.IKRAFTDATO < b.SLUTDATO '
if @debug = 1 print @cmd
exec (@cmd)


if @debug = 1 print ' '
if @debug = 1 print '9. Laver Tilgang, afgang, primo (Type 1,2,3,4) Hj'
if @debug = 1 print '----------------------------------------------------------------------'

--laver _FACT_SPVisiSag_Step 2
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step2_PP' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step2_PP

set @cmd = 'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID, ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,   visiid, sagikraft AS start, ' +char(13)+
			'			   sagslut AS slut, HJVISI, 1 AS type ' +char(13)+
			'into  _FACT_HJVisiSag_Step2_PP ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PP ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID, ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, HJVISI, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PP AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, HJVISI, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PP AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID,  ' +char(13)+
			'HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYPL_DAGGRP_ID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, HJALPTYPE, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, HJVISI, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_HJVisiSag_Step1_PP AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)


if @debug = 1 print ' '
if @debug = 1 print '10. Forbedrede Dognindeling til brug for join imellem pp og bb tmp facttabellerne '
if @debug = 1 print '----------------------------------------------------------------------'
---laver hjvisi dogenindeling table til brugfor join imellem pp og bb tmp facttabellerne
-- Yd_Gange bliver divideret med sum af alle yd felter, for at der bliver to poster som ikke blive dobbelt op (f.eks. hvis et job udføres middag og aften)
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_HjvisiJobDogninddeling' AND type = 'U') DROP TABLE _HjvisiJobDogninddeling

SELECT ID, 
       HJVISIID, 
       JOBID, 
       HYPPIGHED, 
       -- Hvis hyppighed er 0 (daglig) skal ydelsesgange deles med de antal flueben der er sat, ellers skal det ikke 
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE,
       PERSONER, 
       NORMTID, 
       HJALPFRA, 
       SKJULT, 
       coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN /*navn på leverandør hentes - for at blive brugt senere til tjek af intern(kommunal) leverandør*/
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,        
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND,
       PARAGRAF, 
       TID_FRAVALGT, 
       1 AS dogninddeling
into _HjvisiJobDogninddeling
FROM  dbo.HJVISIJOB
WHERE (YD_MORGEN <> 0)
-- * Formiddag* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE, 
PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 2 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_11
WHERE (YD_FORMIDDAG <> 0)
-- * Middag * ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE, 
PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 3 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_10
WHERE (YD_MIDDAG <> 0)
-- * Eftermiddag* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV, 
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 4 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_9
WHERE (YD_EFTERMIDDAG <> 0)
UNION ALL
-- * Aften1* ---
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE 
, PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 5 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_8
WHERE (YD_AFTEN1 <> 0)
UNION ALL
-- * Aften2* ---
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER,NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 6 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_7
WHERE (YD_AFTEN2 <> 0)
UNION ALL
-- * Aften3* ---
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 7 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_6
WHERE (YD_AFTEN3 <> 0)
-- * Aften4* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 8 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_5
WHERE (YD_AFTEN4 <> 0)
-- * NAT1* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
 , PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
 	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 9 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_4
WHERE (YD_NAT1 <> 0)
-- * NAT2* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 10 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_3
WHERE (YD_NAT2 <> 0)
-- * NAT3* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE 
, PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 11 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_2
WHERE (YD_NAT3 <> 0)
-- * NAT4* ---
UNION ALL
SELECT ID, HJVISIID, JOBID, HYPPIGHED,  
       case when HYPPIGHED = 0 then
			case when YD_GANGE = 0 then null 
			else (convert(decimal(18,10),YD_GANGE)) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4) 
			end
	   else
		   case when YD_GANGE = 0 then null 
		   else
			convert(decimal(18,10),YD_GANGE)
			end
		end as YD_GANGE
, PERSONER,  NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 12 AS dogninddeling
FROM  dbo.HJVISIJOB AS HJVISIJOB_1
WHERE (YD_NAT4 <> 0)

--join jobtyper på _HjvisiJobDogninddeling
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_HjvisiJobDogninddelingJobType' AND type = 'U') DROP TABLE _HjvisiJobDogninddelingJobType

SELECT a.*,
       coalesce(b.NORMTID1, 1) AS NormTidJobType
into  _HjvisiJobDogninddelingJobType
FROM  _HjvisiJobDogninddeling a LEFT OUTER JOIN
               JOBTYPER b  ON a.JOBID = b.JOBID


if @debug = 1 print ' '
if @debug = 1 print '10. Join PB og PP sammen. (_FACT_HJVisiSag_Step2_PB og _FACT_HJVisiSag_Step2_PP sammen)'
if @debug = 1 print '----------------------------------------------------------------------'



---join _FACT_HJVisiSag_Step2_PB og _FACT_HJVisiSag_Step2_PP sammen
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step2_PBPP' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step2_PBPP
SELECT SagsId,
       Sagikraft,
       Sagslut,
       Hjemmepleje_Status, 
       Hjemmepleje_StatusID,
       Hjemmepleje_GruppeID, 
       HJPL_AFTENGRP_ID,
       HJPL_NATGRP_ID,
       SYPL_DAGGRP_ID,
       SYPL_AFTENGRP_ID,
       SYPL_NATGRP_ID,     
       Dogninddeling, 
       Hjalptype,
       Visiikraft, 
       Visislut, 
       Visiid, 
       Start, 
       Slut, 
       HJVisi,
       Type -- specifikation
into _FACT_HJVisiSag_Step2_PBPP
from  dbo._FACT_HJVisiSag_Step2_PB
union all
select SagsId,
       Sagikraft,
       Sagslut,
       Hjemmepleje_Status, 
       Hjemmepleje_StatusID,
       Hjemmepleje_GruppeID, 
       HJPL_AFTENGRP_ID,
       HJPL_NATGRP_ID,
       SYPL_DAGGRP_ID,
       SYPL_AFTENGRP_ID,
       SYPL_NATGRP_ID,        
       Dogninddeling, 
       Hjalptype,
       Visiikraft, 
       Visislut, 
       Visiid, 
       Start, 
       Slut, 
       HJVisi,
       Type
FROM  dbo._FACT_HJVisiSag_Step2_PP

if @debug = 1 print ' '
if @debug = 1 print '11. Gruppering af HJ PBPP'
if @debug = 1 print '----------------------------------------------------------------------'


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_HJVisiSag_Step3_PBPP' AND type = 'U') DROP TABLE _FACT_HJVisiSag_Step3_PBPP

SELECT SagsId,
       Sagikraft,
       Sagslut,
       Hjemmepleje_Status, 
       Hjemmepleje_StatusID,
       Hjemmepleje_GruppeID, 
       Dogninddeling, 
       Visiikraft, 
       Visislut, 
       Visiid, 
       Start, 
       Slut, 
       HJVisi,
       [Type],
       Hjalptype
  into [_FACT_HJVisiSag_Step3_PBPP]
  FROM [_FACT_HJVisiSag_Step2_PBPP]
  group by SagsId,
       Sagikraft,
       Sagslut,
       Hjemmepleje_Status, 
       Hjemmepleje_StatusID,
       Hjemmepleje_GruppeID, 
       Dogninddeling, 
       Visiikraft, 
       Visislut, 
       Visiid, 
       Start, 
       Slut, 
       HJVisi,
       [Type],
       Hjalptype
  


if @debug = 1 print ' '
if @debug = 1 print '12. Tilføje jobid til visiid'
if @debug = 1 print '----------------------------------------------------------------------'

--Laver facttable
-- Laver distinct, så man kun får posterne 1 gang
-- Person tilføjet, gammel version uden antal personer er ikke fjernet
-- ID (jobID) er tilføjet, da samme jobID kan være på samme visitation flere gange
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job_PBPP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_PBPP'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT DISTINCT  ' +char(13)+
            'c.VisiID, ' +char(13)+ 
            'c.SagsID, ' +char(13)+ 
            'c.HjemmePleje_Status, ' +char(13)+ 
			'c.HjemmePleje_StatusID, ' +char(13)+ 
			'c.HjemmePleje_GruppeID as organization,  ' +char(13)+
			'C.HJPL_AFTENGRP_ID, ' +char(13)+ 
			'C.HJPL_NATGRP_ID, ' +char(13)+ 			
			'C.SYPL_DAGGRP_ID, ' +char(13)+ 
            'C.SYPL_AFTENGRP_ID, ' +char(13)+
            'C.SYPL_NATGRP_ID, ' +char(13)+			
			'a.Dogninddeling,' +char(13)+ 
			'c.Hjalptype, ' +char(13)+
			'c.Start,' +char(13)+ 
			'c.Start as dato,  ' +char(13)+
		    'c.Slut,' +char(13)+ 
		    'c.Type, ' +
		    'a.JobID,  ' +char(13)+
		    'a.ID,' +char(13)+
		    'case ' +char(13)+ 
            '  when a.HYPPIGHED = 0 then (((coalesce( B.INT_DAG,0) * NORMTIDJobType) /60.0) * 7.0 * YD_GANGE)/'+@dagfactor+' ' +char(13)+
			'  when a.HYPPIGHED = 1 then (((coalesce( B.INT_DAG,0) * NORMTIDJobType) /60.0) * YD_GANGE)/'+@dagfactor+' ' +char(13)+
			'  when a.HYPPIGHED = 2 then (((coalesce( B.INT_DAG,0) * NORMTIDJobType) /60.0) / YD_GANGE)/'+@dagfactor +' '+char(13)+
			'end as Pris ,b.startdato as pstart,b.slutdato as pslut,2 AS specifikation, ' +char(13)+
		/*	Gammel version uden person
			'case  ' +char(13)+ 
			'  when a.HYPPIGHED = 2 then (a.NORMTID/YD_GANGE)/'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 1 then (a.NORMTID*YD_GANGE) /'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 0 then (a.NORMTID*YD_GANGE*7)/'+@dagfactor+' ' +char(13)+
			'end as HJVISIJOB, ' +char(13)+
			*/
			'case  ' +char(13)+ 
			'  when a.HYPPIGHED = 2 then (a.NORMTID/YD_GANGE*PERSONER)/'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 1 then (a.NORMTID*YD_GANGE*PERSONER) /'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 0 then (a.NORMTID*YD_GANGE*7*PERSONER)/'+@dagfactor+' ' +char(13)+
			'end as HJVISIJOB, ' +char(13)+
			
			--Hverdage
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then (a.NormTid*YD_GANGE*Personer)/5 ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*(YD_GANGE-YD_WEEKEND)*Personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid/YD_GANGE*personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as HJVISIJOBHverdag, ' +char(13)+				
			
			--Weekend
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*YD_WEEKEND*Personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid/YD_WEEKEND*personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'end as HJVISIJOBWeekend, ' +char(13)+			
			
			'case ' +char(13)+ 
			'  when a.HYPPIGHED = 2 then (1/convert(decimal(18,10),YD_GANGE)) /'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 1 then (convert(decimal(18,10),YD_GANGE))/'+@dagfactor+' ' +char(13)+
			'  when  a.HYPPIGHED = 0 then (convert(decimal(18,10),YD_GANGE)*7) /'+@dagfactor+' ' +char(13)+
			'end as HJVISIJOBAntal, ' +char(13)+
			'a.FRITVALGLEV, ' +char(13)+
			'a.LEVERANDOERNAVN ' +char(13)+		
			'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_PBPP ' +char(13)+
			'FROM  _HjvisiJobDogninddelingJobType a LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER b ON a.JOBID = b.JOBID RIGHT OUTER JOIN ' +char(13)+
		     '_FACT_HJVisiSag_Step2_PBPP c ON a.HJVISIID = c.visiid  ' +char(13)+
			'union all ' +char(13)+
			'SELECT DISTINCT  ' +char(13)+     
            '_FACT_HJVisiSag_Step2_PBPP.visiid, _FACT_HJVisiSag_Step2_PBPP.SAGSID, _FACT_HJVisiSag_Step2_PBPP.HJEMMEPLEJE_STATUS, ' +char(13)+ 
			'_FACT_HJVisiSag_Step2_PBPP.HJEMMEPLEJE_STATUSID, _FACT_HJVisiSag_Step2_PBPP.HJEMMEPLEJE_GRUPPEID as organization,  ' +char(13)+
			'_FACT_HJVisiSag_Step2_PBPP.HJPL_AFTENGRP_ID, ' +char(13)+ 
			'_FACT_HJVisiSag_Step2_PBPP.HJPL_NATGRP_ID, ' +char(13)+ 			
			'_FACT_HJVisiSag_Step2_PBPP.SYPL_DAGGRP_ID, ' +char(13)+ 
            '_FACT_HJVisiSag_Step2_PBPP.SYPL_AFTENGRP_ID, ' +char(13)+
            '_FACT_HJVisiSag_Step2_PBPP.SYPL_NATGRP_ID, ' +char(13)+				
			'_HjvisiJobDogninddelingJobType.dogninddeling, _FACT_HJVisiSag_Step2_PBPP.Hjalptype, _FACT_HJVisiSag_Step2_PBPP.slut,_FACT_HJVisiSag_Step2_PBPP.Slut as dato,   ' +char(13)+
		    '_FACT_HJVisiSag_Step2_PBPP.slut, _FACT_HJVisiSag_Step2_PBPP.type, _HjvisiJobDogninddelingJobType.JOBID,  ' +
		    '_HjvisiJobDogninddelingJobType.ID,  ' +char(13)+
            'case when _HjvisiJobDogninddelingJobType.HYPPIGHED = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * - 1) /60.0) * 7.0 * YD_GANGE)/'+@dagfactor+' ' +char(13)+
			'when _HjvisiJobDogninddelingJobType.HYPPIGHED = 1 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * -1) /60.0) * YD_GANGE) /'+@dagfactor+' ' +char(13)+
			'when _HjvisiJobDogninddelingJobType.HYPPIGHED = 2 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * -1) /60.0) / YD_GANGE) /'+@dagfactor+' ' +char(13)+
			'end as Pris,jobpriser.startdato as pstart,jobpriser.slutdato as pslut, 3 AS specifikation, ' +char(13)+
			'case   when _HjvisiJobDogninddelingJobType.HYPPIGHED = 2 then ((_HjvisiJobDogninddelingJobType.NORMTID/YD_GANGE)*-1)/'+@dagfactor+' ' +char(13)+
			'when  _HjvisiJobDogninddelingJobType.HYPPIGHED = 1 then ((_HjvisiJobDogninddelingJobType.NORMTID*YD_GANGE)*-1)/'+@dagfactor+' ' +char(13)+
			'when  _HjvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_HjvisiJobDogninddelingJobType.NORMTID*YD_GANGE)*-1*7)/'+@dagfactor+' ' +char(13)+
			'end as HJVISIJOB,' +char(13)+	
			
			--Hverdag
			'case '  +char(13)+
			'  when _HjvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_HjvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1) ' +char(13)+
			'  when _HjvisiJobDogninddelingJobType.HYPPIGHED = 1 then ' +char(13)+
			'    case when _HjvisiJobDogninddelingJobType.YD_WEEKEND is null then ((_HjvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1)/5 ' +char(13)+
			'    else ' +char(13)+
			'    ((_HjvisiJobDogninddelingJobType.NormTid*(YD_GANGE-YD_WEEKEND)*Personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when _HjvisiJobDogninddelingJobType.HYPPIGHED = 2 then ' +char(13)+
			'    case when _HjvisiJobDogninddelingJobType.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_HjvisiJobDogninddelingJobType.NormTid/YD_GANGE*personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as HJVISIJOBHverdag, ' +char(13)+				
			
			--Weekend
			'case '  +char(13)+
			'  when  _HjvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_HjvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1) ' +char(13)+
			'  when  _HjvisiJobDogninddelingJobType.HYPPIGHED = 1 then ' +char(13)+
			'    case when _HjvisiJobDogninddelingJobType.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_HjvisiJobDogninddelingJobType.NormTid*YD_WEEKEND*Personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'  when _HjvisiJobDogninddelingJobType.HYPPIGHED = 2 then ' +char(13)+
			'    case when _HjvisiJobDogninddelingJobType.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_HjvisiJobDogninddelingJobType.NormTid/YD_WEEKEND*personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'end as HJVISIJOBWeekend, ' +char(13)+			
			'case when _HjvisiJobDogninddelingJobType.HYPPIGHED = 2 then (1/YD_GANGE*-1)/'+@dagfactor+' ' +char(13)+
			'when _HjvisiJobDogninddelingJobType.HYPPIGHED = 1 then (YD_GANGE*-1)/'+@dagfactor+' ' +char(13)+
			'when _HjvisiJobDogninddelingJobType.HYPPIGHED = 0 then (YD_GANGE*-1*7) /'+@dagfactor+' ' +char(13)+
			'end as HJVISIJOBantal,' +char(13)+	
			' _HjvisiJobDogninddelingJobType.FRITVALGLEV, ' +char(13)+	
	        '_HjvisiJobDogninddelingJobType.LEVERANDOERNAVN ' +char(13)+				
			'FROM  _HjvisiJobDogninddelingJobType LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON _HjvisiJobDogninddelingJobType.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
            '_FACT_HJVisiSag_Step2_PBPP ON _HjvisiJobDogninddelingJobType.dogninddeling = _FACT_HJVisiSag_Step2_PBPP.dogninddeling  ' +char(13)+
			'AND _HjvisiJobDogninddelingJobType.HJVISIID = _FACT_HJVisiSag_Step2_PBPP.visiid '  +char(13)+
		--'_FACT_HJVisiSag_Step2_PBPP ON _HjvisiJobDogninddelingJobType.HJVISIID = _FACT_HJVisiSag_Step2_PBPP.visiid '  +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999))  ' +char(13)
			
if @debug = 1 print @cmd
exec (@cmd)



set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job_PBPP'', '''+@DestinationDB+''',''HJVISIJOB'''
if @debug = 1 print @cmd
exec (@cmd)

/*
if @debug = 1 print ' '
if @debug = 1 print '13. Laver Pakke tabel '
if @debug = 1 print '----------------------------------------------------------------------'

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job_PBPP_pakker'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_PBPP_pakker'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT      a.SAGSID, a.sagikraft, a.sagslut, '  +char(13)+
            '          a.HJEMMEPLEJE_STATUS, a.HJEMMEPLEJE_STATUSID, '  +char(13)+
            '          a.HJEMMEPLEJE_GRUPPEID as organization, a.dogninddeling, a.visiikraft, '  +char(13)+
            '          a.visislut, a.visiid, a.start, a.slut, '  +char(13)+
            '          a.HJVISI, a.type, b.Pakke_Visitype, '  +char(13)+
            '          b.Pakke_Ugentlig_Leveret, b.Pakke_ID, b.Pakke_Lev_ID, 2 as specifikation, a.start as dato'  +char(13)+
	        '          into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job_PBPP_Pakker ' +char(13)+
'FROM         _FACT_HJVisiSag_Step3_PBPP a INNER JOIN  '  +char(13)+
'                      VISI_PAKKER_BEREGN b ON a.visiid = b.Pakke_Visi_ID '  +char(13)+
 '                     Union all  '  +char(13)+
 'SELECT      _FACT_HJVisiSag_Step3_PBPP.SAGSID, _FACT_HJVisiSag_Step3_PBPP.sagikraft, _FACT_HJVisiSag_Step3_PBPP.sagslut,  '  +char(13)+
 '                     _FACT_HJVisiSag_Step3_PBPP.HJEMMEPLEJE_STATUS, _FACT_HJVisiSag_Step3_PBPP.HJEMMEPLEJE_STATUSID, '  +char(13)+
 '                     _FACT_HJVisiSag_Step3_PBPP.HJEMMEPLEJE_GRUPPEID, _FACT_HJVisiSag_Step3_PBPP.dogninddeling, _FACT_HJVisiSag_Step3_PBPP.visiikraft, '  +char(13)+
 '                     _FACT_HJVisiSag_Step3_PBPP.visislut, _FACT_HJVisiSag_Step3_PBPP.visiid, _FACT_HJVisiSag_Step3_PBPP.start, _FACT_HJVisiSag_Step3_PBPP.slut, '  +char(13)+
  '                    _FACT_HJVisiSag_Step3_PBPP.HJVISI, _FACT_HJVisiSag_Step3_PBPP.type, VISI_PAKKER_BEREGN.Pakke_Visitype, '  +char(13)+
 '                     VISI_PAKKER_BEREGN.Pakke_Ugentlig_Leveret, VISI_PAKKER_BEREGN.Pakke_ID, VISI_PAKKER_BEREGN.Pakke_Lev_ID, 3 as specifikation, _FACT_HJVisiSag_Step3_PBPP.Slut as dato  '  +char(13)+
'FROM         _FACT_HJVisiSag_Step3_PBPP INNER JOIN  '  +char(13)+
       '               VISI_PAKKER_BEREGN ON _FACT_HJVisiSag_Step3_PBPP.visiid = VISI_PAKKER_BEREGN.Pakke_Visi_ID      '  +char(13)                
                      
if @debug = 1 print @cmd
exec (@cmd)          */

/*
set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job_PBPP_pakker'', '''+@DestinationDB+''',''Pakke_Ugentlig_Leveret'''
if @debug = 1 print @cmd
exec (@cmd)            
*/

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=48)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (48,GETDATE())           
--end