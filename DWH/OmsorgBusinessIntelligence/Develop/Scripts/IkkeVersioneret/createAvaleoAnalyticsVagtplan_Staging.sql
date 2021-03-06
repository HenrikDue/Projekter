USE [master]
GO
/****** Object:  Database [AvaleoAnalyticsVagtplan_Staging]    Script Date: 11/05/2010 08:31:59 ******/
CREATE DATABASE [AvaleoAnalyticsVagtplan_Staging] ON  PRIMARY 
( NAME = N'AvaleoAnalyticsVagtplan_Staging', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplan_Staging.mdf' , SIZE = 72704KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalyticsVagtplan_Staging_log', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplan_Staging_log.ldf' , SIZE = 18240KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AvaleoAnalyticsVagtplan_Staging].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ANSI_NULLS OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ANSI_PADDING OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ARITHABORT OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET  DISABLE_BROKER
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET  READ_WRITE
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET RECOVERY FULL
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET  MULTI_USER
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [AvaleoAnalyticsVagtplan_Staging] SET DB_CHAINING OFF
GO
USE [AvaleoAnalyticsVagtplan_Staging]
GO
/****** Object:  Table [dbo].[VP_MEDARB_V]    Script Date: 11/05/2010 08:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VP_MEDARB_V](
	[ADM_ENHEDS_ID] [float] NULL,
	[PERSONNR] [float] NULL,
	[PERSONNR_EKSTRA] [float] NULL,
	[AFLONNINGSFORM] [float] NULL,
	[ANSAET_DATO] [nvarchar](255) NULL,
	[FRATRAED_DATO] [nvarchar](255) NULL,
	[ADM_START] [nvarchar](255) NULL,
	[ADM_STOP] [nvarchar](255) NULL,
	[INITIALER] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VAGTPLAN_TJENESTE_TYPE]    Script Date: 11/05/2010 08:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VAGTPLAN_TJENESTE_TYPE](
	[TJENESTE_TYPE] [float] NULL,
	[TJENESTE_TYPE_NAVN] [nvarchar](max) NULL,
	[TJENESTE_TYPE_BESK] [nvarchar](max) NULL,
	[NAERVAER] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VAGTPLAN_KOMME_GAA_UD]    Script Date: 11/05/2010 08:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VAGTPLAN_KOMME_GAA_UD](
	[BRUGER_ID] [nvarchar](max) NULL,
	[ADM_ENHEDS_ID] [nvarchar](max) NULL,
	[PERSONNR] [nvarchar](max) NULL,
	[PERSONNR_EKSTRA] [nvarchar](max) NULL,
	[AFLONNINGSFORM] [nvarchar](max) NULL,
	[DATO_FRA] [nvarchar](255) NULL,
	[DATO_TIL] [nvarchar](255) NULL,
	[RULLEDATO] [nvarchar](255) NULL,
	[INDIVID_TYPE] [nvarchar](max) NULL,
	[SKEMAENHED_ID] [nvarchar](max) NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL,
	[AFV_ADM_ENHEDS_ID] [nvarchar](max) NULL,
	[DATO_BA_GG_OS] [nvarchar](255) NULL,
	[OMSORGSDAGE] [nvarchar](max) NULL,
	[AKTIVITETS_TEKST] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VAGTPLAN_KOMME_GAA_IND_TMP]    Script Date: 11/05/2010 08:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VAGTPLAN_KOMME_GAA_IND_TMP](
	[BRUGER_ID] [varchar](30) NULL,
	[ADM_ENHEDS_ID] [nvarchar](384) NULL,
	[PERSONNR] [varchar](10) NULL,
	[PERSONNR_EKSTRA] [varchar](1) NULL,
	[AFLONNINGSFORM] [nvarchar](384) NULL,
	[DATO_FRA] [datetime2](7) NULL,
	[DATO_TIL] [datetime2](7) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareVagtplanData]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_PrepareVagtplanData]
		@DestinationDB as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS

DECLARE @cmd as varchar(max)

if @ExPart=1 
--hent komme gå nærvær og fravær
begin

--hent fra komme_gaa_ud og find vagter over midnat
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep1'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+ 
           '  B.MEDARBEJDERID AS MEDID, ' +char(13)+ 
           '  C.UAFDELINGID AS MEDARB_ORG, ' +char(13)+
           '  A.PERSONNR, ' +char(13)+ 
           '  A.DATO_FRA, ' +char(13)+ 
           '  A.DATO_TIL, ' +char(13)+ 
           '  A.TJENESTE_TYPE, ' +char(13)+ 
           'CASE WHEN (DATEPART(DAYOFYEAR,DATO_TIL)-DATEPART(DAYOFYEAR,DATO_FRA))>0 THEN 1 ' +char(13)+ 
           'ELSE 0 ' +char(13)+                   --her skal der medid og gruppetilhør fra historik
           'END AS VAGT_OVER_MIDNAT ' +char(13)+ 
           'INTO FactVagtplanStep1 ' +char(13)+
           'FROM dbo.VAGTPLAN_KOMME_GAA_UD A ' +char(13)+
           'JOIN AvaleoAnalyticsDW.dbo.MEDARBEJDERE B ON A.PERSONNR=B.CPRNR'+char(13)+
           'JOIN AvaleoAnalyticsDW.dbo.MEDHISTORIK C ON B.MEDARBEJDERID=C.MEDARBEJDERID AND '+char(13)+
           '  CONVERT(DATETIME,SUBSTRING(A.DATO_FRA,1,16),102)<C.SLUTDATO AND CONVERT(DATETIME,SUBSTRING(A.DATO_FRA,1,16),102)>=C.IKRAFTDATO '
if @debug = 1 print @cmd           
exec (@cmd)

--dubler vagter over midnat
set @cmd = 'INSERT INTO FactVagtplanStep1 ' +char(13)+
           'SELECT ' +char(13)+
           '  B.MEDID, '  +char(13)+
           '  B.MEDARB_ORG,  ' +char(13)+
           '  B.PERSONNR, ' +char(13)+
           '  B.DATO_FRA, ' +char(13)+
           '  B.DATO_TIL, ' +char(13)+
           '  B.TJENESTE_TYPE,' +char(13)+
           '  2 AS VAGT_OVER_MIDNAT ' +char(13)+
           'FROM FactVagtplanStep1 B' +char(13)+
           'WHERE B.VAGT_OVER_MIDNAT=1' 
exec (@cmd)

--del vagter over midnat
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep2'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           'CASE WHEN VAGT_OVER_MIDNAT=2 THEN CONVERT(DATETIME,(SUBSTRING(DATO_TIL,1,10)+ '' 00:00:00''))' +char(13)+
           'ELSE CONVERT(DATETIME,SUBSTRING(DATO_FRA,1,16)) ' +char(13)+
           'END AS DATO_FRA, ' +char(13)+
           'CASE WHEN VAGT_OVER_MIDNAT=1 THEN CONVERT(DATETIME,(SUBSTRING(DATO_TIL,1,10)+ '' 00:00:00''))' +char(13)+
           'ELSE CONVERT(DATETIME,SUBSTRING(DATO_TIL,1,16)) ' +char(13)+
           'END AS DATO_TIL, ' +char(13)+ 
           '  TJENESTE_TYPE,' +char(13)+
           '  VAGT_OVER_MIDNAT' +char(13)+          
           'INTO FactVagtplanStep2' +char(13)+
           'FROM FactVagtplanStep1' 
if @debug = 1 print @cmd           
exec (@cmd)

-- tid til minutter
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep3'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep3'
if @debug = 1 print @cmd
exec (@cmd)
           
set @cmd = 'SELECT ' +char(13)+
           '  FactVagtplanStep2.PERSONNR, ' +char(13)+
           '  FactVagtplanStep2.MEDID, '  +char(13)+
           '  FactVagtplanStep2.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanStep2.DATO_FRA, ' +char(13)+
           '  FactVagtplanStep2.DATO_TIL, ' +char(13)+ --nedenstående for at få tidspunkt 00:00:00 efter dato
           '  Convert(datetime,substring(convert(varchar, convert(date,FactVagtplanStep2.DATO_FRA)),1,10)) AS PK_DATE, ' +char(13)+
           '  DATEDIFF(MINUTE,FactVagtplanStep2.DATO_FRA,FactVagtplanStep2.DATO_TIL) AS TJENESTETID_MINUTTER, ' +char(13)+  
           '  FactVagtplanStep2.TJENESTE_TYPE, ' +char(13)+
           '  VAGTPLAN_TJENESTE_TYPE.NAERVAER  ' +char(13)+
           'INTO FactVagtplanStep3 ' +char(13)+
           'FROM FactVagtplanStep2 ' +char(13)+
           'JOIN VAGTPLAN_TJENESTE_TYPE ON FactVagtplanStep2.TJENESTE_TYPE=VAGTPLAN_TJENESTE_TYPE.TJENESTE_TYPE'
exec (@cmd)

--del tjeneste i nærvær og fravær
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanNaervaer'' AND type = ''U'') DROP TABLE dbo.FactVagtplanNaervaer'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  TJENESTETID_MINUTTER, ' +char(13)+
           '  TJENESTE_TYPE ' +char(13)+
           'INTO FactVagtplanNaervaer ' +char(13)+
           'FROM FactVagtplanStep3 ' +char(13)+
           'WHERE NAERVAER>0'
exec (@cmd) 


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''FactVagtplanFravaer'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVagtplanFravaer'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  TJENESTETID_MINUTTER,' +char(13)+
           '  TJENESTE_TYPE' +char(13)+ 
           'INTO '+@DestinationDB+'.dbo.FactVagtplanFravaer ' +char(13)+
           'FROM FactVagtplanStep3' +char(13)+
           'WHERE NAERVAER=0'
exec (@cmd)

--er til test skal slettes


--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-17 08:00:00.000',121),convert(datetime,'2010-10-17 16:00:00.000',121),
--convert(datetime,'2010-10-17 00:00:00.000',121),480,1)
--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-17 08:00:00.000',121),convert(datetime,'2010-10-17 09:00:00.000',121),
--convert(datetime,'2010-10-17 00:00:00.000',121),60,403)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-17 08:00:00.000',121),convert(datetime,'2010-10-17 09:00:00.000',121),
--convert(datetime,'2010-10-17 00:00:00.000',121),60,399)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-17 12:00:00.000',121),convert(datetime,'2010-10-17 16:00:00.000',121),
--convert(datetime,'2010-10-17 00:00:00.000',121),240,207)

--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-18 08:00:00.000',121),convert(datetime,'2010-10-18 16:00:00.000',121),
--convert(datetime,'2010-10-18 00:00:00.000',121),480,1)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-18 10:00:00.000',121),convert(datetime,'2010-10-18 15:00:00.000',121),
--convert(datetime,'2010-10-18 00:00:00.000',121),300,399)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-18 12:00:00.000',121),convert(datetime,'2010-10-18 16:00:00.000',121),
--convert(datetime,'2010-10-18 00:00:00.000',121),240,207)

--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-19 08:00:00.000',121),convert(datetime,'2010-10-19 12:00:00.000',121),
--convert(datetime,'2010-10-19 00:00:00.000',121),240,1)
--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-19 12:00:00.000',121),convert(datetime,'2010-10-19 16:00:00.000',121),
--convert(datetime,'2010-10-19 00:00:00.000',121),240,1)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-19 08:00:00.000',121),convert(datetime,'2010-10-19 16:00:00.000',121),
--convert(datetime,'2010-10-19 00:00:00.000',121),480,207)

--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-20 08:00:00.000',121),convert(datetime,'2010-10-20 16:00:00.000',121),
--convert(datetime,'2010-10-20 00:00:00.000',121),480,1)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-20 08:00:00.000',121),convert(datetime,'2010-10-20 16:00:00.000',121),
--convert(datetime,'2010-10-20 00:00:00.000',121),480,204)

--insert into factvagtplannaervaer values('1111112222',666,9999,convert(datetime,'2010-10-21 10:00:00.000',121),convert(datetime,'2010-10-21 14:00:00.000',121),
--convert(datetime,'2010-10-21 00:00:00.000',121),240,1)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-21 08:00:00.000',121),convert(datetime,'2010-10-21 10:00:00.000',121),
--convert(datetime,'2010-10-21 00:00:00.000',121),120,399)
--insert into factvagtplanfravaer values('1111112222',666,9999,convert(datetime,'2010-10-21 12:00:00.000',121),convert(datetime,'2010-10-21 16:00:00.000',121),
--convert(datetime,'2010-10-21 00:00:00.000',121),120,207)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep1'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep1'
if @debug = 1 print @cmd
exec (@cmd)

--henter fravær hvor der er nærvær (der kan være fravær uden nærvær)
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  F.PERSONNR, ' +char(13)+
           '  F.MEDID, '  +char(13)+
           '  F.MEDARB_ORG, '  +char(13)+
           '  CASE WHEN F.DATO_FRA>N.DATO_FRA THEN F.DATO_FRA ELSE N.DATO_FRA END AS DATO_FRA, ' +char(13)+
           '  CASE WHEN F.DATO_TIL<N.DATO_TIL THEN F.DATO_TIL ELSE N.DATO_TIL END AS DATO_TIL,' +char(13)+
         --  '  HIGH(F.DATO_FRA,N.DATO_FRA), ' +char(13)+
         --  '  LOW(F.DATO_TIL,N.DATO_TIL), ' +char(13)+
           '  F.PK_DATE, ' +char(13)+
           '  F.TJENESTETID_MINUTTER,' +char(13)+
           '  F.TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep1 ' +char(13)+             
           'FROM '+@DestinationDB+'.dbo.FactVagtplanFravaer F ' +char(13)+   
           'JOIN FactVagtplanNaervaer N ON F.MEDID=N.MEDID AND ' +char(13)+        
           '  F.PK_DATE=N.PK_DATE AND ' +char(13)+        
           '  ((F.DATO_FRA<N.DATO_TIL) AND (F.DATO_TIL>N.DATO_FRA))'  --fravær skal ligge indenfor nærvær      
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep2'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep2'
if @debug = 1 print @cmd
exec (@cmd)

--grupper på dagen for at få samlede tjenestetid og periode
set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  MIN(DATO_FRA) AS DATO_FRA, ' +char(13)+
           '  MAX(DATO_TIL) AS DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  SUM(TJENESTETID_MINUTTER) AS TJENESTETID_MINUTTER,' +char(13)+
           '  -1 AS TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep2 ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep1 ' +char(13)+      
           'GROUP BY PERSONNR,MEDID,MEDARB_ORG, ' +char(13)+
           '  PK_DATE' 
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep3'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep3'
if @debug = 1 print @cmd
exec (@cmd)

--lav fraværs periode
set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  DATEDIFF(MINUTE,DATO_FRA,DATO_TIL) AS PERIODE_MINUTTER, '+char(13)+
           '  TJENESTETID_MINUTTER,' +char(13)+
           '  TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep3 ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep2 '  
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFremmoedeTmp'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFremmoedeTmp'
if @debug = 1 print @cmd
exec (@cmd)

--saml nærvær og fravær (laves negativt) i samme tabel
set @cmd = 'SELECT ' +char(13)+
           '  FactVagtplanNaervaer.PERSONNR, ' +char(13)+
           '  FactVagtplanNaervaer.MEDID, '  +char(13)+
           '  FactVagtplanNaervaer.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanNaervaer.DATO_FRA, ' +char(13)+
           '  FactVagtplanNaervaer.DATO_TIL, ' +char(13)+
           '  FactVagtplanNaervaer.PK_DATE, ' +char(13)+
           '  FactVagtplanNaervaer.TJENESTETID_MINUTTER,' +char(13)+
           '  FactVagtplanNaervaer.TJENESTE_TYPE' +char(13)+ 
           'INTO FactVagtplanBTPFremmoedeTmp ' +char(13)+
           'FROM FactVagtplanNaervaer' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.PERSONNR, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.MEDID, '  +char(13)+
           '  FactVagtplanBTPFravaerStep3.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanBTPFravaerStep3.DATO_FRA, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.DATO_TIL, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.PK_DATE, ' +char(13)+   --er fravær tjenestetiden større end fraværet i periode er der overlap og beregnet fraværperiode vælges  
           '  CASE WHEN FactVagtplanBTPFravaerStep3.TJENESTETID_MINUTTER>FactVagtplanBTPFravaerStep3.PERIODE_MINUTTER THEN '+char(13)+
           '  (FactVagtplanBTPFravaerStep3.PERIODE_MINUTTER)*-1 ' +char(13)+ 
           '  ELSE (FactVagtplanBTPFravaerStep3.TJENESTETID_MINUTTER)*-1 ' +char(13)+ --ellers er tjenestetiden ok 
           '  END AS TJENESTETID_MINUTTER,' +char(13)+
           '  FactVagtplanBTPFravaerStep3.TJENESTE_TYPE ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep3 ' +char(13)+           
           'UNION ALL ' +char(13)+
           'SELECT ' +char(13)+
           '  A.PERSONNR, ' +char(13)+
           '  A.MEDID, '  +char(13)+
           '  A.MEDARB_ORG, '  +char(13)+
           '  A.DATO_FRA, ' +char(13)+
           '  A.DATO_TIL, ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.TJENESTETID_MINUTTER,' +char(13)+
           '  A.TJENESTE_TYPE ' +char(13)+            
           'FROM '+@DestinationDB+'.dbo.FactVagtplanFravaer A' +char(13)+
           'WHERE (A.TJENESTE_TYPE=204)'  --kurser hentes da de tæller med i BTP                  
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactVagtplanBTPFremmoede'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVagtplanBTPFremmoede'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  SUM(TJENESTETID_MINUTTER) AS TJENESTETID_MINUTTER, ' +char(13)+
           '  PK_DATE' +char(13)+
           'INTO '+@DestinationDB+'.dbo.FactVagtplanBTPFremmoede ' +char(13)+
           'FROM FactVagtplanBTPFremmoedeTmp' +char(13)+
           'GROUP BY PERSONNR,MEDID,MEDARB_ORG,PK_DATE'   
if @debug = 1 print @cmd
exec (@cmd)

end

if @ExPart=2 
--hent KMD tjenestetyper
begin

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimKMDFravaerstyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimKMDFravaerstyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  TJENESTE_TYPE, ' +char(13)+
           '  TJENESTE_TYPE_NAVN,' +char(13)+
           '  TJENESTE_TYPE_BESK' +char(13)+
           'INTO '+@DestinationDB+'.dbo.DimKMDFravaerstyper' +char(13)+
           'FROM AvaleoAnalyticsVagtplan_Staging.dbo.VAGTPLAN_TJENESTE_TYPE' +char(13)+
           'WHERE VAGTPLAN_TJENESTE_TYPE.NAERVAER=0' +char(13)+
           '' +char(13)+
           ''   
exec (@cmd)

end
GO
/****** Object:  StoredProcedure [dbo].[usp_ImportKMDData]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ImportKMDData]
                 @DestinationDB as varchar(200),@ExPart as Int=0,@Debug  as bit = 1
AS

DECLARE @cmd as varchar(max)
DECLARE @LinkedServer as varchar(50)
DECLARE @BiUser as varchar(10)
DECLARE @DageFrem as varchar(2)
DECLARE @DageTilbage as varchar(2)

SET @LinkedServer = 'VAGTPLAN'
SET @BiUser = 'BIUSER'
SET @DageFrem = '14'
SET @DageTilbage  = '7'

if @ExPart=1
begin
--hent VP_MEDARB_V og TJENESTE_TYPE fra KMD
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''TJENESTE_TYPE'' AND type = ''U'') DROP TABLE dbo.TJENESTE_TYPE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * ' +char(13)+
           'INTO VAGTPLAN_TJENESTE_TYPE ' +char(13)+
           'FROM OPENQUERY('+@LinkedServer+',SELECT * FROM TJENESTE_TYPE)' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
--exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VP_MEDARB_V'' AND type = ''U'') DROP TABLE dbo.VP_MEDARB_V'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'SELECT * ' +char(13)+
           'INTO VP_MEDARB_V ' +char(13)+
           'FROM OPENQUERY('+@LinkedServer+',SELECT * FROM VP_MEDARB_V ' +char(13)+
           'WHERE VP_MEDARB_V.ADM_START<=CONVERT(DATE,GETDATE()+'+@DageFrem+') AND ' +char(13)+
           '  VP_MEDARB_V.ADM_START>CONVERT(DATE,GETDATE()-'+@DageTilbage+'))' +char(13)+           
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
--exec (@cmd)
         
end


if @ExPart=2
BEGIN

--lav tmp tabel og indsæt data i KMD KOMME_GAA_IND tabel 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''KOMME_GAA_IND_TMP'' AND type = ''U'') DROP TABLE dbo.KOMME_GAA_IND_TMP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '  +char(13)+
           '  '''+@BiUser+''' AS BRUGER_ID, ' +char(13)+
           '  MED.CPRNR AS PERSONNR,' +char(13)+
           '  MED.PERSONNR_EKSTRA, ' +char(13)+
           '  VP_MED.ADM_ENHEDS_ID, ' +char(13)+
           '  VP_MED.AFLONNINGSFORM, ' +char(13)+
           '  CONVERT(DATE,GETDATE()-'+@DageTilbage+') AS DATO_FRA, ' +char(13)+
           '  CONVERT(DATE,GETDATE()+'+@DageFrem+') AS DATO_TIL ' +char(13)+
           'INTO KOMME_GAA_IND_TMP ' +char(13)+
           'FROM AvaleoAnalytics_Staging.dbo.MEDARBEJDERE MED ' +char(13)+
           'JOIN VP_MEDARB_V VP_MED ON MED.CPRNR=VP_MED.PERSONNR ' +char(13)+
           'WHERE MED.MEDARBEJDERTYPE=0 AND MED.MEDARBEJDER_STATUS=1 ' +char(13)+ 
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
           
if @debug = 1 print @cmd           
exec (@cmd) 

--ryd op i KOMME_GAA_IND tabel
set @cmd = 'SELECT * FROM OPENQUERY('+@LinkedServer+',DELETE FROM KOMME_GAA_IND WHERE BRUGERID='+@BiUser+')' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' 
--exec (@cmd) 
--indsat temp data i KOMME_GAA_IND tabel
set @cmd = 'INSERT OPENQUERY('+@LinkedServer+', ' +char(13)+
         --  '  INSERT INTO KOMME_GAA_IND VALUES( ' +char(13)+
           '  ''SELECT ' +char(13)+
           '    BRUGER_ID, ' +char(13)+
           '    PERSONNR, ' +char(13)+
           '    PERSONNR_EKSTRA, ' +char(13)+
           '    ADM_ENHEDS_ID, ' +char(13)+
           '    AFLONNINGSFORM,' +char(13)+
           '    DATO_FRA, ' +char(13)+
           '    DATO_TIL' +char(13)+
           '    FROM KOMME_GAA_IND'')' +char(13)+
           ' values ' +char(13)+
           '  ( ' +char(13)+
           '    ''BIUSER'', ' +char(13)+
           '    ''1309672557'', ' +char(13)+
           '    ''0'', ' +char(13)+
           '    50, ' +char(13)+
           '    3,' +char(13)+
           '    ''2004/08/05'', ' +char(13)+
           '    ''2004/09/05'')' +char(13)+           
         --  '  FROM '+@DestinationDB+'.dbo.VAGTPLAN_KOMME_GAA_IND_TMP)' +char(13)+
           '' +char(13)+
           '' +char(13)+                      
          -- '))' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
           
--INSERT OPENQUERY (OracleSvr, 'SELECT name FROM joe.titles')
--VALUES ('NewTitle');           
           
           
if @debug = 1 print @cmd            
exec (@cmd) 
end

if @ExPart=3
begin                               
--eksekver stored procedure i KMD db

set @cmd = 'SELECT * FROM OPENQUERY('+@LinkedServer+', EXECUTE SP KOMME_GAA_TIDER.FIND_PERSON PARAM='+@BiUser+')' +char(13)+ --pseudo kode
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
--exec (@cmd) 
end

if @ExPart=4
begin  
--flyt data fra KMD KOMME_GAA_UD til staging

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''VAGTPLAN_KOMME_GAA_UD'' AND type = ''U'') DROP TABLE dbo.VAGTPLAN_KOMME_GAA_UD'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'SELECT * ' +char(13)+
           'INTO '+@DestinationDB+'.dbo.VAGTPLAN_KOMME_GAA_UD ' +char(13)+
           'FROM OPENQUERY('+@LinkedServer+',SELECT * FROM KOMME_GAA_UD WHERE BRUGERID='+@BiUser+')' +char(13)+ +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
--exec (@cmd)           
          
                      
set @cmd = '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           '' +char(13)+
           ''
           
END
GO
/****** Object:  Table [dbo].[KOMME_GAA_IND_TMP]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[KOMME_GAA_IND_TMP](
	[BRUGER_ID] [varchar](6) NOT NULL,
	[PERSONNR] [nvarchar](10) NULL,
	[PERSONNR_EKSTRA] [int] NOT NULL,
	[ADM_ENHEDS_ID] [float] NULL,
	[AFLONNINGSFORM] [float] NULL,
	[DATO_FRA] [date] NULL,
	[DATO_TIL] [date] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactVagtplanStep3]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanStep3](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL,
	[NAERVAER] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanStep2]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanStep2](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL,
	[VAGT_OVER_MIDNAT] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanStep1]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanStep1](
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[PERSONNR] [nvarchar](max) NULL,
	[DATO_FRA] [nvarchar](255) NULL,
	[DATO_TIL] [nvarchar](255) NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL,
	[VAGT_OVER_MIDNAT] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanNaervaer]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanNaervaer](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanFravaer]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanFravaer](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFremmoedeTmp]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFremmoedeTmp](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFremmoede]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFremmoede](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[PK_DATE] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFravaerStep3]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFravaerStep3](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[PERIODE_MINUTTER] [int] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFravaerStep2]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFravaerStep2](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFravaerStep1]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFravaerStep1](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVagtplanBTPFravaer]    Script Date: 11/05/2010 08:32:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVagtplanBTPFravaer](
	[PERSONNR] [nvarchar](max) NULL,
	[MEDID] [int] NOT NULL,
	[MEDARB_ORG] [int] NOT NULL,
	[DATO_FRA] [datetime] NULL,
	[DATO_TIL] [datetime] NULL,
	[PK_DATE] [datetime] NULL,
	[PERIODE_MINUTTER] [int] NULL,
	[TJENESTETID_MINUTTER] [int] NULL,
	[TJENESTE_TYPE] [int] NOT NULL
) ON [PRIMARY]
GO
