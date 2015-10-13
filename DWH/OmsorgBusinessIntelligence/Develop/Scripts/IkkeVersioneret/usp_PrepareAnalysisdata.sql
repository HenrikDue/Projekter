USE [AvaleoAnalytics_Staging_Clean]
GO

/****** Object:  StoredProcedure [dbo].[usp_PrepareAnalysisdata]    Script Date: 11/16/2010 08:22:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--1. kopier tabeller over i DestDB
--2.Lav dimensioner
--3.Lav Time_Dimension 
--4.Lav facttabeller SP 
--5.Lav facttabeller HJ
--6.Lav facttabeller TP 
--7.Lav facttabeller MAD -
--8.Lav SagsPlanMedArbejder facttable
--09.Lav dim_time ekstra

--10.Lav Fact_Jobpriser 
--11.Lav Fact_Jobpriser med dato
--12.Lav Lav FactVisisagjobAfregnet_TilAfgang

--13.Lav FACT_VISISAGJOB_Afregnet_udenJobpriser
--14.Lav FACT_VISISAGJOB_Afregnet
--15.Lav FACTVISISAGJobAfregnet - Sæt PakkeID ind
--16.Lav FACTVISISAGJobAfregnet_Pakker
--17.Lav FACT_FRAVAER_UNIQOMSORG
--18.Clean Up job
--19.Bolig


CREATE PROCEDURE [dbo].[usp_PrepareAnalysisdata]
		@DestinationDB as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS
--- [usp_PrepareAnalysisdata] pgedw
---DECLARE @DestinationDB as varchar(200)
DECLARE @cmd as varchar(max)
DECLARE @StartDate as datetime
DECLARE @EndDate as datetime
DECLARE @Debugcmd as nvarchar(4000)
DECLARE @DestDB as varchar(200)
set @DestDB = @DestinationDB
--set @DestinationDB = 'SeniorService'


-----------------------------------------------------------------------------------------------------
--1. kopier tabeller over i DestDB
-----------------------------------------------------------------------------------------------------
if (@ExPart=1 or @ExPart=0  or (@ExPart>100 and @ExPart<=101))
begin

print '---------------------------------------------------------------------------------------------'
print '1. kopier tabeller over i DestDB'
print ''
--Sagsstatus
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''SAGSSTATUS'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.SAGSSTATUS'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.SAGSSTATUS from SAGSSTATUS'
	if @debug = 1 print @cmd
	exec (@cmd)
	
-----------------------------------------------------------------------------------------------------
--SAGSTYPE
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''SAGSTYPE'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.SAGSTYPE'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.SAGSTYPE from SAGSTYPE'
	if @debug = 1 print @cmd
	exec (@cmd)
	
	--JOBTYPER
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''JOBTYPER'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.JOBTYPER'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.JOBTYPER from DIM_JOBTYPER'
	if @debug = 1 print @cmd
	exec (@cmd)	

	--MEDARBEJDERE
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''MEDARBEJDERE'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.MEDARBEJDERE'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.MEDARBEJDERE from MEDARBEJDERE'
	if @debug = 1 print @cmd
	exec (@cmd)	

	--MEDHISTORIK
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''MEDHISTORIK'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.MEDHISTORIK'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.MEDHISTORIK from MEDHISTORIK'
	if @debug = 1 print @cmd
	exec (@cmd)	

	--MEDSTATUS
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''MEDSTATUS'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.MEDSTATUS'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.MEDSTATUS from MEDSTATUS'
	if @debug = 1 print @cmd
	exec (@cmd)

    --MEDSTATUS
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''STILLINGBET'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.STILLINGBET'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.STILLINGBET from STILLINGBET'
	if @debug = 1 print @cmd
	exec (@cmd)
	
	  --BESOGSTATUS
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Dim_besogsstatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Dim_besogsstatus'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.Dim_besogsstatus from BESOGSTATUS'
	if @debug = 1 print @cmd
	exec (@cmd)

	  --BESOGSTATUS
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBesoegKval'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBesoegKval'
	if @debug = 1 print @cmd
	exec (@cmd)
--	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.DimBesoegKval from BESOEG_KVAL'
	set @cmd = 'create table '+ @DestinationDB +'.dbo.DimBesoegKval (Besoeg_KvalId int not null, Kval_Bet nvarchar(50) not null)'
	if @debug = 1 print @cmd
	exec (@cmd)
end --Part 1. 

-----------------------------------------------------------------------------------------------------
--2.Lav dimensioner
-----------------------------------------------------------------------------------------------------
if (@ExPart=2 or @ExPart=0  or (@ExPart>100 and @ExPart<=102))
begin
print '---------------------------------------------------------------------------------------------'
print '2.Lav dimensioner'
print ''
 
 set @cmd = 'exec usp_Create_Dimensions ''' + @DestinationDB + ''''
 if @debug = 1 print @cmd
exec (@cmd)
end -- end part 2

----------------------------------------------------------------------------------------------------
--3.Lav Time_Dimension 
-----------------------------------------------------------------------------------------------------
if (@ExPart=3 or @ExPart=0  or (@ExPart>100 and @ExPart<=102))
begin 
print '---------------------------------------------------------------------------------------------'
print '3.Lav Time dimension'
print ''
set @cmd = 'exec usp_Create_Time_Dimension ''' + @DestinationDB + ''',''2002-01-01'',''2015-12-31'''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''[Dim_Time]'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.[Dim_Time]'
set @cmd= 'Select * into ' + + @DestinationDB + '.dbo.[Dim_Time] from [Dim_time]'
end

----------------------------------------------------------------------------------------------------
--4.Lav facttabeller SP
-----------------------------------------------------------------------------------------------------
if (@ExPart=4 or @ExPart=0  or (@ExPart>100 and @ExPart<=104))
begin

print '---------------------------------------------------------------------------------------------'
print '4.Lav facttabeller SP'
print '' 


set @cmd = 'exec usp_Create_FactTables_SP ''' + @DestinationDB + ''',0,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'exec usp_Create_FactTables_SP ''' + @DestinationDB + ''',1,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

end  -- end part 4

----------------------------------------------------------------------------------------------------
--5.Lav facttabeller HJ
-----------------------------------------------------------------------------------------------------
if (@ExPart=5 or @ExPart=0  or (@ExPart>100 and @ExPart<=105))
begin
print '---------------------------------------------------------------------------------------------'
print '5.Lav facttabeller HJ'
print ''



set @cmd = 'exec usp_Create_FactTables_HJ ''' + @DestinationDB + ''',0,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'exec usp_Create_FactTables_HJ ''' + @DestinationDB + ''',1,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

end 
----------------------------------------------------------------------------------------------------
--6.Lav facttabeller TP
-----------------------------------------------------------------------------------------------------
if (@ExPart=6 or @ExPart=0  or (@ExPart>100 and @ExPart<=106))
begin
print '---------------------------------------------------------------------------------------------'
print '6.Lav facttabeller TP'
print ''

set @cmd = 'exec usp_Create_FactTables_TP ''' + @DestinationDB + ''',0,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'exec usp_Create_FactTables_TP ''' + @DestinationDB + ''',1,'+CAST(@debug as nvarchar(1))
if @debug = 1 print @cmd
exec (@cmd)

end
--------------------------------------------------------------------------------------------------
--7.Lav facttabeller MAD
-----------------------------------------------------------------------------------------------------
if (@ExPart=7 or @ExPart=0  or (@ExPart>100 and @ExPart<=107))
begin
set @cmd = 'exec usp_Create_FactTables_MAD ''' + @DestinationDB + ''',0'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'exec usp_Create_FactTables_MAD ''' + @DestinationDB + ''',1'
if @debug = 1 print @cmd
exec (@cmd)
end -- end part 7
--------------------------------------------------------------------------------------------------
--8.Lav SagsPlanMedArbejder facttable
-----------------------------------------------------------------------------------------------------
if (@ExPart=8 or @ExPart=0  or (@ExPart>100 and @ExPart<=108))
begin
print '---------------------------------------------------------------------------------------------'
print '8.Lav SagsPlanMedArbejder facttable'
print ''
--
set @cmd = 'exec usp_Create_FactTables_SagsPlan ''' + @DestinationDB + ''''
if @debug = 1 print @cmd
exec (@cmd)

end
--------------------------------------------------------------------------------------------------
--9.Lav dim_time ekstra
-----------------------------------------------------------------------------------------------------
if (@ExPart=9 or @ExPart=0  or (@ExPart>100 and @ExPart<=109))
begin
print '---------------------------------------------------------------------------------------------'
print '9.Lav dim_time ekstra'
print ''

-- Der er ingen grund til at lave tidsdimensionen flere gange
--set @cmd = 'Select * into '+@DestinationDB+'.DBO.DIM_TIME from Dim_Time'
--set @cmd = 'insert into '+@DestinationDB+'.dbo.dim_time (pk_date) values (''01-01-9999 00:00:00'')'
--if @debug = 1 print @cmd
--exec (@cmd)
--insert into dim_time (pk_date) values ('01-01-9999 00:00:00')

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'tmp' AND type = 'U') DROP TABLE tmp
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmpTableDef' AND type = 'U') DROP TABLE _tmpTableDef


end
--------------------------------------------------------------------------------------------------
--10.Lav Fact_Jobpriser 
-----------------------------------------------------------------------------------------------------
if (@ExPart=10 or @ExPart=0  or (@ExPart>100 and @ExPart<=110))
begin
print '---------------------------------------------------------------------------------------------'
print '10.Lav Fact_Jobpriser'
print ''
  --Fact_Jobpriser (forudsætning for Fact_jobpriser med dato)
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactJobpriser'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactJobpriser'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.FactJobpriser from Fact_Jobpriser'
	if @debug = 1 print @cmd
	exec (@cmd)
end
--------------------------------------------------------------------------------------------------
--11.Lav Fact_Jobpriser med dato
-----------------------------------------------------------------------------------------------------
if (@ExPart=11 or @ExPart=0 or (@ExPart between 101 and 111))
begin
print '---------------------------------------------------------------------------------------------'
print '11.Lav Fact_Jobpriser med dato'
print ''
	  
	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactJobpriserDato'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactJobpriserDato'
	if @debug = 1 print @cmd
	exec (@cmd)
	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.FactJobpriserDato from Fact_Jobpriser_dato'
	if @debug = 1 print @cmd
	exec (@cmd)
end
--------------------------------------------------------------------------------------------------
--12.Lav FactVisisagjobAfregnet_TilAfgang                          - samler hj sp tr
--------------------------------------------------------------------------------------------------
if (@ExPart=12 or @ExPart=0 or (@ExPart>100 and @ExPart<=112))
begin

print '---------------------------------------------------------------------------------------------'
print '12.Lav FactVisisagjobAfregnet_TilAfgang'
print ''


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactVisisagjobAfregnet_TilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVisisagjobAfregnet_TilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd =	'Select		' +char(13)+
			'Alder,		' +char(13)+
		    'CPRNR,		'+char(13)+
		    'SagsID,	'+char(13)+
		    'Dato,		'+char(13)+
		    'HjemmePleje_Status,'+char(13)+
		    'HjemmePleje_StatusID,'+char(13)+
		    'Organization, '+char(13)+
			'HJPL_AFTENGRP_ID, ' +char(13)+ 
			'HJPL_NATGRP_ID, ' +char(13)+ 			
			'SYPL_DAGGRP_ID, ' +char(13)+ 
            'SYPL_AFTENGRP_ID, ' +char(13)+
            'SYPL_NATGRP_ID, ' +char(13)+				    
		    'Dogninddeling,  ' +char(13)+
		    'Hjalptype, ' +char(13)+  --HDJ
			'Specifikation,'+char(13)+
			'HJvisiJob as VisiJob, '+char(13)+
			'HJVISIJOBHverdag as VisijobHverdag, ' +char(13)+
			'HJVISIJOBWeekend as VisijobWeekend, ' +char(13)+
			'a.Jobid,'+char(13)+
			'case Pris ' +char(13)+
			'  when 0 then null ' +char(13)+
			'  else Pris ' +char(13)+
			'end as Pris,'+char(13)+
			'coalesce(pstart,Convert(DATETIME, ''2007-01-01 00:00:00'', 102)) as PrisStart,'+char(13)+
			'coalesce(pslut,Convert(DATETIME, ''9999-01-01 00:00:00'', 102))  as PrisSlut,'+char(13)+
			'Fritvalglev, ' +char(13)+
			'LEVERANDOERNAVN, ' +char(13)+
			'CASE WHEN FRITVALGLEV = 8888 THEN' +char(13)+  /*leverandør er kommune(standard)*/
			'  CASE ' +char(13)+ 
			'    WHEN Dogninddeling in (1,2,3,4) THEN Organization '+char(13)+    /*afhængig af tidpunkt på døgn, sættes hjemmeplejegrp*/
			'    WHEN Dogninddeling in (5,6,7,8) THEN HJPL_AFTENGRP_ID '+char(13)+  /*til at være leverandør på indsatse*/
			'    WHEN Dogninddeling in (9,10,11,12) THEN HJPL_NATGRP_ID '+char(13)+
			'  ELSE 5555 ' +char(13)+   /*5555 = gruppe ikke tildelt - medarb dimension*/
			'  END ' +char(13)+	
			'ELSE '+char(13)+  		
			'  CASE WHEN LEVERANDOERNAVN = ''Kommunal sygepleje'' THEN ' +char(13)+ /*er leverandør intern(kommunal)?*/
			'    CASE ' +char(13)+ 
			'      WHEN Dogninddeling in (1,2,3,4) THEN SYPL_DAGGRP_ID '+char(13)+    /*afhængig af tidpunkt på døgn, sættes sygeplejegrp*/
			'      WHEN Dogninddeling in (5,6,7,8) THEN SYPL_AFTENGRP_ID '+char(13)+  /*til at være leverandør på indsatse*/
			'      WHEN Dogninddeling in (9,10,11,12) THEN SYPL_NATGRP_ID '+char(13)+
			'    ELSE 5555 ' +char(13)+   /*5555 = gruppe ikke tildelt - medarb dimension*/
			'    END ' +char(13)+			
			'  ELSE 5555 '+char(13)+
			'  END ' +char(13)+			
			'END AS INTERNLEVERANDOERID, '+char(13)+	
			'Start as BorgerStart, '+char(13)+
			'Slut as BorgerSlut, ' +char(13)+
			'NormTid1 as NormTid,'+char(13)+
			'case b.NormTid1 '+char(13)+
			'  when null THEN NULL '+char(13)+
			'  when 0 then null '+char(13)+
			'  ELSE  Convert(float,hjVISIJOB) / convert (float,b.NormTid1) '+char(13)+
			'end as Antal_Pakker,' +char(13)+
			'Convert(decimal(18,10), HJVISIJOBAntal)   as Antal,' +char(13)+
			'ViSiID   as ViSiID' +char(13)+
			'into '+@DestinationDB+'.dbo.FactVisisagjobAfregnet_TilAfgang  ' +char(13)+
			'FROM '+@DestinationDB+'.dbo.FACT_HJVisiSag_AfregnetJob_PBPP a' +char(13)+
			'LEFT OUTER JOIN ' +char(13)+
			'dbo.JOBTYPER  b ' +char(13)+
			'ON a.JOBID = b.JOBID' +char(13)+
			-------------------------------------------------------------------------------------------------------------------
			----- Mad 
			'UNION ALL			' +char(13)+
			'SELECT Alder,		' +char(13)+
			'CPRNR,				' +char(13)+
			'SAGSID,			' +char(13)+
			'Dato,				' +char(13)+
			'MADVISI_STATUS,	' +char(13)+
			'MADVISI_STATUSID,	' +char(13)+
			'Organization,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'Dogninddeling,		' +char(13)+
			'0 as Hjalptype,    ' +char(13)+  --HDJ
			'Specifikation,		' +char(13)+
			'Madleverancer,		' +char(13)+
			'MadleverancerHverdag as VisijobHverdag, ' +char(13)+
			'MadleverancerWeekend as VisijobWeekend, ' +char(13)+			
			'a.JOBID,			' +char(13)+
			'case Pris			' +char(13)+
			'  when 0 then null	' +char(13)+
			'  else pris		' +char(13)+
			'end as PRIS,		' +char(13)+
			'coalesce(pstart,Convert(DATETIME, ''2007-01-01 00:00:00'', 102)) as Prisstart,' +char(13)+
			'coalesce(pslut,Convert(DATETIME, ''9999-01-01 00:00:00'', 102)) as prisslut,  ' +char(13)+
			'FRITVALGLEV,		' +char(13)+
			'null as LEVERANDOERNAVN, ' +char(13)+
			'5555 as InternLeverandoerID, ' +char(13)+
			'start as BorgerStart,'+char(13)+
			'slut as BorgerSlut ' +char(13)+
			',NormTid1 as NormTid,' +char(13)+
			'Madleverancer as ANTAL_PAKKER,' +char(13)+
		    '0   as Antal,' +char(13)+
		    '0   as VisiID' +char(13)+
			'FROM  '+@DestinationDB+'.dbo.FACT_MADVisiSag_AfregnetJob a		' +char(13)+
			' LEFT OUTER JOIN												' +char(13)+
			'                         dbo.JOBTYPER b ON a.JOBID = b.JOBID	' +char(13)+
			'UNION ALL ' +char(13)+
			-------------------------------------------------------------------------------------------------
			----- Træning 
			'SELECT Alder,		' +char(13)+
			'CPRNR,				' +char(13)+
			'SAGSID,			' +char(13)+
			'Dato,				' +char(13)+
			'TERAPEUT_STATUS,	' +char(13)+
			'TERAPEUT_STATUSID, ' +char(13)+
			'Organization,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'5555,		' +char(13)+
			'Dogninddeling,		' +char(13)+
			'0 as Hjalptype,    ' +char(13)+ --HDJ
			'specifikation,		' +char(13)+
			'TPVISIJOB as VISIJOB,' +char(13)+
			'TPVISIJOBHverdag as VisijobHverdag, ' +char(13)+
			'TPVISIJOBWeekend as VisijobWeekend, ' +char(13)+
			'a.JOBID,case Pris when 0 then null else pris end as Pris, '+char(13)+
			'coalesce(pstart,Convert(DATETIME, ''2007-01-01 00:00:00'', 102)) as Prisstart, '+char(13)+
			'coalesce(pslut,Convert(DATETIME, ''9999-01-01 00:00:00'', 102)) as prisslut,  '+char(13)+
			'FRITVALGLEV,' +char(13)+
			'null as LEVERANDOERNAVN, ' +char(13)+
		    '5555 as InternLeverandoerID, ' +char(13)+
			' start as BorgerStart,' +char(13)+
			'Slut as BorgerSlut ' +char(13)+
			',NormTid1 as NormTid, ' +char(13)+
			'CASE b.NormTid1 WHEN null THEN NULL when 0 then null ELSE Convert(float,TPVISIJOB) / Convert(float, b.NormTid1) END as ANTAL_PAKKER,' +char(13)+
			'Convert(decimal(18,10), TPVISIJOBAntal)   as Antal,' +char(13)+
			'ViSiID   as VisiID' +char(13)+
			'FROM  '+@DestinationDB+'.dbo.FACT_TPVisiSag_AfregnetJob_TPTB a LEFT OUTER JOIN dbo.JOBTYPER b ON a.JOBID = b.JOBID' +char(13)+
			--------------------------------------------------------------------------------------------------
			----- Sygeplejen
			'UNION ALL ' +char(13)+
			'SELECT Alder,' +char(13)+
			'CPRNR, ' +char(13)+
			'SagsID, ' +char(13)+
			'Dato,' +char(13)+
			'SygePLEJE_STATUS,' +char(13)+
			'SygePLEJE_STATUSID,' +char(13)+
			'Organization, ' +char(13)+
            'SYPL_AFTENGRP_ID, ' +char(13)+
            'SYPL_NATGRP_ID, ' +char(13)+
			'HJPL_DAGGRP_ID, ' +char(13)+ 
			'HJPL_AFTENGRP_ID, ' +char(13)+ 
			'HJPL_NATGRP_ID, ' +char(13)+   			
			'Dogninddeling,  ' +char(13)+
			'0 as Hjalptype,    ' +char(13)+  --HDJ
			'Specifikation, ' +char(13)+
			'SPVISIJOB as VISIJOB,' +char(13)+
			'SPVISIJOBHverdag as VisijobHverdag, ' +char(13)+
			'SPVISIJOBWeekend as VisijobWeekend, ' +char(13)+
			'a.JOBID,' +char(13)+
			 'case Pris ' +char(13)+
			 'when 0 then null ' +char(13)+
			 'else pris end as Pris,' +char(13)+
			 'coalesce(pstart,Convert(DATETIME, ''2007-01-01 00:00:00'', 102)) as Prisstart, ' +char(13)+
			 'coalesce(pslut,Convert(DATETIME, ''9999-01-01 00:00:00'', 102)) as prisslut,' +char(13)+
			 'FRITVALGLEV, ' +char(13)+
			 'LEVERANDOERNAVN, ' +char(13)+
			'CASE WHEN FRITVALGLEV = 8888 THEN' +char(13)+  /*leverandør er kommune(standard)*/
			'  CASE ' +char(13)+ 
			'    WHEN Dogninddeling in (1,2,3,4) THEN Organization '+char(13)+    /*afhængig af tidpunkt på døgn, sættes sygeplejegrp*/
			'    WHEN Dogninddeling in (5,6,7,8) THEN SYPL_AFTENGRP_ID '+char(13)+  /*til at være leverandør på indsatse*/
			'    WHEN Dogninddeling in (9,10,11,12) THEN SYPL_NATGRP_ID '+char(13)+
			'  ELSE 5555 ' +char(13)+   /*5555 = gruppe ikke tildelt - medarb dimension*/
			'  END ' +char(13)+	
			'ELSE '+char(13)+  		
			'  CASE WHEN LEVERANDOERNAVN = ''Kommunal hjemmepleje'' THEN ' +char(13)+ /*er leverandør intern(kommunal)?*/
			'    CASE ' +char(13)+ 
			'      WHEN Dogninddeling in (1,2,3,4) THEN HJPL_DAGGRP_ID '+char(13)+    /*afhængig af tidpunkt på døgn, sættes hjemmeplejegrp*/
			'      WHEN Dogninddeling in (5,6,7,8) THEN HJPL_AFTENGRP_ID '+char(13)+  /*til at være leverandør på indsatse*/
			'      WHEN Dogninddeling in (9,10,11,12) THEN HJPL_NATGRP_ID '+char(13)+
			'    ELSE 5555 ' +char(13)+   /*5555 = gruppe ikke tildelt - medarb dimension*/
			'    END ' +char(13)+			
			'  ELSE 5555 '+char(13)+
			'  END ' +char(13)+			
			'END AS INTERNLEVERANDOERID, '+char(13)+
			 'Start as BorgerStart,' +char(13)+
			 'Slut as BorgerSlut, ' +char(13)+
			 'NormTid1 as NormTid, ' +char(13)+
			 'CASE b.NormTid1 ' +char(13)+
			 '  WHEN null THEN NULL ' +char(13)+
			 '  when 0    then null ' +char(13)+
			 ' ELSE Convert(float,SPVISIJOB) / Convert(float,b.NormTid1) ' +char(13)+
			 'END as ANTAL_PAKKER,' +char(13)+
			 'Convert(decimal(18,10), SPvisijobantal) as Antal,' +char(13)+
			 'VISIID   as VisiID' +char(13)+
			'FROM  '+@DestinationDB+'.dbo.FACT_SPVisiSag_AfregnetJob a LEFT OUTER JOIN dbo.JOBTYPER b ON a.JOBID = b.JOBID' +char(13)

	
