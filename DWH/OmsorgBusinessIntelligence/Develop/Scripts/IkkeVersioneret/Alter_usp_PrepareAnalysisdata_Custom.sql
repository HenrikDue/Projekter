USE [PGSTA_AVA]
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareAnalysisdata_Custom]    Script Date: 11/03/2010 07:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--1. kopier tabeller over i DestDB
--2.Lav dimensioner



ALTER PROCEDURE [dbo].[usp_PrepareAnalysisdata_Custom]
		@DestinationDB as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS
--DECLARE @DestinationDB as varchar(2000)
--declare @ExPart int
--declare @Debug int
--set @Debug=1
--set @DestinationDB='PGEDW'

DECLARE @cmd as varchar(max)
DECLARE @StartDate as datetime
DECLARE @EndDate as datetime
DECLARE @Debugcmd as nvarchar(4000)
DECLARE @PrisDB as nvarchar(4000)
set @PrisDB='GMSTA'


-----------------------------------------------------------------------------------------------------
--2. usp_PrepareAnalysisdata_Custom - PakkePris
-----------------------------------------------------------------------------------------------------

print '---------------------------------------------------------------------------------------------'
print '1. usp_PrepareAnalysisdata_Custom - PakkePris'
print ''


set @cmd = '  insert into  '+@PrisDB+'.dbo.PrisSetupPakkeMappeing (GMPakkeID,GMPakke_Navn) '+char(13)+
           '  select pakke_id, Pakke_Navn from dbo.YDELSESPAKKER  where status =1 and pakke_id not in (select GMPakkeID from  '+@PrisDB+'.dbo.PrisSetupPakkeMappeing)'
if @debug = 1 print @cmd
exec (@cmd)
           

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPriser'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPriser'
if @debug = 1 print @cmd
exec (@cmd)



set @cmd = 'SELECT c.PGPakkeID PakkeID,       -- pakke           '+char(13)+
           '       a.LeverandorID,  -- Leverandør      '+char(13)+  
           '       a.DriftFormID,   -- Driftform       '+char(13)+
           '       b.StartDato,     -- StartDato       '+char(13)+  
           '       coalesce(b.SlutDato,getdate())   as SlutDato,  -- SlutDato        '+char(13)+
           '       b.AktivitetID,                      '+char(13)+
           '       b.PakkeGruppeID,                    '+char(13)+
           '       b.PakkePris,                        '+char(13)+
           '       b.PakkeTid,                         '+char(13)+  
           '       b.PrisGruppeID,                     '+char(13)+
           '       b.PakkePrisID,                      '+char(13)+ 
           '       b.PakkeTypeID,                      '+char(13)+ 
           '       case  when  driftformid=9 then 9 else 0 end           UdeIndeID'+char(13)+ 
           ' into  '+@DestinationDB+'.dbo.DimPriser    '+char(13)+
'FROM        '+@PrisDB+'.dbo.PrisSetupPrisGruppe    AS a INNER JOIN   '+char(13)+
'            '+@PrisDB+'.dbo.PrisSetupPakker        AS b ON a.PrisGruppeID = b.PrisGruppeID inner join '+char(13)+
'            '+@PrisDB+'.dbo.PrisSetupPakkeMappeing AS c ON c.GMPakkeID = b.PakkeID '+char(13)+
'            where  leverandorid=27'+char(13)+
'            and    ((stednavnid=550  and driftformid=9)   '+char(13)+
'            or      (stednavnid=558  and driftformid=1))  '+char(13)+
'            and PGPakkeID is not null  '+char(13)+
'            group by'+char(13)+
'            c.PGPakkeID,       -- pakke'+char(13)+
'                 a.LeverandorID,  -- Leverandør'+char(13)+
'                 a.DriftFormID,   -- Driftform'+char(13)+
'                 b.StartDato,     -- StartDato'+char(13)+
'                 b.SlutDato,      -- SlutDato'+char(13)+
'                 b.AktivitetID, '+char(13)+
'                 b.PakkeGruppeID,'+char(13)+
'                 b.PakkePris,      '+char(13)+
'                 b.PakkeTid,			'+char(13)+
'                 b.PrisGruppeID,		'+char(13)+
'                 b.PakkePrisID, 		'+char(13)+
           '      b.PakkeTypeID'
if @debug = 1 print @cmd
exec (@cmd)
                 

set @cmd = 'CREATE UNIQUE NONCLUSTERED INDEX [DimPrisIndex] ON '+@DestinationDB+'.[dbo].[DimPriser] '+char(13)+
           '('+char(13)+
           '       	[PakkeID] ASC,'+char(13)+
           '       	[UdeIndeID] ASC,'+char(13)+
           '       	[StartDato] ASC,'+char(13)+
           '       	[SlutDato] ASC'+char(13)+
           '       )WITH '+char(13)+
           '       (PAD_INDEX  = OFF, '+char(13)+
           '       STATISTICS_NORECOMPUTE  = OFF, '+char(13)+
           '       SORT_IN_TEMPDB = OFF,'+char(13)+
           '       IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)



