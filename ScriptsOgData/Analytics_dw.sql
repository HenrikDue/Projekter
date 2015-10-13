USE [master]
GO
/****** Object:  Database [AvaleoAnalytics_DWa]    Script Date: 10/06/2015 18:34:03 ******/
CREATE DATABASE [AvaleoAnalytics_DWa] ON  PRIMARY 
( NAME = N'AvaleoAnalytics_DWa', FILENAME = N'c:\avaleoproj\data\AvaleoAnalytics_DWa.mdf' , SIZE = 6000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalytics_DWa_log', FILENAME = N'c:\avaleoproj\log\AvaleoAnalytics_DWa_Log.ldf' , SIZE = 6000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AvaleoAnalytics_DWa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ANSI_NULLS OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ANSI_PADDING OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ARITHABORT OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET  DISABLE_BROKER
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET  READ_WRITE
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET RECOVERY SIMPLE
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET  MULTI_USER
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [AvaleoAnalytics_DWa] SET DB_CHAINING OFF
GO
USE [AvaleoAnalytics_DWa]
GO
/****** Object:  User [NT AUTHORITY\NETWORK SERVICE]    Script Date: 10/06/2015 18:34:03 ******/
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[VERSION]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VERSION](
	[VERSION] [int] NOT NULL,
	[OPDATERINGSDATO] [datetime] NOT NULL,
 CONSTRAINT [PK_VERSION] PRIMARY KEY CLUSTERED 
(
	[VERSION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STILLINGBET]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STILLINGBET](
	[STILLINGID] [int] NOT NULL,
	[STILLINGNAVN] [nvarchar](50) NOT NULL,
	[PCVAGTID] [int] NULL,
	[PCVAGTSYNC] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSTYPE]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSTYPE](
	[SAGSTYPEID] [int] NOT NULL,
	[SAGSTYPENAVN] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSSTATUS]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSSTATUS](
	[SAGSSTATUSID] [int] NOT NULL,
	[SAGSTYPE] [int] NOT NULL,
	[SAGAKTIV] [int] NOT NULL,
	[STATUSNAVN] [nvarchar](50) NOT NULL,
	[ERGLOBAL] [int] NULL,
	[HJEMMEPLEJEN] [int] NULL,
	[SYGEPLEJEN] [int] NULL,
	[TERAPEUTER] [int] NULL,
	[SKAT] [int] NULL,
	[SERVICEAFD] [int] NULL,
	[MADSERVICE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEDSTATUS]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEDSTATUS](
	[MEDSTATUSID] [int] NOT NULL,
	[MEDAKTIV] [int] NOT NULL,
	[STATUSNAVN] [nvarchar](50) NOT NULL,
	[KMDFR] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEDHISTORIK]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEDHISTORIK](
	[ID] [int] NOT NULL,
	[MEDARBEJDERID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[MEDARBEJDER_STATUS] [int] NOT NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[TIMER] [int] NOT NULL,
	[STILLINGSID] [int] NOT NULL,
	[UAFDELINGID] [int] NOT NULL,
	[AFDELINGID] [int] NOT NULL,
	[VAGTER] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEDARBEJDERE]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEDARBEJDERE](
	[MEDARBEJDERID] [int] NOT NULL,
	[OPRETTET] [datetime] NULL,
	[FODDATO] [date] NULL,
	[MEDARBEJDER_STATUS] [int] NOT NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[FORNAVN] [nvarchar](50) NOT NULL,
	[EFTERNAVN] [nvarchar](50) NOT NULL,
	[ADRESSE] [nvarchar](70) NULL,
	[POSTNR] [nvarchar](4) NULL,
	[TIMER] [int] NOT NULL,
	[STILLINGSID] [int] NOT NULL,
	[UAFDELINGID] [int] NOT NULL,
	[AFDELINGID] [int] NOT NULL,
	[RETTET] [date] NULL,
	[KMD_MEDNR] [nvarchar](8) NULL,
	[ANSATDATO] [date] NOT NULL,
	[EMAIL] [nvarchar](100) NULL,
	[UPDATPEN] [datetime] NOT NULL,
	[TELEFON] [nvarchar](30) NULL,
	[ALTTELEFON] [nvarchar](30) NULL,
	[MOBILTELEFON] [nvarchar](30) NULL,
	[TLF_HEMMELIGT] [int] NULL,
	[ALTTLF_HEMMELIGT] [int] NULL,
	[MOBIL_HEMMELIGT] [int] NULL,
	[MEDARBEJDERNR] [int] NULL,
	[MEDARBEJDERINIT] [nvarchar](5) NULL,
	[MEDARBEJDERTYPE] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[PERSONNR_EKSTRA] [int] NOT NULL,
	[COADR] [nvarchar](70) NULL,
	[VAGTER] [int] NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL,
	[CPR_VEJNAVN] [nvarchar](40) NULL,
	[CPR_HUSNR] [nvarchar](4) NULL,
	[CPR_ETAGE] [nvarchar](2) NULL,
	[CPR_SIDEDOR] [nvarchar](4) NULL,
	[TRANSPORT] [int] NOT NULL,
	[STARTFROM] [int] NOT NULL,
	[STARTLOKALE] [int] NULL,
	[ABP_FIKTIV] [int] NOT NULL,
	[AFLON_FORM] [int] NULL,
	[ADR_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JOBTYPER]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOBTYPER](
	[JOBID] [int] NOT NULL,
	[JOBNAVN] [nvarchar](100) NOT NULL,
	[KATEGORI] [int] NOT NULL,
	[NIVEAU1] [int] NOT NULL,
	[NIVEAU2] [int] NOT NULL,
	[NIVEAU3] [int] NOT NULL,
	[SLETTET_JOB] [int] NULL,
	[SKRIVEBESKYTTET] [int] NULL,
	[FALLES_SPROG_KAT_KODE] [int] NULL,
	[FALLES_SPROG_NIV1_KODE] [int] NULL,
	[FALLES_SPROG_NIV2_KODE] [int] NULL,
	[FALLES_SPROG_NIV3_KODE] [int] NULL,
	[SIDSTE_VITALE_AENDRING] [datetime] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[NORMTID2] [int] NULL,
	[NORMTID3] [int] NULL,
	[NORMTID4] [int] NULL,
	[FUNKKAT] [int] NULL,
	[MAXTID2] [int] NULL,
	[MAXTID3] [int] NULL,
	[MAXTID4] [int] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[NORMTID1] [int] NULL,
	[MAXTID1] [int] NULL,
	[BTP] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVisisagjobAfregnet_TilAfgang]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVisisagjobAfregnet_TilAfgang](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NULL,
	[Hjalptype] [int] NOT NULL,
	[Specifikation] [int] NOT NULL,
	[VisiJob] [float] NULL,
	[VisijobHverdag] [float] NULL,
	[VisijobWeekend] [float] NULL,
	[Jobid] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[PrisStart] [datetime] NULL,
	[PrisSlut] [datetime] NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL,
	[INTERNLEVERANDOERID] [int] NULL,
	[BorgerStart] [datetime] NULL,
	[BorgerSlut] [datetime] NULL,
	[NormTid] [int] NULL,
	[Antal_Pakker] [float] NULL,
	[Antal] [decimal](18, 10) NULL,
	[ViSiID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactVisiSagJobAfregnet]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactVisiSagJobAfregnet](
	[Alder] [int] NULL,
	[CprNr] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NULL,
	[Hjemmepleje_Status] [int] NOT NULL,
	[StatusID] [int] NULL,
	[Organisation] [int] NULL,
	[DognInddeling] [int] NULL,
	[Hjalptype] [int] NOT NULL,
	[Specifikation] [int] NOT NULL,
	[VisiSagJob] [float] NULL,
	[VISITERET_TID_Hverdag] [float] NULL,
	[VISITERET_TID_Weekend] [float] NULL,
	[VISITERET_TID_HELLIGDAG] [float] NULL,
	[JobID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[Antal_Pakker] [float] NULL,
	[FritValgLev] [int] NULL,
	[InternLeverandoerID] [int] NULL,
	[BorgerStart] [datetime] NULL,
	[BorgerSlut] [datetime] NULL,
	[PK_Date] [datetime] NOT NULL,
	[Antal] [float] NULL,
	[AntalTotal] [decimal](20, 10) NULL,
	[VisiID] [int] NULL,
	[JobLeveringsTidID] [int] NULL,
	[Funktionsscore] [float] NULL,
	[FunktionsscoreNaevner] [int] NULL,
	[FunktionsscoreTotal] [int] NULL,
	[FunktionsscoreCounter] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactUdfoertTid]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactUdfoertTid](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[BORGERORG] [int] NULL,
	[STATUSID] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MEDARB_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[JOBID] [int] NOT NULL,
	[UDFOERT_TID] [decimal](31, 21) NULL,
	[UDFOERT_TID_HVERDAG] [decimal](31, 21) NULL,
	[UDFOERT_TID_WEEKEND] [decimal](31, 21) NULL,
	[UDFOERT_TID_HELLIGDAG] [decimal](31, 21) NULL,
	[MOBIL_TID] [int] NOT NULL,
	[MOBIL_TID_HVERDAG] [int] NULL,
	[MOBIL_TID_WEEKEND] [int] NULL,
	[MOBIL_TID_HELLIGDAG] [int] NOT NULL,
	[REGBES] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](28) NOT NULL,
	[STEP] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactTimerPlan]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactTimerPlan](
	[PK_DATE] [datetime] NULL,
	[MEDID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](23, 15) NULL,
	[PLANLAGTTIMER] [decimal](26, 10) NULL,
	[OMFORDELTTID] [numeric](22, 6) NULL,
	[FRAVAERSTIMER] [decimal](38, 6) NULL,
	[FRAVAERSDAGE] [decimal](20, 10) NULL,
	[DELVIST_SYG] [nvarchar](1) NULL,
	[SYGDOMSPERIOD] [decimal](20, 10) NULL,
	[FRAVAERTYPEID] [int] NULL,
	[TJENESTETYPERID] [int] NULL,
	[TJENESTEGROUPID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactPlanlagtUdfoert]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactPlanlagtUdfoert](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[STATUSID] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[JOBID] [int] NOT NULL,
	[PLANLAGT_TID] [decimal](31, 21) NULL,
	[PLANLAGT_TID_HVERDAG] [decimal](31, 21) NULL,
	[PLANLAGT_TID_WEEKEND] [decimal](31, 21) NULL,
	[PLANLAGT_TID_HELLIGDAG] [decimal](31, 21) NULL,
	[UDFOERT_TID] [decimal](31, 21) NULL,
	[UDFOERT_TID_HVERDAG] [decimal](31, 21) NULL,
	[UDFOERT_TID_WEEKEND] [decimal](31, 21) NULL,
	[UDFOERT_TID_HELLIGDAG] [decimal](31, 21) NULL,
	[MOBIL_TID] [int] NOT NULL,
	[MOBIL_TID_HVERDAG] [int] NULL,
	[MOBIL_TID_WEEKEND] [int] NULL,
	[MOBIL_TID_HELLIGDAG] [int] NOT NULL,
	[REGBES] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](28) NOT NULL,
	[STEP] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactPlanlagtTid]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactPlanlagtTid](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[BORGERORG] [int] NULL,
	[STATUSID] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MEDARB_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[JOBID] [int] NOT NULL,
	[PLANLAGT_TID] [decimal](31, 21) NULL,
	[PLANLAGT_TID_HVERDAG] [decimal](31, 21) NULL,
	[PLANLAGT_TID_WEEKEND] [decimal](31, 21) NULL,
	[PLANLAGT_TID_HELLIGDAG] [decimal](31, 21) NULL,
	[REGBES] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](28) NOT NULL,
	[STEP] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactForbrugsafvigelse]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FactForbrugsafvigelse](
	[ID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[SERIEID] [int] NULL,
	[SAGSID] [int] NOT NULL,
	[MEDID] [int] NULL,
	[RETDATO] [datetime] NOT NULL,
	[START] [int] NOT NULL,
	[TID] [int] NOT NULL,
	[VEJTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[STATUSID] [int] NOT NULL,
	[RSTART] [int] NOT NULL,
	[RTID] [int] NOT NULL,
	[RVEJTID] [int] NOT NULL,
	[REGBES] [int] NOT NULL,
	[SERIEDATO] [datetime] NULL,
	[VISISTART] [int] NOT NULL,
	[VISISLUT] [int] NOT NULL,
	[Målt] [varchar](14) NOT NULL,
	[Forbrugsstatus] [varchar](26) NOT NULL,
	[Samlet_Forbrugsafvigelse] [int] NULL,
	[JOBID] [int] NOT NULL,
	[Normtid_Ydelse] [int] NOT NULL,
	[Fordelt_Forbrug] [int] NULL,
	[Fordelt_Forbrugsafvigelse] [int] NULL,
	[Fordelt_Vejtid] [int] NULL,
	[HJEMMEPLEJE_STATUS] [int] NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[SYGEPLEJE_STATUS] [int] NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[TERAPEUT_STATUS] [int] NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[GRUPPEID] [int] NULL,
	[MEDARBEJDER_STATUS] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[MedarbGrp] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactBTP]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTP](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NULL,
	[PK_DATE] [datetime] NULL,
	[UDFOERTTID] [decimal](38, 7) NULL,
	[TJENESTETID] [decimal](38, 7) NULL,
	[ARBEJDSTID] [decimal](38, 7) NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBruger]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBruger](
	[BRUGERID] [int] NOT NULL,
	[TABELDATO] [datetime2](7) NULL,
	[PK_DATE] [date] NULL,
	[BEVAEGID] [int] NOT NULL,
	[BRUGERSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBorger]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBorger](
	[SAGSID] [int] NULL,
	[PKDate] [datetime] NULL,
	[Foedselsdag] [datetime] NULL,
	[AlderDage] [float] NULL,
	[AlderAar] [float] NULL,
	[AlderAarAfrund] [float] NULL,
	[AlderGruppe] [float] NULL,
	[AlderGruppeStart] [float] NULL,
	[AlderGruppeSlut] [float] NULL,
	[Specifikation] [int] NOT NULL,
	[Borger] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBoligIndflyt]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBoligIndflyt](
	[SAGSID] [int] NOT NULL,
	[BOLIGID] [int] NOT NULL,
	[PK_DATE] [date] NULL,
	[BORGERALDER] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_VisitationTilAfgang]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fact_VisitationTilAfgang](
	[PK_DATE] [datetime] NULL,
	[SAGSID] [int] NULL,
	[ALDER] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[JOBID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FACT_VISISAGJOB_Afregnet_udenJobpriser]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_VISISAGJOB_Afregnet_udenJobpriser](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[Dogninddeling] [int] NULL,
	[Hjalptype] [int] NOT NULL,
	[Specifikation] [int] NOT NULL,
	[VisiJob] [float] NULL,
	[VisiJobHverdag] [float] NULL,
	[VisiJobWeekend] [float] NULL,
	[JobID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[Antal_pakker] [float] NULL,
	[FritValgLev] [int] NULL,
	[InternLeverandoerID] [int] NULL,
	[BorgerStart] [datetime] NULL,
	[BorgerSlut] [datetime] NULL,
	[PK_Date] [datetime] NOT NULL,
	[AntalTotal] [decimal](20, 10) NULL,
	[VisiID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_TPVisiSagJob_TPTB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_TPVisiSagJob_TPTB](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[TPVISI_TP] [decimal](38, 17) NULL,
	[type] [int] NOT NULL,
	[Pris] [numeric](38, 12) NULL,
	[pstart] [datetime] NULL,
	[Pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[TPVISIJOB] [decimal](38, 17) NULL,
	[TPVISIJOBHverdag] [decimal](38, 6) NULL,
	[TPVISIJOBWeekend] [decimal](38, 6) NULL,
	[TPVISIJOBantal] [decimal](32, 21) NULL,
	[Dato] [datetime] NOT NULL,
	[jobid] [int] NULL,
	[FRITVALGLEV] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_TPVisiSag_TB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_TPVisiSag_TB](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[dato] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[TPVISI_TB] [float] NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_TPVisiSag_AfregnetJob_TPTB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_TPVisiSag_AfregnetJob_TPTB](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[TPVISI_TP] [decimal](38, 17) NULL,
	[type] [int] NOT NULL,
	[Pris] [numeric](38, 12) NULL,
	[pstart] [datetime] NULL,
	[Pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[TPVISIJOB] [decimal](38, 17) NULL,
	[TPVISIJOBHverdag] [decimal](38, 6) NULL,
	[TPVISIJOBWeekend] [decimal](38, 6) NULL,
	[TPVISIJOBantal] [decimal](32, 21) NULL,
	[Dato] [datetime] NULL,
	[jobid] [int] NULL,
	[FRITVALGLEV] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_TPVisiSag_Afregnet_TB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_TPVisiSag_Afregnet_TB](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[dato] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[TPVISI_TB] [float] NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSagJob]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSagJob](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[visiid] [int] NOT NULL,
	[Sagsid] [int] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[HJPL_DAGGRP_ID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[JOBID] [int] NULL,
	[ID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[SPVISIJOB] [decimal](38, 6) NULL,
	[SPVISIJOBHverdag] [decimal](38, 6) NULL,
	[SPVISIJOBWeekend] [decimal](38, 6) NULL,
	[SPVISIJOBantal] [decimal](38, 14) NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSag_pakker]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSag_pakker](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[SPVISI] [int] NULL,
	[type] [int] NOT NULL,
	[Pakke_Visitype] [int] NULL,
	[Pakke_Ugentlig_Leveret] [numeric](12, 2) NULL,
	[Pakke_ID] [int] NULL,
	[Pakke_Lev_ID] [int] NULL,
	[specifikation] [int] NOT NULL,
	[dato] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSag_AfregnetJob]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSag_AfregnetJob](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[visiid] [int] NOT NULL,
	[Sagsid] [int] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[HJPL_DAGGRP_ID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[JOBID] [int] NULL,
	[ID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[SPVISIJOB] [decimal](38, 6) NULL,
	[SPVISIJOBHverdag] [decimal](38, 6) NULL,
	[SPVISIJOBWeekend] [decimal](38, 6) NULL,
	[SPVISIJOBantal] [decimal](38, 14) NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSag_Afregnet_pakker]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSag_Afregnet_pakker](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[SPVISI] [int] NULL,
	[type] [int] NOT NULL,
	[Pakke_Visitype] [int] NULL,
	[Pakke_Ugentlig_Leveret] [numeric](12, 2) NULL,
	[Pakke_ID] [int] NULL,
	[Pakke_Lev_ID] [int] NULL,
	[specifikation] [int] NOT NULL,
	[dato] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSag_Afregnet]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSag_Afregnet](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[SPVISI] [float] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_SPVisiSag]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_SPVisiSag](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[SPVISI] [float] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_MADVisiSagJob]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_MADVisiSagJob](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[dato] [datetime] NOT NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[MADVISI_STATUSID] [int] NULL,
	[organization] [int] NOT NULL,
	[madleverancer] [float] NULL,
	[madleverancerHverdag] [float] NULL,
	[madleverancerWeekend] [float] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[JOBID] [int] NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[PRIS] [int] NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[FRITVALGLEV] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_MADVisiSag_AfregnetJob]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_MADVisiSag_AfregnetJob](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSID] [int] NOT NULL,
	[dato] [datetime] NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[MADVISI_STATUSID] [int] NULL,
	[organization] [int] NOT NULL,
	[madleverancer] [float] NULL,
	[madleverancerHverdag] [float] NULL,
	[madleverancerWeekend] [float] NULL,
	[dogninddeling] [int] NOT NULL,
	[specifikation] [int] NOT NULL,
	[count] [int] NOT NULL,
	[JOBID] [int] NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[PRIS] [int] NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[FRITVALGLEV] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_LedigeBoliger]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_LedigeBoliger](
	[PK_DATE] [date] NULL,
	[BOLIGID] [int] NULL,
	[DFPTID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_HJVisiSagJob_PBPP]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_HJVisiSagJob_PBPP](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[VisiID] [int] NULL,
	[SagsID] [int] NOT NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NULL,
	[Hjalptype] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[dato] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[JobID] [int] NULL,
	[ID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[HJVISIJOB] [decimal](38, 6) NULL,
	[HJVISIJOBHverdag] [decimal](38, 6) NULL,
	[HJVISIJOBWeekend] [decimal](38, 6) NULL,
	[HJVISIJOBAntal] [decimal](38, 14) NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_HJVisiSag_PB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_HJVisiSag_PB](
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[Specifikation] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[HjVisi_PB] [float] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_HJVisiSag_AfregnetJob_PBPP]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_HJVisiSag_AfregnetJob_PBPP](
	[Alder] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[VisiID] [int] NULL,
	[SagsID] [int] NOT NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[organization] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NULL,
	[Hjalptype] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[dato] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[Type] [int] NOT NULL,
	[JobID] [int] NULL,
	[ID] [int] NULL,
	[Pris] [numeric](38, 6) NULL,
	[pstart] [datetime] NULL,
	[pslut] [datetime] NULL,
	[specifikation] [int] NOT NULL,
	[HJVISIJOB] [decimal](38, 6) NULL,
	[HJVISIJOBHverdag] [decimal](38, 6) NULL,
	[HJVISIJOBWeekend] [decimal](38, 6) NULL,
	[HJVISIJOBAntal] [decimal](38, 14) NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACT_HJVisiSag_Afregnet_PB]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACT_HJVisiSag_Afregnet_PB](
	[SagsID] [int] NOT NULL,
	[Dato] [datetime] NOT NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[Organization] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[Specifikation] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[HjVisi_PB] [float] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_FunktionsNiveau]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fact_FunktionsNiveau](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_STATUS] [int] NULL,
	[BORGER_STATUSID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[DIM_FUNKNIVEAU_ID] [int] NULL,
	[FS_TYPE] [varchar](3) NOT NULL,
	[VISI_TID_HVERDAG] [numeric](38, 6) NULL,
	[VISI_TID_WEEKEND] [numeric](38, 6) NULL,
	[VISI_TID_TOTAL] [numeric](38, 6) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fact_Fraflyt]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Fraflyt](
	[driftform] [int] NULL,
	[sagsid] [int] NULL,
	[pk_date] [date] NOT NULL,
	[fraflytid] [int] NOT NULL,
	[boligid] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Boligventeliste]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Boligventeliste](
	[PK_DATE] [datetime] NULL,
	[SAGSID] [int] NOT NULL,
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[TILBUD_DATO] [date] NULL,
	[VENTETID_DAGE] [int] NULL,
	[DRIFTFORM] [int] NOT NULL,
	[PLADSTYPE] [int] NOT NULL,
	[DFPTID] [nvarchar](2) NULL,
	[FRA_GARANTI_LISTE] [int] NULL,
	[FRITVALGSVENTELISTE] [int] NOT NULL,
	[VENTELISTETYPEID] [int] NOT NULL,
	[ANTAL_BORGERE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Boligliste]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Boligliste](
	[PK_DATE] [datetime] NOT NULL,
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[INDFLYTNING] [date] NULL,
	[FRAFLYTNING] [date] NULL,
	[KLAR_DATO] [date] NULL,
	[DFPTID] [nvarchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Bolig_Beboet]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fact_Bolig_Beboet](
	[ledig] [int] NULL,
	[beboet] [int] NULL,
	[pk_date] [date] NOT NULL,
	[boligid] [int] NOT NULL,
	[sagsid] [int] NULL,
	[cprnr] [varchar](10) NULL,
	[aldergrp] [int] NULL,
	[kvinde] [int] NULL,
	[mand] [int] NULL,
	[BEBOET_DIST] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimYdelsesPakker]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimYdelsesPakker](
	[Pakke_ID] [int] NOT NULL,
	[Pakke_Navn] [varchar](30) NOT NULL,
	[Ydelse_Dag] [int] NULL,
	[Ydelse_Aften] [int] NULL,
	[Ydelse_Nat] [int] NULL,
	[Ydelse_Sumtype] [int] NULL,
	[Fra_Antal] [int] NULL,
	[Til_Antal] [int] NULL,
	[Pakke_Sumtype] [int] NULL,
	[Status] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimTjenestetyper]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTjenestetyper](
	[TJENESTEID] [int] NULL,
	[NAVN] [nvarchar](50) NOT NULL,
	[KMDID] [nvarchar](2) NOT NULL,
	[TJENESTETYPE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTimeExtended]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTimeExtended](
	[PK_Date] [datetime] NULL,
	[Date_Name] [nvarchar](max) NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](max) NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](max) NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](max) NULL,
	[Week] [datetime] NULL,
	[Week_Name] [nvarchar](max) NULL,
	[Day_Of_Year] [float] NULL,
	[Day_Of_Year_Name] [nvarchar](max) NULL,
	[Day_Of_Quarter] [float] NULL,
	[Day_Of_Quarter_Name] [nvarchar](max) NULL,
	[Day_Of_Month] [float] NULL,
	[Day_Of_Month_Name] [nvarchar](max) NULL,
	[Day_Of_Week] [float] NULL,
	[Day_Of_Week_Name] [nvarchar](max) NULL,
	[Week_Of_Year] [float] NULL,
	[Week_Of_Year_Name] [nvarchar](max) NULL,
	[Month_Of_Year] [float] NULL,
	[Month_Of_Year_Name] [nvarchar](max) NULL,
	[Month_Of_Quarter] [float] NULL,
	[Month_Of_Quarter_Name] [nvarchar](max) NULL,
	[Quarter_Of_Year] [float] NULL,
	[Quarter_Of_Year_Name] [nvarchar](max) NULL,
	[Helligdag] [nvarchar](max) NULL,
	[Arbejdsdag] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTime]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTime](
	[PK_Date] [datetime] NOT NULL,
	[Date_Name] [nvarchar](50) NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](50) NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](50) NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](50) NULL,
	[Week] [datetime] NULL,
	[Week_Name] [nvarchar](50) NULL,
	[Day_Of_Year] [int] NULL,
	[Day_Of_Year_Name] [nvarchar](50) NULL,
	[Day_Of_Quarter] [int] NULL,
	[Day_Of_Quarter_Name] [nvarchar](50) NULL,
	[Day_Of_Month] [int] NULL,
	[Day_Of_Month_Name] [nvarchar](50) NULL,
	[Day_Of_Week] [int] NULL,
	[Day_Of_Week_Name] [nvarchar](50) NULL,
	[Week_Of_Year] [int] NULL,
	[Week_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Year] [int] NULL,
	[Month_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Quarter] [int] NULL,
	[Month_Of_Quarter_Name] [nvarchar](50) NULL,
	[Quarter_Of_Year] [int] NULL,
	[Quarter_Of_Year_Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimStillingbet]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimStillingbet](
	[STILLINGID] [int] NOT NULL,
	[STILLINGNAVN] [nvarchar](50) NOT NULL,
	[PCVAGTID] [int] NULL,
	[PCVAGTSYNC] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSpecifikation]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSpecifikation](
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSagsstatus]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSagsstatus](
	[SagsstatusID] [int] NOT NULL,
	[StatusNavn] [nvarchar](50) NOT NULL,
	[SagsType] [int] NOT NULL,
	[SagsTypeNavn] [nvarchar](50) NOT NULL,
	[SagsAktiv] [int] NOT NULL,
	[SagAktivNavn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSager]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimSager](
	[SagsId] [int] NULL,
	[SagsType] [int] NULL,
	[CprNr] [nvarchar](10) NULL,
	[Navn] [nvarchar](101) NULL,
	[Adresse] [nvarchar](70) NULL,
	[PostNr] [nvarchar](4) NULL,
	[Aargang] [nvarchar](5) NULL,
	[Civilstand] [varchar](10) NOT NULL,
	[Kon] [varchar](6) NOT NULL,
	[RefusionStatus] [varchar](16) NOT NULL,
	[REFUSIONSKOMMUNE] [int] NULL,
	[RefusionskommuneNavn] [nvarchar](200) NULL,
	[PlejeKategori] [nvarchar](50) NULL,
	[LAEGENAVNTELEFON] [nvarchar](112) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimPakkeTyperKatNavne]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPakkeTyperKatNavne](
	[KatNavn] [nvarchar](100) NOT NULL,
	[Kategori] [int] NOT NULL,
	[Falles_Sprog_Art] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPakkeTyperJob]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPakkeTyperJob](
	[JOBID] [int] NOT NULL,
	[JOBNAVN] [nvarchar](100) NOT NULL,
	[KATEGORI] [int] NOT NULL,
	[NIVEAU1] [int] NOT NULL,
	[NIVEAU2] [int] NOT NULL,
	[NIVEAU3] [int] NOT NULL,
	[SLETTET_JOB] [int] NULL,
	[SKRIVEBESKYTTET] [int] NULL,
	[FALLES_SPROG_KAT_KODE] [int] NULL,
	[FALLES_SPROG_NIV1_KODE] [int] NULL,
	[FALLES_SPROG_NIV2_KODE] [int] NULL,
	[FALLES_SPROG_NIV3_KODE] [int] NULL,
	[SIDSTE_VITALE_AENDRING] [datetime] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[NORMTID2] [int] NULL,
	[NORMTID3] [int] NULL,
	[NORMTID4] [int] NULL,
	[FUNKKAT] [int] NULL,
	[MAXTID2] [int] NULL,
	[MAXTID3] [int] NULL,
	[MAXTID4] [int] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[NORMTID1] [int] NULL,
	[MAXTID1] [int] NULL,
	[BTP] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPakkeTyperBTP]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimPakkeTyperBTP](
	[BTPId] [int] NOT NULL,
	[BtpNavn] [nvarchar](50) NULL,
	[AtaIbt] [nvarchar](50) NULL,
	[BtpKategori] [int] NULL,
	[BtpKatNavn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimPakkeTyper1]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimPakkeTyper1](
	[JOBID] [int] NOT NULL,
	[JOBNAVN] [nvarchar](100) NOT NULL,
	[KATEGORI] [int] NOT NULL,
	[NIVEAU1] [int] NOT NULL,
	[NIVEAU2] [int] NOT NULL,
	[NIVEAU3] [int] NOT NULL,
	[SLETTET_JOB] [int] NULL,
	[SKRIVEBESKYTTET] [int] NULL,
	[FALLES_SPROG_KAT_KODE] [int] NULL,
	[FALLES_SPROG_NIV1_KODE] [int] NULL,
	[FALLES_SPROG_NIV2_KODE] [int] NULL,
	[FALLES_SPROG_NIV3_KODE] [int] NULL,
	[SIDSTE_VITALE_AENDRING] [datetime] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[NORMTID2] [int] NULL,
	[NORMTID3] [int] NULL,
	[NORMTID4] [int] NULL,
	[FUNKKAT] [int] NULL,
	[MAXTID2] [int] NULL,
	[MAXTID3] [int] NULL,
	[MAXTID4] [int] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[NORMTID1] [int] NULL,
	[MAXTID1] [int] NULL,
	[BTP] [int] NULL,
	[KATNAVN] [nvarchar](100) NOT NULL,
	[FALLES_SPROG_NAVN] [varchar](14) NOT NULL,
	[Slettet_job_navn] [varchar](6) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimPakkeTyper]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimPakkeTyper](
	[JOBID] [int] NULL,
	[JOBNAVN] [nvarchar](100) NOT NULL,
	[KATEGORI] [int] NULL,
	[NIVEAU1] [int] NULL,
	[NIVEAU2] [int] NULL,
	[NIVEAU3] [int] NULL,
	[SLETTET_JOB] [int] NULL,
	[SKRIVEBESKYTTET] [int] NULL,
	[FALLES_SPROG_KAT_KODE] [int] NULL,
	[FALLES_SPROG_NIV1_KODE] [int] NULL,
	[FALLES_SPROG_NIV2_KODE] [int] NULL,
	[FALLES_SPROG_NIV3_KODE] [int] NULL,
	[SIDSTE_VITALE_AENDRING] [datetime] NULL,
	[PLEJETYPE] [int] NULL,
	[NORMTID2] [int] NULL,
	[NORMTID3] [int] NULL,
	[NORMTID4] [int] NULL,
	[FUNKKAT] [int] NULL,
	[MAXTID2] [int] NULL,
	[MAXTID3] [int] NULL,
	[MAXTID4] [int] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[PARAGRAF] [int] NULL,
	[NORMTID1] [int] NULL,
	[MAXTID1] [int] NULL,
	[BTP] [int] NULL,
	[KATNAVN] [nvarchar](100) NOT NULL,
	[FALLES_SPROG_NAVN] [varchar](14) NOT NULL,
	[Slettet_job_navn] [varchar](12) NOT NULL,
	[Kat_nogle] [nvarchar](60) NULL,
	[BTPNAVN] [nvarchar](50) NULL,
	[ATAIBT] [nvarchar](50) NULL,
	[BTPKATEGORI] [int] NULL,
	[BTPKATNAVN] [nvarchar](50) NULL,
	[PLEJETYPE_NAVN] [varchar](17) NULL,
	[PLEJETYPE_PARAGRUPPE] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimOrganisation]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimOrganisation](
	[UAFDELINGID] [int] NOT NULL,
	[UAFDELINGNAVN] [nvarchar](50) NOT NULL,
	[ORGSTATUS] [varchar](7) NULL,
	[AFDELINGID] [int] NOT NULL,
	[AFDELINGNAVN] [nvarchar](50) NOT NULL,
	[ORGANISATIONID] [int] NOT NULL,
	[ORGANISATIONNAVN] [nvarchar](50) NOT NULL,
	[OmraedeID] [int] NOT NULL,
	[OmraedeNavn] [nvarchar](50) NULL,
	[Distrikt] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimMedarbejderStatus]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMedarbejderStatus](
	[MedStatusId] [int] NULL,
	[StatusNavn] [nvarchar](50) NULL,
	[MedAktiv] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimMedarbejdere]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimMedarbejdere](
	[MEDARBEJDERID] [int] NOT NULL,
	[OPRETTET] [datetime] NULL,
	[FODDATO] [date] NULL,
	[MEDARBEJDER_STATUS] [int] NOT NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[FORNAVN] [nvarchar](50) NOT NULL,
	[EFTERNAVN] [nvarchar](50) NOT NULL,
	[ADRESSE] [nvarchar](70) NULL,
	[POSTNR] [nvarchar](4) NULL,
	[TIMER] [int] NOT NULL,
	[STILLINGSID] [int] NOT NULL,
	[UAFDELINGID] [int] NOT NULL,
	[AFDELINGID] [int] NOT NULL,
	[RETTET] [date] NULL,
	[KMD_MEDNR] [nvarchar](8) NULL,
	[ANSATDATO] [date] NOT NULL,
	[EMAIL] [nvarchar](100) NULL,
	[UPDATPEN] [datetime] NOT NULL,
	[TELEFON] [nvarchar](30) NULL,
	[ALTTELEFON] [nvarchar](30) NULL,
	[MOBILTELEFON] [nvarchar](30) NULL,
	[TLF_HEMMELIGT] [int] NULL,
	[ALTTLF_HEMMELIGT] [int] NULL,
	[MOBIL_HEMMELIGT] [int] NULL,
	[MEDARBEJDERNR] [int] NULL,
	[MEDARBEJDERINIT] [nvarchar](5) NULL,
	[MEDARBEJDERTYPE] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[PERSONNR_EKSTRA] [int] NOT NULL,
	[COADR] [nvarchar](70) NULL,
	[VAGTER] [int] NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL,
	[CPR_VEJNAVN] [nvarchar](40) NULL,
	[CPR_HUSNR] [nvarchar](4) NULL,
	[CPR_ETAGE] [nvarchar](2) NULL,
	[CPR_SIDEDOR] [nvarchar](4) NULL,
	[TRANSPORT] [int] NOT NULL,
	[STARTFROM] [int] NOT NULL,
	[STARTLOKALE] [int] NULL,
	[ABP_FIKTIV] [int] NOT NULL,
	[AFLON_FORM] [int] NULL,
	[ADR_ID] [int] NULL,
	[MEDARBEJDERTYPENAVN] [varchar](18) NOT NULL,
	[Ansættelsesbrøk] [numeric](17, 6) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimMedarbejder]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMedarbejder](
	[MedStatusId] [int] NOT NULL,
	[StatusNavn] [nvarchar](50) NOT NULL,
	[MedAktiv] [int] NOT NULL,
	[MedArbAktivNavn] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimLeverandor]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimLeverandor](
	[UAFDELINGID] [int] NOT NULL,
	[UAFDELINGNAVN] [nvarchar](50) NOT NULL,
	[ORGSTATUS] [varchar](7) NULL,
	[AFDELINGID] [int] NOT NULL,
	[AFDELINGNAVN] [nvarchar](50) NOT NULL,
	[ORGANISATIONID] [int] NOT NULL,
	[ORGANISATIONNAVN] [nvarchar](50) NOT NULL,
	[OmraedeID] [int] NOT NULL,
	[OmraedeNavn] [nvarchar](50) NULL,
	[Distrikt] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimJobTyper]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimJobTyper](
	[ParentID] [numeric](36, 0) NULL,
	[JobID] [numeric](36, 0) NULL,
	[Falles_Sprog_Art] [int] NOT NULL,
	[Kategori] [int] NOT NULL,
	[Niveau1] [int] NOT NULL,
	[Niveau2] [int] NOT NULL,
	[Niveau3] [int] NOT NULL,
	[Jobnavn] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimJobHyppighed]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimJobHyppighed](
	[Id] [smallint] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimHjalpType]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimHjalpType](
	[ID] [float] NULL,
	[Label] [nvarchar](max) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimFunkNiveau]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimFunkNiveau](
	[FUNKNIVEAU_ID] [int] NULL,
	[FUNKNIVEAU_FSTYPE] [nvarchar](10) NULL,
	[FUNKNIVEAU_NAVN] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimFritvalgLeverandor]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimFritvalgLeverandor](
	[Id] [int] NOT NULL,
	[Navn] [nvarchar](100) NOT NULL,
	[LevType] [varchar](12) NOT NULL,
	[LEVSTATUS] [varchar](7) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimFravaerstyper]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimFravaerstyper](
	[FRAVARID] [int] NULL,
	[NAVN] [nvarchar](50) NOT NULL,
	[KMDID] [nvarchar](2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDognInddeling]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimDognInddeling](
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[Døgninddeling] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBrugerTidsProcent]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBrugerTidsProcent](
	[BTPId] [int] NOT NULL,
	[BtpNavn] [nvarchar](50) NULL,
	[BtpKategori] [int] NULL,
	[BtpKatNavn] [nvarchar](50) NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBrugerStatus]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBrugerStatus](
	[BRUGERSTATUSID] [int] NOT NULL,
	[BRUGERSTATUS] [varchar](29) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBruger]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBruger](
	[BRUGERID] [int] NOT NULL,
	[MEDARBEJDER] [int] NULL,
	[MEDARBCPRNR] [nvarchar](18) NULL,
	[UAFDELINGID] [int] NULL,
	[LASTPWCHANGE] [datetime2](7) NULL,
	[LOGINSTATUS] [varchar](14) NOT NULL,
	[KONTOSTATUS] [varchar](11) NULL,
	[GRUPPENAVN] [nvarchar](50) NULL,
	[PROFILNAVN] [nvarchar](20) NULL,
	[BRUGERNAVN] [nvarchar](50) NOT NULL,
	[NAVN] [nvarchar](101) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBorgerAlderGruppe]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBorgerAlderGruppe](
	[ALDERGRP] [int] NOT NULL,
	[TEKST] [varchar](49) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBoligventeliste]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBoligventeliste](
	[VENTELISTETYPEID] [int] NOT NULL,
	[VENTELISTETYPE] [varchar](19) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBoligtype]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBoligtype](
	[DFPTID] [nvarchar](2) NULL,
	[DRIFTFORM] [nvarchar](20) NOT NULL,
	[PLADSTYPE] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBoligFraflytning]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBoligFraflytning](
	[FRAFLYTNINGID] [int] NOT NULL,
	[FRAFLYTNINGTYPE] [varchar](25) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBoliger]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimBoliger](
	[BOLIGID] [int] NOT NULL,
	[BOLIGNAVN] [nvarchar](40) NOT NULL,
	[ADRESSE] [nvarchar](40) NULL,
	[HJEMSTED] [varchar](13) NULL,
	[BOLIGGRUPPE] [nvarchar](50) NULL,
	[BOLIGSTATUS] [varchar](23) NULL,
	[DRIFTFORM] [nvarchar](20) NOT NULL,
	[PLADSTYPE] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DimBevaegelse]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBevaegelse](
	[BEVAEG_ID] [int] NULL,
	[BEVAEG_NAVN] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBesogStatus]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBesogStatus](
	[BESOGID] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STAT_TYPE] [int] NOT NULL,
	[STAT_GYLDIG] [int] NOT NULL,
	[STATUSNAVN] [nvarchar](50) NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimBesoegKval]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBesoegKval](
	[Besoeg_KvalId] [int] NOT NULL,
	[Kval_Bet] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimAldersopdeling]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimAldersopdeling](
	[AlderAar] [int] NULL,
	[AldersGruppe] [float] NULL,
	[AldersGruppeStart] [float] NULL,
	[AldersGruppeSlut] [float] NULL,
	[AldersGruppeNavn] [nvarchar](61) NULL,
	[Pensionist] [varchar](4) NOT NULL,
	[YngreÆldre67] [varchar](4) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DIM_TIME]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_TIME](
	[PK_Date] [datetime] NOT NULL,
	[Date_Name] [nvarchar](50) NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](50) NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](50) NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](50) NULL,
	[Week] [datetime] NULL,
	[Week_Name] [nvarchar](50) NULL,
	[Day_Of_Year] [int] NULL,
	[Day_Of_Year_Name] [nvarchar](50) NULL,
	[Day_Of_Quarter] [int] NULL,
	[Day_Of_Quarter_Name] [nvarchar](50) NULL,
	[Day_Of_Month] [int] NULL,
	[Day_Of_Month_Name] [nvarchar](50) NULL,
	[Day_Of_Week] [int] NULL,
	[Day_Of_Week_Name] [nvarchar](50) NULL,
	[Week_Of_Year] [int] NULL,
	[Week_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Year] [int] NULL,
	[Month_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Quarter] [int] NULL,
	[Month_Of_Quarter_Name] [nvarchar](50) NULL,
	[Quarter_Of_Year] [int] NULL,
	[Quarter_Of_Year_Name] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_besogsstatus]    Script Date: 10/06/2015 18:34:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_besogsstatus](
	[BESOGID] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STAT_TYPE] [int] NOT NULL,
	[STAT_GYLDIG] [int] NOT NULL,
	[STATUSNAVN] [nvarchar](50) NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL
) ON [PRIMARY]
GO