if @debug = 1 print @cmd

exec (@cmd)
end 
--------------------------------------------------------------------------------------------------
--13.Lav FACT_VISISAGJOB_Afregnet_udenJobpriser
-----------------------------------------------------------------------------------------------------
if (@ExPart=13 or @ExPart=0 or (@ExPart>100 and @ExPart<=113))
begin
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestDB+'.DBO.sysobjects WHERE name =  ''FACT_VISISAGJOB_Afregnet_udenJobpriser'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FACT_VISISAGJOB_Afregnet_udenJobpriser'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd  = 
 'SELECT FactVisisagjobAfregnet_TilAfgang.Alder,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.CPRNR,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.SagsID,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.Dato,' + char (13) + 
   'FactVisisagjobAfregnet_TilAfgang.HjemmePleje_Status,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.HjemmePleje_StatusID,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.Organization,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.Dogninddeling,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.Hjalptype,' +char(13)+ --HDJ
   '2 as Specifikation,' + char (13) + --tilgang
   'FactVisisagjobAfregnet_TilAfgang.VisiJob,' +char(13)+
   'VisiJobHverdag,' +char(13)+
   'VisiJobWeekend,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.JobID,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.Pris,' +char(13)+
   'Convert(float,FactVisisagjobAfregnet_TilAfgang.Antal_pakker) as Antal_pakker,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.FritValgLev,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.InternLeverandoerID, ' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.BorgerStart,' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.BorgerSlut, ' +char(13)+
   'DIMTIME.PK_Date,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.Antal as AntalTotal,'+char(13)+
   'FactVisisagjobAfregnet_TilAfgang.VisiID'+char(13)+
 'into '+@DestDB+'.dbo.FACT_VISISAGJOB_Afregnet_udenJobpriser' +char(13)+
 'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang INNER JOIN' + char (13) +
    ''+@DestDB+'.dbo.DIMTIME ON '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerStart='+@DestDB+'.dbo.DIMTIME.PK_Date AND' + char (13) +
    ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerSlut>='+@DestDB+'.dbo.DIMTIME.PK_Date AND' + char (13) +
    ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.PrisSLUT>'+@DestDB+'.dbo.DIMTIME.PK_Date and' + char (13) +
    ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.Prisstart<='+@DestDB+'.dbo.DIMTIME.PK_Date' + char (13) +
 'WHERE ('+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.specifikation=2)'+char(13)+ 
 'Union all' +char(13)+
 'SELECT FactVisisagjobAfregnet_TilAfgang.Alder,FactVisisagjobAfregnet_TilAfgang.CPRNR,FactVisisagjobAfregnet_TilAfgang.SAGSID,FactVisisagjobAfregnet_TilAfgang.dato,' + char (13) + 
   'FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUS,FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUSID,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.organization,FactVisisagjobAfregnet_TilAfgang.dogninddeling,FactVisisagjobAfregnet_TilAfgang.Hjalptype,3 as specifikation,' + char (13) + --afgang
   'FactVisisagjobAfregnet_TilAfgang.VISIJOB * -1 as visijob,(VisiJobHverdag)* -1 as VisiJobHverdag,(VisiJobWeekend)* -1 as VisiJobWeekend,' + char (13) + 
   'FactVisisagjobAfregnet_TilAfgang.JOBID,FactVisisagjobAfregnet_TilAfgang.Pris * -1 as Pris,Convert(float,FactVisisagjobAfregnet_TilAfgang.Antal_pakker) * -1 as ANTAL_PAKKER, FactVisisagjobAfregnet_TilAfgang.FRITVALGLEV,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.InternLeverandoerID, ' +char(13)+
   'FactVisisagjobAfregnet_TilAfgang.BorgerStart,FactVisisagjobAfregnet_TilAfgang.BorgerSlut,DIMTIME.PK_Date,' + char (13) +
   'FactVisisagjobAfregnet_TilAfgang.Antal*-1 as AntalTotal,'+char(13)+
   'FactVisisagjobAfregnet_TilAfgang.VisiID'+char(13)+