-- Tilføj PakkePris
if col_length(@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker', 'PakkePris') is not null 
BEGIN
    set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_Pakker'				+char(13)+
                ' DROP COLUMN [PakkePris]  '				+char(13)
    if @debug = 1 print @cmd
	exec (@cmd)
    
END

if col_length(@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker', 'PakkeDagsPris') is not null 
BEGIN
    set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_Pakker'				+char(13)+
                ' DROP COLUMN [PakkeDagsPris]  '				+char(13)
    if @debug = 1 print @cmd
	exec (@cmd)
    
END
if col_length(@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker', 'AktivitetID') is not null 
BEGIN
    set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_Pakker'				+char(13)+
                ' DROP COLUMN [AktivitetID]  '				+char(13)
    if @debug = 1 print @cmd
	exec (@cmd)
    
END
if col_length(@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker', 'UdeIndeID') is not null 
BEGIN
    set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_Pakker'				+char(13)+
                ' DROP COLUMN [UdeIndeID]  '				+char(13)
    if @debug = 1 print @cmd
	exec (@cmd)
    
END

set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_pakker'				+char(13)+
                ' ADD [PakkePris] numeric(18,2)   '				+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_pakker'				+char(13)+
                ' ADD [PakkeDagsPris] numeric(18,2)   '				+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_pakker'				+char(13)+
                ' ADD [AktivitetID] int   '				+char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 	'ALTER TABLE '+ @DestinationDB +'.dbo.FactVisiSagJobAfregnet_pakker'				+char(13)+
                ' ADD [UdeIndeID] int   '				+char(13)
exec (@cmd)

--Jira#92 Korrekte pakkepriser
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''DimOrganisationTilPriser'' AND type = ''U'') DROP TABLE DimOrganisationTilPriser'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * INTO DimOrganisationTilPriser from '+ @DestinationDB +'.dbo.DimOrganisation'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 	'ALTER TABLE DimOrganisationTilPriser ' +char(13)+
            'ADD [UdeIndeID] int ' +char(13)
exec (@cmd)

set @cmd = 	'UPDATE DimOrganisationTilPriser ' +char(13)+
            'SET UdeIndeID=9 ' +char(13)+
            'WHERE AFDELINGID=18 ' 
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker '+char(13)+
           'SET UDEINDEID=(SELECT UDEINDEID FROM DimOrganisationTilPriser B WHERE B.UAFDELINGID='+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.ORGANISATION)'
if @debug = 1 print @cmd
exec (@cmd)
--Jira#92


--set @cmd = ' update '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker 	            '+char(13)+
--           ' set    '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.UdeIndeID=9	'+char(13)+
--           ' WHERE  '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.SAGSID IN	    '+char(13)+
--           ' (SELECT  [SAGSID]--  ,b.[AFDELINGID] --  ,b.[AFDELINGNAVN]                 '+char(13)+
--           ' FROM [PGSTA].[dbo].[SAGER] left join  [PGEDW].[dbo].[DimOrganisation] b    '+char(13)+        
--           ' on coalesce([HJEMMEPLEJE_GRUPPEID],[HJGRP_AFTEN_ID],[HJGRP_NAT_ID],[HJGRP_WEEKEND_ID],  '+char(13)+        
--           '             [SYGEPLEJE_GRUPPEID]  ,[SPGRP_AFTEN_ID],[SPGRP_NAT_ID],[SPGRP_WEEKEND_ID],  '+char(13)+        
--           '             [TERAPEUT_GRUPPEID]   ,[TPGRP_AFTEN_ID],[TPGRP_NAT_ID],[TPGRP_WEEKEND_ID]) = b.[UAFDELINGID]   '+char(13)+  
--           '   where [AFDELINGID]= 18)'      
--if @debug = 1 print @cmd
--exec (@cmd)



set @cmd = ' update '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker 	'+char(13)+
           ' set    '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.PakkeDagsPris=case when '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.AntalPakker <0 then -a.[PakkePris] else a.[PakkePris] end ,	'+char(13)+
           '        '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.PakkePris    =a.[PakkePris] * '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.AntalPakker	'+char(13)+
           ' from '+@DestinationDB+'.[dbo].[DimPriser] a	'+char(13)+
           ' where '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.PK_Date between a.StartDato and a.SlutDato	'+char(13)+
           ' and   '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.PakkeID        = a.PakkeID	'+char(13)+
           ' and   coalesce('+@DestinationDB+'.dbo.FactVisiSagJobAfregnet_Pakker.UdeIndeID,0)     = a.UdeIndeID	'+char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimGMPakkeTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimGMPakkeTyper'
if @debug = 1 print @cmd
exec (@cmd)
	
set @cmd = ' select [PakkeTypeID],[PakkeType] into '+@DestinationDB+'.dbo.DimGMPakkeTyper from gmsta.dbo.[PrisSetupPakkeTyper]'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimAktiviteter'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimAktiviteter'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = ' select * into '+@DestinationDB+'.dbo.DimAktiviteter from gmsta.dbo.prissetupaktiviteter'
if @debug = 1 print @cmd
exec (@cmd)


-----------------------------------------------------------------------------------------------------
--3. usp_GetJobPlanDuration- PakkePris
-----------------------------------------------------------------------------------------------------

exec usp_GetJobPlanDuration pgedw