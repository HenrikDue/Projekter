USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_SP]    Script Date: 11/26/2010 13:58:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER procEDURE [dbo].[usp_Create_FactTables_SP]
					  @DestinationDB as  varchar(200),
					  @Afregnet as bit,
					  @Debug    as bit=0
					 
AS
--1.Henter Sagshistorik   
--2.Sletter gamle data   
--3.Laver _tmp_sp_visitation     
--4.Laver _FACT_SPVisiSag_Step1  
--5.Laver _FACT_SPVisiSag_Step2  
--6.Laver _SPvisiJobDogninddelingJobType  
--7.Laver _SPvisiJobDogninddelingJobType          
--8.Laver SPVISIJOB			


DECLARE @cmd as varchar(max)
DECLARE @tablePrefix as varchar(200)
declare @DebugCmd as nvarchar(4000)

if @afregnet = 0
	set @tablePrefix = 'FACT_SPVisiSag'
if @afregnet = 1
	set @tablePrefix = 'FACT_SPVisiSag_Afregnet'



------------------------------------------------------------------------------------------------------------
--1.Henter Sagshistorik                                                         ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '1.Henter Sagshistorik                                                    ( usp_Create_FactTables_SP) '
print ''


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactVisisagjobAfregnet_TilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVisisagjobAfregnet_TilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

--Debug kode
 if (@debug=1)  set @DebugCmd = 'where sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''

--først ryddes der op i SAGSHISTORIK og _tmp_SP_SAGSHISTORIK skabes
set @cmd = 'exec usp_SP_SAGSHISTORIK '+cast(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

------------------------------------------------------------------------------------------------------------
--2.Sletter gamle data                                                          ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '2.Sletter gamle data                                                     ( usp_Create_FactTables_SP) '
print ''

Delete from dbo.SPVISITATION
where (SLUTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102))

Update  dbo.SPVISITATION
set IKRAFTDATO = CONVERT(DATETIME, '2009-01-01 00:00:00', 102)
WHERE     (IKRAFTDATO < CONVERT(DATETIME, '2009-01-01 00:00:00', 102)) and (SLUTDATO >= CONVERT(DATETIME, '2009-01-01 00:00:00', 102))


------------------------------------------------------------------------------------------------------------
--3.Laver _tmp_sp_visitation                                                     ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '3.Laver _tmp_sp_visitation                                                ( usp_Create_FactTables_SP) '
print ''

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_SPVISITATION' AND type = 'U') DROP TABLE _tmp_SPVISITATION
set @cmd = 'Select * into _tmp_SPVISITATION  from ( ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 1 AS Dogninddeling, SP_MORGEN AS SPVISI ' +char(13)+
			'FROM  dbo.SPVISITATION  ' +char(13) +   -- @DebugCmd + ') a'
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 2 AS dogninddeling, SP_FORMIDDAG ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_11 ' +char(13)+
			'WHERE (SP_FORMIDDAG <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 3 AS dogninddeling, SP_MIDDAG ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_10 ' +char(13)+
			'WHERE (SP_MIDDAG <> 0) ' +char(13)+

			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 4 AS dogninddeling, SP_EFTERMIDDAG ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_9 ' +char(13)+
			'WHERE  (SP_EFTERMIDDAG <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 5 AS dogninddeling, SP_AFTEN1 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_8 ' +char(13)+
			'WHERE  (SP_AFTEN1 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 6 AS dogninddeling, SP_AFTEN2 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_7 ' +char(13)+
			'WHERE  (SP_AFTEN2 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 7 AS dogninddeling, SP_AFTEN3 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_6 ' +char(13)+
			'WHERE  (SP_AFTEN3 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 8 AS dogninddeling, SP_AFTEN4 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_5 ' +char(13)+
			'WHERE  (SP_AFTEN4 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9 AS dogninddeling, SP_NAT1 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_4 ' +char(13)+
			'WHERE  (SP_NAT1 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 10 AS dogninddeling, SP_NAT2 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_3 ' +char(13)+
			'WHERE  (SP_NAT2 <> 0) ' +char(13)+
	
			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 11 AS dogninddeling, SP_NAT3 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_2 ' +char(13)+
			'WHERE  (SP_NAT3 <> 0) ' +char(13)+

			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 12 AS dogninddeling, SP_NAT3 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_2 ' +char(13)+
			'WHERE  (SP_NAT4 <> 0) ' +char(13)+

			'UNION ALL ' +char(13)+
			'SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 0 AS dogninddeling, 1 ' +char(13)+
			'FROM  dbo.SPVISITATION AS SPVISITATION_1 ' +char(13)+
			'where (SP_MORGEN = 0) ' +char(13)+
			'and   (SP_FORMIDDAG = 0) ' +char(13)+
			'and   (SP_MIDDAG = 0) ' +char(13)+
			'and   (SP_EFTERMIDDAG = 0) ' +char(13)+
			'and   (SP_AFTEN1 = 0) ' +char(13)+
			'and   (SP_AFTEN2 = 0) ' +char(13)+
			'and   (SP_AFTEN3 = 0) ' +char(13)+
			'and   (SP_AFTEN4 = 0) ' +char(13)+
			'and   (SP_NAT1 = 0) ' +char(13)+
			'and   (SP_NAT2 = 0) ' +char(13)+
			'and   (SP_NAT3 = 0) ' +char(13)+
			'and   (SP_NAT4 = 0) ' +char(13)+
			' ) as tmp where (SAGSID IN ' +char(13)+
			'				   (SELECT SAGSID FROM  dbo.DIMSAGER AS DIM_SAGER_1) ) ' 
		

   
   