'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang INNER JOIN' + char (13) +
   ''+@DestDB+'.dbo.DimTime ON '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerStart<='+@DestDB+'.dbo.DIMTIME.PK_Date AND' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerSlut='+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.PrisSLUT>'+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.Prisstart<='+@DestDB+'.dbo.DimTime.PK_Date' + char (13) +
'WHERE ('+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.specifikation=2)'+char(13)+
'union all' +char(13)+
'SELECT FactVisisagjobAfregnet_TilAfgang.Alder,FactVisisagjobAfregnet_TilAfgang.CPRNR,FactVisisagjobAfregnet_TilAfgang.SAGSID,FactVisisagjobAfregnet_TilAfgang.dato,' + char (13) + 
  'FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUS, FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUSID,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.organization, FactVisisagjobAfregnet_TilAfgang.dogninddeling, FactVisisagjobAfregnet_TilAfgang.Hjalptype, 1 as specikation,' + char (13) + --primo
  'FactVisisagjobAfregnet_TilAfgang.VISIJOB,VisiJobHverdag,VisiJobWeekend,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.JOBID, FactVisisagjobAfregnet_TilAfgang.Pris, Convert(float,FactVisisagjobAfregnet_TilAfgang.Antal_pakker) as Antal_pakker,FactVisisagjobAfregnet_TilAfgang.FRITVALGLEV,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.InternLeverandoerID, ' +char(13)+
  'FactVisisagjobAfregnet_TilAfgang.BorgerStart, FactVisisagjobAfregnet_TilAfgang.BorgerSlut, DimTime.PK_Date,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.Antal as AntalTotal,'+char(13)+
  'FactVisisagjobAfregnet_TilAfgang.VisiID'+char(13)+
