USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dim_Bolig]    Script Date: 06/25/2013 13:16:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Dim_Bolig] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBoligventeliste'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBoligventeliste'
if @debug = 1 print @cmd
exec (@cmd)
--opret DimBoligventeliste
set @cmd = 'SELECT '+char(13)+
           '  1 AS VENTELISTETYPEID,'+char(13)+
           '  ''Afslået boligtilbud'' AS VENTELISTETYPE'+char(13)+
           '  '+char(13)+
           'INTO '+@DestinationDB+'.DBO.DimBoligventeliste'+char(13)      
exec (@cmd)

set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligventeliste VALUES(2,''Garantiventeliste'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligventeliste VALUES(3,''Fritvalgsventeliste'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligventeliste VALUES(9999,''Fejl på venteliste'')'exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBoligFraflytning'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBoligFraflytning'
if @debug = 1 print @cmd
exec (@cmd)
--opret DimBoligFraflytning
set @cmd = 'SELECT '+char(13)+
           '  99 AS FRAFLYTNINGID,'+char(13)+
           '  ''Dødsfald       '' AS FRAFLYTNINGTYPE'+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimBoligFraflytning'+char(13)
if @debug = 1 print @cmd
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(1,''Samlivsophør'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(2,''Til plejebolig'')'exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBoliger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBoliger'
if @debug = 1 print @cmd
exec (@cmd)
--opret DimBoliger
set @cmd = 'SELECT '+char(13)+
           '  BO.ID AS BOLIGID,'+char(13)+
           '  BO.KENDENAVN AS BOLIGNAVN,'+char(13)+
           '  BO.ADRESSE,'+char(13)+
           '  CASE BO.HJEMSTED'+char(13)+
           '    WHEN 0 THEN ''Egen kommune'''+char(13)+
           '    WHEN 1 THEN ''Anden kommune'''+char(13)+
           '  END AS HJEMSTED,'+char(13)+
           '  COALESCE(BG.BOLIGGRUPPE,''Uden boliggruppe'') AS BOLIGGRUPPE,'+char(13)+
           '  CASE BO.STATUS'+char(13)+
           '    WHEN 0 THEN ''Aktiv'''+char(13)+
           '    WHEN 1 THEN ''Inaktiv'''+char(13)+
           '    WHEN 2 THEN ''Inaktiv ved fraflytning'''+char(13)+
           '  END AS BOLIGSTATUS, '+char(13)+ 
           '  DRIFT.KODE AS DRIFTFORM, '+char(13)+
           '  PLADS.KODE AS PLADSTYPE'+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+      
           'INTO '+@DestinationDB+'.dbo.DimBoliger '+char(13)+  
           'FROM BOLIGER BO '+char(13)+
           'JOIN BOLIG_DFPT DRIFT ON BO.DRIFTFORM=DRIFT.ID '+char(13)+
           'JOIN BOLIG_DFPT PLADS ON BO.PLADSTYPE=PLADS.ID'+char(13)+
           ''+char(13)+
           'LEFT JOIN BOLIGGRUPPER BG ON BO.BOLIGGRP=BG.GRUPPEID '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBorgerAlderGruppe'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBorgerAlderGruppe'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  1 AS ALDERGRP,'+char(13)+
           '  ''Under 20 år (født '+datename(year,dateadd(yy,-20,getdate()))+' eller senere)             '' AS TEKST'+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimBorgerAlderGruppe'+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(2,''20 - 29 år (født '+datename(year,dateadd(yy,-21,getdate()))+' - '+datename(year,dateadd(yy,-30,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(3,''30 - 39 år (født '+datename(year,dateadd(yy,-31,getdate()))+' - '+datename(year,dateadd(yy,-40,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(4,''40 - 59 år (født '+datename(year,dateadd(yy,-41,getdate()))+' - '+datename(year,dateadd(yy,-60,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(5,''60 - 64 år (født '+datename(year,dateadd(yy,-61,getdate()))+' - '+datename(year,dateadd(yy,-65,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(6,''65 - 66 år (født '+datename(year,dateadd(yy,-66,getdate()))+' - '+datename(year,dateadd(yy,-67,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(7,''67 - 74 år (født '+datename(year,dateadd(yy,-68,getdate()))+' - '+datename(year,dateadd(yy,-75,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(8,''75 - 79 år (født '+datename(year,dateadd(yy,-76,getdate()))+' - '+datename(year,dateadd(yy,-80,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(9,''80 - 84 år (født '+datename(year,dateadd(yy,-81,getdate()))+' - '+datename(year,dateadd(yy,-85,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(10,''85 - 89 år (født '+datename(year,dateadd(yy,-86,getdate()))+' - '+datename(year,dateadd(yy,-90,getdate()))+')'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(11,''90 år og derover (født '+datename(year,dateadd(yy,-91,getdate()))+' eller før)'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBorgerAlderGruppe VALUES(0,''Ingen aldersgruppe'')'exec (@cmd)
             
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=71)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (71,GETDATE())           
--end

END