if @debug = 1 print @cmd
exec (@cmd)



------------------------------------------------------------------------------------------------------------
--4.Laver _FACT_SPVisiSag_Step1                                                     ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '4.Laver _FACT_SPVisiSag_Step1                                                ( usp_Create_FactTables_SP) '
print ''

--laver _FACT_SPVisiSag_Step1
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_SPVisiSag_Step1' AND type = 'U') DROP TABLE _FACT_SPVisiSag_Step1

set @cmd = 'SELECT a.SAGSID,  ' +char(13)+		   
			'a.IKRAFTDATO AS sagikraft,  ' +char(13)+
			'a.SLUTDATO AS sagslut,  ' +char(13)+
			'a.SYGEPLEJE_STATUS,  ' +char(13)+
			'a.SYGEPLEJE_STATUSID,  ' +char(13)+
			'a.SYGEPLEJE_GRUPPEID,  ' +char(13)+
			'A.SYPL_AFTENGRP_ID, ' +char(13)+ 
			'A.SYPL_NATGRP_ID, ' +char(13)+ 
			'A.HJPL_DAGGRP_ID, ' +char(13)+    /*dag, aften og nat gruppe hentes - skal bruges som leverandør på indsats*/
			'A.HJPL_AFTENGRP_ID, ' +char(13)+  
			'A.HJPL_NATGRP_ID, ' +char(13)+ 									
			'b.Dogninddeling,  ' +char(13)+
			'b.IKRAFTDATO AS visiikraft,  ' +char(13)+
			'b.SLUTDATO AS visislut,  ' +char(13)+
			'b.ID AS visiid,  ' +char(13)+
			'b.SPVISI ' +char(13)+
		    ' into _FACT_SPVisiSag_Step1 ' +char(13)+
			'FROM  dbo._tmp_SP_SAGSHISTORIK a INNER JOIN ' +char(13)+
			'dbo._tmp_SPVISITATION b on ' +char(13)+ 
			'a.SAGSID		= b.SAGSID		AND  ' +char(13)+
			'a.SLUTDATO		> b.IKRAFTDATO	AND  ' +char(13)+
			'a.IKRAFTDATO	< b.SLUTDATO '
if @debug = 1 print @cmd
exec (@cmd)


------------------------------------------------------------------------------------------------------------
--5.Laver _FACT_SPVisiSag_Step2                                                     ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '5.Laver _FACT_SPVisiSag_Step2                                                ( usp_Create_FactTables_SP) '
print ''


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_SPVisiSag_Step2' AND type = 'U') DROP TABLE _FACT_SPVisiSag_Step2

set @cmd = 'SELECT SAGSID, sagikraft, sagslut, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID, ' +char(13)+
            'SYPL_AFTENGRP_ID,SYPL_NATGRP_ID,HJPL_DAGGRP_ID,HJPL_AFTENGRP_ID,HJPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,   visiid, sagikraft AS start, ' +char(13)+
			'			   sagslut AS slut, SPVISI, 1 AS type ' +char(13)+
			'into  _FACT_SPVisiSag_Step2 ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_Step1 ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID, ' +char(13)+
			'SYPL_AFTENGRP_ID,SYPL_NATGRP_ID,HJPL_DAGGRP_ID,HJPL_AFTENGRP_ID,HJPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, SPVISI, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_Step1 AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID,  ' +char(13)+
			'SYPL_AFTENGRP_ID,SYPL_NATGRP_ID,HJPL_DAGGRP_ID,HJPL_AFTENGRP_ID,HJPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, SPVISI, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_Step1 AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID,  ' +char(13)+
			'SYPL_AFTENGRP_ID,SYPL_NATGRP_ID,HJPL_DAGGRP_ID,HJPL_AFTENGRP_ID,HJPL_NATGRP_ID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, SPVISI, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_Step1 AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)


------------------------------------------------------------------------------------------------------------
--6.Laver _SPvisiJobDogninddelingJobType                                            ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '6.Laver _SPvisiJobDogninddelingJobType                                       ( usp_Create_FactTables_SP) '
print ''


--laver factable med jobid cast((SPVISI * - 1) / 7 as float)
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job'
if @debug = 1 print @cmd
exec (@cmd)
/*
set @cmd = 'SELECT SAGSID, start AS dato, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, ' +char(13)+
			'SYGEPLEJE_GRUPPEID AS organization, dogninddeling, 2 AS specifikation, 1 AS count, cast(SPVISI  / 7 as float) as SPVISI,SPVISIJOB.JOBID, start, slut, cast( JOBPRISER.INT_DAG as float) as PRIS ' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job ' +char(13)+
			'FROM  SPVISIJOB LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON SPVISIJOB.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
		    '_FACT_SPVisiSag_Step2 ON SPVISIJOB.SPVISIID = _FACT_SPVisiSag_Step2.visiid ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID AS organization, ' +char(13)+
		    'dogninddeling, 3 AS specifikation, - 1 AS count,  cast((SPVISI * - 1) / 7 as float) AS Expr1,SPVISIJOB.JOBID,start, slut, cast( JOBPRISER.INT_DAG as float) as PRIS  ' +char(13)+
			'FROM  SPVISIJOB LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON SPVISIJOB.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
		    '_FACT_SPVisiSag_Step2 ON SPVISIJOB.SPVISIID = _FACT_SPVisiSag_Step2.visiid ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' 
*/