'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang INNER JOIN' + char (13) +
   ''+@DestDB+'.dbo.DimTime ON '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerStart<'+@DestDB+'.dbo.DimTime.PK_Date AND ' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerSlut>='+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.PrisSLUT>'+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.Prisstart<='+@DestDB+'.dbo.DimTime.PK_Date' + char (13) +
'WHERE ('+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.specifikation=2)' + char (13) +
--and ('+@DestinationDB+'.dbo.DimTime.Day_Of_Week = 1)'+char(13)+
'union all' +char(13)+
'SELECT FactVisisagjobAfregnet_TilAfgang.Alder,FactVisisagjobAfregnet_TilAfgang.CPRNR,FactVisisagjobAfregnet_TilAfgang.SAGSID,FactVisisagjobAfregnet_TilAfgang.dato,' + char (13) + 
  'FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUS, FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUSID,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.organization, FactVisisagjobAfregnet_TilAfgang.dogninddeling, FactVisisagjobAfregnet_TilAfgang.Hjalptype,6 as specikation,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.VISIJOB,VisiJobHverdag,VisiJobWeekend,' + char (13) + 
  'FactVisisagjobAfregnet_TilAfgang.JOBID, FactVisisagjobAfregnet_TilAfgang.Pris, Convert(float,FactVisisagjobAfregnet_TilAfgang.Antal_pakker) as Antal_pakker,FactVisisagjobAfregnet_TilAfgang.FRITVALGLEV,' + char (13) +
  'InternLeverandoerID, ' +char(13)+
  'FactVisisagjobAfregnet_TilAfgang.BorgerStart, FactVisisagjobAfregnet_TilAfgang.BorgerSlut, DimTime.PK_Date,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.Antal as AntalTotal,'+char(13)+
  'FactVisisagjobAfregnet_TilAfgang.VisiID'+char(13)+
'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang INNER JOIN' + char (13) +
   ''+@DestDB+'.dbo.DimTime ON '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.dato<'+@DestDB+'.dbo.DimTime.PK_Date AND' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerSlut>='+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.PrisSLUT>'+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.Prisstart<='+@DestDB+'.dbo.DimTime.PK_Date' + char (13) +
'WHERE ('+@DestinationDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.specifikation=6) '+char(13)+ --fodselsdag tilgang
--and ('+@DestinationDB+'.dbo.DimTime.Day_Of_Week = 1)'+char(13)+
'union all' +char(13)+
'SELECT FactVisisagjobAfregnet_TilAfgang.Alder,FactVisisagjobAfregnet_TilAfgang.CPRNR,FactVisisagjobAfregnet_TilAfgang.SAGSID,FactVisisagjobAfregnet_TilAfgang.dato,' + char (13) + 
  'FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUS,FactVisisagjobAfregnet_TilAfgang.HJEMMEPLEJE_STATUSID, ' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.organization,FactVisisagjobAfregnet_TilAfgang.dogninddeling,FactVisisagjobAfregnet_TilAfgang.Hjalptype,7 as specikation,' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.VISIJOB,VisiJobHverdag,VisiJobWeekend, ' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.JOBID,FactVisisagjobAfregnet_TilAfgang.Pris,Convert(float,FactVisisagjobAfregnet_TilAfgang.Antal_pakker) as antal_pakker,FactVisisagjobAfregnet_TilAfgang.FRITVALGLEV, ' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.InternLeverandoerID, ' +char(13)+
  'FactVisisagjobAfregnet_TilAfgang.BorgerStart,FactVisisagjobAfregnet_TilAfgang.BorgerSlut,DimTime.PK_Date, ' + char (13) +
  'FactVisisagjobAfregnet_TilAfgang.Antal as AntalTotal,'+char(13)+
  'FactVisisagjobAfregnet_TilAfgang.VisiID'+char(13)+
'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang INNER JOIN' + char (13) +
   ''+@DestDB+'.dbo.DimTime ON '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.dato<'+@DestDB+'.dbo.DimTime.PK_Date AND' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.BorgerSlut>='+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.PrisSLUT>'+@DestDB+'.dbo.DimTime.PK_Date and' + char (13) +
   ''+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.Prisstart<='+@DestDB+'.dbo.DimTime.PK_Date' + char (13) +
'WHERE ('+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang.specifikation=7)'+char(13) --fodselsdag afgang
--and ('+@DestinationDB+'.dbo.DimTime.Day_Of_Week = 1)'+char(13)


if @debug = 1 print @cmd
exec (@cmd)
end --Part 13


--------------------------------------------------------------------------------------------------
--14.Lav FACTVISISAGJobAfregnet
-----------------------------------------------------------------------------------------------------
if (@ExPart=14 or @ExPart=0 or (@ExPart>100 and @ExPart<=114))



begin

	--Debug kode
	 if (@debug=1)  set @DebugCmd = 'where a.cprnr in (select cprnr from dbo.FireBirdTestUser) ' + CHAR(13)
	 else set @DebugCmd=''

	set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FACTVISISAGJOBAfregnet'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FACTVISISAGJOBAfregnet'
	if @debug = 1 print @cmd
	exec (@cmd)

	set @cmd  = 'SELECT a.Alder                            as Alder,' +char(13)+ 
				'       a.CPRNR                            as CprNr,'+char(13)+
				'       a.SagsID                           as SagsID, ' + char (13) +
				'       a.Dato                             as Dato,'+char(13)+
				'       a.HjemmePleje_Status               as Hjemmepleje_Status, ' + char (13) +
				'       a.Hjemmepleje_StatusID             as StatusID,'+char(13)+
				'       a.Organization                     as Organisation, ' + char (13) +
				'       a.Dogninddeling                    as DognInddeling, '+char(13)+
				'       a.Hjalptype                        as Hjalptype, '  +char(13)+ 
				'       a.Specifikation                    as Specifikation, '+char(13)+
				'       a.VISIJOB                          as VisiSagJob, ' + char (13) +
				'       case                                               ' + char (13) +
				'         when datepart(dw, a.PK_Date) in (1,7) then 0     ' + char (13) +
				'         else a.VisijobHverdag                            ' + char (13) +
				'       end as VisiSagJobHverdag,                          ' + char (13) +
				'       case                                               ' + char (13) +
				'         when datepart(dw, a.PK_Date) not in (1,7) then 0 ' + char (13) +
				'         else a.VisijobWeekend                            ' + char (13) +
				'       end as VisiSagJobWeekend,                          ' + char (13) +				
				'       case                                               ' + char (13) +
				'          when a.jobid=0    then 999                      ' + char (13) +
				'          when a.jobid=9999 then 999                      ' + char (13) +
				'          else COALESCE(a.Jobid,999)                      ' + char (13) +
				'       end       as JobID,                                '+char(13)+
				'       a.Pris                             as Pris,'+char(13)+
				'       a.Antal_Pakker                     as Antal_Pakker, ' + char (13) +
				'       a.Fritvalglev                      as FritValgLev,'+char(13)+
				'       a.INTERNLEVERANDOERID as InternLeverandoerID, ' +char(13)+
				'       a.BorgerStart                      as BorgerStart, ' + char (13) +
				'       a.BorgerSlut                       as BorgerSlut,'+char(13)+
				'       a.PK_Date,                           ' + char (13) +
				--'       Case                                 ' + char (13) +
				/*'       When b.BESOG_UGE = null THEN NULL    ' + char (13) +
				'       else   Convert(float, a.Antal_pakker)' + char (13) +
				'            / Convert(float,b.BESOG_UGE)    ' + char (13) + 
				'       end                                as Antal, ' + char (13) +*/
				
				'     a.Antal_pakker                       as Antal, ' + char (13) +
				--'     b.Besog_uge                          as Besog_Uge,' + char (13) +
				'     a.AntalTotal						   as AntalTotal,' + char (13) +
				'     a.VisiID,'											+char(13) +
				
/*				'     case                                               '    + char (13) +
				'          when a.jobid=0    then ''999''                      '   + char (13) +
				'          when a.jobid=9999 then ''999''                      '   + char (13) +
				'          else cast(COALESCE(a.Jobid,999) as nvarchar(4))     '   + char (13) +
				'       end +''_9999''						   as JobIDPakkeID, ' +char(13) +
				'     9999								   as PakkeID, ' + CHAR(13) +		
*/				'     null								   as JobLeveringsTidID, ' + CHAR(13) +		
				/*'	  null								   as LeverandorID,  ' + CHAR(13) +	  */
				/*'     null                                 as PakkeAntalFix,  ' + CHAR(13) +	  
				'     null                                 as PakkeFreq,      ' + CHAR(13) +	  */
				'     Convert(float,null)                  as Funktionsscore,      ' + CHAR(13) +	  
				'     null                                 as FunktionsscoreNaevner,  ' + CHAR(13) +	  
				'     null                                 as FunktionsscoreTotal,      ' + CHAR(13) +
				'     null                                 as FunktionsscoreCounter      ' + CHAR(13) +						
				'into '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet'											+char(13)+
				'FROM '
				+@DestinationDB+'.dbo.FACT_VISISAGJOB_Afregnet_udenJobpriser a ' + char (13) +' '+
				+'' + char (13) + @DebugCmd
				
	 

	if @debug = 1 print @cmd
	exec (@cmd)

end  -- part 14
--------------------------------------------------------------------------------------------------
--15.Lav FACTVISISAGJobAfregnet - Sæt PakkeID ind
-----------------------------------------------------------------------------------------------------
/*if (@ExPart=15 or @ExPart=0  or (@ExPart>100 and @ExPart<=115))
begin

set @cmd =	     'update '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet '	     + CHAR(13) +
					  '	set PakkeID = case '  							        	+ CHAR(13) +
					  ' when c.Pakke_ID is null THEN 9999'  	        			+ CHAR(13) +
					  ' else c.Pakke_ID '  			               					+ CHAR(13) +
					  'end,' 								                     	+  CHAR(13) +
					  'LeverandorID = '  								        	+  CHAR(13) +
				      'case '  											            + CHAR(13) +
				      '  when c.LeverandorID is null THEN 9999'  		            + CHAR(13) +
				      '  else c.LeverandorID '  						            + CHAR(13) +
				      'end,                                                     '	+ CHAR(13) + 
                      'PakkeFreq     = c.Pakke_Visitype,              '       	    +  CHAR(13) +
				      'PakkeAntalFix = c.Pakke_Ugentlig_Leveret'  				 	+  CHAR(13) +
				      'from                                                        '+ CHAR(13) +
                      '(select distinct '											+ CHAR(13)+
					  ' a.Pakke_Visi_ID,'											+ CHAR(13)+
					  '  b.JobType_ID,'											    + CHAR(13)+
					  ' a.Pakke_ID, '												+ CHAR(13)+
					  ' a.Pakke_Lev_ID  as LeverandorID,'							+ CHAR(13)+
					  ' a.Pakke_Visitype, '												+ CHAR(13)+
					  ' a.Pakke_Ugentlig_Leveret '												+ CHAR(13)+
				  	  ' from Visi_Pakker_Beregn a, '								+ CHAR(13)+
					  '      Jobtype2ydelsespakke b '								+ CHAR(13)+
					  ' where a.pakke_id   = b.Pakke_ID) c '						+ CHAR(13)+
					  ' where   '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.VisiID      = c.Pakke_Visi_ID '	+ CHAR(13)+
					  ' and     '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.JobID       = c.JobType_ID    '	+ CHAR(13)+
					  ' and     '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.FritValgLev = c.LeverandorID  '	+ CHAR(13)

	if @debug = 1 print @cmd
	exec (@cmd)
*/
/*
Relateret til pakke 
set @cmd =	     'update '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet '	     + CHAR(13) +
					  '	set PakkeID = case '  							        	+ CHAR(13) +
					  ' when c.Pakke_ID is null THEN 9999'  	        			+ CHAR(13) +
					  ' else c.Pakke_ID '  			               					+ CHAR(13) +
					  'end,' 								                     	+  CHAR(13) +
					  '	JobIDPakkeID = case '  							        + CHAR(13) +
					  ' when c.Pakke_ID is null THEN  cast('+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.JobID as nvarchar(4)) +''_9999'' '  	        + CHAR(13) +
					  ' else  cast('+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.JobID as nvarchar(4))+''_''+cast(c.Pakke_ID as nvarchar(4))'  			               		+ CHAR(13) +
					  'end,' 								                     	+  CHAR(13) +
					  'LeverandorID = '  								        	+  CHAR(13) +
				      'case '  											            + CHAR(13) +
				      '  when c.LeverandorID is null THEN 9999'  		            + CHAR(13) +
				      '  else c.LeverandorID '  						            + CHAR(13) +
				      'end,                                                     '	+ CHAR(13) + 
                      'PakkeFreq     = c.Pakke_Visitype,              '       	    +  CHAR(13) +
				      'PakkeAntalFix = c.Pakke_Ugentlig_Leveret'  				 	+  CHAR(13) +
				      'from                                                        '+ CHAR(13) +
                      '(select distinct '											+ CHAR(13)+
					  ' a.Pakke_Visi_ID,'											+ CHAR(13)+
					  '  b.JobType_ID,'											    + CHAR(13)+
					  ' a.Pakke_ID, '												+ CHAR(13)+
					  ' a.Pakke_Lev_ID  as LeverandorID,'							+ CHAR(13)+
					  ' a.Pakke_Visitype, '											+ CHAR(13)+
					  ' cc.Ydelse_dag, '											+ CHAR(13)+
					  ' cc.Ydelse_aften, '											+ CHAR(13)+
					  ' cc.Ydelse_Nat, '											+ CHAR(13)+
					  ' a.Pakke_Ugentlig_Leveret '									+ CHAR(13)+
				  	  ' from Visi_Pakker_Beregn a, '								+ CHAR(13)+
					  '      Jobtype2ydelsespakke b, '								+ CHAR(13)+
					  '      YDELSESPAKKER cc '										+ CHAR(13)+
					  ' where a.pakke_id   = b.Pakke_ID  '							+ CHAR(13)+
					  ' and a.pakke_id   = cc.Pakke_ID) c '							+ CHAR(13)+
					  ' where   '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.VisiID      = c.Pakke_Visi_ID '	+ CHAR(13)+
					  ' and     '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.JobID       = c.JobType_ID    '	+ CHAR(13)+
					  ' and     '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.FritValgLev = c.LeverandorID  '	+ CHAR(13) +
				      ' and ((c.Ydelse_Dag=1 AND  '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.DognInddeling BETWEEN 1 AND 4)'	  + CHAR(13) +
				      ' or (c.Ydelse_aften=1 AND  '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.DognInddeling BETWEEN 5 AND 8)'	  + CHAR(13) +
				      ' or (c.Ydelse_Nat=1 AND  '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.DognInddeling BETWEEN 9 AND 12)'	  + CHAR(13) +
				      ' or  '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet.DognInddeling=0)'	  + CHAR(13) 
					  
					  
					 
	if @debug = 1 print @cmd
	exec (@cmd)
	*/