--------
---laver SPvisi dogenindeling table til brugfor join imellem pp og bb tmp facttabellerne
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_SPvisiJobDogninddeling' AND type = 'U') DROP TABLE _SPvisiJobDogninddeling
SELECT ID, 
       SPVISIID,
       JOBID, 
       HYPPIGHED,
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
               TID_FRAVALGT, 1 AS dogninddeling
into _SPvisiJobDogninddeling
FROM  dbo.SPVISIJOB
WHERE (YD_MORGEN <> 0)

UNION ALL
-- *Formiddag* --
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
       end as YD_WEEKEND, 
       PARAGRAF, 
               TID_FRAVALGT, 2 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_11
WHERE (YD_FORMIDDAG <> 0)
UNION ALL
-- * Middag * --
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
       end as YD_WEEKEND,  PARAGRAF, 
               TID_FRAVALGT, 3 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_10
WHERE (YD_MIDDAG <> 0)
UNION ALL
-- * Aften * --
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
               TID_FRAVALGT, 4 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_9
WHERE (YD_EFTERMIDDAG <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
FROM  dbo.SPVISIJOB AS SPVISIJOB_8
WHERE (YD_AFTEN1 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
               TID_FRAVALGT, 6 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_7
WHERE (YD_AFTEN2 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
FROM  dbo.SPVISIJOB AS SPVISIJOB_6
WHERE (YD_AFTEN3 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
               TID_FRAVALGT, 8 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_5
WHERE (YD_AFTEN4 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  case when YD_GANGE = 0 then null 
else (convert(decimal(18,10),YD_GANGE) / (YD_AFTEN1+YD_AFTEN2+YD_AFTEN3+YD_AFTEN4+YD_EFTERMIDDAG+YD_FORMIDDAG+YD_MIDDAG+YD_MORGEN+YD_NAT1+YD_NAT2+YD_NAT3+YD_NAT4))
end as YD_GANGE , PERSONER, NORMTID, HJALPFRA, SKJULT, coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, PARAGRAF, 
               TID_FRAVALGT, 9 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_4
WHERE (YD_NAT1 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
FROM  dbo.SPVISIJOB AS SPVISIJOB_3
WHERE (YD_NAT2 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
               TID_FRAVALGT, 11 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_2
WHERE (YD_NAT3 <> 0)
UNION ALL
SELECT ID, SPVISIID, JOBID, HYPPIGHED,  
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
               TID_FRAVALGT, 12 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_1
WHERE (YD_NAT4 <> 0)
UNION ALL
SELECT ID, 
       SPVISIID, 
       JOBID, 
       HYPPIGHED,
       case 
         when YD_GANGE = 0 then null
         else convert(decimal(18,10),YD_GANGE)  
       end as YD_GANGE ,
       PERSONER, 
       NORMTID, 
       HJALPFRA, 
       SKJULT,
       coalesce( FRITVALGLEV,8888) as FRITVALGLEV,
	   CASE WHEN FRITVALGLEV is not null THEN 
	    (SELECT NAVN FROM HJPLEVERANDOR WHERE ID=FRITVALGLEV)
	   ELSE 'Kommunen'
	   END AS LEVERANDOERNAVN,       
		case when YD_WEEKEND = 0 then null
        else
        convert(decimal(18,10),YD_WEEKEND)
        end as YD_WEEKEND, 
       PARAGRAF, 
       TID_FRAVALGT, 
       0 AS dogninddeling
FROM  dbo.SPVISIJOB AS SPVISIJOB_1
WHERE (YD_FORMIDDAG = 0)
and   (YD_EFTERMIDDAG = 0)
and   (YD_MIDDAG = 0)
and   (YD_MORGEN = 0)
and   (YD_AFTEN1 = 0)
and   (YD_AFTEN2 = 0)
and   (YD_AFTEN3= 0)
and   (YD_AFTEN4 = 0)
and   (YD_NAT1 = 0)
and   (YD_NAT2 = 0)
and   (YD_NAT3 = 0)
and   (YD_NAT4 = 0)


------------------------------------------------------------------------------------------------------------
--7.Laver _SPvisiJobDogninddelingJobType                                            ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '7.Laver _SPvisiJobDogninddelingJobType                                       ( usp_Create_FactTables_SP) '
print ''


--join jobtyper på _SPvisiJobDogninddeling
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_SPvisiJobDogninddelingJobType' AND type = 'U') DROP TABLE _SPvisiJobDogninddelingJobType
SELECT _SPvisiJobDogninddeling.*,
        coalesce(JOBTYPER.NormTid1, 1) AS NORMTIDJobType
into _SPvisiJobDogninddelingJobType
FROM  _SPvisiJobDogninddeling LEFT OUTER JOIN
               JOBTYPER ON _SPvisiJobDogninddeling.JOBID = JOBTYPER.JOBID

--laver facttable
-- ID tilføjet, for at håndtere at der kan være samme jobId på en visitation
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT DISTINCT  ' +char(13)+
            'c.visiid,' +char(13)+
            'c.Sagsid,' +char(13)+
            'c.SygePleje_Status, ' +char(13)+ 
			'c.SygePleje_StatusID,' +char(13)+
            'c.SygePleje_GRUPPEID as organization,  ' +char(13)+
            'C.SYPL_AFTENGRP_ID, ' +char(13)+
            'C.SYPL_NATGRP_ID, ' +char(13)+
			'C.HJPL_DAGGRP_ID, ' +char(13)+ 
			'C.HJPL_AFTENGRP_ID, ' +char(13)+ 
			'C.HJPL_NATGRP_ID, ' +char(13)+             
			'c.Dogninddeling, ' +char(13)+
            'c.Start,' +char(13)+
            'c.start as Dato,  ' +char(13)+
		    'c.Slut, ' +char(13)+
            'c.Type, a.JOBID, a.ID,   ' +char(13)+
            'case when a.Hyppighed = 0 then (((coalesce( b.INT_DAG,0) * NORMTIDJobType) /60.0) * 7.0 * YD_GANGE) ' +char(13)+
			'  when a.Hyppighed = 1 then (((coalesce( b.INT_DAG,0) * NORMTIDJobType) /60.0) * YD_GANGE) ' +char(13)+
			'  when a.Hyppighed = 2 then (((coalesce( b.INT_DAG,0) * NORMTIDJobType) /60.0) / YD_GANGE) ' +char(13)+
			'end as Pris,' +char(13)+
            'b.startdato as pstart,' +char(13)+
            'b.slutdato as pslut,' +char(13)+
            '2 AS specifikation, ' +char(13)+
			'case   when a.Hyppighed = 2 then (a.NormTid/YD_GANGE*personer)/7  ' +char(13)+
			'  when  a.Hyppighed = 1     then (a.NormTid*YD_GANGE*Personer)/7  ' +char(13)+
			'  when  a.Hyppighed = 0     then (a.NormTid*YD_GANGE*7*Personer)/7 ' +char(13)+
			'end as SPVISIJOB, ' +char(13)+		
			
			--Hverdage
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then (a.NormTid*YD_GANGE*Personer)/5 ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*(YD_GANGE-YD_WEEKEND)*Personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is not null then 0 ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid/YD_GANGE*personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as SPVISIJOBHverdag, ' +char(13)+		
			
			--Weekend
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then 0 ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*YD_WEEKEND*Personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is null then 0 ' +char(13)+
			'    else ' +char(13)+
			'    ((a.NormTid/a.YD_WEEKEND)*personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'end as SPVISIJOBWeekend, ' +char(13)+							

			/*-
						'case   when a.Hyppighed = 2 then (a.NormTid/YD_GANGE)  ' +char(13)+
			'  when  a.Hyppighed = 1     then (a.NormTid*YD_GANGE)  ' +char(13)+
			'  when  a.Hyppighed = 0     then (a.NormTid*YD_GANGE*7) ' +char(13)+
			'end as SPVISIJOB, ' +char(13)+
			*/
			
			'case   when a.Hyppighed = 2 then (1/YD_GANGE)  ' +char(13)+
			'  when  a.Hyppighed = 1 then (1*YD_GANGE)  ' +char(13)+
			'  when  a.Hyppighed = 0 then (YD_GANGE*7) ' +char(13)+
			'end as SPVISIJOBantal' +char(13)+
			', a.FRITVALGLEV, ' +char(13)+
			' a.LEVERANDOERNAVN ' +char(13)+
			'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job ' +char(13)+
			'from  _SPvisiJobDogninddelingJobType a LEFT OUTER JOIN ' +char(13)+
            '      jobpriser                      b ON a.JOBID = b.JOBID RIGHT OUTER JOIN ' +char(13)+
            '      _FACT_SPVisiSag_Step2          c ON a.dogninddeling = c.dogninddeling  ' +char(13)+
			'                                       AND a.SPVISIID = c.visiid ' +char(13)+
			'union all ' +char(13)+
			'SELECT DISTINCT  ' +char(13)+
            '_FACT_SPVisiSag_Step2.visiid, _FACT_SPVisiSag_Step2.SAGSID, _FACT_SPVisiSag_Step2.SYGEPLEJE_STATUS, ' +char(13)+ 
			'_FACT_SPVisiSag_Step2.SYGEPLEJE_STATUSID, _FACT_SPVisiSag_Step2.SYGEPLEJE_GRUPPEID as organization,  ' +char(13)+
			'_FACT_SPVisiSag_Step2.SYPL_AFTENGRP_ID, _FACT_SPVisiSag_Step2.SYPL_NATGRP_ID, ' +char(13)+
			'_FACT_SPVisiSag_Step2.HJPL_DAGGRP_ID,_FACT_SPVisiSag_Step2.HJPL_AFTENGRP_ID,_FACT_SPVisiSag_Step2.HJPL_NATGRP_ID, ' +char(13)+			
			'_FACT_SPVisiSag_Step2.dogninddeling, _FACT_SPVisiSag_Step2.slut,_FACT_SPVisiSag_Step2.Slut as dato,   ' +char(13)+
		    '_FACT_SPVisiSag_Step2.slut, _FACT_SPVisiSag_Step2.type, _SPvisiJobDogninddelingJobType.JOBID, ' +
		    '_SPvisiJobDogninddelingJobType.ID,  ' +char(13)+
            'case when _SPvisiJobDogninddelingJobType.HYPPIGHED = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * - 1) /60.0) * 7.0 * YD_GANGE) ' +char(13)+
			'when _SPvisiJobDogninddelingJobType.HYPPIGHED = 1 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * -1) /60.0) * YD_GANGE) ' +char(13)+
			'when _SPvisiJobDogninddelingJobType.HYPPIGHED = 2 then (((coalesce( JOBPRISER.INT_DAG,0) * NORMTIDJobType * -1) /60.0) / YD_GANGE) ' +char(13)+
			'end as Pris,jobpriser.startdato as pstart,jobpriser.slutdato as pslut, 3 AS specifikation, ' +char(13)+
			'case   when _SPvisiJobDogninddelingJobType.HYPPIGHED = 2 then ((_SPvisiJobDogninddelingJobType.NormTid/YD_GANGE)*-1)  ' +char(13)+
			'when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 1 then ((_SPvisiJobDogninddelingJobType.NormTid*YD_GANGE)*-1)  ' +char(13)+
			'when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_SPvisiJobDogninddelingJobType.NormTid*YD_GANGE)*-1*7) ' +char(13)+
			'end as SPVISIJOB, ' +char(13)+
			
			--Hverdag
			'case '  +char(13)+
			'  when _SPvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_SPvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1) ' +char(13)+
			'  when _SPvisiJobDogninddelingJobType.HYPPIGHED = 1 then ' +char(13)+
			'    case when _SPvisiJobDogninddelingJobType.YD_WEEKEND is null then ((_SPvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1)/5 ' +char(13)+
			'    else ' +char(13)+
			'    ((_SPvisiJobDogninddelingJobType.NormTid*(YD_GANGE-YD_WEEKEND)*Personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when _SPvisiJobDogninddelingJobType.HYPPIGHED = 2 then ' +char(13)+
			'    case when _SPvisiJobDogninddelingJobType.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_SPvisiJobDogninddelingJobType.NormTid/YD_GANGE*personer)*-1)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as SPVISIJOBHverdag, ' +char(13)+				
			
			--Weekend
			'case '  +char(13)+
			'  when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 0 then ((_SPvisiJobDogninddelingJobType.NormTid*YD_GANGE*Personer)*-1) ' +char(13)+
			'  when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 1 then ' +char(13)+
			'    case when _SPvisiJobDogninddelingJobType.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_SPvisiJobDogninddelingJobType.NormTid*YD_WEEKEND*Personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'  when _SPvisiJobDogninddelingJobType.HYPPIGHED = 2 then ' +char(13)+
			'    case when _SPvisiJobDogninddelingJobType.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    ((_SPvisiJobDogninddelingJobType.NormTid/YD_WEEKEND*personer)*-1)/2 ' +char(13)+
			'    end ' +char(13)+			
			'end as SPVISIJOBWeekend, ' +char(13)+					
					
			'case   when _SPvisiJobDogninddelingJobType.HYPPIGHED = 2 then (1/YD_GANGE)*-1  ' +char(13)+
			'when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 1 then (YD_GANGE*-1)  ' +char(13)+
			'when  _SPvisiJobDogninddelingJobType.HYPPIGHED = 0 then (YD_GANGE)*-1*7 ' +char(13)+
			'end as SPVISIJOBAntal,' +char(13)+	
			' _SPvisiJobDogninddelingJobType.FRITVALGLEV, ' +char(13)+		
			' _SPvisiJobDogninddelingJobType.LEVERANDOERNAVN ' +char(13)+
			'FROM  _SPvisiJobDogninddelingJobType LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON _SPvisiJobDogninddelingJobType.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
            '_FACT_SPVisiSag_Step2 ON _SPvisiJobDogninddelingJobType.dogninddeling = _FACT_SPVisiSag_Step2.dogninddeling  ' +char(13)+
			'AND _SPvisiJobDogninddelingJobType.SPVISIID = _FACT_SPVisiSag_Step2.visiid '  +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)
			
if @debug = 1 print @cmd
exec (@cmd)

------------------------------------------------------------------------------------------------------------
--8.Laver SPVISIJOB																  ( usp_Create_FactTables_SP)
------------------------------------------------------------------------------------------------------------
print '-----------------------------------------------------------------------------------------------------'
print '8.Laver SPVISIJOB														  ( usp_Create_FactTables_SP) '
print ''



set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job'', '''+@DestinationDB+''',''SPVISIJOB'''
if @debug = 1 print @cmd
exec (@cmd)


/*
set @cmd = 	'SELECT _FACT_SPVisiSag_Step2.SAGSID, _FACT_SPVisiSag_Step2.start AS dato, _FACT_SPVisiSag_Step2.SYGEPLEJE_STATUS, ' +char(13)+
			'_FACT_SPVisiSag_Step2.SYGEPLEJE_STATUSID, _FACT_SPVisiSag_Step2.SYGEPLEJE_GRUPPEID AS organization, ' +char(13)+
			'_FACT_SPVisiSag_Step2.dogninddeling,  2 AS specifikation, 1 AS count, ' +char(13)+
'case   when SPVISIJOB.HYPPIGHED = 2 and yd_gange <> 0 then (SPVISIJOB.NormTid/YD_GANGE)  ' +char(13)+
			'when  SPVISIJOB.HYPPIGHED = 1 then (SPVISIJOB.NormTid*YD_GANGE)  ' +char(13)+
			'when  SPVISIJOB.HYPPIGHED = 0 then (SPVISIJOB.NormTid*YD_GANGE*7) ' +char(13)+
			'end as SPVISI, SPVISIJOB.JOBID, _FACT_SPVisiSag_Step2.start, _FACT_SPVisiSag_Step2.slut, ' +char(13)+
			'case when SPVISIJOB.HYPPIGHED = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)) /60.0) * 7.0 * (YD_GANGE * 1.0)) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 1 and yd_gange <> 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)) /60.0) / (YD_GANGE * 1.0)) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 1 and yd_gange = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)) /60.0) / 1.0) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 2 and yd_gange <> 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)) /60.0) / (YD_GANGE * 1.0))  ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 2 and yd_gange = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)) /60.0) / 1.0) end as Pris  ' +char(13)+
			',coalesce( FRITVALGLEV,8888) as FRITVALGLEV ' +char(13)+
			'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job ' +char(13)+
			'FROM  JOBTYPER RIGHT OUTER JOIN ' +char(13)+
						   'JOBPRISER ON JOBTYPER.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
						   'SPVISIJOB ON JOBPRISER.JOBID = SPVISIJOB.JOBID RIGHT OUTER JOIN ' +char(13)+
						   '_FACT_SPVisiSag_Step2 ON SPVISIJOB.SPVISIID = _FACT_SPVisiSag_Step2.visiid ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID AS organization,  ' +char(13)+
			'dogninddeling, 3 AS specifikation, - 1 AS count,  case   when SPVISIJOB.HYPPIGHED = 2 and yd_gange <> 0 then (SPVISIJOB.NormTid/YD_GANGE) *-1 ' +char(13)+
			'when  SPVISIJOB.HYPPIGHED = 1 then (SPVISIJOB.NormTid*YD_GANGE) *-1 ' +char(13)+
			'when  SPVISIJOB.HYPPIGHED = 0 then (SPVISIJOB.NormTid*YD_GANGE*7) * - 1 ' +char(13)+
			'end as SPVISI,SPVISIJOB.JOBID,start, slut, ' +char(13)+
			'case when SPVISIJOB.HYPPIGHED = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)* - 1) /60.0) * 7.0 * (YD_GANGE * 1.0)) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 1 and yd_gange <> 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)* - 1) /60.0) / (YD_GANGE * 1.0)) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 1 and yd_gange = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)* - 1) /60.0) / 1.0) ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 2 and yd_gange <> 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)* - 1) /60.0) / (YD_GANGE * 1.0))  ' +char(13)+
			'when SPVISIJOB.HYPPIGHED = 2 and yd_gange = 0 then (((coalesce( JOBPRISER.INT_DAG,0) * coalesce(JOBTYPER.NormTid1,1)* - 1) /60.0) / 1.0) end as Pris ' +char(13)+
			',coalesce( FRITVALGLEV,8888) as FRITVALGLEV ' +char(13)+
			'FROM  JOBTYPER RIGHT OUTER JOIN ' +char(13)+
						   'JOBPRISER ON JOBTYPER.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
						   'SPVISIJOB ON JOBPRISER.JOBID = SPVISIJOB.JOBID RIGHT OUTER JOIN ' +char(13)+
						   '_FACT_SPVisiSag_Step2 ON SPVISIJOB.SPVISIID = _FACT_SPVisiSag_Step2.visiid ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999))  ' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job'', '''+@DestinationDB+''',''SPVISI'''
if @debug = 1 print @cmd
exec (@cmd)
--End

*/
--laver _FACT_SPVisiSag_Step 3
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +''' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +''
if @debug = 1 print @cmd
exec (@cmd)
set @cmd =  'SELECT SagsID ' +char(13)+
            ',start AS Dato ' +char(13)+
            ',SygePleje_Status ' +char(13)+
            ',SygePleje_StatusID ' +char(13)+
			',SYGEPLEJE_GruppeID AS organization' +char(13)+
			', dogninddeling ' +char(13)+
			', 2 AS specifikation' +char(13)+
			', 1 AS count ' +char(13)+
			',cast(SPVISI / 7.0 as float) as SPVISI' +char(13)+
			',Start' +char(13)+
			',Slut' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +' ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_step2 ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato' +char(13)+
			',SYGEPLEJE_STATUS' +char(13)+
			',SYGEPLEJE_STATUSID' +char(13)+
			',SYGEPLEJE_GRUPPEID AS organization' +char(13)+
			',dogninddeling' +char(13)+
			', 3 AS specifikation' +char(13)+
			', - 1 AS count' +char(13)+
			', cast((SPVISI * - 1) / 7.0 as float) AS Expr1' +char(13)+
			',start' +char(13)+
			', slut ' +char(13)+
			'FROM  dbo._FACT_SPVisiSag_step2 AS VisiSag_step2_1 ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'usp_Birthddays '''+@tablePrefix +''', '''+@DestinationDB+''',''SPVISI'''
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_SPVisiSag_Step3' AND type = 'U') DROP TABLE _FACT_SPVisiSag_Step3


set @cmd = 'SELECT [SagsID]' +char(13)+
      ',[Sagikraft]' +char(13)+
      ',[Sagslut]' +char(13)+
      ',[SygePleje_Status]' +char(13)+
      ',[SygePleje_STATUSID]' +char(13)+
      ',[SygePleje_GRUPPEID]' +char(13)+
      ',[Dogninddeling]' +char(13)+
      ',[Visiikraft]' +char(13)+
      ',[Visislut]' +char(13)+
     ' ,[Visiid]' +char(13)+
    '  ,[Start]' +char(13)+
     ' ,[Slut]' +char(13)+
     ' ,[SPVISI]' +char(13)+
     ' ,[type]' +char(13)+
  'into [_FACT_SPVisiSag_Step3]' +char(13)+
  'FROM [_FACT_SPVisiSag_Step2]' +char(13)+
  'group by [SAGSID]' +char(13)+
    '  ,[sagikraft]' +char(13)+
    '  ,[sagslut]' +char(13)+
    '  ,[SYGEPLEJE_STATUS]' +char(13)+
    '  ,[SYGEPLEJE_STATUSID]' +char(13)+
    '  ,[SYGEPLEJE_GRUPPEID]' +char(13)+
    '  ,[dogninddeling]' +char(13)+
    '  ,[visiikraft]' +char(13)+
    '  ,[visislut]' +char(13)+
     ' ,[visiid]' +char(13)+
     ' ,[start]' +char(13)+
   '   ,[slut]' +char(13)+
   '   ,[SPVISI]' +char(13)+
     ' ,[type]' +char(13)
     
     if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'_pakker'' AND type = ''U'')
            DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'_pakker'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Select      a.SagsID,'								+char(13)+
            '			a.Sagikraft,'							+char(13)+
            '			a.sagslut, '							+char(13)+
            '           a.SygePleje_Status,'					+char(13)+
            '			a.SygePleje_StatusID, '					+char(13)+
            '           a.SygePleje_GruppeID as Organization,'  +char(13)+
            '			a.dogninddeling, a.visiikraft, '		+char(13)+
            '           a.visislut,a.visiid, a.start, a.slut, ' +char(13)+
            '           a.SPVISI, a.type, b.Pakke_Visitype, '	+char(13)+
            '           b.Pakke_Ugentlig_Leveret,'				+char(13)+
            '			b.Pakke_ID,'							+char(13)+
            '			b.Pakke_Lev_ID,'						+char(13)+
            '			2 as specifikation,'					+char(13)+
            '			a.start as dato'						+char(13)+
'Into '+@DestinationDB+'.dbo.'+@tablePrefix +'_Pakker '			+char(13)+
'From         _FACT_SPVisiSag_Step3 a '							+char(13)+
'             inner join  '										+char(13)+
'             VISI_PAKKER_BEREGN b  '							+char(13)+
'			 ON a.visiid = b.Pakke_Visi_ID '					+char(13)+
'Union all  '													+char(13)+
  'Select				a.SagsID,'								+char(13)+
            '			a.sagikraft, '							+char(13)+
            '			a.sagslut,	'							+char(13)+
            '           a.SygePleje_Status,'					+char(13)+
            '			a.SygePleje_StatusID, '					+char(13)+
            '           a.SygePleje_GruppeID as Organization,'	+char(13)+
            '		    a.dogninddeling,'						+char(13)+
            '		    a.visiikraft, '							+char(13)+
             '          a.visislut,'							+char(13)+
            '			a.visiid,'								+char(13)+
            '		    a.start,'								+char(13)+
            '			a.slut, '								+char(13)+
            '           a.SPVISI,'								+char(13)+
            '			a.type,'								+char(13)+
            '			b.Pakke_Visitype, '						+char(13)+
            '           b.Pakke_Ugentlig_Leveret,'				+char(13)+
            '			b.Pakke_ID,'							+char(13)+
            '			b.Pakke_Lev_ID,'						+char(13)+
            '			3 as specifikation,'					+char(13)+
            '			a.Slut as dato'							+char(13)+
'From       _FACT_SPVisiSag_Step3  a '							+char(13)+
'            inner join   '										+char(13)+
'           VISI_PAKKER_BEREGN  b'								+char(13)+
'           ON a.visiid = b.Pakke_Visi_ID      '   				+char(13)

if @debug = 1 print @cmd
exec (@cmd)          


set @cmd = 'usp_Birthddays '''+@tablePrefix +'_pakker'', '''+@DestinationDB+''',''Pakke_Ugentlig_Leveret'''
if @debug = 1 print @cmd
exec (@cmd)      

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=11)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (11,GETDATE())           
end

/*
--lav sag
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_SPVisiJob_Step1' AND type = 'U') DROP TABLE _FACT_SPVisijob_Step1
set @cmd = 'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 1 AS dogninddeling, PARAGRAF, YD_MORGEN AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge' +char(13)+
			'into _FACT_SPVisiJob_Step1 ' +char(13)+
			'FROM  dbo.SPVISIJOB ' +char(13)+
			'WHERE (YD_MORGEN = 1) AND (SPVISIID IN (SELECT ID FROM   dbo.SPVISITATION)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 2 AS dogninddeling, PARAGRAF, YD_FORMIDDAG AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_11 ' +char(13)+
			'WHERE (YD_FORMIDDAG = 1) AND (SPVISIID IN  (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_11)) AND (HYPPIGHED = 0)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 3 AS dogninddeling, PARAGRAF, YD_MIDDAG AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_10	WHERE (YD_MIDDAG = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_10)) AND (HYPPIGHED = 0)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 4 AS dogninddeling, PARAGRAF, YD_EFTERMIDDAG AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_9  WHERE (YD_EFTERMIDDAG = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_9)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 5 AS dogninddeling, PARAGRAF, YD_AFTEN1 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_8)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 6 AS dogninddeling, PARAGRAF, YD_AFTEN2 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_7	WHERE (YD_AFTEN2 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_7)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 7 AS dogninddeling, PARAGRAF, YD_AFTEN3 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_6	WHERE (YD_AFTEN3 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_6)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 8 AS dogninddeling, PARAGRAF, YD_AFTEN4 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_5	WHERE (YD_AFTEN4 = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_5)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 9 AS dogninddeling, PARAGRAF, YD_NAT1 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_4	WHERE (YD_NAT1 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_4)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 10 AS dogninddeling, PARAGRAF, YD_NAT2 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_3	WHERE (YD_NAT2 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_3)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 11 AS dogninddeling, PARAGRAF, YD_NAT3 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_2 WHERE (YD_NAT3 = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_2)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 12 AS dogninddeling, PARAGRAF, YD_NAT4 AS SPVISIJOB, NORMTID * 7 * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_1	WHERE (YD_NAT4 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_1)) AND (HYPPIGHED = 0) ' 

print len(@cmd)
if @debug = 1 print @cmd
exec (@cmd)
			 
set @cmd	='insert into _FACT_SPVisiJob_Step1 ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 1 AS dogninddeling, PARAGRAF, YD_MORGEN AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_13 WHERE (YD_MORGEN = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_13)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 2 AS dogninddeling, PARAGRAF, YD_FORMIDDAG AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_11  ' +char(13)+
			'WHERE (YD_FORMIDDAG = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_11)) AND (HYPPIGHED = 1)  ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 3 AS dogninddeling, PARAGRAF, YD_MIDDAG AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_10 WHERE (YD_MIDDAG = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_10)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 4 AS dogninddeling, PARAGRAF, YD_EFTERMIDDAG AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_9	WHERE (YD_EFTERMIDDAG = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_9)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 5 AS dogninddeling, PARAGRAF, YD_AFTEN1 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_8)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 6 AS dogninddeling, PARAGRAF, YD_AFTEN2 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_7 WHERE (YD_AFTEN2 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_7)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 7 AS dogninddeling, PARAGRAF, YD_AFTEN3 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_6 WHERE (YD_AFTEN3 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_6)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 8 AS dogninddeling, PARAGRAF, YD_AFTEN4 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_5 WHERE (YD_AFTEN4 = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_5)) AND (HYPPIGHED = 1)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 9 AS dogninddeling, PARAGRAF, YD_NAT1 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_4 WHERE (YD_NAT1 = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_4)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 10 AS dogninddeling, PARAGRAF, YD_NAT2 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_3  ' +char(13)+
			'WHERE (YD_NAT2 = 1) AND (SPVISIID IN  (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_3)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 11 AS dogninddeling, PARAGRAF, YD_NAT3 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_2  ' +char(13)+
			'WHERE (YD_NAT3 = 1) AND (SPVISIID IN (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_2)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 12 AS dogninddeling, PARAGRAF, YD_NAT4 AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_1 WHERE (YD_NAT4 = 1) AND (SPVISIID IN (SELECT ID	FROM   dbo.SPVISITATION AS SPVISITATION_1)) AND (HYPPIGHED = 1) '  
print len(@cmd)
if @debug = 1 print @cmd
exec (@cmd)			 
			
set @cmd 	='insert into _FACT_SPVisiJob_Step1 ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 1 AS dogninddeling, PARAGRAF, YD_MORGEN AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_12 WHERE (YD_MORGEN = 1) AND (SPVISIID IN (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_12))  ' +char(13)+
			'AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 2 AS dogninddeling, PARAGRAF, YD_FORMIDDAG AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_11 WHERE (YD_FORMIDDAG = 1) AND (SPVISIID IN (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_11))  ' +char(13)+
			'AND (HYPPIGHED = 2) AND (YD_GANGE <> 0)  ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 3 AS dogninddeling, PARAGRAF, YD_MIDDAG AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_10  ' +char(13)+
			'WHERE (YD_MIDDAG = 1) AND (SPVISIID IN (SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_10)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 4 AS dogninddeling, PARAGRAF, YD_EFTERMIDDAG AS SPVISIJOB, NORMTID * YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_9 WHERE (YD_EFTERMIDDAG = 1) AND (SPVISIID IN (SELECT ID  ' +char(13)+
			'FROM   dbo.SPVISITATION AS SPVISITATION_9)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 5 AS dogninddeling, PARAGRAF, YD_AFTEN1 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (SPVISIID IN  ' +char(13)+
		    '(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_8)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 6 AS dogninddeling, PARAGRAF, YD_AFTEN2 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_7 WHERE (YD_AFTEN2 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_7)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 7 AS dogninddeling, PARAGRAF, YD_AFTEN3 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge  ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_6 WHERE (YD_AFTEN3 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_6)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 8 AS dogninddeling, PARAGRAF, YD_AFTEN4 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_5 WHERE (YD_AFTEN4 = 1) AND (SPVISIID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_5)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 9 AS dogninddeling, PARAGRAF, YD_NAT1 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_4 WHERE (YD_NAT1 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_4)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 10 AS dogninddeling, PARAGRAF, YD_NAT2 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_3 WHERE (YD_NAT2 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_3)) AND (HYPPIGHED = 2)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 11 AS dogninddeling, PARAGRAF, YD_NAT3 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_2 WHERE (YD_NAT3 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_2)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, SPVISIID, JOBID, HYPPIGHED, 12 AS dogninddeling, PARAGRAF, YD_NAT4 AS SPVISIJOB, NORMTID / YD_GANGE * PERSONER AS NormtidUge ' +char(13)+
			'FROM  dbo.SPVISIJOB AS SPVISIJOB_1	WHERE (YD_NAT4 = 1) AND (SPVISIID IN ' +char(13)+
			'(SELECT ID FROM   dbo.SPVISITATION AS SPVISITATION_1)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' 
print len(@cmd)
if @debug = 1 print @cmd
exec (@cmd)
*/