/*

	SET @cmd = 'CREATE NONCLUSTERED INDEX [idx_VisiID] ON '+@DestinationDB+'.[dbo].[FactVisiSagJobAfregnet] '+ CHAR(13)+
		'( VisiID ASC ' + CHAR(13) +
		')WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'

	if @debug = 1 print @cmd
	exec (@cmd)

*/
	--Indsæt Funktionsscore
	-------------------------------------------------------------------------
	--set @cmd = 'exec usp_FunktionsScoreCalc ''' + @DestinationDB + ''','+CAST(@debug as nvarchar(1))
	--EXEC (@cmd)
	-------------------------------------------------------------------------
/*
	Relateret til pakkebegrebet som de har det i Gribskov kommune
	update pgedw.dbo.FactVisiSagJobAfregnet 
	Set PakkeID = '9999' 
	WHERE PakkeID IS NULL
*/

/*	update pgedw.dbo.FactVisiSagJobAfregnet 
	Set JobID = '999' 
	WHERE JobID IS NULL or JobID = '9999'
*/

	/*
	--Slet hvis det er 6 eller 22
		set @cmd = 'DELETE  FROM ' +@DestinationDB+'.dbo.FactVisiSagJobAfregnet ' + CHAR(13) +
				   '	WHERE (PakkeID = 6) OR (PakkeID = 22)'
				   
	if @debug = 1 print @cmd
	exec (@cmd)					   
	
		   
	

end -- end part 15
*/
--------------------------------------------------------------------------------------------------
--16.Lav FACTVISISAGJobAfregnet_Pakker
-----------------------------------------------------------------------------------------------------
--Drop FACTVISISAGJobAfregnet_Pakker
--[dbo].[usp_PrepareAnalysisdata] pgedw,16
		
if (@ExPart=16 or @ExPart=0 or  (@ExPart>100 and @ExPart<=116))
begin
print '---------------------------------------------------------------------------------------------'
print '16.Lav FACTVISISAGJobAfregnet_Pakker'
print '' 


--Debug kode
 if (@debug=1)  set @DebugCmd = 'where cprnr in (select cprnr from dbo.FireBirdTestUser) ' + CHAR(13)
 else set @DebugCmd=''

 
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactVisiSagJobAfregnet_Pakker'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker'
if @debug = 1 print @cmd
exec (@cmd)

--Generer FACTVISISAGJobAfregnet_Pakker
		
	set @cmd = 	'SELECT [Alder]													' + CHAR(13)+
				'	  ,[CprNr] ' + CHAR(13)+
				'	  ,[SagsID] ' + CHAR(13)+
				'	  ,[Dato] ' + CHAR(13)+
				'	  ,[StatusID] ' + CHAR(13)+
				'	  ,[Organisation] ' + CHAR(13)+
				'	  ,[Specifikation] ' + CHAR(13)+
				'	  ,[FritValgLev] ' + CHAR(13)+
				'	  ,[PK_Date] ' + CHAR(13)+
				'	  ,[VisiID] ' + CHAR(13)+
				'	  ,[PakkeID] ' + CHAR(13)+
				'	  ,[LeverandorID] ' + CHAR(13)+
				'	  ,PakkeAntalFix  ' + CHAR(13) +	  
				'	  ,Convert(decimal(18,10),max(case ' + CHAR(13)+
				'	  when PakkeID = 9999 then 0 ' + CHAR(13)+
				'	  else  ' + CHAR(13)+
				'     Case  ' + CHAR(13)+
	            '       when antaltotal < -1                                       then -1' + CHAR(13)+
	            '       when antaltotal < 0         and antaltotal >-0.1428571429  then -0.1428571429' + CHAR(13)+
	            '       when antaltotal > 0		    and antaltotal < 0.1428571429  then  0.1428571429' + CHAR(13)+
	            '       when antaltotal > 0.1428571429  and PakkeAntalFix=1 then 0.1428571429' + CHAR(13)+
	            '       when antaltotal < -0.1428571429  and PakkeAntalFix=1 then -0.1428571429' + CHAR(13)+
	            '       when antaltotal > 0.1428571429  and PakkeAntalFix>1 and  PakkeAntalFix<7 then antaltotal/PakkeAntalFix' + CHAR(13)+
	            '       when antaltotal < -0.1428571429  and PakkeAntalFix>1 and  PakkeAntalFix<7 then antaltotal/PakkeAntalFix' + CHAR(13)+
	            '       when antaltotal > 1                                        then 1' + CHAR(13)+
	            '       else antaltotal' + CHAR(13)+
	            	'	  end end)) 											' + CHAR(13)+
				/*
				Udkommenteret, Der er ikke Pakke begrebet som de har i Gribskov kommune eksisterer ikke i guldborgssund
				'	  Convert(decimal(18,10),max(case ' + CHAR(13)+
				'	  when PakkeID = 9999 then 0 ' + CHAR(13)+
				'	  else  ' + CHAR(13)+
				'		  case ' + CHAR(13)+
				'			  when specifikation=1 then  dbo.GribskovPakker(antaltotal) ' + CHAR(13)+
				'			  when specifikation=2 then  dbo.GribskovPakker(antaltotal) ' + CHAR(13)+
				'			  when specifikation=3 then  dbo.GribskovPakker(antaltotal) ' + CHAR(13)+  -- minus
				'			  when specifikation=6 then  dbo.GribskovPakker(antaltotal) ' + CHAR(13)+
				'			  when specifikation=7 then  dbo.GribskovPakker(antaltotal) ' + CHAR(13)+   -- minus
				'			  else 0								' + CHAR(13)+
				'		  end										' + CHAR(13)+
				'	  end))											' + CHAR(13)+
				*/
				'	  AntalPakker,									' + CHAR(13)+
				'	  COUNT(distinct jobid) AntalYdelser			' + CHAR(13)+
					' into '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker ' + CHAR(13)+
				' FROM '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet  				' + CHAR(13)+
				@DebugCmd+
				'	GROUP BY										' + CHAR(13)+
				'	   [Alder] ' + CHAR(13)+
				'	  ,[CprNr] ' + CHAR(13)+
				'	  ,[SagsID] ' + CHAR(13)+
				'	  ,[Dato] ' + CHAR(13)+
				'	  ,[StatusID] ' + CHAR(13)+
				'	  ,[Organisation] ' + CHAR(13)+
				'	  ,[Specifikation] ' + CHAR(13)+
				'	  ,[FritValgLev] ' + CHAR(13)+
				'	  ,[PK_Date] ' + CHAR(13)+
				'	  ,[VisiID] ' + CHAR(13)+
				'	  ,[PakkeID] ' + CHAR(13)+
				'	  ,[LeverandorID] ' + CHAR(13)+
				'	  ,PakkeAntalFix  ' + CHAR(13) +	  
				'--	  , dbo.GribskovPakker(antaltotal) '

if @debug = 1 print @cmd
exec (@cmd)




	set @cmd = 	'DELETE '+@DestinationDB+'.[dbo].[FactVisiSagJobAfregnet] '+ CHAR(13)+
                'WHERE PK_Date>GETDATE() '
    if @debug = 1 print @cmd
	exec (@cmd)
    
    set @cmd = 	'DELETE  '+@DestinationDB+'.dbo.[FactVisiSagJobAfregnet_Pakker] '+ CHAR(13)+
                'WHERE PK_Date>GETDATE()'
    if @debug = 1 print @cmd
    exec (@cmd)
/*
	set @cmd =  'update ['+@DestinationDB+'].[dbo].[FactVisiSagJobAfregnet_Pakker] ' + 
		        'Set PakkeID = ''9999''' + CHAR(13)+
		     	'WHERE PakkeID IS NULL '
  	

	if @Debug = 1 print @cmd
	exec @cmd   
*/
	
end



--------------------------------------------------------------------------------------------------
--17.Lav FACT_FRAVAER_UNIQOMSORG
-----------------------------------------------------------------------------------------------------

if (@ExPart=17 or @ExPart=0  or (@ExPart>100 and @ExPart<=117))
begin
--Fravær beregnes via Uniq tabeller
--Fravær beregnes via Uniq tabeller

	

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step1'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step1'
exec (@cmd)
--aktive medarbejdere hentes med gennemsnitstimer i en periode 1 år tilbage fra dagsdato
SET @cmd =	' SELECT					' +char(13)+
			' e.PK_DATE,				' +char(13)+
			' a.MEDARBEJDERID as MedID, ' +char(13)+
			' a.IKRAFTDATO,				' +char(13)+
			' a.SLUTDATO,				' +char(13)+
  			' a.VAGTER,					' +char(13)+
  		    ' c.UAFDELINGID,			' +char(13)+
  		    ' d.STATUSNAVN,				' +char(13)+
  		    ' b.STILLINGNAVN,			' +char(13)+
  		    ' b.STILLINGID,			' +char(13)+
  		    ' Convert(decimal(18,10),a.TIMER)/60/7 as GennemsnitTimer,' +char(13)+
  		    ' Convert(decimal(18,10),null)      as PlanlagtTimer,    ' +char(13)+
  		    ' Convert(decimal(18,10),null)      as FravaersTimer,      ' +char(13)+
  		    ' Convert(decimal(18,10),null)									  FravaersDage,      ' +char(13)+
  		   	' ''''									  Delvist_Syg,    ' +char(13)+
  		    ' Convert(decimal(18,10),null)           as SygdomsPeriod,    ' +char(13)+
  		    ' 999									  FravaerTypeID ,   ' +char(13)+
  		    ' 0									     TjenesteTyperID,    ' +char(13)+
  		    ' 0									     TjenesteGroupID    ' +char(13)+
  		    ' into Tmp_Vagtplan_FactTimerPlan_Step1 ' +char(13)+
  		    ' FROM	 PGEDW.DBO.DIM_TIME e ' +char(13)+
  		    ' left join MEDHISTORIK a	 ON PK_DATE >a.IKRAFTDATO AND PK_DATE <a.SLUTDATO ' +char(13)+
  		    ' LEFT JOIN STILLINGBET b ON b.STILLINGID  =a.STILLINGSID'			+char(13)+
  		    ' LEFT JOIN UAFDELINGER c ON c.UAFDELINGID =a.UAFDELINGID'			+char(13)+
  		    ' LEFT JOIN MEDSTATUS   d ON d.MEDSTATUSID =a.MEDARBEJDER_STATUSID' +char(13)+
  		    ' ' +char(13)+
  		    ' WHERE  YEAR(e.PK_DATE) >= year(getdate() )-1 ' +char(13)+
  		    ' and    PK_DATE < GETDATE() ' +char(13)+
  		    ' and    d.STATUSNAVN=''Aktiv'' ' +char(13)
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step2'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step2'
exec (@cmd)
--der hentes vagter ud for alle medarbejdere i en periode 1 år tilbage fra dagsdato
--er der vagt over midnat markeres disse VAGT_OVER_MIDNAT=1
set @cmd = 'SELECT ' +char(13)+
           '  A.MEDARBEJDER, ' +char(13)+
           '  NULL AS IKRAFTDATO, ' +char(13)+
           '  NULL AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  A.OMKOST_GRUPPE, ' +char(13)+
           '  COALESCE(A.OMKOST_GRUPPE,A.MEDARB_GRUPPE) AS MEDARB_GRUPPE, ' +char(13)+
           '  (SELECT DISTINCT STATUSNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STATUSNAVN, ' +char(13)+
  		   '  (SELECT DISTINCT STILLINGNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGNAVN, ' +char(13)+
  		   '  (SELECT DISTINCT STILLINGID FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGID, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS GENNEMSNITTIMER, ' +char(13)+
           '  A.STARTTIDSPUNKT, ' +char(13)+
           '  A.SLUT, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS FRAVAERSTIMER, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS FRAVAERSDAGE, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS SYGDOMSPERIOD, ' +char(13)+
           '  '''' AS DELVIST_SYG, ' +char(13)+
           '  A.TJENESTE AS TJENESTETYPERID, ' +char(13)+
           '  C.TJENESTETYPE AS TJENESTEGROUPID, ' +char(13)+
           '  0 AS FRAVAERTYPEID, ' +char(13)+
           '  CASE WHEN (DATEPART(DAYOFYEAR,A.SLUT)-DATEPART(DAYOFYEAR,A.STARTTIDSPUNKT))>0 THEN 1 ' +char(13)+ 
           '  ELSE 0 ' +char(13)+                  
           '  END AS VAGT_OVER_MIDNAT, ' +char(13)+
           '  PAA_ARBEJDE,  ' +char(13)+ 
           '  A.ANNULLERET, ' +char(13)+ 
           '  A.FAKTISK_TID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step2' +char(13)+
           'FROM VPL_TJENESTER A' +char(13)+
           'JOIN VPL_TJENESTETYPER C ON A.TJENESTE=C.ID ' +char(13)+
           'WHERE YEAR(A.STARTTIDSPUNKT)>= YEAR(GETDATE())-1 AND ' +char(13)+
  		   '  A.STARTTIDSPUNKT<GETDATE() AND A.TJENESTE NOT IN (7) AND ' +char(13)+ --omlagt tjeneste, fra
  		   '  A.ANNULLERET=0 ' +char(13)+
  		   '  '

if @debug = 1 print @cmd
exec (@cmd)

--vagter over midnat dubleres
set @cmd = 'INSERT INTO Tmp_Vagtplan_FactTimerPlan_Step2 ' +char(13)+
           'SELECT ' +char(13)+
           '  MEDARBEJDER, '  +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE,  ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
           '  STILLINGNAVN, ' +char(13)+
           '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+
           '  FRAVAERSTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+ 
           '  DELVIST_SYG, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  2 AS VAGT_OVER_MIDNAT, ' +char(13)+
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET, ' +char(13)+
           '  FAKTISK_TID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step2 ' +char(13)+
           'WHERE VAGT_OVER_MIDNAT=1' 
exec (@cmd)

-- vagter over midnat opdeles
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step3'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step3'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
  		   '  STILLINGNAVN, ' +char(13)+
  		   '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER, ' +char(13)+
           '  CASE WHEN VAGT_OVER_MIDNAT=2 THEN CONVERT(DATETIME,SUBSTRING(CONVERT(CHAR,SLUT,120),1,10)+ '' 00:00:00'') ' +char(13)+ --vagt skal starte ved midnat ved vagt hen over midnat
           '  ELSE STARTTIDSPUNKT ' +char(13)+
           '  END AS STARTTIDSPUNKT, ' +char(13)+
           '  CASE WHEN VAGT_OVER_MIDNAT=1 THEN CONVERT(DATETIME,SUBSTRING(CONVERT(CHAR,SLUT,120),1,10)+ '' 00:00:00'')' +char(13)+ --vagt skal slutte ved midnat ved vagt hen over midnat
           '  ELSE SLUT ' +char(13)+
           '  END AS SLUT, ' +char(13)+ 
           '  FRAVAERSTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET, ' +char(13)+
           '  FAKTISK_TID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step3' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step2 '

if @debug = 1 print @cmd
exec (@cmd)

--planlagte og fraværs (afspadsering) timer fra tjenester beregnes

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step4'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step4'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  CAST(STARTTIDSPUNKT AS DATE) AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
  		   '  STILLINGNAVN, ' +char(13)+
  		   '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER, ' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+   --hvis der skal frasorteres tjenester gøres det her i næste linie
           '  COALESCE(CASE WHEN (PAA_ARBEJDE=1 AND FAKTISK_TID>0) THEN CAST(DATEDIFF(MINUTE,STARTTIDSPUNKT,SLUT) AS NUMERIC(18,2))/60 ELSE 0 END,0) AS PLANLAGTTIMER, ' +char(13)+ 
           '  COALESCE(CASE WHEN TJENESTEGROUPID IN (4,10,11) THEN CAST(DATEDIFF(MINUTE,STARTTIDSPUNKT,SLUT) AS NUMERIC(18,2))/60 ELSE 0 END,0) AS FRAVAERSTIMER, ' +char(13)+
           '  CASE WHEN ((OMKOST_GRUPPE IS NOT NULL) AND (OMKOST_GRUPPE<>MEDARB_GRUPPE)) THEN ' +char(13)+  
           '    COALESCE(CASE WHEN (PAA_ARBEJDE=1 AND FAKTISK_TID>0) THEN CAST(DATEDIFF(MINUTE,STARTTIDSPUNKT,SLUT) AS NUMERIC(18,2))/60 ELSE 0 END,0) ' +char(13)+
           '  ELSE 0 ' +char(13)+ 
           '  END AS OMFORDELTTID, ' +char(13)+ 
           '  FRAVAERSDAGE, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE ' +char(13)+
           '  ANNULLERET, ' +char(13)+
           '  FAKTISK_TID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step4' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step3 ' 
if @debug = 1 print @cmd
exec (@cmd)

--fravaer hentes og beregnes

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step5'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step5'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  CAST(C.STARTTIDSPUNKT AS DATE) AS PK_DATE, ' +char(13)+
           '  A.MEDARBEJDER AS MEDID, ' +char(13)+
           '  NULL AS IKRAFTDATO, ' +char(13)+
           '  NULL AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  COALESCE(C.OMKOST_GRUPPE,A.MEDARB_GRUPPE) AS UAFDELINGID, ' +char(13)+
           '  C.OMKOST_GRUPPE, ' +char(13)+
           '  A.MEDARB_GRUPPE AS STAMDATA_GRUPPE, ' +char(13)+ 
           '  (SELECT STATUSNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STATUSNAVN, ' +char(13)+
  		   '  (SELECT STILLINGNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGNAVN, ' +char(13)+
  		   '  (SELECT STILLINGID FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGID, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS GENNEMSNITTIMER, ' +char(13)+
           '  CONVERT(DECIMAL(18,10),NULL) AS PLANLAGTTIMER, ' +char(13)+
           '  CASE WHEN DATEDIFF(HH,A.STARTTIDSPUNKT,A.SLUT)>DATEDIFF(HH,C.STARTTIDSPUNKT,C.SLUT) THEN ' +char(13)+ --fravaær større and tjeneste vælges tjeneste 
           '    CASE WHEN B.PAA_ARBEJDE=1 THEN CAST(DATEDIFF(MINUTE,C.STARTTIDSPUNKT,C.SLUT) AS NUMERIC(18,2))/60 ' +char(13)+
           '    ELSE 0 END ' +char(13)+ 
           '  ELSE ' +char(13)+
           '    CASE WHEN B.PAA_ARBEJDE= 1 THEN CAST(DATEDIFF(MINUTE,A.STARTTIDSPUNKT,A.SLUT) AS NUMERIC(18,2))/60 ' +char(13)+
           '    ELSE 0 END ' +char(13)+ 
           '  END AS FRAVAERSTIMER, ' +char(13)+
           '  1 AS FRAVAERSDAGE , ' +char(13)+ 
           '  A.DELVIST_SYG, ' +char(13)+
  	       '  CASE WHEN (DATEDIFF(DD,A.STARTTIDSPUNKT,A.SLUT))-1 < 0 THEN NULL ' +char(13)+
  		   ' 	ELSE (DATEDIFF(DD,A.STARTTIDSPUNKT,A.SLUT))-1 ' +char(13)+
  		   '  END AS SYGDOMSPERIOD, ' +char(13)+         
           '  COALESCE(A.FRAVAER,999) AS FRAVAERTYPEID, ' +char(13)+ 
  		   ' 0 AS TJENESTETYPERID, ' +char(13)+
  		   ' 0 AS TJENESTEGROUPID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step5' +char(13)+
           'FROM VPL_FRAVAER A' +char(13)+
           'JOIN VPL_TJENESTER C ON A.MEDARBEJDER=C.MEDARBEJDER AND A.STARTTIDSPUNKT<C.SLUT AND A.SLUT>C.STARTTIDSPUNKT ' +char(13)+
           'JOIN VPL_TJENESTETYPER B ON C.TJENESTE=B.ID ' +char(13)+
           'WHERE YEAR(A.STARTTIDSPUNKT)>= YEAR(GETDATE())-1 AND ' +char(13)+
  		   '  A.STARTTIDSPUNKT<GETDATE() AND ' +char(13)+
  		   '  A.ANNULLERET=0 '

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step6'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step6'
exec (@cmd)

--ifølge aftale med Rune fra Gribskov sættes tilhørsforhold til stamdata gruppe, hvis der er mere end 1 tilhørsforhold pr dag.
set @cmd = 'SELECT '  +char(13)+  
           '  A.PK_DATE, ' +char(13)+
           '  A.MEDID,' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.VAGTER, ' +char(13)+  
           '  CASE WHEN (SELECT COUNT(*) FROM Tmp_Vagtplan_FactTimerPlan_Step5 WHERE ' +char(13)+ 
           '    Tmp_Vagtplan_FactTimerPlan_Step5.MEDID=A.MEDID AND Tmp_Vagtplan_FactTimerPlan_Step5.PK_DATE=A.PK_DATE)>1 THEN A.STAMDATA_GRUPPE ' +char(13)+ 
           '  ELSE A.UAFDELINGID ' +char(13)+  
           '  END AS UAFDELINGID, ' +char(13)+
           '  A.STATUSNAVN, ' +char(13)+
           '  A.STILLINGNAVN, ' +char(13)+
           '  A.STILLINGID, ' +char(13)+
           '  A.GENNEMSNITTIMER, ' +char(13)+
           '  A.PLANLAGTTIMER, ' +char(13)+    --nedenstående hvis der skal fratrækkes 
           '  0 AS OMFORDELTTID, ' +char(13)+ --CASE WHEN A.OMKOST_GRUPPE IS NOT NULL THEN A.FRAVAERSTIMER*-1 ELSE 0 END AS OMFORDELTTID, ' +char(13)+
           '  A.FRAVAERSTIMER, ' +char(13)+
           '  A.FRAVAERSDAGE, ' +char(13)+
           '  A.DELVIST_SYG, ' +char(13)+
           '  A.SYGDOMSPERIOD, ' +char(13)+
           '  A.FRAVAERTYPEID, ' +char(13)+
           '  A.TJENESTETYPERID, ' +char(13)+
           '  A.TJENESTEGROUPID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step6 ' +char(13)+             
           'FROM Tmp_Vagtplan_FactTimerPlan_Step5 A' 
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step7'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step7'
exec (@cmd)

set @cmd = 'SELECT '  +char(13)+
           '  PK_DATE, ' +char(13)+
           '  MEDID,' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  UAFDELINGID, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
           '  STILLINGNAVN, ' +char(13)+
           '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER, ' +char(13)+
           '  PLANLAGTTIMER, ' +char(13)+
           '  SUM(FRAVAERSTIMER) AS FRAVAERSTIMER, ' +char(13)+
           '  SUM(OMFORDELTTID) AS OMFORDELTTID, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Step7 ' +char(13)+ 
           'FROM Tmp_Vagtplan_FactTimerPlan_Step6' +char(13)+  
           'GROUP BY ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  MEDID,' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  UAFDELINGID, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
           '  STILLINGNAVN, ' +char(13)+
           '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER, ' +char(13)+
           '  PLANLAGTTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID '          
exec (@cmd)           

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactTimerPlan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactTimerPlan'
exec (@cmd)
--samler delresultater på aktive medarbejdere
set @cmd = 'SELECT '  +char(13)+
           '  PK_DATE, ' +char(13)+
           '  MEDID,' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  UAFDELINGID, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
           '  STILLINGNAVN, ' +char(13)+
           '  STILLINGID, ' +char(13)+
           '  GENNEMSNITTIMER, ' +char(13)+
           '  PLANLAGTTIMER, ' +char(13)+
           '  0 AS OMFORDELTTID, ' +char(13)+
           '  FRAVAERSTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactTimerPlan  ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step1 ' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.MEDID,' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.VAGTER, ' +char(13)+
           '  A.UAFDELINGID, ' +char(13)+
           '  A.STATUSNAVN, ' +char(13)+
           '  A.STILLINGNAVN, ' +char(13)+
           '  A.STILLINGID, ' +char(13)+
           '  A.GENNEMSNITTIMER, ' +char(13)+
           '  A.PLANLAGTTIMER, ' +char(13)+
           '  A.OMFORDELTTID, ' +char(13)+
           '  A.FRAVAERSTIMER, ' +char(13)+
           '  A.FRAVAERSDAGE, ' +char(13)+
           '  A.DELVIST_SYG, ' +char(13)+
           '  A.SYGDOMSPERIOD, ' +char(13)+
           '  A.FRAVAERTYPEID, ' +char(13)+
           '  A.TJENESTETYPERID, ' +char(13)+
           '  A.TJENESTEGROUPID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step4 A ' +char(13)+
           ' WHERE EXISTS(SELECT * FROM Tmp_Vagtplan_FactTimerPlan_Step1 WHERE Tmp_Vagtplan_FactTimerPlan_Step1.MEDID=A.MEDID and Tmp_Vagtplan_FactTimerPlan_Step1.PK_DATE=A.PK_DATE) '  +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+
           '  B.PK_DATE, ' +char(13)+
           '  B.MEDID,' +char(13)+
           '  B.IKRAFTDATO, ' +char(13)+
           '  B.SLUTDATO, ' +char(13)+
           '  B.VAGTER, ' +char(13)+
           '  B.UAFDELINGID, ' +char(13)+
           '  B.STATUSNAVN, ' +char(13)+
           '  B.STILLINGNAVN, ' +char(13)+
           '  B.STILLINGID, ' +char(13)+
           '  B.GENNEMSNITTIMER, ' +char(13)+
           '  B.PLANLAGTTIMER, ' +char(13)+
           '  B.OMFORDELTTID, ' +char(13)+
           '  B.FRAVAERSTIMER, ' +char(13)+
           '  B.FRAVAERSDAGE, ' +char(13)+
           '  B.DELVIST_SYG, ' +char(13)+
           '  B.SYGDOMSPERIOD, ' +char(13)+
           '  B.FRAVAERTYPEID, ' +char(13)+
           '  B.TJENESTETYPERID, ' +char(13)+
           '  B.TJENESTEGROUPID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step7 B ' +char(13)+ 
           ' WHERE EXISTS(SELECT * FROM Tmp_Vagtplan_FactTimerPlan_Step1 WHERE Tmp_Vagtplan_FactTimerPlan_Step1.MEDID=B.MEDID and Tmp_Vagtplan_FactTimerPlan_Step1.PK_DATE=B.PK_DATE) ' 

END --17.

--------------------------------------------------------------------------------------------------
--18.Clean Up job
-----------------------------------------------------------------------------------------------------
/*
if (@ExPart=18 or @ExPart=0  or (@ExPart>100 and @ExPart<=118))
begin
  set @cmd = 'exec usp_CleanUp ''' + @DestinationDB + ''''
  if @debug = 1 print @cmd
  exec (@cmd)
end 
*/

--------------------------------------------------------------------------------------------------
--19.Run Custom
-----------------------------------------------------------------------------------------------------
/*
if (@ExPart=19 or @ExPart=0  or (@ExPart>100 and @ExPart<=119))
BEGIN

			print '---------------------------------------------------------------------------------------------'
			print '19.Run Custom'
			print '---------------------------------------------------------------------------------------------'


	EXEC	 [dbo].[usp_PrepareAnalysisdata_Custom]	@DestinationDB ,@ExPart ,	@Debug 
end
*/


GO

