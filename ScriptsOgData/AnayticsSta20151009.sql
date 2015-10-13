USE [master]
GO
/****** Object:  Database [AvaleoAnalytics_STAa]    Script Date: 10/06/2015 18:35:10 ******/
CREATE DATABASE [AvaleoAnalytics_STAa] ON  PRIMARY 
( NAME = N'AvaleoAnalytics_STAa', FILENAME = N'c:\avaleoproj\data\AvaleoAnalytics_STAa.mdf' , SIZE = 6000kb , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalytics_STAa_log', FILENAME = N'c:\avaleoproj\log\AvaleoAnalytics_STAa_Log.ldf' , SIZE = 6000kb , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AvaleoAnalytics_STAa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ANSI_NULLS OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ANSI_PADDING OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ARITHABORT OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET  DISABLE_BROKER
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET  READ_WRITE
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET RECOVERY SIMPLE
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET  MULTI_USER
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [AvaleoAnalytics_STAa] SET DB_CHAINING OFF
GO
USE [AvaleoAnalytics_STAa]
GO
/****** Object:  Table [dbo].[YDELSESPAKKER]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[YDELSESPAKKER](
	[PAKKE_ID] [int] NOT NULL,
	[PAKKE_NAVN] [varchar](30) NOT NULL,
	[YDELSE_DAG] [int] NULL,
	[YDELSE_AFTEN] [int] NULL,
	[YDELSE_NAT] [int] NULL,
	[YDELSE_SUMTYPE] [int] NULL,
	[FRA_ANTAL] [int] NULL,
	[TIL_ANTAL] [int] NULL,
	[PAKKE_SUMTYPE] [int] NULL,
	[STATUS] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VURDERINGSNIV]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VURDERINGSNIV](
	[ID] [int] NOT NULL,
	[NIVEAUNAVN] [nvarchar](50) NOT NULL,
	[NIVEAU] [int] NULL,
	[FALLES_SPROG_ART] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VPL_TJENESTETYPER]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPL_TJENESTETYPER](
	[ID] [int] NULL,
	[NAVN] [nvarchar](50) NOT NULL,
	[KMDID] [nvarchar](2) NOT NULL,
	[PAA_ARBEJDE] [int] NULL,
	[RULLEPLAN] [int] NULL,
	[SUPPLERENDE] [int] NULL,
	[TJENESTETYPE] [int] NULL,
	[SKJULT] [int] NULL,
	[FARVE_BAGGRUND] [int] NULL,
	[FARVE_TEKST] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VPL_TJENESTER]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPL_TJENESTER](
	[ID] [int] NULL,
	[TJENESTE] [int] NULL,
	[STARTTIDSPUNKT] [datetime] NOT NULL,
	[SLUT] [datetime] NOT NULL,
	[FAKTISK_TID] [int] NULL,
	[MEDARBEJDER] [int] NULL,
	[MEDARB_GRUPPE] [int] NULL,
	[RULLEPLAN] [int] NULL,
	[OVF_TIL_TIDSADM] [int] NULL,
	[OVF_TIDSADM] [datetime] NULL,
	[OPRETTET_AF] [int] NULL,
	[OPRETTET] [datetime] NOT NULL,
	[RETTET_AF] [int] NULL,
	[RETTET_SIDST] [datetime] NULL,
	[ANNULLERET] [int] NULL,
	[OMKOST_GRUPPE] [int] NULL,
	[ADMIN_ENHED] [nvarchar](15) NULL,
	[DIR_UDBETALING] [int] NULL,
	[OMKOST_AFD] [nvarchar](3) NULL,
	[OMKOST_KONTO] [nvarchar](10) NULL,
	[SAERYDELSE] [int] NULL,
	[STAT_TYPE] [nvarchar](2) NULL,
	[VARSLET] [int] NULL,
	[OMLAGT_TIL] [int] NULL,
	[ERKMDKODE] [int] NULL,
	[TFKODE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VPL_FRAVAERSTYPER]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPL_FRAVAERSTYPER](
	[ID] [int] NULL,
	[NAVN] [nvarchar](50) NOT NULL,
	[KMDID] [nvarchar](2) NOT NULL,
	[SKJULT] [int] NULL,
	[SKAL_AFSLUTTES] [int] NULL,
	[FARVE_BAGGRUND] [int] NULL,
	[FARVE_TEKST] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VPL_FRAVAER]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VPL_FRAVAER](
	[ID] [int] NULL,
	[FRAVAER] [int] NULL,
	[STARTTIDSPUNKT] [datetime2](7) NOT NULL,
	[SLUT] [datetime2](7) NOT NULL,
	[HELDAGS] [int] NULL,
	[MEDARBEJDER] [int] NULL,
	[MEDARB_GRUPPE] [int] NULL,
	[OVF_TIL_TIDSADM] [int] NULL,
	[OVF_TIDSADM] [datetime2](7) NULL,
	[OPRETTET_AF] [int] NULL,
	[OPRETTET] [datetime2](7) NOT NULL,
	[RETTET_AF] [int] NULL,
	[RETTET_SIDST] [datetime2](7) NULL,
	[ANNULLERET] [int] NULL,
	[DAGP_BA_AP] [nvarchar](1) NULL,
	[DATO_BA_GG_OS] [datetime2](7) NULL,
	[DELVIST_SYG] [nvarchar](1) NULL,
	[MED_LOEN] [int] NULL,
	[OMSORGSDAGE] [nvarchar](4) NULL,
	[SAERYDELSE] [int] NULL,
	[TFKODE] [nvarchar](4) NULL,
	[ANNULLERET_AF] [int] NULL,
	[OPRINDELIG_START] [datetime2](7) NULL,
	[ERKMDKODE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VISI_PAKKER_BEREGN]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VISI_PAKKER_BEREGN](
	[ID] [int] NULL,
	[Pakke_Visitype] [int] NULL,
	[Pakke_Navn] [nvarchar](30) NULL,
	[Pakke_Lev_Navn] [nvarchar](100) NULL,
	[Pakke_Visi_ID] [int] NULL,
	[Pakke_Ugentlig_Leveret] [numeric](12, 2) NULL,
	[Pakke_ID] [int] NULL,
	[Pakke_Lev_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VERSION]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VERSION](
	[VERSION] [int] NOT NULL,
	[OPDATERINGSDATO] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tpvisiJobDogninddelingJobType]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tpvisiJobDogninddelingJobType](
	[ID] [int] NOT NULL,
	[TPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[NORMTIDJobType] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tpvisiJobDogninddeling]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tpvisiJobDogninddeling](
	[ID] [int] NOT NULL,
	[TPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_TPVISITATION_TP]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_TPVISITATION_TP](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[dogninddeling] [int] NOT NULL,
	[TPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_TP_SAGSHISTORIK]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_TP_SAGSHISTORIK](
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_TBVISITATION_TB]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_TBVISITATION_TB](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[dogninddeling] [int] NOT NULL,
	[TPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_SPVISITATION]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_SPVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[Dogninddeling] [int] NOT NULL,
	[SPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_SP_SAGSHISTORIK]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_SP_SAGSHISTORIK](
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[SYGEPLEJE_STATUS] [int] NOT NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[HJPL_DAGGRP_ID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_MADVISITATION]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_MADVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[dogninddeling] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_MAD_SAGSHISTORIK]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_MAD_SAGSHISTORIK](
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[MADVISI_STATUSID] [int] NULL,
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_HJVISITATION_PP]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_HJVISITATION_PP](
	[ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[dogninddeling] [int] NOT NULL,
	[HJVISI] [int] NULL,
	[HJALPTYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_HJVISITATION_PB]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_HJVISITATION_PB](
	[ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[dogninddeling] [int] NOT NULL,
	[HJVISI] [int] NULL,
	[HJALPTYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_HJ_SAGSHISTORIK]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_HJ_SAGSHISTORIK](
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_tmp_fraflyt1]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_tmp_fraflyt1](
	[DRIFTFORM] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[startdato] [datetime] NULL,
	[BOLIGID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_SPvisiJobDogninddelingJobType]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_SPvisiJobDogninddelingJobType](
	[ID] [int] NOT NULL,
	[SPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [decimal](29, 21) NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[NORMTIDJobType] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_SPvisiJobDogninddeling]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_SPvisiJobDogninddeling](
	[ID] [int] NOT NULL,
	[SPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [decimal](29, 21) NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_HjvisiJobDogninddelingJobType]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_HjvisiJobDogninddelingJobType](
	[ID] [int] NULL,
	[HJVISIID] [int] NULL,
	[JOBID] [int] NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [decimal](29, 21) NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[NormTidJobType] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_HjvisiJobDogninddeling]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_HjvisiJobDogninddeling](
	[ID] [int] NULL,
	[HJVISIID] [int] NULL,
	[JOBID] [int] NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [decimal](29, 21) NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[LEVERANDOERNAVN] [nvarchar](100) NULL,
	[YD_WEEKEND] [decimal](18, 10) NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL,
	[dogninddeling] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_Forbrugsafvigelser_borger3]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_Forbrugsafvigelser_borger3](
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
/****** Object:  Table [dbo].[_Forbrugsafvigelser_Borger2]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_Forbrugsafvigelser_Borger2](
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
	[Fordelt_Forbrugsafvigelse] [int] NULL,
	[Fordelt_Forbrug] [int] NULL,
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
	[GRUPPEID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[_Forbrugsafvigelser_Borger1]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_Forbrugsafvigelser_Borger1](
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
	[Fordelt_Forbrugsafvigelse] [int] NULL,
	[Fordelt_Forbrug] [int] NULL,
	[Fordelt_Vejtid] [int] NULL,
	[HJEMMEPLEJE_STATUS] [int] NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[SYGEPLEJE_STATUS] [int] NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[TERAPEUT_STATUS] [int] NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[_Forbrugsafvigelser]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[_Forbrugsafvigelser](
	[ID] [int] NOT NULL,
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
	[STAT_TYPE] [int] NOT NULL,
	[SERIEDATO] [datetime] NULL,
	[VISISTART] [int] NOT NULL,
	[VISISLUT] [int] NOT NULL,
	[Målt] [varchar](14) NOT NULL,
	[Forbrugsstatus] [varchar](26) NOT NULL,
	[Samlet_Forbrugsafvigelse] [int] NULL,
	[JOBID] [int] NOT NULL,
	[Normtid_ydelse] [int] NOT NULL,
	[Fordelt_Forbrug] [int] NULL,
	[Fordelt_Forbrugsafvigelse] [int] NULL,
	[Fordelt_vejtid] [int] NULL,
	[VISITYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[_FACT_TPVisiSag_Step2_TP]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TPVisiSag_Step2_TP](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[TPVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_TPVisiSag_Step2_TBTP_Distinct]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TPVisiSag_Step2_TBTP_Distinct](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_TPVisiSag_Step2_TBTP]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TPVisiSag_Step2_TBTP](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[TPVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_TPVisiSag_Step1_TP]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TPVisiSag_Step1_TP](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[TPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_TBVisiSag_Step2_TB]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TBVisiSag_Step2_TB](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[TPVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_TBVisiSag_Step1_TB]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_TBVisiSag_Step1_TB](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[TPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_SPVisiSag_Step3]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_SPVisiSag_Step3](
	[SagsID] [int] NOT NULL,
	[Sagikraft] [datetime] NOT NULL,
	[Sagslut] [datetime] NOT NULL,
	[SygePleje_Status] [int] NOT NULL,
	[SygePleje_STATUSID] [int] NULL,
	[SygePleje_GRUPPEID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[Visiikraft] [datetime] NOT NULL,
	[Visislut] [datetime] NOT NULL,
	[Visiid] [int] NOT NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[SPVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_SPVisiSag_Step2]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_SPVisiSag_Step2](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[SYGEPLEJE_STATUS] [int] NOT NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[HJPL_DAGGRP_ID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[SPVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_SPVisiSag_Step1]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_SPVisiSag_Step1](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[SYGEPLEJE_STATUS] [int] NOT NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[HJPL_DAGGRP_ID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NOT NULL,
	[visislut] [datetime] NOT NULL,
	[visiid] [int] NOT NULL,
	[SPVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_MADVisiSag_Step2]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_MADVisiSag_Step2](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NULL,
	[sagslut] [datetime] NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[MADVISI_STATUSID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL,
	[start] [datetime] NULL,
	[slut] [datetime] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_MADVisiSag_Step1]    Script Date: 10/06/2015 18:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_MADVisiSag_Step1](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NULL,
	[sagslut] [datetime] NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[MADVISI_STATUSID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[visiikraft] [datetime] NULL,
	[visislut] [datetime] NULL,
	[visiid] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_name]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_name] AS SELECT RowNumber, Alder, birthdaysInPeriod, CPRNR, SAGSID, dato, MADVISI_STATUS, MADVISI_STATUSID, organization, madleverancer, madleverancerHverdag, madleverancerWeekend, dogninddeling, specifikation, count, JOBID, start, slut, PRIS, pstart, pslut, FRITVALGLEV from AvaleoAnalytics_DW.dbo._FACT_MADVisiSag_AfregnetJob
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step3_PBPP]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step3_PBPP](
	[SagsId] [int] NOT NULL,
	[Sagikraft] [datetime] NOT NULL,
	[Sagslut] [datetime] NOT NULL,
	[Hjemmepleje_Status] [int] NOT NULL,
	[Hjemmepleje_StatusID] [int] NULL,
	[Hjemmepleje_GruppeID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[Visiikraft] [date] NOT NULL,
	[Visislut] [date] NOT NULL,
	[Visiid] [int] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[HJVisi] [int] NULL,
	[Type] [int] NOT NULL,
	[Hjalptype] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step2_PP]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step2_PP](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[visiikraft] [date] NOT NULL,
	[visislut] [date] NOT NULL,
	[visiid] [int] NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[HJVISI] [int] NULL,
	[type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step2_PBPP]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step2_PBPP](
	[SagsId] [int] NOT NULL,
	[Sagikraft] [datetime] NOT NULL,
	[Sagslut] [datetime] NOT NULL,
	[Hjemmepleje_Status] [int] NOT NULL,
	[Hjemmepleje_StatusID] [int] NULL,
	[Hjemmepleje_GruppeID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[Hjalptype] [int] NOT NULL,
	[Visiikraft] [date] NOT NULL,
	[Visislut] [date] NOT NULL,
	[Visiid] [int] NULL,
	[Start] [datetime] NOT NULL,
	[Slut] [datetime] NOT NULL,
	[HJVisi] [int] NULL,
	[Type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step2_PB]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step2_PB](
	[SagsID] [int] NOT NULL,
	[SagIkraft] [datetime] NOT NULL,
	[SagSlut] [datetime] NOT NULL,
	[HjemmePleje_Status] [int] NOT NULL,
	[HjemmePleje_StatusID] [int] NULL,
	[HjemmePleje_GruppeID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[Dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[Visiikraft] [date] NOT NULL,
	[Visislut] [date] NOT NULL,
	[Visiid] [int] NULL,
	[start] [datetime] NOT NULL,
	[slut] [datetime] NOT NULL,
	[HJVISI] [int] NULL,
	[Type] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step1_PP]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step1_PP](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[visiikraft] [date] NOT NULL,
	[visislut] [date] NOT NULL,
	[visiid] [int] NULL,
	[HJVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_FACT_HJVisiSag_Step1_pb]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_FACT_HJVisiSag_Step1_pb](
	[SAGSID] [int] NOT NULL,
	[sagikraft] [datetime] NOT NULL,
	[sagslut] [datetime] NOT NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[HJPL_AFTENGRP_ID] [int] NULL,
	[HJPL_NATGRP_ID] [int] NULL,
	[SYPL_DAGGRP_ID] [int] NULL,
	[SYPL_AFTENGRP_ID] [int] NULL,
	[SYPL_NATGRP_ID] [int] NULL,
	[dogninddeling] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[visiikraft] [date] NOT NULL,
	[visislut] [date] NOT NULL,
	[visiid] [int] NULL,
	[HJVISI] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[_BorgerÅrstal]    Script Date: 10/06/2015 18:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[_BorgerÅrstal](
	[SagsId] [int] NULL,
	[CprNr] [nvarchar](10) NULL,
	[År] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareBTP]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_PrepareBTP]
		@DestinationDB as varchar(200),
		@SourceVagtplan as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS

DECLARE @cmd as varchar(max)

if @ExPart=1 
begin
      
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep1'' AND type = ''U'') DROP TABLE FactBTPStep1'
if @debug = 1 print @cmd
exec (@cmd)

--hent udført tid
set @cmd = 'SELECT ' +char(13)+ 
           '  MEDID, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  UDFOERT_TID+MOBIL_TID AS UDFOERTTID ' +char(13)+
           'INTO FactBTPStep1 ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' --Skal være fra FactPlanlagtUdfoert
if @debug = 1 print @cmd
exec (@cmd)        

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep2'' AND type = ''U'') DROP TABLE FactBTPStep2'
if @debug = 1 print @cmd
exec (@cmd)

--sæt BTP definition på
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep1.MEDID, ' +char(13)+
           '  FactBTPStep1.MED_ORG, ' +char(13)+
           '  FactBTPStep1.PK_DATE, ' +char(13)+
           '  FactBTPStep1.UDFOERTTID, ' +char(13)+
           '  COALESCE('+@DestinationDB+'.dbo.DimPakkeTyper.BTP, 0) AS BTPDEFINITION, ' +char(13)+  --måske 9999
           '  '+@DestinationDB+'.dbo.DimBrugerTidsProcent.SORTERING '+char(13)+
           'INTO FactBTPStep2 ' +char(13)+
           'FROM FactBTPStep1 ' +char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimPakkeTyper ON FactBTPStep1.JOBID='+@DestinationDB+'.dbo.DimPakkeTyper.JOBID '+char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimBrugerTidsProcent ON '+@DestinationDB+'.dbo.DimPakkeTyper.BTP='+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID'  
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep3'' AND type = ''U'') DROP TABLE FactBTPStep3'
if @debug = 1 print @cmd
exec (@cmd)

----gruppér og summér
set @cmd = 'SELECT ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  BTPDEFINITION, ' +char(13)+
        --   '  BTPKATEGORI, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  SUM(UDFOERTTID) AS UDFOERTTID, ' +char(13)+
           '  SORTERING ' +char(13)+ 
           'INTO FactBTPStep3 ' +char(13)+
           'FROM factbtpstep2 ' +char(13)+
           'GROUP BY MEDID, MED_ORG, BTPDEFINITION, PK_DATE, SORTERING ' +char(13)+
           'ORDER BY MEDID,PK_DATE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep3_1'' AND type = ''U'') DROP TABLE FactBTPStep3_1'
if @debug = 1 print @cmd
exec (@cmd)

--summér tjensetetid fra vagtplan pr. dag pr. medarbejder SKAL TILPASSES HVIS KMD
set @cmd = 'SELECT ' +char(13)+
           '  PK_DATE, '+char(13)+
           '  MEDID, '+char(13)+
           '  SUM(PlanlagtTimer)*60 AS TJENESTETID '+char(13)+ --timer til minutter
           'INTO FactBTPStep3_1 '+char(13)+
           'FROM '+@DestinationDB+'.dbo.FactTimerPlan '+char(13)+
           'WHERE PlanlagtTimer IS NOT NULL '+char(13)+
           'GROUP BY PK_DATE,MEDID '+char(13)+
           'ORDER BY PK_DATE,MEDID '+char(13)+
           ''+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep4'' AND type = ''U'') DROP TABLE FactBTPStep4'
if @debug = 1 print @cmd
exec (@cmd)

--sæt tjenestetid på SKAL TILPASSES HVIS KMD VAGTPLAN
set @cmd = 'SELECT ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.MED_ORG, ' +char(13)+
           '  A.BTPDEFINITION, ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.UDFOERTTID, ' +char(13)+ 
           '  COALESCE(B.TJENESTETID,0) AS TJENESTETID, '+char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+ 
           '  A.SORTERING ' +char(13)+
           'INTO FactBTPStep4  ' +char(13)+
           'FROM FactBTPStep3 A ' +char(13)+  
           'LEFT JOIN FactBTPStep3_1 B ON A.PK_DATE=B.PK_DATE AND A.MEDID=B.MEDID' 
if @debug = 1 print @cmd
exec (@cmd)  

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPAnvendtDefinition'' AND type = ''U'') DROP TABLE FactBTPAnvendtDefinition'
exec (@cmd)

--find anvendte btpdefinitioner
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  BTPID AS BTPDEFINITION, ' +char(13)+
           '  SORTERING ' +char(13)+
           'INTO FactBTPAnvendtDefinition ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.DimBrugerTidsProcent' +char(13)+
           'JOIN JOBTYPER ON '+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID=JOBTYPER.BTP ' +char(13)+
           'JOIN '+@DestinationDB+'.dbo.FactPlanlagtUdfoert ON JOBTYPER.JOBID='+@DestinationDB+'.dbo.FactPlanlagtUdfoert.JOBID '
if @debug = 1 print @cmd           
exec (@cmd)  

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPTommeRaekker'' AND type = ''U'') DROP TABLE FactBTPTommeRaekker'
exec (@cmd)  

--indsæt tomme rækker i union tabel så summéring passer
set @cmd = 'SELECT DISTINCT ' +char(13)+ 
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+
           '  B.BTPDEFINITION, ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  A.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  0 AS SORTERING ' +char(13)+
           'INTO FactBTPTommeRaekker ' +char(13)+
           'FROM FactBTPStep4 A' +char(13)+
           'RIGHT OUTER JOIN FactBTPAnvendtDefinition B ON A.BTPDEFINITION<>B.BTPDEFINITION'
exec (@cmd)

--slet dubletter
set @cmd = 'DELETE FROM FactBTPTommeRaekker ' +char(13)+  
           'WHERE EXISTS(SELECT * FROM FactBTPStep4 WHERE ' +char(13)+
           '  FactBTPTommeRaekker.MEDID=FactBTPStep4.MEDID AND ' +char(13)+  
           '  FactBTPTommeRaekker.PK_DATE=FactBTPStep4.PK_DATE AND ' +char(13)+
           '  FactBTPTommeRaekker.BTPDEFINITION=FactBTPStep4.BTPDEFINITION)'
exec (@cmd)           

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep5FremMoedeArbTid'' AND type = ''U'') DROP TABLE FactBTPStep5FremMoedeArbTid'
exec (@cmd) 

--mødetid og arbejdstid til union        
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  8888 AS BTPDEFINITION, ' +char(13)+  --8888 = btp fremmødetid
         --  '  8888 AS BTPKATEGORI, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS TJENESTETID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID AS ARBEJDSTID,' +char(13)+
           '  14 AS SORTERING ' +char(13)+
           'INTO FactBTPStep5FremMoedeArbTid ' +char(13)+
           'FROM FactBTPStep4' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep6TotalUdfoert'' AND type = ''U'') DROP TABLE FactBTPStep6TotalUdfoert'
exec (@cmd)

--summér udførttid til ledigtid til union
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep3.MEDID, ' +char(13)+ 
           '  FactBTPStep3.MED_ORG,' +char(13)+ 
           '  7777 AS BTPDEFINITION, ' +char(13)+ --7777 = btp ledigtid
        --   '  7777 AS BTPKATEGORI, ' +char(13)+
           '  FactBTPStep3.PK_DATE, ' +char(13)+ 
           '  SUM(FactBTPStep3.UDFOERTTID) AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep5FremMoedeArbTid.TJENESTETID, ' +char(13)+  
           '  0 AS ARBEJDSTID, ' +char(13)+ 
           '  12 AS SORTERING ' +char(13)+
           'INTO  FactBTPStep6TotalUdfoert' +char(13)+ 
           'FROM FactBTPStep3' +char(13)+ 
           'JOIN FactBTPStep5FremMoedeArbTid ON FactBTPStep3.MEDID=FactBTPStep5FremMoedeArbTid.MEDID AND ' +char(13)+
           '  FactBTPStep3.PK_DATE=FactBTPStep5FremMoedeArbTid.PK_DATE ' +char(13)+
           'GROUP BY FactBTPStep3.MEDID, FactBTPStep3.MED_ORG, FactBTPStep3.PK_DATE, FactBTPStep5FremMoedeArbTid.TJENESTETID' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBTP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBTP'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactBTPStep7Vejtid'' AND type = ''U'') DROP TABLE FactBTPStep7Vejtid'
exec (@cmd)

--saml det hele i FactBTP
set @cmd = 'SELECT ' +char(13)+ 
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+ 
           '  FactBTPStep4.BTPDEFINITION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+ 
           '  FactBTPStep4.UDFOERTTID, ' +char(13)+ 
           '  FactBTPStep4.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep4.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep4.SORTERING '  +char(13)+
           'INTO '+@DestinationDB+'.dbo.FactBTP ' +char(13)+ 
           'FROM FactBTPStep4' +char(13)+ 
           'UNION ALL ' +char(13)+ 
           'SELECT ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.MEDID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.MED_ORG, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.BTPDEFINITION, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.PK_DATE, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.UDFOERTTID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep5FremMoedeArbTid.SORTERING ' +char(13)+ 
           'FROM FactBTPStep5FremMoedeArbTid' +char(13)+ 
           'UNION ALL ' +char(13)+ 
           'SELECT ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.MEDID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.MED_ORG, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.BTPDEFINITION, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.PK_DATE, ' +char(13)+
           'CASE WHEN FactBTPStep6TotalUdfoert.TJENESTETID>0 THEN ' +char(13)+
           ''+char(13)+
           ''+char(13)+ 
           '  (FactBTPStep6TotalUdfoert.TJENESTETID-FactBTPStep6TotalUdfoert.UDFOERTTID)  ' +char(13)+ 
           ''+char(13)+
           'ELSE 0 '+char(13)+
           'END AS UDFOERTTID, '+char(13)+
           '  FactBTPStep6TotalUdfoert.TJENESTETID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.ARBEJDSTID, ' +char(13)+ 
           '  FactBTPStep6TotalUdfoert.SORTERING ' +char(13)+
           'FROM FactBTPStep6TotalUdfoert ' +char(13)+  
           'UNION ALL' +char(13)+ 
           'SELECT ' +char(13)+
           '  FactBTPTommeRaekker.MEDID, ' +char(13)+
           '  FactBTPTommeRaekker.MED_ORG, ' +char(13)+
           '  FactBTPTommeRaekker.BTPDEFINITION, ' +char(13)+
           '  FactBTPTommeRaekker.PK_DATE, ' +char(13)+
           '  FactBTPTommeRaekker.UDFOERTTID, ' +char(13)+
           '  FactBTPTommeRaekker.TJENESTETID, ' +char(13)+
           '  FactBTPTommeRaekker.ARBEJDSTID, ' +char(13)+
           '  FactBTPTommeRaekker.SORTERING ' +char(13)+
           'FROM FactBTPTommeRaekker' +char(13)+
           'UNION ALL ' +char(13)+ --direkte borgertid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  6666 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  1 AS SORTERING ' +char(13)+
           'FROM FactBTPStep4 ' +char(13)+
           'UNION ALL ' +char(13)+ --indirekte borgertid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  5555 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  4 AS SORTERING ' +char(13)+
           'FROM   FactBTPStep4 ' +char(13)+
          'UNION ALL ' +char(13)+ --kvalifikationstid
           'SELECT DISTINCT ' +char(13)+
           '  FactBTPStep4.MEDID, ' +char(13)+ 
           '  FactBTPStep4.MED_ORG, ' +char(13)+
           '  4444 AS BTPDEFINITTION, ' +char(13)+
           '  FactBTPStep4.PK_DATE, ' +char(13)+
           '  0 AS UDFOERTTID, ' +char(13)+
           '  FactBTPStep4.TJENESTETID, ' +char(13)+
           '  0 AS ARBEJDSTID, ' +char(13)+
           '  8 AS SORTERING ' +char(13)+
           'FROM   FactBTPStep4 ' 
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (9,10,11) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 4444' 
           
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (6,7,8) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 5555' 
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET UDFOERTTID= ' +char(13)+
           '  COALESCE((SELECT SUM(UDFOERTTID) FROM FactBTPStep4 WHERE BTPDEFINITION IN (1,2) AND' +char(13)+
           '   FactBTPStep4.MEDID=FactBTP.MEDID AND FactBTPStep4.PK_DATE=FactBTP.PK_DATE),0) ' +char(13)+
           'WHERE BTPDEFINITION = 6666' 
exec (@cmd)   
           
set @cmd = 'UPDATE '+@DestinationDB+'.DBO.FactBTP SET SORTERING= ' +char(13)+
           '  (SELECT SORTERING FROM '+@DestinationDB+'.dbo.DimBrugerTidsProcent ' +char(13)+
           '   WHERE '+@DestinationDB+'.dbo.DimBrugerTidsProcent.BTPID='+@DestinationDB+'.DBO.FactBTP.BTPDEFINITION) '
exec (@cmd)                            
           
           
--if @debug = 1 print @cmd
exec (@cmd)

end


--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=33)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (33,GETDATE())           
--end
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dim_Bolig]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Create_Dim_Bolig] 
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
           '  ''Dødsfald                 '' AS FRAFLYTNINGTYPE'+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimBoligFraflytning'+char(13)
if @debug = 1 print @cmd
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(1,''Samlivsophør'')'exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(2,''Til plejebolig'')'exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(3,''Til anden ældrebolig'')'exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.DBO.DimBoligFraflytning VALUES(98,''Til anden kommune'')'exec (@cmd) 

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
GO
/****** Object:  StoredProcedure [dbo].[usp_Forbrugsafvigelsesrapport]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Forbrugsafvigelsesrapport]
	@DestinationDB as varchar(200),
	@debug as bit
				 
AS
DECLARE @cmd as varchar(max)
DECLARE @StartDate as datetime
DECLARE @EndDate as datetime


   ---sagsstatus
	set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser '
	if @debug = 1 print @cmd
	exec (@cmd)

	set @cmd = 'SELECT ' +char(13)+   
	           '  dbo.SAGSPLANRET.ID, ' +char(13)+
	           '  dbo.SAGSPLANRET.SERIEID, ' +char(13)+
	           '  dbo.SAGSPLANRET.SAGSID, ' +char(13)+ 
	           '  dbo.SAGSPLANRET.MEDID, ' +char(13)+
	           '  dbo.SAGSPLANRET.RETDATO, '+char(13)+
               '  dbo.SAGSPLANRET.STARTMINEFTERMIDNAT As START, ' +char(13)+
               '  dbo.SAGSPLANRET.TID, ' +char(13)+
               '  dbo.SAGSPLANRET.VEJTID, ' +char(13)+
               '  dbo.SAGSPLANRET.YDELSESTID, ' +char(13)+
               '  dbo.SAGSPLANRET.STATUSID, '+char(13)+
               '  dbo.SAGSPLANRET.RSTART, ' +char(13)+
               '  dbo.SAGSPLANRET.RTID, ' +char(13)+
               '  dbo.SAGSPLANRET.RVEJTID, ' +char(13)+
               '  dbo.SAGSPLANRET.REGBES, ' +char(13)+
               '  dbo.BESOGSTATUS.STAT_TYPE, ' +char(13)+
               '  dbo.SAGSPLANRET.SERIEDATO, '+char(13)+
               '  dbo.SAGSPLANRET.VISISTART, ' +char(13)+
               '  dbo.SAGSPLANRET.VISISLUT, '+char(13)+
               '  CASE When regbes = 1  THEN  ''Registreret'' ELSE  ''Ej registreret''  END AS Målt, ' +char(13)+
               '  CASE WHEN sagsplanret.rstart <> 0 AND '+char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid > sagsplanret.ydelsestid THEN ''Merforbrug'' ' +char(13)+
               '       WHEN sagsplanret.rstart <> 0 AND '+char(13)+
               '   (sagsplanret.rtid - sagsplanret.rvejtid < sagsplanret.ydelsestid  and ' +char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid > 1) THEN ''Mindreforbrug''' +char(13)+
               '       WHEN sagsplanret.rtid - sagsplanret.rvejtid <= 1 and ' +char(13)+
               '    sagsplanret.rtid - sagsplanret.rvejtid < sagsplanret.ydelsestid and ' +char(13)+
               '    (sagsplanret.regbes = 1 and stat_type <> 2 ) THEN ''Mindreforbrug lig planlagt''' +char(13)+
               '       WHEN stat_type = 2 then ''Ej gennemført''' +char(13)+
               '  ELSE ''Neutral'' END AS Forbrugsstatus, '+char(13)+
               '  CASE WHEN sagsplanret.regbes = 1  and   sagsplanret.rtid - sagsplanret.rvejtid > 1  THEN ' +char(13)+
               '    sagsplanret.RTID-RVejtid - sagsplanret.YDELSESTID ELSE NULL END AS Samlet_Forbrugsafvigelse, '+char(13)+
               '  dbo.SAGSPRETDET.JOBID, ' +char(13)+
               '  dbo.SAGSPRETDET.YDELSESTID AS Normtid_ydelse, '+char(13)+
               '  Case WHEN  sagsplanret.rtid - sagsplanret.rvejtid > 1 and (regbes = 1 ) then '+char(13)+
               '    (dbo.SAGSPLANRET.RTID -  dbo.SAGSPLANRET.RVEJTID ) * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID  '+char(13)+
               '       WHEN stat_type = 2 then null '+char(13)+
               '  else  dbo.SAGSPRETDET.YDELSESTID end  AS Fordelt_Forbrug, '+char(13)+
               '  Case WHEN  sagsplanret.rtid - sagsplanret.rvejtid > 1 and (regbes=1 ) then ' +char(13)+
               '    (dbo.SAGSPLANRET.RTID -dbo.SAGSPLANRET.RVEJTID - dbo.SAGSPLANRET.YDELSESTID) * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID '+char(13)+
               '       WHEN stat_type = 2 then dbo.SAGSPRETDET.YDELSESTID '+char(13)+
               '  else 0 end AS Fordelt_Forbrugsafvigelse, '+char(13)+
               '    dbo.SAGSPLANRET.RVEJTID   * dbo.SAGSPRETDET.YDELSESTID / dbo.SAGSPLANRET.YDELSESTID AS Fordelt_vejtid, '+char(13)+
               '  Dbo.SAGSPRETDET.VISITYPE   '+char(13)+
               'into _Forbrugsafvigelser       '+char(13)+
               'FROM         dbo.SAGSPLANRET ' +char(13)+
               'INNER JOIN dbo.SAGSPRETDET ON dbo.SAGSPLANRET.ID = dbo.SAGSPRETDET.SAGSPRETID ' +char(13)+
               'INNER JOIN BESOGSTATUS ON SAGSPLANRET.STATUSID = BESOGSTATUS.BESOGID '+char(13)+
               'where dbo.SAGSPLANRET.YDELSESTID <> 0 and datepart(year,dbo.SAGSPLANRET.RETDATO) >2007 and datepart(year,dbo.SAGSPLANRET.RETDATO) < 2014 '+char(13)

	if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'INSERT INTO _Forbrugsafvigelser' +char(13)+
           '  (ID, SERIEID, SAGSID, MEDID, RETDATO, TID, VEJTID, YDELSESTID, STATUSID, RSTART, RTID, RVEJTID, ' +char(13)+
           '   REGBES, SERIEDATO, VISISTART, VISISLUT, Målt, Forbrugsstatus, Samlet_Forbrugsafvigelse, JOBID, ' +char(13)+
           '   Normtid_ydelse, Fordelt_Forbrug, Fordelt_Forbrugsafvigelse, Fordelt_vejtid, VISITYPE, Start,STAT_TYPE )' +char(13)+
           'SELECT ID, SERIEID, SAGSID, MEDID, RETDATO, TID, VEJTID, YDELSESTID, STATUSID, RSTART, RTID, RVEJTID, ' +char(13)+
           '   REGBES, SERIEDATO, VISISTART, VISISLUT, Målt, Forbrugsstatus, Samlet_Forbrugsafvigelse, jobid, ' +char(13)+
           '   Normtid_ydelse, fordelt_forbrug, Fordelt_forbrugsafvigelse, fordelt_vejtid, visitype, STARTMINEFTERMIDNAT, STAT_TYPE ' +char(13)+
           'FROM _vForbrugsafvigelserUdenYdelse '+char(13)


if @debug = 1 print @cmd
	exec (@cmd)
	
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger1 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger1 '
	if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  dbo._Forbrugsafvigelser.ID, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISITYPE, '+char(13)+
           '  dbo._Forbrugsafvigelser.SERIEID, '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID, '+char(13)+
           '  dbo._Forbrugsafvigelser.MEDID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO, '+char(13)+
           '  dbo._Forbrugsafvigelser.START, '+char(13)+
           '  dbo._Forbrugsafvigelser.TID, '+char(13)+
           '  dbo._Forbrugsafvigelser.VEJTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.YDELSESTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.STATUSID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RSTART, '+char(13)+
           '  dbo._Forbrugsafvigelser.RTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.RVEJTID, '+char(13)+
           '  dbo._Forbrugsafvigelser.REGBES, '+char(13)+
           '  dbo._Forbrugsafvigelser.SERIEDATO, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISISTART, '+char(13)+
           '  dbo._Forbrugsafvigelser.VISISLUT,  '+char(13)+
           '  dbo._Forbrugsafvigelser.Målt, '+char(13)+
           '  dbo._Forbrugsafvigelser.Forbrugsstatus, '+char(13)+
           '  dbo._Forbrugsafvigelser.Samlet_Forbrugsafvigelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.JOBID, '+char(13)+
           '  dbo._Forbrugsafvigelser.Normtid_Ydelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Forbrugsafvigelse, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Forbrug, '+char(13)+
           '  dbo._Forbrugsafvigelser.Fordelt_Vejtid, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_STATUS, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_STATUSID, '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK.HJEMMEPLEJE_GRUPPEID, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_STATUS, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_STATUSID, '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK.SYGEPLEJE_GRUPPEID, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUS, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_STATUSID, '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK.TERAPEUT_GRUPPEID '+char(13)+
           'into _Forbrugsafvigelser_Borger1 ' +char(13)+
           'FROM dbo._Forbrugsafvigelser LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_TP_SAGSHISTORIK ON dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_TP_SAGSHISTORIK.SLUTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_TP_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_TP_SAGSHISTORIK.SAGSID LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_SP_SAGSHISTORIK ON dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_SP_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_SP_SAGSHISTORIK.SLUTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_SP_SAGSHISTORIK.SAGSID LEFT OUTER JOIN   '+char(13)+
           '  dbo._tmp_HJ_SAGSHISTORIK ON dbo._Forbrugsafvigelser.SAGSID = dbo._tmp_HJ_SAGSHISTORIK.SAGSID AND   '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO >= dbo._tmp_HJ_SAGSHISTORIK.IKRAFTDATO AND '+char(13)+
           '  dbo._Forbrugsafvigelser.RETDATO < dbo._tmp_HJ_SAGSHISTORIK.SLUTDATO  '+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger2 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger2 '
	if @debug = 1 print @cmd
	exec (@cmd)
  

set @cmd = 'SELECT  *, ' +char(13)+
           '  CASE ' +char(13)+
           '    WHEN VISITYPE = 0 or VISITYPE =1 OR VISITYPE = 2 THEN HJEMMEPLEJE_GRUPPEID ' +char(13)+
           '    WHEN VISITYPE = 3 OR VISITYPE =4 THEN TERAPEUT_GRUPPEID ' +char(13)+
           '    WHEN VISITYPE = 5 THEN SYGEPLEJE_GRUPPEID ' +char(13)+
           '  ELSE 9999 ' +char(13)+
           '  END AS GRUPPEID' +char(13)+
           'INTO _Forbrugsafvigelser_Borger2' +char(13)+
           'From _Forbrugsafvigelser_Borger1'+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''_Forbrugsafvigelser_borger3 '' AND type = ''U'') DROP TABLE dbo._Forbrugsafvigelser_borger3 '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	
-- **************************************************************************************************************************
-- Joiner med MEDHISTORIK tabellen for at finde StatusID (som bruges i Stillingsbetegnelse dimensionen)
-- **************************************************************************************************************************

set @cmd = 'SELECT  ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.ID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISITYPE, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SERIEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SAGSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.MEDID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RETDATO, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.START, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.TID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VEJTID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.YDELSESTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.STATUSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RSTART, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.RTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.RVEJTID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.REGBES, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.SERIEDATO, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISISTART, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.VISISLUT, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.Målt, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Forbrugsstatus, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Samlet_Forbrugsafvigelse, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.JOBID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Normtid_Ydelse, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Forbrug,' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Forbrugsafvigelse, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.Fordelt_Vejtid, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_STATUS, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_STATUSID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.HJEMMEPLEJE_GRUPPEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_STATUS, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_STATUSID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.SYGEPLEJE_GRUPPEID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_STATUS, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_STATUSID, '+char(13)+
           '  _Forbrugsafvigelser_Borger2.TERAPEUT_GRUPPEID, ' +char(13)+
           '  _Forbrugsafvigelser_Borger2.GRUPPEID, ' +char(13)+
           '  MEDHISTORIK.MEDARBEJDER_STATUS, '+char(13)+
           '  MEDHISTORIK.MEDARBEJDER_STATUSID, ' +char(13)+
           '  MEDHISTORIK.STILLINGSID, ' +char(13)+
           '  MEDHISTORIK.UAFDELINGID AS MedarbGrp   '+char(13)+
           'into _Forbrugsafvigelser_borger3   '+char(13)+
           'FROM _Forbrugsafvigelser_Borger2 ' +char(13)+
           'LEFT OUTER JOIN MEDHISTORIK ON _Forbrugsafvigelser_Borger2.MEDID = MEDHISTORIK.MEDARBEJDERID AND  '+char(13)+
           '  _Forbrugsafvigelser_Borger2.RETDATO >= MEDHISTORIK.IKRAFTDATO AND _Forbrugsafvigelser_Borger2.RETDATO < MEDHISTORIK.SLUTDATO '+char(13)

if @debug = 1 print @cmd
	exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactForbrugsafvigelse'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactForbrugsafvigelse'
	if @debug = 1 print @cmd
	exec (@cmd)

	set @cmd = 'Select * into '+ @DestinationDB +'.dbo.FactForbrugsafvigelse from _Forbrugsafvigelser_borger3 '
	if @debug = 1 print @cmd
	exec (@cmd)
	

-- Sætter GruppeID til 8888 hvor der er en visitype, men ikke et gruppe tilhørsforhold borger Organisation
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set GRUPPEID=8888 where GRUPPEID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	-- Sætter GruppeID til 8888 hvor der er en visitype, men ikke et gruppe tilhørsforhold på Medarb Organisation
		set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set medarbGrp=8888 where medarbGrp is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
-- Opdatere Stillingsbetegnelse, da ikke alle får en (bliver sat til 9999)	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set STILLINGSID=9999 where STILLINGSID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
-- Opdatere MedarbejderStatus (Der er nogle som falder forbi). Bliver sat til ukendt (9999) 	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set MEDARBEJDER_STATUSID=9999 where MEDARBEJDER_STATUSID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
	
	
-- Opdatere MEDID, hvor den ikke eksisterer og sætter den til ukendt (9999). 	
	set @cmd = 'update '+ @DestinationDB +'.dbo.FactForbrugsafvigelse set MEDID=9999 where MEDID is null '
	if @debug = 1 print @cmd
	exec (@cmd)
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateFactPlanlagtUdfoertTid]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Henrik Due Jensen
-- Create date: 2010-10-08
-- Description:	Planlagt og udført tid fra Tkorttavle
-- OBS OBS bruges til BTP beregning - PAS PÅ ændringer
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreateFactPlanlagtUdfoertTid] 
                    @DestinationDB as varchar(200),@ExPart as Int=0,@Debug  as bit = 1
AS
DECLARE @cmd as varchar(max)
DECLARE @vejtidibesoeg as varchar(1)

SET @vejtidibesoeg = (select * from openquery(OMSORG,'select tkvejtid from opsatning'))
print @vejtidibesoeg

if @ExPart=1 or @ExPart=0
begin
set @cmd = 'DELETE FROM SAGSPLAN WHERE STARTDATO > SLUTDATO'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep1'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep1'
if @debug = 1 print @cmd
exec (@cmd)
--hent alle data fra sagsplan
set @cmd = 'SELECT ' +char(13)+
           '  SP.ID AS SERIEID, ' +char(13)+
           '  SA.SAGSID, ' +char(13)+
           '  SA.CPRNR, ' +char(13)+
           '  SA.SAGSTYPE,' +char(13)+
           '  SP.STARTDATO, ' +char(13)+
           '  SP.SLUTDATO, ' +char(13)+
           '  COALESCE((SELECT MEDARBEJDERTYPE FROM MEDARBEJDERE WHERE MEDARBEJDERID=SP.MEDID),1) AS MEDARB_TYPE,' +char(13)+
           '  COALESCE(SP.MEDID,9999) AS MEDID, ' +char(13)+
           '  SP.VEJTID, ' +char(13)+
           '  SP.FREKVENS, ' +char(13)+
           '  SP.FREKTYPE, ' +char(13)+
           '  SP.FREKVALGTEDAGE, ' +char(13)+
           '  SP.YDELSESTID, ' +char(13)+
           '  (SELECT COUNT(*) FROM SAGSPDET WHERE SP.ID = SAGSPDET.SAGSPID) AS ANTAL_INDSATSE, ' +char(13)+
           '  dbo.Udf_SaetDoegninddeling(SP.STARTMINEFTERMIDNAT) AS DOEGNINDDELING ' +char(13)+
           'INTO PlanlagtUdfoertStep1 ' +char(13)+
           'FROM SAGSPLAN SP ' +char(13)+
           'JOIN SAGER SA ON SA.SAGSID=SP.SAGSID ' +char(13)+
           'WHERE (SP.SLUTDATO>=CONVERT(DATETIME,''2009-01-01 00:00:00'',102)) AND SP.FREKVENS<>0 AND (SP.STARTDATO>CONVERT(DATETIME,''2000-01-01 00:00:00'',102))'  
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep2'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep2'
if @debug = 1 print @cmd
exec (@cmd)
--rul besøg ud, MEN kun besøg der ikke er rettet
set @cmd = 'SELECT' +char(13)+  --HUSK
           '  Dim_Time.PK_DATE, ' +char(13)+
           '  A.SERIEID, ' +char(13)+
           '  A.SAGSID, ' +char(13)+                   
           '  A.SAGSTYPE,' +char(13)+
           '  dbo.Age(A.CPRNR,Dim_Time.PK_DATE) AS ALDER, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  COALESCE((SELECT UAFDELINGID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS MED_ORG, ' +char(13)+ 
           '  COALESCE((SELECT MEDARBEJDER_STATUSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS MEDARBEJDER_STATUSID, ' +char(13)+
           '  COALESCE((SELECT STILLINGSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID AND ' +char(13)+
           '   (Dim_Time.PK_DATE>=MEDHISTORIK.IKRAFTDATO) AND (Dim_Time.PK_DATE<MEDHISTORIK.SLUTDATO)),9999) AS STILLINGSID, ' +char(13)+                        
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.ANTAL_INDSATSE, ' +char(13)+
           '  A.VEJTID, ' +char(13)+  
           '  A.YDELSESTID,' +char(13)+ --denne skal IKKE tælles med da det er hele besøget
           '  1 AS BESOEGSSTATUSID '+char(13)+
           'INTO PlanlagtUdfoertStep2 ' +char(13)+
           'FROM PlanlagtUdfoertStep1 A ' +char(13)+
           'JOIN Dim_Time ON Dim_Time.PK_Date between ''2009.01.01'' and GETDATE() ' +char(13)+ 
           'WHERE dbo.SERIES_OCCURS_ON_DAY(Dim_Time.PK_Date,FREKVENS,FREKTYPE,FREKVALGTEDAGE,STARTDATO) = 1 AND ' +char(13)+
           '  NOT EXISTS(SELECT * FROM SAGSPLANRET WHERE SERIEID=A.SERIEID AND SERIEDATO=PK_DATE) AND ' +char(13)+
           '  A.STARTDATO<=PK_DATE AND A.SLUTDATO>PK_DATE ' 
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep3'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep3'
if @debug = 1 print @cmd
exec (@cmd)
--hent detaljer på sagsplan         
set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE ,' +char(13)+
           '  A.SAGSID, ' +char(13)+     
           '  A.ALDER, ' +char(13)+  
           '  CASE WHEN (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPD.JOBID)=1 THEN ' +char(13)+
           '    (SELECT PLEJETYPE FROM JOBTYPER WHERE JOBID=SPD.JOBID)' +char(13)+
           '  ELSE ' +char(13)+
           '    (SELECT PARAGRAF_GRUPPERING.ID FROM JOBTYPER ' +char(13)+
           '    JOIN PARATYPER ON JOBTYPER.PARAGRAF=PARATYPER.ID AND JOBTYPER.FALLES_SPROG_ART=2 AND JOBTYPER.JOBID=SPD.JOBID' +char(13)+
           '    JOIN PARAGRAF_GRUPPERING ON PARATYPER.PARAGRAF_GRUPPERING_ID=PARAGRAF_GRUPPERING.ID)' +char(13)+
           '  END AS PLEJETYPE,' +char(13)+
           '  (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPD.JOBID) AS FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.VEJTID AS SPVEJTID, ' +char(13)+ 
           '  A.ANTAL_INDSATSE, ' +char(13)+
           '  CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '    Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '  ELSE ' +char(13)+ 
           '    A.VEJTID' +char(13)+ 
           '  END AS VEJTID, ' +char(13)+ 
           '  SPD.JOBID, ' +char(13)+ 
           '  SPD.NORMTID AS VISITERET_TID, ' +char(13)+ --visiterede tid
           '  SPD.YDELSESTID AS PLANLAGT_TID , ' +char(13)+  --planlagte tid 
           '  SPD.VISITYPE, ' +char(13)+
           '  A.BESOEGSSTATUSID, ' +char(13)+
           '  ''Planlagt + Udført'' AS STATISTIKTYPE ' +char(13)+
           'INTO PlanlagtUdfoertStep3 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep2 A ' +char(13)+
           'JOIN SAGSPDET SPD ON A.SERIEID = SPD.SAGSPID ' 
exec (@cmd)

set @cmd = 'UPDATE PlanlagtUdfoertStep3 SET PLEJETYPE=1 WHERE PLEJETYPE IN (1,2,8)'
exec (@cmd)
set @cmd = 'UPDATE PlanlagtUdfoertStep3 SET PLEJETYPE=3 WHERE PLEJETYPE IN (3,4)'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep4'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep4'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.ALDER, ' +char(13)+ 
           '  COALESCE((SELECT TOP 1 BORGER_ORG FROM BORGER_TILHOER_HISTORIK ' +char(13)+
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND ' +char(13)+
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND ' +char(13)+
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND ' +char(13)+
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG,  ' +char(13)+   
           '  COALESCE((SELECT TOP 1 STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+ 
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+           
           '  A.PLEJETYPE, ' +char(13)+
           '  A.FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.MED_ORG, ' +char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.VEJTID AS PLANLAGT_VEJTID, ' +char(13)+
           '  A.VEJTID AS UDFOERT_VEJTID, ' +char(13)+
           '  A.JOBID, ' +char(13)+
           '  A.VISITERET_TID, ' +char(13)+
           '  A.PLANLAGT_TID, ' +char(13)+
           '  A.VISITYPE, ' +char(13)+
           '  A.BESOEGSSTATUSID, ' +char(13)+
           '  A.STATISTIKTYPE ' +char(13)+
           'INTO PlanlagtUdfoertStep4 ' +char(13)+
           'FROM PlanlagtUdfoertStep3 A' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep5'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep5'
if @debug = 1 print @cmd
exec (@cmd)
--hent alle data fra sagsplanret 
set @cmd = 'SELECT' +char(13)+  --HUSK
           '  SPR.RETDATO AS PK_DATE,' +char(13)+
           '  SPR.ID AS SPRID, ' +char(13)+
           '  SA.SAGSID, ' +char(13)+ 
           '  dbo.Age(SA.CPRNR,SPR.RETDATO) AS ALDER, ' +char(13)+
           '  SA.SAGSTYPE,' +char(13)+         
           '  COALESCE(SPR.MEDID,9999) AS MEDID,' +char(13)+
           '  COALESCE((SELECT UAFDELINGID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS MED_ORG, ' +char(13)+ 
           '  COALESCE((SELECT MEDARBEJDER_STATUSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  COALESCE((SELECT STILLINGSID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=SPR.MEDID AND ' +char(13)+
           '   (SPR.RETDATO>=MEDHISTORIK.IKRAFTDATO) AND (SPR.RETDATO<MEDHISTORIK.SLUTDATO)),9999) AS STILLINGSID, ' +char(13)+ 
           '  SPR.VEJTID, ' +char(13)+
           '  SPR.RVEJTID AS MOB_VEJTID, ' +char(13)+ 
           '  (SELECT COUNT(*) FROM SAGSPRETDET WHERE SPR.ID = SAGSPRETDET.SAGSPRETID) AS ANTAL_INDSATSE, ' +char(13)+
           '  SPR.YDELSESTID, ' +char(13)+
           '  dbo.Udf_SaetDoegninddeling(SPR.STARTMINEFTERMIDNAT) AS DOEGNINDDELING, ' +char(13)+
           '  SPR.REGBES, '  +char(13)+ 
           '  SPR.RSTART, ' +char(13)+ 
           '  dbo.Udf_SaetDoegninddeling(SPR.RSTART) AS MOBIL_DOEGNINDDELING, ' +char(13)+
           '  BES.STAT_TYPE AS BESOEG_STAT_TYPE, ' +char(13)+
           '  BES.STATUS AS BESOEG_STATUS, '+char(13)+
           '  SPR.STATUSID AS BESOEGSSTATUSID ' +char(13)+ 
           'INTO PlanlagtUdfoertStep5 ' +char(13)+
           'FROM SAGSPLANRET SPR ' +char(13)+
           'JOIN SAGER SA ON SA.SAGSID=SPR.SAGSID ' +char(13)+  
           'JOIN BESOGSTATUS BES ON BES.BESOGID=SPR.STATUSID ' +char(13)+ 
           'WHERE (SPR.RETDATO>=CONVERT(DATETIME,''2009-01-01 00:00:00'',102)) AND '  +char(13)+ 
           '  SPR.RETDATO<GETDATE() '
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep6'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep6'
if @debug = 1 print @cmd
exec (@cmd)
--hent PLANLAGTE detaljer på sagsplanret         
set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE ,' +char(13)+
           '  A.SAGSID, ' +char(13)+  
           '  A.ALDER, ' +char(13)+ 
           '  CASE WHEN (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPRD.JOBID)=1 THEN ' +char(13)+
           '    (SELECT PLEJETYPE FROM JOBTYPER WHERE JOBID=SPRD.JOBID)' +char(13)+
           '  ELSE ' +char(13)+
           '    (SELECT PARAGRAF_GRUPPERING.ID FROM JOBTYPER ' +char(13)+
           '    JOIN PARATYPER ON JOBTYPER.PARAGRAF=PARATYPER.ID AND JOBTYPER.FALLES_SPROG_ART=2 AND JOBTYPER.JOBID=SPRD.JOBID' +char(13)+
           '    JOIN PARAGRAF_GRUPPERING ON PARATYPER.PARAGRAF_GRUPPERING_ID=PARAGRAF_GRUPPERING.ID)' +char(13)+
           '  END AS PLEJETYPE,' +char(13)+ 
           '  (SELECT FALLES_SPROG_ART FROM JOBTYPER WHERE JOBID=SPRD.JOBID) AS FALLES_SPROG_ART, ' +char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.MOBIL_DOEGNINDDELING, ' +char(13)+ 
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,2) THEN ' +char(13)+ --Planlagte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS PLANLAGT_VEJTID, ' +char(13)+     
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,3) THEN ' +char(13)+  --Udførte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS UDFOERT_VEJTID, ' +char(13)+ 
           '  CASE WHEN A.REGBES=1 THEN ' +char(13)+  --Mobil udførte besøg
           '    CASE WHEN A.ANTAL_INDSATSE>0 THEN ' +char(13)+ 
           '      Convert(decimal(18,10),A.MOB_VEJTID)/A.ANTAL_INDSATSE ' +char(13)+
           '    ELSE ' +char(13)+ 
           '      A.MOB_VEJTID ' +char(13)+ 
           '    END ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS MOB_VEJTID, ' +char(13)+                              
           '  A.REGBES, ' +char(13)+ 
           '  SPRD.JOBID, ' +char(13)+ 
           '  SPRD.STATUSID, ' +char(13)+
           '  SPRD.NORMTID AS VISITERET_TID, ' +char(13)+ --visiterede tid
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,2) THEN ' +char(13)+ --Planlagte besøg
           '    SPRD.YDELSESTID ' +char(13)+ 
           '  ELSE 0 ' +char(13)+ 
           '  END AS PLANLAGT_TID, ' +char(13)+  --planlagte tid 
           '  CASE WHEN A.BESOEG_STAT_TYPE IN (1,3) THEN ' +char(13)+ --udført tid
           '    CASE WHEN SPRD.STATUSID=1 THEN ' +char(13)+  
           '      SPRD.YDELSESTID ' +char(13)+ 
           '    ELSE ' +char(13)+ 
           '      SPRD.AFVIGELSE ' +char(13)+  
           '    END ' +char(13)+ 
           '  ELSE 0 ' +char(13)+    
           '  END AS UDFOERT_TID, ' +char(13)+            
           '  SPRD.VISITYPE, ' +char(13)+
           '  A.BESOEG_STAT_TYPE, ' +char(13)+
           '  A.BESOEG_STATUS, ' +char(13)+
           '  A.BESOEGSSTATUSID ' +char(13)+
           'INTO PlanlagtUdfoertStep6 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep5 A ' +char(13)+
           'JOIN SAGSPRETDET SPRD ON A.SPRID = SPRD.SAGSPRETID '
exec (@cmd)

set @cmd = 'UPDATE PlanlagtUdfoertStep6 SET PLEJETYPE=1 WHERE PLEJETYPE IN (1,2,8)'
exec (@cmd)
set @cmd = 'UPDATE PlanlagtUdfoertStep6 SET PLEJETYPE=3 WHERE PLEJETYPE IN (3,4)'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep7'' AND type = ''U'') DROP TABLE dbo.PlanlagtUdfoertStep7'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  A.PK_DATE, ' +char(13)+ 
           '  A.SAGSID, ' +char(13)+ 
           '  A.ALDER, ' +char(13)+ 
           '  COALESCE((SELECT TOP 1 BORGER_ORG FROM BORGER_TILHOER_HISTORIK ' +char(13)+
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND ' +char(13)+
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND ' +char(13)+
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND ' +char(13)+
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG,  ' +char(13)+  
           '  COALESCE((SELECT TOP 1 STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '     A.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+ 
           '     A.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+           
           '  A.PLEJETYPE, ' +char(13)+ 
           '  A.FALLES_SPROG_ART, '  +char(13)+
           '  A.SAGSTYPE, ' +char(13)+ 
           '  A.MEDID, ' +char(13)+ 
           '  A.MED_ORG, ' +char(13)+ 
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+ 
           '  A.MOBIL_DOEGNINDDELING, ' +char(13)+
           '  A.PLANLAGT_VEJTID, ' +char(13)+ 
           '  A.UDFOERT_VEJTID, ' +char(13)+ 
           '  A.MOB_VEJTID, ' +char(13)+ 
           '  A.REGBES, ' +char(13)+ 
           '  A.JOBID, ' +char(13)+ 
           '  A.VISITERET_TID, ' +char(13)+ 
           '  A.PLANLAGT_TID, ' +char(13)+ 
           '  A.UDFOERT_TID, '+char(13)+
           '  A.VISITYPE, ' +char(13)+ 
           '  A.BESOEG_STAT_TYPE, ' +char(13)+
           '  CASE WHEN A.BESOEG_STATUS=1 THEN '+char(13)+
           '    CASE A.BESOEG_STAT_TYPE ' +char(13)+
           '      WHEN 1 THEN ''Planlagt + Udført'' ' +char(13)+
           '      WHEN 2 THEN ''Planlagt'' ' +char(13)+
           '      WHEN 3 THEN ''Udført'' ' +char(13)+
           '    ELSE ''Statistiktype ikke defineret'' ' +char(13)+
           '    END ' +char(13)+ 
           '  ELSE ''Statistiktype ikke defineret'' ' +char(13)+
           '  END AS STATISTIKTYPE, ' +char(13)+         
           '  A.BESOEGSSTATUSID ' +char(13)+
           'INTO PlanlagtUdfoertStep7 ' +char(13)+ 
           'FROM PlanlagtUdfoertStep6 A'
if @debug = 1 print @cmd
exec (@cmd)           

end 

if @ExPart=2 or @ExPart=0
BEGIN
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''PlanlagtUdfoertStep9'' AND type = ''U'') DROP TABLE DBO.PlanlagtUdfoertStep9'
if @debug = 1 print @cmd
exec (@cmd)
                                --fra SAGSPLAN
set @cmd = 'SELECT ' +char(13)+ --vejtid fra PLANLAGTE seriebesøg   --HUSK PLANLAGT OG UDFOERT VEJTID
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000001 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000004 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  PLANLAGT_VEJTID AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID,' +char(13)+ 
           '  0 AS REGBES, '+char(13)+  
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+  --til fejlsøgning
           'INTO PlanlagtUdfoertStep9' +char(13)+
           'FROM PlanlagtUdfoertStep4 ' +char(13)+
           'UNION ALL ' +char(13)+  
           'SELECT ' +char(13)+ --vejtid fra UDFØRTE seriebesøg   --HUSK PLANLAGT OG UDFOERT VEJTID
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000002 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000005 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_VEJTID AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID,' +char(13)+ 
           '  0 AS REGBES, '+char(13)+  
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+  
           'FROM PlanlagtUdfoertStep4 ' +char(13)+
           'UNION ALL ' +char(13)+  --fra SAGSPDET
           'SELECT ' +char(13)+  --detaljer på PLANLAGTE og UDFØRTE seriebesøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  PLANLAGT_TID, ' +char(13)+
           '  PLANLAGT_TID AS UDFOERT_TID,' +char(13)+ --alle seriebesøg der ikke er rettet er også udført
           '  0 AS MOBIL_TID,' +char(13)+
           '  0 AS REGBES, '+char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  4 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep4' +char(13)+ 
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid PLANLAGTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000001 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000004 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  PLANLAGT_VEJTID AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid UDFØRTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000002 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000005 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_VEJTID AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'WHERE REGBES=0 ' +char(13)+    
           'UNION ALL ' +char(13)+ --fra SAGSPRETDET
           'SELECT ' +char(13)+  --vejtid MOBIL UDFØRTE rettede/enkelt besøg 
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  CASE WHEN FALLES_SPROG_ART=1 THEN ' +char(13)+ 
           '    1000003 ' +char(13)+
           '  ELSE ' +char(13)+
           '    1000006 ' +char(13)+
           '  END AS JOBID, ' +char(13)+ --vejtid
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  MOB_VEJTID AS UDFOERT_TID, ' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+  
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+         
           'FROM PlanlagtUdfoertStep7 ' +char(13)+  
           'WHERE REGBES=1 ' +char(13)+                    
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på PLANLAGTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID,' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på UDFØRTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  UDFOERT_TID,' +char(13)+
           '  0 AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'WHERE REGBES=0 ' +char(13)+   
           'UNION ALL ' +char(13)+  --fra SAGSPRETDET
           'SELECT ' +char(13)+  --detaljer på MOBIL UDFØRTE rettede/enkelt besøg
           '  PK_DATE, ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  SAGSTYPE, ' +char(13)+
           '  MEDID, ' +char(13)+
           '  MED_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           '  DOEGNINDDELING, ' +char(13)+
           '  JOBID, ' +char(13)+
           '  0 AS PLANLAGT_TID, ' +char(13)+
           '  0 AS UDFOERT_TID,' +char(13)+
           '  UDFOERT_TID AS MOBIL_TID, ' +char(13)+
           '  REGBES, ' +char(13)+ 
           '  BESOEGSSTATUSID, '+char(13)+
           '  STATISTIKTYPE, '+char(13)+
           '  7 AS STEP ' +char(13)+
           'FROM PlanlagtUdfoertStep7' +char(13)+  
           'WHERE REGBES=1 '                                                 
exec (@cmd)   

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactPlanlagtUdfoert'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactPlanlagtUdfoert'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+  
           '  A.PK_DATE, ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  A.ALDER, ' +char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.STATUSID, '+char(13)+
           '  A.SAGSTYPE, ' +char(13)+
           '  A.MEDID, ' +char(13)+
           '  A.MED_ORG, ' +char(13)+
           '  A.MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  A.STILLINGSID, ' +char(13)+ 
           '  A.DOEGNINDDELING, ' +char(13)+
           '  A.JOBID, ' +char(13)+
           '  A.PLANLAGT_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 THEN PLANLAGT_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS PLANLAGT_TID_HVERDAG, ' +char(13)+ 
		   '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
		   '    CASE WHEN B.WEEKEND=1 then PLANLAGT_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS PLANLAGT_TID_WEEKEND, ' + char (13) +
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    PLANLAGT_TID ' +char(13)+
		   '  ELSE 0 END AS PLANLAGT_TID_HELLIGDAG, ' +char(13)+		
           '  UDFOERT_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 then UDFOERT_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' + char (13) +
		   '  END AS UDFOERT_TID_HVERDAG, ' + char (13) +
		   '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
		   '    CASE WHEN B.WEEKEND=1 then UDFOERT_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '  END ' + char(13)+
		   '  END AS UDFOERT_TID_WEEKEND, ' + char (13) +	
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    UDFOERT_TID ' +char(13)+
		   '  ELSE 0 END AS UDFOERT_TID_HELLIGDAG, ' +char(13)+		   
           '  MOBIL_TID, ' +char(13)+
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 then MOBIL_TID     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+ 
		   '  END AS MOBIL_TID_HVERDAG, ' + char (13) +
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=1 then MOBIL_TID ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS MOBIL_TID_WEEKEND, ' + char (13) +	 
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
		   '    MOBIL_TID ' +char(13)+
		   '  ELSE 0 END AS MOBIL_TID_HELLIGDAG, ' +char(13)+        
           '  A.REGBES, ' +char(13)+ 
           '  A.BESOEGSSTATUSID, '+char(13)+
           '  A.STATISTIKTYPE, '+char(13)+
           '  A.STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactPlanlagtUdfoert ' +char(13)+   
           'FROM PlanlagtUdfoertStep9 A ' +char(13)+
           'JOIN DimWeekendHelligdag B on A.PK_DATE=B.PK_DATE'   
if @debug = 1 print @cmd
exec (@cmd)      
END

if @ExPart=3 or @ExPart=0  
BEGIN
  

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactPlanlagtTid'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactPlanlagtTid'
if @debug = 1 print @cmd
exec (@cmd)   

set @cmd = 'SELECT ' +char(13)+ 
           ' PK_DATE, ' +char(13)+
           ' SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           ' BORGER_ORG AS BORGERORG, '+char(13)+
           '  STATUSID, '+char(13)+
           ' SAGSTYPE, ' +char(13)+
           ' MEDID, ' +char(13)+
           ' MED_ORG AS MEDARB_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           ' DOEGNINDDELING, ' +char(13)+
           ' JOBID, ' +char(13)+
           ' PLANLAGT_TID, ' +char(13)+
           ' PLANLAGT_TID_HVERDAG, ' +char(13)+
           ' PLANLAGT_TID_WEEKEND, ' +char(13)+
           ' PLANLAGT_TID_HELLIGDAG, ' +char(13)+
           ' REGBES, ' +char(13)+
           ' BESOEGSSTATUSID, '+char(13)+
           ' STATISTIKTYPE, '+char(13)+
           ' STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactPlanlagtTid ' +char(13)+ 
           ' FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' 
           
exec (@cmd)           
           
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactUdfoertTid'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactUdfoertTid'
if @debug = 1 print @cmd
exec (@cmd)   

set @cmd = 'SELECT ' +char(13)+ 
           ' PK_DATE, ' +char(13)+
           ' SAGSID, ' +char(13)+
           '  ALDER, ' +char(13)+
           ' BORGER_ORG AS BORGERORG, '+char(13)+
           '  STATUSID, '+char(13)+
           ' SAGSTYPE, ' +char(13)+
           ' MEDID, ' +char(13)+
           ' MED_ORG AS MEDARB_ORG, ' +char(13)+
           '  MEDARBEJDER_STATUSID, ' +char(13)+ 
           '  STILLINGSID, ' +char(13)+ 
           ' DOEGNINDDELING, ' +char(13)+
           ' JOBID, ' +char(13)+
           ' UDFOERT_TID, ' +char(13)+
           ' UDFOERT_TID_HVERDAG, ' +char(13)+
           ' UDFOERT_TID_WEEKEND, ' +char(13)+
           ' UDFOERT_TID_HELLIGDAG, ' +char(13)+
           ' MOBIL_TID, ' +char(13)+
           ' MOBIL_TID_HVERDAG, ' +char(13)+
           ' MOBIL_TID_WEEKEND, ' +char(13)+
           ' MOBIL_TID_HELLIGDAG, ' +char(13)+
           ' REGBES, ' +char(13)+
           ' BESOEGSSTATUSID, '+char(13)+
           ' STATISTIKTYPE, '+char(13)+
           ' STEP ' +char(13)+
           'INTO '+@DestinationDB+'.DBO.FactUdfoertTid ' +char(13)+ 
           ' FROM '+@DestinationDB+'.dbo.FactPlanlagtUdfoert' 
exec (@cmd) 

END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalyticsDW.dbo.VERSION WHERE VERSION=24)
--if @version is null
--begin
--INSERT INTO AvaleoAnalyticsDW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (24,GETDATE())           
--end
GO
/****** Object:  Table [dbo].[BRUGERPROFILREL]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRUGERPROFILREL](
	[PROFILID] [int] NOT NULL,
	[BRUGERID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BRUGERPROFIL]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRUGERPROFIL](
	[ID] [int] NOT NULL,
	[NAVN] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BRUGER_PASSW_HIST]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRUGER_PASSW_HIST](
	[BRUGERID] [int] NOT NULL,
	[OPRETTET] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BRUGER]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BRUGER](
	[BRUGERID] [int] NOT NULL,
	[MEDARBEJDER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[BRUGERNAVN] [nvarchar](50) NOT NULL,
	[ADBRUGERNAVN] [nvarchar](255) NULL,
	[KONTI_DISABLED] [int] NULL,
	[FORNAVN] [nvarchar](50) NULL,
	[EFTERNAVN] [nvarchar](50) NULL,
	[KONTI_DISABLED_AARSAG] [int] NOT NULL,
	[LASTPWCHANGE] [datetime2](7) NULL,
	[SYSTEMBRUGER] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BORLAGEREL]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BORLAGEREL](
	[LAEGEID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BORGER_TILHOER_HISTORIK]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BORGER_TILHOER_HISTORIK](
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[BORGER_ORG] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIGVISITATION]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIGVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[VISIDATO] [datetime] NOT NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[INDFLYTNING] [date] NULL,
	[BOLIGERANVIST] [int] NULL,
	[DRIFTFORM] [int] NOT NULL,
	[PLADSTYPE] [int] NOT NULL,
	[BOLIG_ANSOG] [date] NULL,
	[FRITVALGSVENTELISTE] [int] NOT NULL,
	[FRITVALGSVENTELISTE_DATO] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIGSAGHIST]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIGSAGHIST](
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[INDFLYTNING] [date] NULL,
	[FRAFLYTNING] [date] NULL,
	[KLAR_DATO] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIGGRUPPER]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIGGRUPPER](
	[GRUPPEID] [int] NOT NULL,
	[BOLIGGRUPPE] [nvarchar](50) NOT NULL,
	[SKJULT] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIGER]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIGER](
	[ID] [int] NOT NULL,
	[DRIFTFORM] [int] NOT NULL,
	[PLADSTYPE] [int] NOT NULL,
	[UDLEJETDATO] [date] NULL,
	[HJEMSTED] [int] NOT NULL,
	[KENDENAVN] [nvarchar](40) NOT NULL,
	[ADRESSE] [nvarchar](40) NULL,
	[STATUS] [int] NOT NULL,
	[BOLIGGRP] [int] NULL,
	[TILDELTPR] [date] NULL,
	[LEDIGPR] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIG_TILBUD]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIG_TILBUD](
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NULL,
	[BORGERID] [int] NULL,
	[TILBUD_DATO] [date] NULL,
	[UDLOB_DATO] [date] NULL,
	[AFVIST_DATO] [date] NULL,
	[FRA_GARANTI_LISTE] [int] NULL,
	[BOLIGVISI_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOLIG_DFPT]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOLIG_DFPT](
	[ID] [int] NOT NULL,
	[KODE] [nvarchar](20) NOT NULL,
	[DF_PT] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BESOGSTATUS]    Script Date: 10/06/2015 18:35:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BESOGSTATUS](
	[BESOGID] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STAT_TYPE] [int] NOT NULL,
	[STAT_GYLDIG] [int] NOT NULL,
	[STATUSNAVN] [nvarchar](50) NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Age]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Age](@cprNr AS nvarchar(10), @dato as datetime) 
RETURNS  int

AS
BEGIN
  if @cprnr is null
	return null
  if @cprnr = ''
	return null
  DECLARE @CENT as varchar(2)
  DECLARE @DATEOFBIRTH as datetime
  declare @age as int
  select @CENT =(select CASE WHEN (substring(@cprNr, 7, 1)) < 4 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
			    WHEN (substring(@cprNr, 7, 1)) = 4 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) = 9 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
			    WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) > 36 THEN 18 
				END AS år)  
  set @DATEOFBIRTH = CAST(LOWER(@CENT) + SUBSTRING(@cprNr, 5, 2)+ 
					 '-' + SUBSTRING(@cprNr, 3, 2) + 
					 '-' + LEFT(@cprNr, 2) AS datetime) 

  --set @age = FLOOR((CAST(@dato AS float) - CAST(@DATEOFBIRTH AS float)) / 365) 
	--set @age =  datediff(year,@DATEOFBIRTH,@dato)
	select @age = (select CASE
					WHEN dateadd(year, datediff (year, @DATEOFBIRTH, @dato), @DATEOFBIRTH) > @dato
					THEN datediff (year, @DATEOFBIRTH, @dato) - 1
					ELSE datediff (year, @DATEOFBIRTH, @dato)
					END as Age)

  RETURN @age;
END
GO
/****** Object:  Table [dbo].[AFDELINGER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AFDELINGER](
	[AFDELINGID] [int] NOT NULL,
	[ORGANISATIONID] [int] NOT NULL,
	[AFDELINGNAVN] [nvarchar](50) NOT NULL,
	[LEDER] [nvarchar](100) NULL,
	[ADRESSE] [nvarchar](100) NULL,
	[TELEFON] [nvarchar](20) NULL,
	[FAX] [nvarchar](20) NULL,
	[AKTIV] [int] NOT NULL,
	[SAGSSTED] [nvarchar](3) NULL,
	[KONTAKTTID] [nvarchar](35) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ADRESSER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADRESSER](
	[ADR_ID] [int] NOT NULL,
	[POSTNR] [nvarchar](4) NOT NULL,
	[CPR_VEJNAVN] [nvarchar](40) NOT NULL,
	[CPR_HUSNR] [nvarchar](4) NOT NULL,
	[X_KOOR] [float] NULL,
	[Y_KOOR] [float] NULL,
	[LASTUPDATE] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[temp_DimJobTyper]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_DimJobTyper](
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
/****** Object:  Table [dbo].[STILLINGBET]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[SPVISITATION]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[VISIDATO] [datetime] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SP_MORGEN] [int] NULL,
	[SP_FORMIDDAG] [int] NULL,
	[SP_MIDDAG] [int] NULL,
	[SP_EFTERMIDDAG] [int] NULL,
	[SP_AFTEN1] [int] NULL,
	[SP_AFTEN2] [int] NULL,
	[SP_AFTEN3] [int] NULL,
	[SP_AFTEN4] [int] NULL,
	[SP_NAT1] [int] NULL,
	[SP_NAT2] [int] NULL,
	[SP_NAT3] [int] NULL,
	[SP_NAT4] [int] NULL,
	[SP_TIMER] [int] NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[NAESTEVIS] [datetime] NOT NULL,
	[HENVENDELSE] [datetime] NULL,
	[BESOGSDATO] [datetime] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SPVISIJOB]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SPVISIJOB](
	[ID] [int] NOT NULL,
	[SPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_MORGEN] [int] NOT NULL,
	[YD_FORMIDDAG] [int] NOT NULL,
	[YD_MIDDAG] [int] NOT NULL,
	[YD_EFTERMIDDAG] [int] NOT NULL,
	[YD_AFTEN1] [int] NOT NULL,
	[YD_AFTEN2] [int] NOT NULL,
	[YD_AFTEN3] [int] NOT NULL,
	[YD_AFTEN4] [int] NOT NULL,
	[YD_NAT1] [int] NOT NULL,
	[YD_NAT2] [int] NOT NULL,
	[YD_NAT3] [int] NOT NULL,
	[YD_NAT4] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[TID_FRAVALGT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[SERIES_OCCURS_ON_DAY]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SERIES_OCCURS_ON_DAY] 
(
	@DATO as datetime,
    @FREKVENS as smallint,
    @FREKTYPE smallint,
    @FREKVALGTEDAGE smallint,
    @STARTDATO datetime
)
RETURNS int
AS
BEGIN
  declare @RESULT as int
  declare @BIN_UGEDAG smallint
  declare @UGEDAG smallint
  set @RESULT = 0
  
  IF @FREKTYPE=0 
  BEGIN
      /* Ugentlige besøg */
    IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%7=0 
    BEGIN
      /* Kun hver x. uge */
      IF @FREKVENS>0 
      BEGIN
        IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* Ikke hver x. uge */
      BEGIN
        IF (((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)+1)%@FREKVENS<>0
        BEGIN      
          SET @RESULT = 1
        END
      END
    END
  END
  ELSE IF @FREKTYPE=1
  BEGIN
    /* Daglige besøg, hver x. dag */
    IF @FREKVENS>0 
    BEGIN
      IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
      BEGIN
        SET @RESULT = 1
      END
    END
    ELSE /* Daglige besøg, ikke hver x. dag */
    BEGIN
     IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
     BEGIN
        SET @RESULT = 1
     END
    END
  END
  ELSE IF (@FREKTYPE=2) 
  BEGIN
    /* Alle hverdag */
    IF DATEPART(DW,@DATO) IN (2,3,4,5,6)
    BEGIN
       /* hver x. dag */
      IF (@FREKVENS>0)
      BEGIN
        IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END
  ELSE IF (@FREKTYPE=3)
  BEGIN
    /* Weekender */
    IF DATEPART(DW,@DATO) IN (7,1)
    BEGIN
      /* hver x. dag */
      IF (@FREKVENS > 0)
      BEGIN
        IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END
  ELSE IF (@FREKTYPE=4)
  BEGIN
    /* Kun udvalgte dage */
    set @UGEDAG = DATEPART(DW,@DATO)-1
    IF (@UGEDAG=0)
    BEGIN
      SET @UGEDAG=7;
    END

    /* Find det binære nummer for dagen i uge */
    set @BIN_UGEDAG = 1;
    WHILE (@UGEDAG>1) 
    BEGIN
      set @BIN_UGEDAG = @BIN_UGEDAG * 2;
      set @UGEDAG = @UGEDAG - 1;
    END

    /* Returner linien hvis dagen er valgt */
    IF (@FREKVALGTEDAGE&@BIN_UGEDAG)>0 
    BEGIN

        /* hver x. dag */
      IF (@FREKVENS > 0)
      BEGIN
        IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF (((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)+1)%@FREKVENS<>0
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END        

  RETURN @RESULT
END
GO
/****** Object:  Table [dbo].[SAGSTYPE]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSTYPE](
	[SAGSTYPEID] [int] NOT NULL,
	[SAGSTYPENAVN] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSSTATUS]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[SAGSPRETDET]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSPRETDET](
	[ID] [int] NOT NULL,
	[SAGSPRETID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[STATUSID] [int] NOT NULL,
	[AFVIGELSE] [int] NOT NULL,
	[VISIID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSPLANRET]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSPLANRET](
	[ID] [int] NOT NULL,
	[SERIEID] [int] NULL,
	[SAGSID] [int] NOT NULL,
	[MEDID] [int] NULL,
	[RETDATO] [datetime] NOT NULL,
	[STARTMINEFTERMIDNAT] [int] NOT NULL,
	[TID] [int] NOT NULL,
	[VEJTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[STATUSID] [int] NOT NULL,
	[RSTART] [int] NOT NULL,
	[RTID] [int] NOT NULL,
	[RVEJTID] [int] NOT NULL,
	[REGBES] [int] NOT NULL,
	[SERIEDATO] [datetime] NULL,
	[KORTBESKRIV] [nvarchar](255) NULL,
	[BESOEG_LAAST] [int] NOT NULL,
	[VISISTART] [int] NOT NULL,
	[VISISLUT] [int] NOT NULL,
	[MED_LAAST] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSPLAN]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSPLAN](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[MEDID] [int] NULL,
	[STARTDATO] [datetime2](7) NOT NULL,
	[SLUTDATO] [datetime2](7) NOT NULL,
	[STARTMINEFTERMIDNAT] [int] NOT NULL,
	[TID] [int] NOT NULL,
	[FREKVENS] [int] NOT NULL,
	[VEJTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[DAGHJEM_CENTER_VISI] [int] NULL,
	[DAGHJEM_CENTER_TYPE] [int] NULL,
	[FREKTYPE] [int] NOT NULL,
	[FREKVALGTEDAGE] [int] NOT NULL,
	[KORTBESKRIV] [nvarchar](255) NULL,
	[BESOEG_LAAST] [int] NOT NULL,
	[VISISTART] [int] NOT NULL,
	[VISISLUT] [int] NOT NULL,
	[MED_LAAST] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSPDET]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSPDET](
	[ID] [int] NOT NULL,
	[SAGSPID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[VISIID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSHISTORIK_TP]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSHISTORIK_TP](
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[BORGER_ORG] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSHISTORIK_SP]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSHISTORIK_SP](
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[BORGER_ORG] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSHISTORIK_MAD]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSHISTORIK_MAD](
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[BORGER_ORG] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSHISTORIK_HJ]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSHISTORIK_HJ](
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[BORGER_ORG] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[STATUS] [int] NOT NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGSHISTORIK]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGSHISTORIK](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[SAGS_STATUS] [int] NOT NULL,
	[SAGS_STATUSID] [int] NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_STATUS] [int] NOT NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[TERMINAL] [int] NULL,
	[HJEMMESYGEPLEJE] [int] NULL,
	[HJGRP_AFTEN_ID] [int] NULL,
	[HJGRP_NAT_ID] [int] NULL,
	[HJGRP_WEEKEND_ID] [int] NULL,
	[SPGRP_AFTEN_ID] [int] NULL,
	[SPGRP_NAT_ID] [int] NULL,
	[SPGRP_WEEKEND_ID] [int] NULL,
	[TPGRP_AFTEN_ID] [int] NULL,
	[TPGRP_NAT_ID] [int] NULL,
	[TPGRP_WEEKEND_ID] [int] NULL,
	[MADVISI_STATUSID] [int] NULL,
	[MADVISI_STATUS] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAGER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAGER](
	[SAGSID] [int] NOT NULL,
	[SAGSTYPE] [int] NOT NULL,
	[OPRETTET] [datetime] NULL,
	[SAGS_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUS] [int] NOT NULL,
	[HJEMMEPLEJE_STATUSID] [int] NULL,
	[SYGEPLEJE_STATUS] [int] NOT NULL,
	[SYGEPLEJE_STATUSID] [int] NULL,
	[TERAPEUT_STATUS] [int] NOT NULL,
	[TERAPEUT_STATUSID] [int] NULL,
	[CPRNR] [nvarchar](10) NULL,
	[FORNAVN] [nvarchar](50) NULL,
	[EFTERNAVN] [nvarchar](50) NULL,
	[ADRESSE] [nvarchar](70) NULL,
	[STEDNAVN] [int] NULL,
	[POSTNR] [nvarchar](4) NULL,
	[HJEMMEPLEJE_GRUPPEID] [int] NULL,
	[SYGEPLEJE_GRUPPEID] [int] NULL,
	[TERAPEUT_GRUPPEID] [int] NULL,
	[SAGS_STATUSID] [int] NULL,
	[FODDATO] [datetime] NULL,
	[HJEMMEPLEJE_KONTAKT1] [int] NULL,
	[HJEMMEPLEJE_KONTAKT2] [int] NULL,
	[TERMINAL] [int] NULL,
	[HJEMMESYGEPLEJE] [int] NULL,
	[COADRESSE] [nvarchar](70) NULL,
	[SERVICE_STATUS] [int] NOT NULL,
	[SERVICE_STATUSID] [int] NULL,
	[SERVICE_AFSNIT] [int] NULL,
	[SKATTE_STATUS] [int] NOT NULL,
	[SKATTE_STATUSID] [int] NULL,
	[RETTET] [datetime] NULL,
	[NOGLEBOX] [int] NULL,
	[EMAIL] [nvarchar](100) NULL,
	[CIVILSTAND] [int] NULL,
	[NODKALDNR] [nvarchar](15) NULL,
	[CHECKOUT] [int] NOT NULL,
	[AGTECPRNR] [nvarchar](10) NULL,
	[MEDOPBEVAR] [nvarchar](40) NULL,
	[MEDLEVSTED] [nvarchar](40) NULL,
	[APOTEKID] [int] NULL,
	[TELEFON] [nvarchar](30) NULL,
	[ALTTELEFON] [nvarchar](30) NULL,
	[MOBILTELEFON] [nvarchar](30) NULL,
	[KALDENAVN] [nvarchar](40) NULL,
	[MEDICINBESTILLER] [nvarchar](40) NULL,
	[MEDICINBUD] [nvarchar](40) NULL,
	[SYGEGRP] [int] NULL,
	[TLF_HEMMELIGT] [int] NULL,
	[ALTTLF_HEMMELIGT] [int] NULL,
	[MOBIL_HEMMELIGT] [int] NULL,
	[TERAPEUT_KONTAKT1] [int] NULL,
	[TERAPEUT_KONTAKT2] [int] NULL,
	[SYGEPLEJE_KONTAKT1] [int] NULL,
	[SYGEPLEJE_KONTAKT2] [int] NULL,
	[AGTENAVN] [nvarchar](40) NULL,
	[NOGLENR] [nvarchar](10) NULL,
	[REFUSIONSKOMMUNE] [int] NULL,
	[PLEJEKATEGORI] [int] NULL,
	[CHECKOUTTO] [int] NULL,
	[CHECKOUTDATO] [datetime] NULL,
	[CHECKOUTMACHINE] [nvarchar](20) NULL,
	[HJP_ANSVARLIG_FOREBYGGER] [int] NULL,
	[ETAGE] [nvarchar](10) NULL,
	[DORNR] [nvarchar](10) NULL,
	[FORTIDSPENSION] [int] NULL,
	[CPR_VEJNAVN] [nvarchar](40) NULL,
	[CPR_HUSNR] [nvarchar](4) NULL,
	[CPR_ETAGE] [nvarchar](2) NULL,
	[CPR_SIDEDOR] [nvarchar](4) NULL,
	[HJGRP_AFTEN_ID] [int] NULL,
	[HJGRP_NAT_ID] [int] NULL,
	[HJGRP_WEEKEND_ID] [int] NULL,
	[SPGRP_AFTEN_ID] [int] NULL,
	[SPGRP_NAT_ID] [int] NULL,
	[SPGRP_WEEKEND_ID] [int] NULL,
	[TPGRP_AFTEN_ID] [int] NULL,
	[TPGRP_NAT_ID] [int] NULL,
	[TPGRP_WEEKEND_ID] [int] NULL,
	[SOCIALKODE] [nvarchar](2) NULL,
	[SOCIALTEKST] [nvarchar](30) NULL,
	[HJEMMEPLEJE_KONTAKT3] [int] NULL,
	[DAGVAGT] [int] NULL,
	[AFTENVAGT] [int] NULL,
	[WEEKENDEVAGT] [int] NULL,
	[NATVAGT] [int] NULL,
	[MADVISI_STATUSID] [int] NULL,
	[MADVISI_STATUS] [int] NOT NULL,
	[BORGERSERVICEKODE] [nvarchar](40) NULL,
	[ADR_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sagaktiv]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sagaktiv](
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REFUSIONSKOMMUNE]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REFUSIONSKOMMUNE](
	[ID] [int] NULL,
	[Navn] [nvarchar](200) NULL,
	[Kommunekode] [int] NULL,
	[Adr1] [nvarchar](40) NULL,
	[Adr2] [nvarchar](40) NULL,
	[Postnr] [nvarchar](4) NULL,
	[ER_RefusionsKommune] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PLEJEKATEGORI]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLEJEKATEGORI](
	[BESKRIVELSE] [nvarchar](50) NULL,
	[ID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep9]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep9](
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
	[UDFOERT_TID] [decimal](31, 21) NULL,
	[MOBIL_TID] [int] NOT NULL,
	[REGBES] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](28) NOT NULL,
	[STEP] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep7]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep7](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NULL,
	[FALLES_SPROG_ART] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[MOBIL_DOEGNINDDELING] [int] NULL,
	[PLANLAGT_VEJTID] [decimal](31, 21) NULL,
	[UDFOERT_VEJTID] [decimal](31, 21) NULL,
	[MOB_VEJTID] [decimal](31, 21) NULL,
	[REGBES] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[VISITERET_TID] [int] NOT NULL,
	[PLANLAGT_TID] [int] NOT NULL,
	[UDFOERT_TID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[BESOEG_STAT_TYPE] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](28) NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep6]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep6](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[PLEJETYPE] [int] NULL,
	[FALLES_SPROG_ART] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[MOBIL_DOEGNINDDELING] [int] NULL,
	[PLANLAGT_VEJTID] [decimal](31, 21) NULL,
	[UDFOERT_VEJTID] [decimal](31, 21) NULL,
	[MOB_VEJTID] [decimal](31, 21) NULL,
	[REGBES] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[STATUSID] [int] NOT NULL,
	[VISITERET_TID] [int] NOT NULL,
	[PLANLAGT_TID] [int] NOT NULL,
	[UDFOERT_TID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[BESOEG_STAT_TYPE] [int] NOT NULL,
	[BESOEG_STATUS] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep5]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep5](
	[PK_DATE] [datetime] NOT NULL,
	[SPRID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[VEJTID] [int] NOT NULL,
	[MOB_VEJTID] [int] NOT NULL,
	[ANTAL_INDSATSE] [int] NULL,
	[YDELSESTID] [int] NOT NULL,
	[DOEGNINDDELING] [int] NULL,
	[REGBES] [int] NOT NULL,
	[RSTART] [int] NOT NULL,
	[MOBIL_DOEGNINDDELING] [int] NULL,
	[BESOEG_STAT_TYPE] [int] NOT NULL,
	[BESOEG_STATUS] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep4]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep4](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[STATUSID] [int] NULL,
	[PLEJETYPE] [int] NULL,
	[FALLES_SPROG_ART] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[PLANLAGT_VEJTID] [decimal](31, 21) NULL,
	[UDFOERT_VEJTID] [decimal](31, 21) NULL,
	[JOBID] [int] NOT NULL,
	[VISITERET_TID] [int] NOT NULL,
	[PLANLAGT_TID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](17) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep3]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep3](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[ALDER] [int] NULL,
	[PLEJETYPE] [int] NULL,
	[FALLES_SPROG_ART] [int] NULL,
	[SAGSTYPE] [int] NOT NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[SPVEJTID] [int] NOT NULL,
	[ANTAL_INDSATSE] [int] NULL,
	[VEJTID] [decimal](31, 21) NULL,
	[JOBID] [int] NOT NULL,
	[VISITERET_TID] [int] NOT NULL,
	[PLANLAGT_TID] [int] NOT NULL,
	[VISITYPE] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL,
	[STATISTIKTYPE] [varchar](17) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep2](
	[PK_DATE] [datetime] NOT NULL,
	[SERIEID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[SAGSTYPE] [int] NOT NULL,
	[ALDER] [int] NULL,
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[MEDARBEJDER_STATUSID] [int] NULL,
	[STILLINGSID] [int] NULL,
	[DOEGNINDDELING] [int] NULL,
	[ANTAL_INDSATSE] [int] NULL,
	[VEJTID] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[BESOEGSSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlanlagtUdfoertStep1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanlagtUdfoertStep1](
	[SERIEID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[CPRNR] [nvarchar](10) NULL,
	[SAGSTYPE] [int] NOT NULL,
	[STARTDATO] [datetime2](7) NOT NULL,
	[SLUTDATO] [datetime2](7) NOT NULL,
	[MEDARB_TYPE] [int] NULL,
	[MEDID] [int] NULL,
	[VEJTID] [int] NOT NULL,
	[FREKVENS] [int] NOT NULL,
	[FREKTYPE] [int] NOT NULL,
	[FREKVALGTEDAGE] [int] NOT NULL,
	[YDELSESTID] [int] NOT NULL,
	[ANTAL_INDSATSE] [int] NULL,
	[DOEGNINDDELING] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PARATYPER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARATYPER](
	[ID] [int] NOT NULL,
	[PARAGRAF] [nvarchar](20) NOT NULL,
	[BETEGNELSE] [nvarchar](100) NOT NULL,
	[STATUS] [int] NOT NULL,
	[PARAGRAF_GRUPPERING_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PARAGRAF_GRUPPERING]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PARAGRAF_GRUPPERING](
	[ID] [int] NULL,
	[NAVN] [nvarchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ORGANISATIONER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORGANISATIONER](
	[ORGANISATIONID] [int] NOT NULL,
	[ORGANISATIONNAVN] [nvarchar](50) NOT NULL,
	[LICENS] [int] NOT NULL,
	[LEDER] [nvarchar](100) NULL,
	[ADRESSE] [nvarchar](100) NULL,
	[TELEFON] [nvarchar](20) NULL,
	[FAX] [nvarchar](20) NULL,
	[AKTIV] [int] NOT NULL,
	[KONTAKTTID] [nvarchar](35) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MEDSTATUS]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[MEDHISTORIK]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[MEDARBEJDERE]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[MADVISITATION]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MADVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[VISIDATO] [datetime] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[HENVENDELSE] [datetime] NULL,
	[BESOGSDATO] [datetime] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[HJALPTYPE] [int] NOT NULL,
	[NAESTEVIS] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MADVISIJOB]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MADVISIJOB](
	[ID] [int] NOT NULL,
	[MADVISI_ID] [int] NOT NULL,
	[JOBID] [int] NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_MORGEN] [int] NOT NULL,
	[YD_MIDDAG] [int] NOT NULL,
	[YD_FORMIDDAG] [int] NOT NULL,
	[YD_EFTERMIDDAG] [int] NOT NULL,
	[YD_AFTEN1] [int] NOT NULL,
	[YD_AFTEN2] [int] NOT NULL,
	[YD_AFTEN3] [int] NOT NULL,
	[YD_AFTEN4] [int] NOT NULL,
	[YD_NAT1] [int] NOT NULL,
	[YD_NAT2] [int] NOT NULL,
	[YD_NAT3] [int] NOT NULL,
	[YD_NAT4] [int] NOT NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[linkFactBorger]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[linkFactBorger](
	[SagsId] [int] NULL,
	[CprNr] [nvarchar](10) NULL,
	[day] [nvarchar](2) NULL,
	[month] [nvarchar](2) NULL,
	[year] [nvarchar](2) NULL,
	[Foedselsdag] [datetime] NULL,
	[JoinFactor] [nvarchar](5) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[link_time]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[link_time](
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
	[Quarter_Of_Year_Name] [nvarchar](50) NULL,
	[JoinFactor] [nvarchar](63) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LAEGER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LAEGER](
	[LAEGEID] [int] NOT NULL,
	[FORNAVN] [nvarchar](50) NOT NULL,
	[EFTERNAVN] [nvarchar](50) NOT NULL,
	[TELEFON] [nvarchar](10) NULL,
	[LAGETYPE] [int] NOT NULL,
	[LAGETYPEID] [int] NOT NULL,
	[LAEGESTATUS] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JOBTYPER]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[JOBPRISER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOBPRISER](
	[PRISID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[STARTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[INT_DAG] [int] NOT NULL,
	[INT_AFTEN] [int] NOT NULL,
	[INT_NAT] [int] NOT NULL,
	[INT_WEEKEND] [int] NOT NULL,
	[EXT_DAG] [int] NOT NULL,
	[EXT_AFTEN] [int] NOT NULL,
	[EXT_NAT] [int] NOT NULL,
	[EXT_WEEKEND] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HJVISITATION]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HJVISITATION](
	[ID] [int] NULL,
	[SAGSID] [int] NULL,
	[VISIDATO] [datetime2](7) NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[PB_MORGEN] [int] NULL,
	[PB_MIDDAG] [int] NULL,
	[PB_EFTERMIDDAG] [int] NULL,
	[PB_AFTEN1] [int] NULL,
	[PB_AFTEN2] [int] NULL,
	[PB_AFTEN3] [int] NULL,
	[GS_SAG_ID] [int] NULL,
	[PB_NAT1] [int] NULL,
	[PB_NAT2] [int] NULL,
	[PB_NAT3] [int] NULL,
	[PP_MORGEN] [int] NULL,
	[PP_MIDDAG] [int] NULL,
	[PP_EFTERMIDDAG] [int] NULL,
	[PP_AFTEN1] [int] NULL,
	[PP_AFTEN2] [int] NULL,
	[PP_AFTEN3] [int] NULL,
	[PP_NAT1] [int] NULL,
	[PP_NAT2] [int] NULL,
	[PP_NAT3] [int] NULL,
	[PP_TIMER] [int] NULL,
	[PB_TIMER] [int] NULL,
	[F1] [int] NULL,
	[F11] [int] NULL,
	[F12] [int] NULL,
	[F13] [int] NULL,
	[F2] [int] NULL,
	[F3] [int] NULL,
	[F4] [int] NULL,
	[F5] [int] NULL,
	[F6] [int] NULL,
	[F7] [int] NULL,
	[F8] [int] NULL,
	[F9] [int] NULL,
	[PB_FORMIDDAG] [int] NULL,
	[PB_AFTEN4] [int] NULL,
	[PB_NAT4] [int] NULL,
	[PP_FORMIDDAG] [int] NULL,
	[PP_AFTEN4] [int] NULL,
	[PP_NAT4] [int] NULL,
	[HJALPTYPE] [int] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[NAESTEVIS] [date] NOT NULL,
	[UDFORER] [int] NOT NULL,
	[VURDERINGSDATO] [date] NOT NULL,
	[HENVENDELSE] [date] NULL,
	[BESOGSDATO] [date] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[PLEJETYNGDE] [nvarchar](40) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HJVISIJOB]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HJVISIJOB](
	[ID] [int] NULL,
	[HJVISIID] [int] NULL,
	[JOBID] [int] NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_MORGEN] [int] NOT NULL,
	[YD_MIDDAG] [int] NOT NULL,
	[YD_EFTERMIDDAG] [int] NOT NULL,
	[YD_AFTEN1] [int] NOT NULL,
	[YD_AFTEN2] [int] NOT NULL,
	[YD_AFTEN3] [int] NOT NULL,
	[YD_NAT1] [int] NOT NULL,
	[YD_NAT2] [int] NOT NULL,
	[YD_NAT3] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[YD_FORMIDDAG] [int] NOT NULL,
	[YD_AFTEN4] [int] NOT NULL,
	[YD_NAT4] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[TID_FRAVALGT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HJPLEVERANDOR]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HJPLEVERANDOR](
	[ID] [int] NOT NULL,
	[NAVN] [nvarchar](100) NOT NULL,
	[ADRESSE] [nvarchar](100) NULL,
	[POSTNR] [nvarchar](100) NULL,
	[TELEFON] [nvarchar](30) NULL,
	[FAX] [nvarchar](30) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[KONTAKTPERS] [nvarchar](100) NULL,
	[DIREKTENR] [nvarchar](30) NULL,
	[KONTAKTEMAIL] [nvarchar](100) NULL,
	[KONTAKTMOBIL] [nvarchar](30) NULL,
	[STATUS] [int] NOT NULL,
	[LEVTYPE] [int] NOT NULL,
	[KONTRAKTDATO] [datetime] NULL,
	[OPHORSDATO] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GS_SAGER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GS_SAGER](
	[SAG_ID] [int] NULL,
	[SAMLET_FUNKTIONSNIVEAU_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[GetBirthDay]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetBirthDay] (@CprNr as nvarchar(10))
RETURNS datetime
AS
BEGIN
   
  DECLARE @CENT as varchar(2)
  DECLARE @DATEOFBIRTH as datetime
  declare @age as int
  DECLARE @dato as datetime

select @CENT =(select CASE WHEN (substring(@cprNr, 7, 1)) < 4 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
			    WHEN (substring(@cprNr, 7, 1)) = 4 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) = 9 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
			    WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) > 36 THEN 18 
				END AS år)  

set @DATEOFBIRTH = CAST(LOWER(@CENT) + SUBSTRING(@cprNr, 5, 2)+ 
					 '-' + SUBSTRING(@cprNr, 3, 2) + 
					 '-' + LEFT(@cprNr, 2) AS datetime) 
RETURN @DATEOFBIRTH
END;
GO
/****** Object:  Table [dbo].[FRAVARTYPER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FRAVARTYPER](
	[FRAVARID] [int] NOT NULL,
	[NAVN] [nvarchar](50) NOT NULL,
	[KMDID] [nvarchar](10) NOT NULL,
	[KATEGORI] [int] NOT NULL,
	[NIVEAU1] [int] NOT NULL,
	[NIVEAU2] [int] NOT NULL,
	[NIVEAU3] [int] NOT NULL,
	[FYLDFARVE] [int] NULL,
	[FONTFARVE] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FireBirdTestUser]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FireBirdTestUser](
	[cprnr] [nvarchar](10) NULL,
	[medid] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FireBirdDBDataDefinition]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FireBirdDBDataDefinition](
	[TableName] [nvarchar](255) NULL,
	[ColName] [nvarchar](255) NULL,
	[ColMapName] [nvarchar](255) NULL,
	[ColType] [nvarchar](255) NULL,
	[ColNull] [nvarchar](255) NULL,
	[Sortorder] [float] NULL,
	[LastImported] [datetime] NULL,
	[RowsImported] [float] NULL,
	[ExecutionTime] [float] NULL,
	[ErrorMessage] [nvarchar](255) NULL,
	[ErrorNumber] [nvarchar](255) NULL,
	[ErrorCmd] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAGLIGVURDERINGHIST]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAGLIGVURDERINGHIST](
	[ID] [int] NOT NULL,
	[FVID] [int] NOT NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[AKTIVITET_ID] [int] NOT NULL,
	[BRUGER_ID] [int] NOT NULL,
	[RELEVANT] [int] NOT NULL,
	[VURDNIV_ID] [int] NOT NULL,
	[VISI_TYPE] [int] NULL,
	[VISI_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FAGLIGVURDERING]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAGLIGVURDERING](
	[ID] [int] NOT NULL,
	[AKTIVITET_ID] [int] NOT NULL,
	[BRUGER_ID] [int] NOT NULL,
	[RELEVANT] [int] NOT NULL,
	[VURDNIV_ID] [int] NOT NULL,
	[VISI_TYPE] [int] NULL,
	[VISI_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPTommeRaekker]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPTommeRaekker](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NOT NULL,
	[PK_DATE] [datetime] NULL,
	[UDFOERTTID] [int] NOT NULL,
	[TJENESTETID] [decimal](38, 7) NULL,
	[ARBEJDSTID] [int] NOT NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep6TotalUdfoert]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep6TotalUdfoert](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NOT NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](38, 21) NULL,
	[TJENESTETID] [decimal](38, 7) NULL,
	[ARBEJDSTID] [int] NOT NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep5FremMoedeArbTid]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep5FremMoedeArbTid](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NOT NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](38, 7) NULL,
	[TJENESTETID] [decimal](38, 7) NULL,
	[ARBEJDSTID] [decimal](38, 7) NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep4]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep4](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](38, 21) NULL,
	[TJENESTETID] [decimal](38, 7) NULL,
	[ARBEJDSTID] [int] NOT NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep3_1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep3_1](
	[PK_DATE] [datetime] NULL,
	[MEDID] [int] NULL,
	[TJENESTETID] [decimal](38, 7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep3]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep3](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[BTPDEFINITION] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](38, 21) NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep2](
	[MEDID] [int] NULL,
	[MED_ORG] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](32, 21) NULL,
	[BTPDEFINITION] [int] NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPStep1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPStep1](
	[MEDID] [int] NULL,
	[JOBID] [int] NOT NULL,
	[MED_ORG] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[UDFOERTTID] [decimal](32, 21) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBTPAnvendtDefinition]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBTPAnvendtDefinition](
	[BTPDEFINITION] [int] NOT NULL,
	[SORTERING] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactBorgerStep1c]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBorgerStep1c](
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
/****** Object:  Table [dbo].[FactBorgerStep1b]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBorgerStep1b](
	[SagsId] [int] NULL,
	[Dag] [int] NULL,
	[Md] [int] NULL,
	[Aar] [int] NULL,
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
/****** Object:  Table [dbo].[FactBorgerStep1a]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactBorgerStep1a](
	[SagsId] [int] NULL,
	[PKDate] [datetime] NOT NULL,
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
/****** Object:  Table [dbo].[DOGN_INDDELING]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOGN_INDDELING](
	[ID] [int] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[MORGEN] [int] NOT NULL,
	[FORMIDDAG] [int] NOT NULL,
	[MIDDAG] [int] NOT NULL,
	[EFTERMIDDAG] [int] NOT NULL,
	[AFTEN1] [int] NOT NULL,
	[AFTEN2] [int] NOT NULL,
	[AFTEN3] [int] NOT NULL,
	[AFTEN4] [int] NOT NULL,
	[NAT1] [int] NOT NULL,
	[NAT2] [int] NOT NULL,
	[NAT3] [int] NOT NULL,
	[NAT4] [int] NOT NULL,
	[MORGENTYPE] [int] NOT NULL,
	[FORMIDDAGTYPE] [int] NOT NULL,
	[MIDDAGTYPE] [int] NOT NULL,
	[EFTERMIDDAGTYPE] [int] NOT NULL,
	[AFTEN1TYPE] [int] NOT NULL,
	[AFTEN2TYPE] [int] NOT NULL,
	[AFTEN3TYPE] [int] NOT NULL,
	[AFTEN4TYPE] [int] NOT NULL,
	[NAT1TYPE] [int] NOT NULL,
	[NAT2TYPE] [int] NOT NULL,
	[NAT3TYPE] [int] NOT NULL,
	[NAT4TYPE] [int] NOT NULL,
	[WEEKENDSTART] [int] NOT NULL,
	[WEEKENDSLUT] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimWeekendHelligdag]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimWeekendHelligdag](
	[PK_Date] [datetime] NOT NULL,
	[helligdag] [int] NULL,
	[weekend] [int] NOT NULL,
	[DAYSINMONTH] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSpecifikation]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSpecifikation](
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSager]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[DimMedarbejderStatusStep1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMedarbejderStatusStep1](
	[MedStatusId] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimDognInddeling]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[DimAldersopdeling]    Script Date: 10/06/2015 18:35:19 ******/
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
/****** Object:  Table [dbo].[Dim_Time_Special]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Time_Special](
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
	[Quarter_Of_Year_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Time_special] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Time]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Time](
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
	[Quarter_Of_Year_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Time] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Udf_SaetDoegninddeling]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Udf_SaetDoegninddeling]  
(
	@MINUTTEREFTERMIDNAT as smallint
)
RETURNS int

AS

BEGIN
declare @RESULT as int
set @RESULT = 0
	IF @MINUTTEREFTERMIDNAT> 420 and @MINUTTEREFTERMIDNAT <= 540 SET @RESULT = 1 
    ELSE IF @MINUTTEREFTERMIDNAT > 540 and @MINUTTEREFTERMIDNAT<= 660 SET @RESULT = 2 
    ELSE IF  @MINUTTEREFTERMIDNAT > 660 and @MINUTTEREFTERMIDNAT <= 780 SET @RESULT = 3 
	ELSE IF  @MINUTTEREFTERMIDNAT > 780 and @MINUTTEREFTERMIDNAT <= 900 SET @RESULT = 4 
	ELSE IF  @MINUTTEREFTERMIDNAT > 900 and @MINUTTEREFTERMIDNAT <= 1020 SET @RESULT = 5 
	ELSE IF  @MINUTTEREFTERMIDNAT > 1020 and @MINUTTEREFTERMIDNAT <= 1140 SET @RESULT = 6 
	ELSE IF  @MINUTTEREFTERMIDNAT > 1140 and @MINUTTEREFTERMIDNAT <= 1260 SET @RESULT = 7 
	ELSE IF  @MINUTTEREFTERMIDNAT > 1260 and @MINUTTEREFTERMIDNAT <= 1380 SET @RESULT = 8 
	ELSE IF  @MINUTTEREFTERMIDNAT > 1380 and @MINUTTEREFTERMIDNAT <= 1440 OR @MINUTTEREFTERMIDNAT <= 60 SET @RESULT = 9 
	ELSE IF  @MINUTTEREFTERMIDNAT> 60 and @MINUTTEREFTERMIDNAT <= 180 SET @RESULT = 10 
	ELSE IF  @MINUTTEREFTERMIDNAT > 180 and @MINUTTEREFTERMIDNAT <= 300 SET @RESULT = 11 
	ELSE IF  @MINUTTEREFTERMIDNAT > 300 and @MINUTTEREFTERMIDNAT <= 420 SET @RESULT = 12 
  RETURN @RESULT	
END
GO
/****** Object:  UserDefinedFunction [dbo].[Udf_Helligdag]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Udf_Helligdag] 
(
	@INDDATO as Date
)
RETURNS int
AS
BEGIN
declare @RESULT as int
declare @TEMP smallint
declare @TEMP_A smallint
declare @TEMP_B smallint
declare @TEMP_C smallint
declare @DAG smallint
declare @MAANED smallint
declare @AAR smallint
declare @PAASKEDAG date
set @RESULT = 0
set @AAR = datepart(year,@INDDATO)
set @MAANED = 3
set @TEMP_A = 225 - 11 * (@AAR%19)
set @TEMP_B = ((@TEMP_A - 21)%30) + 21

IF (@TEMP_B>48) BEGIN SET @TEMP_B=@TEMP_B-1 END 

set @TEMP_C = ((@AAR + (@AAR/4) + @TEMP_B + 1)%7)
set @DAG = @TEMP_B + 7 - @TEMP_C

IF (@DAG>31) BEGIN SET @DAG=@DAG-31 SET @MAANED=4 END

set @PAASKEDAG=CAST(CAST(@AAR AS CHAR)+'-'+CAST(@MAANED AS CHAR)+'-'+CAST(@DAG AS CHAR) AS DATE)

  if datepart(DAYOFYEAR,@INDDATO)=datepart(DAYOFYEAR,(dateadd(DD,-3,@PAASKEDAG))) begin SET @RESULT=1 end             /*skærtorsdag*/
  else if datepart(DAYOFYEAR,@INDDATO)=datepart(DAYOFYEAR,(dateadd(DD,-2,@PAASKEDAG)))  begin SET @RESULT=1 end       /*langfredag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(@PAASKEDAG)))) begin SET @RESULT=1 end                 /*påskedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,1,@PAASKEDAG))))) begin SET @RESULT=1 end   /*2. påskedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,26,@PAASKEDAG))))) begin SET @RESULT=1 end  /*st bededag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,39,@PAASKEDAG))))) begin SET @RESULT=1 end  /*kr himmelfart*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,49,@PAASKEDAG))))) begin SET @RESULT=1 end  /*pinsedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,50,@PAASKEDAG))))) begin SET @RESULT=1 end  /*2. pinsedag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-01-01') AS DATE))) begin SET @RESULT=1 end                /*nytårsdag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-06-05') AS DATE))) begin SET @RESULT=1 end                /*grundlovsdag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-12-25') AS DATE))) begin SET @RESULT=1 end                /*juledag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-12-26') AS DATE))) begin SET @RESULT=1 end                /*2. juledag*/

RETURN @RESULT

END
GO
/****** Object:  UserDefinedFunction [dbo].[udf_GetISOWeekNumberFromDate]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_GetISOWeekNumberFromDate](@dtDate as DATETIME) RETURNS INT WITH RETURNS NULL ON NULL INPUT
/*
** Return the ISO week of the year regardless of the DATEFIRST session setting.
*/
AS
BEGIN

DECLARE @intISOWeekdayNumber INT
DECLARE @dtThisThursday DATETIME
DECLARE @dtFirstOfThisThursdaysYear DATETIME
DECLARE @intISOWeekdayNumberOfFirstOfThisThursdaysYear INT
DECLARE @dtFirstThursdayOfYear DATETIME
DECLARE @intISOWeekNumber INT

   -- Get the ISO week day number (Monday = 1) for our date.
   SET @intISOWeekdayNumber = (((DATEPART(dw, @dtDate) - 1) + (@@DATEFIRST - 1)) % 7) + 1

   -- Get the date of the Thursday in this ISO week.
   SET @dtThisThursday = DATEADD(d,(4 - @intISOWeekdayNumber),@dtDate)

   -- Get the date of the 1st January for 'this Thursdays' year.
   SET @dtFirstOfThisThursdaysYear = CAST(CAST(YEAR(@dtThisThursday) AS CHAR(4)) + '-01-01' AS DATETIME)

   SET @intISOWeekdayNumberOfFirstOfThisThursdaysYear = (((DATEPART(dw, @dtFirstOfThisThursdaysYear) - 1) + (@@DATEFIRST - 1)) % 7) + 1

   -- Get the date of the first Thursday in 'this Thursdays' year.
   -- The year of which the ISO week is a part is the year of this date.     
   IF (@intISOWeekdayNumberOfFirstOfThisThursdaysYear in (1,2,3,4))
      SET @dtFirstThursdayOfYear = DATEADD(d,(4 - @intISOWeekdayNumberOfFirstOfThisThursdaysYear),@dtFirstOfThisThursdaysYear)
   ELSE
      SET @dtFirstThursdayOfYear = DATEADD(d,(4 - @intISOWeekdayNumberOfFirstOfThisThursdaysYear + 7),@dtFirstOfThisThursdaysYear)

   -- Work out how many weeks from the first Thursday to this Thursday.
   SET @intISOWeekNumber = DATEDIFF(d,@dtFirstThursdayOfYear,@dtThisThursday)/7+1
   
   RETURN @intISOWeekNumber

END
GO
/****** Object:  Table [dbo].[UAFDELINGER]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UAFDELINGER](
	[UAFDELINGID] [int] NOT NULL,
	[AFDELINGID] [int] NOT NULL,
	[UAFDELINGNAVN] [nvarchar](50) NOT NULL,
	[LEDER] [nvarchar](100) NULL,
	[ADRESSE] [nvarchar](100) NULL,
	[TELEFON] [nvarchar](20) NULL,
	[FAX] [nvarchar](20) NULL,
	[KMDKALDENAVN] [nvarchar](10) NULL,
	[AKTIV] [int] NOT NULL,
	[ADVIS] [int] NOT NULL,
	[GRPBRUGER] [int] NULL,
	[VAGTTYPE] [int] NOT NULL,
	[VEJTID] [int] NULL,
	[KONTAKTTID] [nvarchar](35) NULL,
	[KONTONR] [nvarchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPVISITATION]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPVISITATION](
	[ID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[VISIDATO] [datetime] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[TP_MORGEN] [int] NULL,
	[TP_FORMIDDAG] [int] NULL,
	[TP_MIDDAG] [int] NULL,
	[TP_EFTERMIDDAG] [int] NULL,
	[TP_AFTEN1] [int] NULL,
	[TP_AFTEN2] [int] NULL,
	[TP_AFTEN3] [int] NULL,
	[TP_AFTEN4] [int] NULL,
	[TP_NAT1] [int] NULL,
	[TP_NAT2] [int] NULL,
	[TP_NAT3] [int] NULL,
	[TP_NAT4] [int] NULL,
	[TP_TIMER] [int] NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[NAESTEVIS] [datetime] NOT NULL,
	[TB_MORGEN] [int] NULL,
	[TB_FORMIDDAG] [int] NULL,
	[TB_MIDDAG] [int] NULL,
	[TB_EFTERMIDDAG] [int] NULL,
	[TB_AFTEN1] [int] NULL,
	[TB_AFTEN2] [int] NULL,
	[TB_AFTEN3] [int] NULL,
	[TB_AFTEN4] [int] NULL,
	[TB_NAT1] [int] NULL,
	[TB_NAT2] [int] NULL,
	[TB_NAT3] [int] NULL,
	[TB_NAT4] [int] NULL,
	[TB_TIMER] [int] NULL,
	[HENVENDELSE] [datetime] NULL,
	[BESOGSDATO] [datetime] NULL,
	[FALLES_SPROG_ART] [int] NOT NULL,
	[VURDERINGSDATO] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TPVISIJOB]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPVISIJOB](
	[ID] [int] NOT NULL,
	[TPVISIID] [int] NOT NULL,
	[JOBID] [int] NOT NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_MORGEN] [int] NOT NULL,
	[YD_FORMIDDAG] [int] NOT NULL,
	[YD_MIDDAG] [int] NOT NULL,
	[YD_EFTERMIDDAG] [int] NOT NULL,
	[YD_AFTEN1] [int] NOT NULL,
	[YD_AFTEN2] [int] NOT NULL,
	[YD_AFTEN3] [int] NOT NULL,
	[YD_AFTEN4] [int] NOT NULL,
	[YD_NAT1] [int] NOT NULL,
	[YD_NAT2] [int] NOT NULL,
	[YD_NAT3] [int] NOT NULL,
	[YD_NAT4] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[NORMTID] [int] NOT NULL,
	[SKJULT] [int] NOT NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[PARAGRAF] [int] NOT NULL,
	[HJALPFRA] [int] NOT NULL,
	[FRITVALGLEV] [int] NULL,
	[TID_FRAVALGT] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_VisitationUdenSlutDato]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationUdenSlutDato](
	[SAGSID_PLEJETYPE] [varchar](21) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationTilAfgang_Ultimo]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationTilAfgang_Ultimo](
	[PK_DATE] [datetime] NOT NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[ULTIMO] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationTilAfgang_Primo]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationTilAfgang_Primo](
	[PK_DATE] [datetime] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[PRIMO] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step3]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step3](
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[STATUS] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step2](
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[STATUS] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationTilAfgang_Over90Dage_Step1](
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[STATUSID] [int] NULL,
	[STATUS] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationsHistorik_Tilgang]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationsHistorik_Tilgang](
	[ID] [int] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[STATUS] [int] NULL,
	[STATUSID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationsHistorik_Afgang]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationsHistorik_Afgang](
	[ID] [int] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[STATUS] [int] NULL,
	[STATUSID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationsHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationsHistorik](
	[VISIID] [int] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_VisitationsGruppeskift]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_VisitationsGruppeskift](
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [varchar](10) NOT NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[STATUSID] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PK_DATE] [datetime] NOT NULL,
	[PLEJETYPE] [int] NOT NULL,
	[GRUPPESKIFT] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_Tilgang_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_Tilgang_Step1](
	[PK_DATE] [datetime] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_Tilgang]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_Tilgang](
	[PK_DATE] [datetime] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[TILGANG] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_Lev_Bevaegelser]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_Lev_Bevaegelser](
	[PK_DATE] [datetime] NOT NULL,
	[VISIID] [int] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
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
/****** Object:  Table [dbo].[tmp_Visitations_BorgerMedFritvalgLev_Step2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_BorgerMedFritvalgLev_Step2](
	[PK_DATE] [datetime] NOT NULL,
	[IKRAFTDATO] [datetime] NOT NULL,
	[SLUTDATO] [datetime] NOT NULL,
	[VISIID] [int] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_BorgerMedFritvalgLev_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_BorgerMedFritvalgLev_Step1](
	[SAGSID_PLEJETYPE] [varchar](21) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_Afgang_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_Afgang_Step1](
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[PK_DATE] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_Visitations_Afgang]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_Visitations_Afgang](
	[PK_DATE] [datetime] NULL,
	[SAGSID] [int] NULL,
	[SAGSID_PLEJETYPE] [varchar](21) NULL,
	[CPRNR] [nvarchar](10) NULL,
	[JOBID] [int] NULL,
	[ALDER] [int] NULL,
	[BORGER_ORG] [int] NULL,
	[BORGER_STATUS] [int] NOT NULL,
	[BORGER_STATUSID] [int] NULL,
	[LEVERANDOERID] [int] NULL,
	[PLEJETYPE] [int] NOT NULL,
	[AFGANG] [int] NOT NULL,
	[SPECIFIKATION_NY] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step7]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step7](
	[PK_DATE] [date] NULL,
	[MEDID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[PLANLAGTTIMER] [decimal](18, 10) NULL,
	[FRAVAERSTIMER] [numeric](38, 6) NULL,
	[OMFORDELTTID] [int] NULL,
	[FRAVAERSDAGE] [int] NOT NULL,
	[DELVIST_SYG] [nvarchar](1) NULL,
	[SYGDOMSPERIOD] [int] NULL,
	[FRAVAERTYPEID] [int] NULL,
	[TJENESTETYPERID] [int] NOT NULL,
	[TJENESTEGROUPID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step6]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step6](
	[PK_DATE] [date] NULL,
	[MEDID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[PLANLAGTTIMER] [decimal](18, 10) NULL,
	[OMFORDELTTID] [int] NOT NULL,
	[FRAVAERSTIMER] [numeric](22, 6) NULL,
	[FRAVAERSDAGE] [int] NOT NULL,
	[DELVIST_SYG] [nvarchar](1) NULL,
	[SYGDOMSPERIOD] [int] NULL,
	[FRAVAERTYPEID] [int] NULL,
	[TJENESTETYPERID] [int] NOT NULL,
	[TJENESTEGROUPID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step5]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step5](
	[PK_DATE] [date] NULL,
	[MEDID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[OMKOST_GRUPPE] [int] NULL,
	[STAMDATA_GRUPPE] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[PLANLAGTTIMER] [decimal](18, 10) NULL,
	[FRAVAERSTIMER] [numeric](22, 6) NULL,
	[FRAVAERSDAGE] [int] NOT NULL,
	[DELVIST_SYG] [nvarchar](1) NULL,
	[SYGDOMSPERIOD] [int] NULL,
	[FRAVAERTYPEID] [int] NULL,
	[TJENESTETYPERID] [int] NOT NULL,
	[TJENESTEGROUPID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step4]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step4](
	[PK_DATE] [date] NULL,
	[MEDID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[STARTTIDSPUNKT] [datetime] NULL,
	[SLUT] [datetime] NULL,
	[PLANLAGTTIMER] [numeric](22, 6) NULL,
	[FRAVAERSTIMER] [numeric](22, 6) NULL,
	[OMFORDELTTID] [numeric](22, 6) NULL,
	[FRAVAERSDAGE] [decimal](18, 10) NULL,
	[SYGDOMSPERIOD] [decimal](18, 10) NULL,
	[DELVIST_SYG] [varchar](1) NOT NULL,
	[TJENESTETYPERID] [int] NULL,
	[TJENESTEGROUPID] [int] NULL,
	[FRAVAERTYPEID] [int] NOT NULL,
	[VAGT_OVER_MIDNAT] [int] NOT NULL,
	[ANNULLERET] [int] NULL,
	[FAKTISK_TID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step3]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step3](
	[MEDARBEJDER] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[OMKOST_GRUPPE] [int] NULL,
	[MEDARB_GRUPPE] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[STARTTIDSPUNKT] [datetime] NULL,
	[SLUT] [datetime] NULL,
	[FRAVAERSTIMER] [decimal](18, 10) NULL,
	[FRAVAERSDAGE] [decimal](18, 10) NULL,
	[SYGDOMSPERIOD] [decimal](18, 10) NULL,
	[DELVIST_SYG] [varchar](1) NOT NULL,
	[TJENESTETYPERID] [int] NULL,
	[TJENESTEGROUPID] [int] NULL,
	[FRAVAERTYPEID] [int] NOT NULL,
	[VAGT_OVER_MIDNAT] [int] NOT NULL,
	[PAA_ARBEJDE] [int] NULL,
	[ANNULLERET] [int] NULL,
	[FAKTISK_TID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step2](
	[MEDARBEJDER] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[OMKOST_GRUPPE] [int] NULL,
	[MEDARB_GRUPPE] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GENNEMSNITTIMER] [decimal](18, 10) NULL,
	[STARTTIDSPUNKT] [datetime] NOT NULL,
	[SLUT] [datetime] NOT NULL,
	[FRAVAERSTIMER] [decimal](18, 10) NULL,
	[FRAVAERSDAGE] [decimal](18, 10) NULL,
	[SYGDOMSPERIOD] [decimal](18, 10) NULL,
	[DELVIST_SYG] [varchar](1) NOT NULL,
	[TJENESTETYPERID] [int] NULL,
	[TJENESTEGROUPID] [int] NULL,
	[FRAVAERTYPEID] [int] NOT NULL,
	[VAGT_OVER_MIDNAT] [int] NOT NULL,
	[PAA_ARBEJDE] [int] NULL,
	[ANNULLERET] [int] NULL,
	[FAKTISK_TID] [int] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tmp_Vagtplan_FactTimerPlan_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tmp_Vagtplan_FactTimerPlan_Step1](
	[PK_DATE] [datetime] NOT NULL,
	[MedID] [int] NULL,
	[IKRAFTDATO] [datetime] NULL,
	[SLUTDATO] [datetime] NULL,
	[VAGTER] [int] NULL,
	[UAFDELINGID] [int] NULL,
	[STATUSNAVN] [nvarchar](50) NULL,
	[STILLINGNAVN] [nvarchar](50) NULL,
	[STILLINGID] [int] NULL,
	[GennemsnitTimer] [decimal](23, 15) NULL,
	[PlanlagtTimer] [decimal](18, 10) NULL,
	[FravaersTimer] [decimal](18, 10) NULL,
	[FravaersDage] [decimal](18, 10) NULL,
	[Delvist_Syg] [varchar](1) NOT NULL,
	[SygdomsPeriod] [decimal](18, 10) NULL,
	[FravaerTypeID] [int] NOT NULL,
	[TjenesteTyperID] [int] NOT NULL,
	[TjenesteGroupID] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step7]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step7](
	[VISI_ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[VISI_TID_HVERDAG] [numeric](38, 6) NULL,
	[VISI_TID_WEEKEND] [numeric](38, 6) NULL,
	[DIM_FUNKNIVEAU_ID] [int] NULL,
	[FS_TYPE] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step6]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step6](
	[VISI_ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[VISI_TID_HVERDAG] [numeric](38, 6) NULL,
	[VISI_TID_WEEKEND] [numeric](38, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step5]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step5](
	[VISI_ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[NORMTID] [numeric](10, 2) NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[PERSONER] [int] NOT NULL,
	[VISI_TID_HVERDAG] [numeric](38, 6) NULL,
	[VISI_TID_WEEKEND] [numeric](38, 6) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step4]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step4](
	[VISI_ID] [int] NULL,
	[SAGSID] [int] NULL,
	[IKRAFTDATO] [date] NOT NULL,
	[SLUTDATO] [date] NOT NULL,
	[NORMTID] [numeric](10, 2) NULL,
	[HYPPIGHED] [int] NOT NULL,
	[YD_GANGE] [int] NOT NULL,
	[YD_PR_DOEGN] [int] NULL,
	[YD_WEEKEND] [int] NOT NULL,
	[PERSONER] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step3]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step3](
	[VISI_ID] [int] NULL,
	[DIM_FUNKNIVEAU_ID] [int] NULL,
	[FS_TYPE] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step2](
	[VISI_ID] [int] NULL,
	[GENNEMSNIT] [numeric](10, 2) NULL,
	[FS_TYPE] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step12]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step12](
	[VISI_ID] [int] NULL,
	[GENNEMSNIT] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step11]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step11](
	[VISI_ID] [int] NULL,
	[GENNEMSNIT] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FunktionsNiveau_Step1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FunktionsNiveau_Step1](
	[VISI_ID] [int] NULL,
	[RELEVANT] [int] NOT NULL,
	[NIVEAU] [numeric](10, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBruger2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBruger2](
	[BRUGERID] [int] NOT NULL,
	[DEAKTIVERET] [datetime2](7) NULL,
	[PK_DATE] [date] NULL,
	[BEVAEGID] [int] NOT NULL,
	[BRUGERSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBruger1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBruger1](
	[BRUGERID] [int] NOT NULL,
	[OPRETTET] [datetime2](7) NULL,
	[PK_DATE] [date] NULL,
	[BEVAEGID] [int] NOT NULL,
	[BRUGERSTATUSID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBoligventeliste2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBoligventeliste2](
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
/****** Object:  Table [dbo].[tmp_FactBoligventeliste1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBoligventeliste1](
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NULL,
	[SAGSID] [int] NULL,
	[TILBUD_DATO] [date] NULL,
	[UDLOB_DATO] [date] NULL,
	[AFVIST_DATO] [date] NULL,
	[FRA_GARANTI_LISTE] [int] NULL,
	[BOLIGVISI_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBoligventeliste]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBoligventeliste](
	[BORGERID] [int] NULL,
	[BOLIGVISI_ID] [int] NULL,
	[TILBUD_DATO] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBoligIndflyt1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBoligIndflyt1](
	[SAGSID] [int] NOT NULL,
	[BOLIGID] [int] NOT NULL,
	[PK_DATE] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_FactBoligIndflyt]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_FactBoligIndflyt](
	[SAGSID] [int] NOT NULL,
	[PK_DATE] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_Fact_Boligliste]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Fact_Boligliste](
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NOT NULL,
	[SAGSID] [int] NOT NULL,
	[INDFLYTNING] [date] NULL,
	[FRAFLYTNING] [date] NULL,
	[KLAR_DATO] [date] NULL,
	[DFPTID] [nvarchar](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_DimPakkeTyper]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tmp_DimPakkeTyper](
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
	[BTPKATNAVN] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tmp_DimBoliger1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_DimBoliger1](
	[DFPTID] [nvarchar](2) NULL,
	[DRIFTFORM] [nvarchar](20) NOT NULL,
	[PLADSTYPE] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_Boligventeliste2]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Boligventeliste2](
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
/****** Object:  Table [dbo].[tmp_Boligventeliste1]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Boligventeliste1](
	[ID] [int] NOT NULL,
	[BOLIGID] [int] NULL,
	[SAGSID] [int] NULL,
	[TILBUD_DATO] [date] NULL,
	[UDLOB_DATO] [date] NULL,
	[AFVIST_DATO] [date] NULL,
	[FRA_GARANTI_LISTE] [int] NULL,
	[BOLIGVISI_ID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_Boligventeliste]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Boligventeliste](
	[BORGERID] [int] NULL,
	[BOLIGVISI_ID] [int] NULL,
	[TILBUD_DATO] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Temp_TPSagshistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Temp_TPSagshistorik] AS SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, COALESCE (TERAPEUT_STATUS, 1) AS TERAPEUT_STATUS, COALESCE (TERAPEUT_STATUSID, 1) AS TERAPEUT_STATUSID, COALESCE (TERAPEUT_GRUPPEID, 9999) AS TERAPEUT_GRUPPEID FROM  dbo.SAGSHISTORIK
GO
/****** Object:  View [dbo].[Temp_SPSagshistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Temp_SPSagshistorik] AS SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, COALESCE (SYGEPLEJE_STATUS, 1) AS SYGEPLEJE_STATUS, COALESCE (SYGEPLEJE_STATUSID, 1) AS SYGEPLEJE_STATUSID, COALESCE (SYGEPLEJE_GRUPPEID, 9999) AS SYGEPLEJE_GRUPPEID, COALESCE (SPGRP_AFTEN_ID,5555) AS SYPL_AFTENGRP_ID, COALESCE (SPGRP_NAT_ID,5555) AS SYPL_NATGRP_ID, COALESCE (HJEMMEPLEJE_GRUPPEID,5555) AS HJPL_DAGGRP_ID, COALESCE (HJGRP_AFTEN_ID,5555) AS HJPL_AFTENGRP_ID, COALESCE (HJGRP_NAT_ID,5555) AS HJPL_NATGRP_ID FROM  dbo.SAGSHISTORIK
GO
/****** Object:  View [dbo].[Temp_MADSagshistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Temp_MADSagshistorik] AS SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, COALESCE (MADVISI_STATUS, 0) AS MADVISI_STATUS, COALESCE (MADVISI_STATUSID, 1) AS MADVISI_STATUSID FROM  dbo.SAGSHISTORIK where madvisi_statusid is not null
GO
/****** Object:  View [dbo].[Temp_HJSagshistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Temp_HJSagshistorik] AS SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, COALESCE (HJEMMEPLEJE_STATUS, 1) AS HJEMMEPLEJE_STATUS, COALESCE (HJEMMEPLEJE_STATUSID, 1) AS HJEMMEPLEJE_STATUSID, COALESCE (HJEMMEPLEJE_GRUPPEID, 9999) AS HJEMMEPLEJE_GRUPPEID, COALESCE (HJGRP_AFTEN_ID,5555) AS HJPL_AFTENGRP_ID, COALESCE (HJGRP_NAT_ID,5555) AS HJPL_NATGRP_ID, COALESCE (SYGEPLEJE_GRUPPEID,5555) AS SYGEPLEJE_GRUPPEID, COALESCE (SPGRP_AFTEN_ID,5555) AS SYPL_AFTENGRP_ID, COALESCE (SPGRP_NAT_ID,5555) AS SYPL_NATGRP_ID FROM  dbo.SAGSHISTORIK
GO
/****** Object:  View [dbo].[Dim_jobtyper]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Dim_jobtyper]
AS
SELECT     JOBID, JOBNAVN, KATEGORI, NIVEAU1, NIVEAU2, NIVEAU3, SLETTET_JOB, SKRIVEBESKYTTET, FALLES_SPROG_KAT_KODE, 
                      FALLES_SPROG_NIV1_KODE, FALLES_SPROG_NIV2_KODE, FALLES_SPROG_NIV3_KODE, SIDSTE_VITALE_AENDRING, PLEJETYPE, NORMTID2, 
                      NORMTID3, NORMTID4, FUNKKAT, MAXTID2, MAXTID3, MAXTID4, FALLES_SPROG_ART, PARAGRAF, NORMTID1, MAXTID1, BTP
FROM         JOBTYPER
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "JOBTYPER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 313
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 11
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 41
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Dim_jobtyper'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Dim_jobtyper'
GO
/****** Object:  UserDefinedFunction [dbo].[CheckLeverandoer]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckLeverandoer](@levId int) 
RETURNS  int

AS
BEGIN
declare @returnLevId as int

  if @levId is null
	return null
  if @levId = ''
	return null
	select @returnLevId = coalesce((select ID from dbo.HJPLEVERANDOR where ID=@levId),9999)

  RETURN @returnLevId;
END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=26)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (26,GETDATE())           
--end
GO
/****** Object:  View [dbo].[_vForbrugsafvigelserUdenYdelse]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[_vForbrugsafvigelserUdenYdelse]
AS
SELECT     dbo.SAGSPLANRET.ID, dbo.SAGSPLANRET.SERIEID, dbo.SAGSPLANRET.SAGSID, dbo.SAGSPLANRET.MEDID, dbo.SAGSPLANRET.RETDATO, dbo.SAGSPLANRET.TID, 
                      dbo.SAGSPLANRET.VEJTID, dbo.SAGSPLANRET.YDELSESTID, dbo.SAGSPLANRET.STATUSID, dbo.SAGSPLANRET.RSTART, dbo.SAGSPLANRET.RTID, 
                      dbo.SAGSPLANRET.RVEJTID, dbo.SAGSPLANRET.REGBES, dbo.SAGSPLANRET.SERIEDATO, dbo.SAGSPLANRET.STARTMINEFTERMIDNAT, 
                      dbo.SAGSPLANRET.VISISTART, dbo.SAGSPLANRET.VISISLUT, CASE WHEN regbes = 1 THEN 'Registreret' ELSE 'Ej registreret' END AS Målt, 
                      'Neutral' AS Forbrugsstatus, CASE WHEN sagsplanret.regbes = 1 THEN sagsplanret.RTID - RVejtid - sagsplanret.YDELSESTID ELSE NULL 
                      END AS Samlet_Forbrugsafvigelse, dbo.BESOGSTATUS.BESOGID * 10000 AS jobid, 0 AS Normtid_ydelse, dbo.SAGSPLANRET.RTID AS fordelt_forbrug, 
                      CASE WHEN sagsplanret.regbes = 1 THEN sagsplanret.RTID - RVejtid - sagsplanret.YDELSESTID ELSE NULL END AS Fordelt_forbrugsafvigelse, 
                      dbo.SAGSPLANRET.RVEJTID AS fordelt_vejtid, 0 AS visitype, dbo.BESOGSTATUS.BESOGID * 10000 AS Expr1, dbo.BESOGSTATUS.STAT_TYPE
FROM         dbo.SAGSPLANRET INNER JOIN
                      dbo.BESOGSTATUS ON dbo.SAGSPLANRET.STATUSID = dbo.BESOGSTATUS.BESOGID LEFT OUTER JOIN
                      dbo.SAGSPRETDET ON dbo.SAGSPLANRET.ID = dbo.SAGSPRETDET.SAGSPRETID
WHERE     (dbo.SAGSPRETDET.ID IS NULL)
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SAGSPLANRET"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "BESOGSTATUS"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 193
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SAGSPRETDET"
            Begin Extent = 
               Top = 20
               Left = 471
               Bottom = 253
               Right = 622
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_vForbrugsafvigelserUdenYdelse'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'_vForbrugsafvigelserUdenYdelse'
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Time_Dimension]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Create_Time_Dimension]
					  @DestinationDB as  varchar(200),
				      @start_date as datetime,
					  @end_date as datetime
					
AS

set nocount on
set datefirst 1
declare 
 --@start_date datetime
 --,@end_date datetime
 @loop_day datetime
 ,@diff int
 --,@loop int
,@weekNo int
declare @date datetime
declare @ISOweek integer
declare @cmd as varchar(max)
declare @debug as bit

declare @PK_Date as datetime
declare @Date_Name as nvarchar(50)
declare @Year as datetime
declare @Year_Name as nvarchar(50)
declare @Quarter as datetime
declare @Quarter_Name as nvarchar(50)
declare @Month as datetime
declare @Month_Name as nvarchar(50)
declare @Week as datetime
declare @Week_Name as nvarchar(50)
declare @Day_Of_Year as int
declare @Day_Of_Year_Name as nvarchar(50)
declare @Day_Of_Quarter as int
declare @Day_Of_Quarter_Name as nvarchar(50)
declare @Day_Of_Month as int
declare @Day_Of_Month_Name as nvarchar(50)
declare @Day_Of_Week as int
declare @Day_Of_Week_Name as nvarchar(50)
declare @Week_Of_Year as int
declare @Week_Of_Year_Name nvarchar(50)
declare @Month_Of_Year as int
declare @Month_Of_Year_Name as nvarchar(50)
declare @Month_Of_Quarter as int
declare @Month_Of_Quarter_Name as nvarchar(50)
declare @Quarter_Of_Year as int
declare @Quarter_Of_Year_Name as nvarchar(50)
declare @tmpint as int
declare @loop as int
set @debug = 1

set @loop = 0
 

set @cmd = 'IF EXISTS(SELECT name FROM  sysobjects WHERE name =  ''Dim_Time'' AND type = ''U'') DROP TABLE Dim_Time'
if @debug = 1 print @cmd
exec (@cmd) 

CREATE TABLE Dim_Time(
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
	[Quarter_Of_Year_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Time] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

select  @diff = datediff(dd,@start_date,@end_date)
while @loop <= @diff
	begin
	 select @loop_day = dateadd(dd,@loop,@start_date)
		set @isoweek = DATEPART( wk,dateadd(dd,@loop,@start_date)) 
			if datepart(dw,@loop_day) = 1  begin
				set @isoweek = DATEPART( wk,dateadd(dd,@loop,@start_date)) 
				if DATEPART( wk,dateadd(dd,@loop,@start_date)) = 1 begin		
					set @date = dateadd(dd,@loop,@start_date)		
					select @ISOweek= datepart(wk,@date)+1-datepart(wk,'Jan 4,'+CAST(datepart(yy,@date) as CHAR(4)))			
					if (@ISOweek=0) begin
						select @ISOweek=datepart(wk, 'Dec '+ CAST(24+datepart(day,@date) as
						CHAR(2))+','+CAST(datepart(yy,@date)-1 as CHAR(4)))+1 
				end	
			end
	 end	
 
 set @PK_Date = dateadd(dd,@loop,@start_date)
 set @Date_Name = datepart(dw,@loop_day)
	if  @Date_Name = '1' 
		set @Date_Name = 'Mandag'
	if  @Date_Name = '2' 
		set @Date_Name = 'Tirsdag'
	if  @Date_Name = '3' 
		set @Date_Name = 'Onsdag'
	if  @Date_Name = '4' 
		set @Date_Name = 'Torsdag'
	if  @Date_Name = '5' 
		set @Date_Name = 'Fredag'
	if  @Date_Name = '6' 
		set @Date_Name = 'Lørdag'
	if  @Date_Name = '7' 
		set @Date_Name = 'Søndag'

 set @Year = cast(lower(year(@PK_Date))  as datetime)
 set @Year_Name = 'Kalender ' + lower( year(@PK_Date))
 set @Quarter_Name = lower(convert(varchar,datepart(qq,@loop_day)))
 
 if @Quarter_Name = '1'
	set @Quarter = cast( lower(year(@PK_Date)) + '-01-01'  as datetime)
  if @Quarter_Name = '2'
	set @Quarter = cast( lower(year(@PK_Date)) + '-04-01'  as datetime)
  if @Quarter_Name = '3'
	set @Quarter = cast( lower(year(@PK_Date)) + '-07-01'  as datetime)
  if @Quarter_Name = '4'
	set @Quarter = cast( lower(year(@PK_Date)) + '-10-01'  as datetime)
   
  set @Quarter_Name = convert(varchar,datepart(qq,@loop_day)) + '. Kvartal ' + lower(year(@PK_Date))
  
  set @tmpint = datepart(mm,@loop_day)  
  if @tmpint > 9  
     set @month = cast(lower(year(@PK_Date)) + '-' + lower(@tmpint) + '-01' as datetime)
  else
	 set @month =cast(lower(year(@PK_Date)) + '-0' + lower(@tmpint) + '-01'  as datetime)
  	
    if  @tmpint = 1 
		set @month_name = 'januar' --+ lower(year(@PK_Date))
	if  @tmpint = 2 
		set @month_name = 'februar'-- + lower(year(@PK_Date))
	if  @tmpint = 3 
		set @month_name = 'marts' --+ lower(year(@PK_Date))
	if  @tmpint = 4 
		set @month_name = 'april'-- + lower(year(@PK_Date))
	if  @tmpint = 5 
		set @month_name = 'maj' --+ lower(year(@PK_Date))
	if  @tmpint = 6 
		set @month_name = 'juni'-- + lower(year(@PK_Date))
	if  @tmpint = 7 
		set @month_name = 'juli' --+ lower(year(@PK_Date))
	if  @tmpint = 8 
		set @month_name = 'august' --+ lower(year(@PK_Date))
   if  @tmpint = 9 
		set @month_name = 'september' --+ lower(year(@PK_Date))
   if  @tmpint = 10 
		set @month_name = 'oktober' --+ lower(year(@PK_Date))
   if  @tmpint = 11 
		set @month_name = 'november' --+ lower(year(@PK_Date))
   if  @tmpint = 12 
		set @month_name = 'december' --+ lower(year(@PK_Date))
  set datefirst 1
  set @Date_Name = @Date_Name + ', '  + lower(day(@PK_Date)) + '. '  + @month_name + ' ' + lower(year(@PK_Date))
  set @month_name = @month_name + ' ' + lower(year(@PK_Date)) 
  set @Week = @PK_Date - (DATEPART(DW,  @PK_Date) - 1)
  declare @yearfix int
  if DAY(@PK_Date)<9 and dbo.udf_GetISOWeekNumberFromDate(@PK_Date)>50 
     set  @yearfix=-1
   else 
     set @yearfix=0 
  set @Week_Name = 'Uge '+ cast(dbo.udf_GetISOWeekNumberFromDate(@PK_Date) as nvarchar(2)) +',' + lower(year(@PK_Date)+@yearfix)
  set @Day_Of_Year =  DATEDIFF(dd, '01/01/'+ lower(year(@PK_Date)), @PK_Date) + 1 
  set @Day_Of_Year_Name = 'Dag ' + lower( @Day_Of_Year)
  set @Day_Of_Quarter = DATEDIFF(dd,@Quarter, @PK_Date) + 1 
  set @Day_Of_Quarter_Name = 'Dag ' + lower(DATEDIFF(dd,@Quarter, @PK_Date) + 1 )
  set @Day_Of_Month = day(@PK_Date)
  set @Day_Of_Month_Name = 'Dag ' + lower(day(@PK_Date))
  set @Day_Of_Week = datepart(dw,@loop_day)
  set @Day_Of_Week_Name = 'Dag ' + lower(@Day_Of_Week)
  set @Week_Of_Year = @isoweek
  set @Week_Of_Year_Name = 'Uge ' + lower(@isoweek)
  set @Month_Of_Year = datepart(mm,@loop_day)
  set @Month_Of_Year_Name = 'Måned ' + lower(@Month_Of_Year)
  set @Month_Of_Quarter =  DATEDIFF(mm,@Quarter, @PK_Date) + 1
  set @Month_Of_Quarter_Name = 'Måned ' + lower( @Month_Of_Quarter )
  set @Quarter_Of_Year =  convert(varchar,datepart(qq,@loop_day))
  set @Quarter_Of_Year_Name = 'Kvartal ' + lower(@Quarter_Of_Year)


insert into Dim_Time
 select @PK_Date, 
		@Date_Name, 
		@Year, 
		@Year_Name, 
		@Quarter, 
		@Quarter_Name, 
		@Month, 
		@Month_Name, 
		@Week, 
		@Week_Name, 
		@Day_Of_Year, 
		@Day_Of_Year_Name, 
		@Day_Of_Quarter,
		@Day_Of_Quarter_Name, 
		@Day_Of_Month, 
		@Day_Of_Month_Name, 
		@Day_Of_Week, 
		@Day_Of_Week_Name, 
		@Week_Of_Year, 
		@Week_Of_Year_Name, 
		@Month_Of_Year,                
		@Month_Of_Year_Name, 
		@Month_Of_Quarter, 
		@Month_Of_Quarter_Name, 
		@Quarter_Of_Year, 
		@Quarter_Of_Year_Name
	

 select @loop = @loop + 1  
end

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimTime'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimTime'
if @debug = 1 print @cmd
exec (@cmd)



set @cmd = 'Select * into '+@DestinationDB+'.DBO.DimTime from dbo.Dim_Time'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'link_time' AND type = 'U') DROP TABLE link_time

SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
into link_time
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 2) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 2)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, '0' + CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 1) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 2)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-0' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM        Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 2) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 1)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, '0' + CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-0' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 1) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 1)
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_TP]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Create_FactTables_TP]
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
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=12)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (12,GETDATE())           
--end
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_SP]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE procEDURE [dbo].[usp_Create_FactTables_SP]
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

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=11)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (11,GETDATE())           
--end

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
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_Mad]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Create_FactTables_Mad]
					  @DestinationDB as  varchar(200),
					  @Afregnet as bit
					 
AS

DECLARE @cmd as varchar(max)
DECLARE @debug as bit
DECLARE @tablePrefix as varchar(200)
if @afregnet = 0
	set @tablePrefix = 'FACT_MADVisiSag'
if @afregnet = 1
	set @tablePrefix = 'FACT_MADVisiSag_Afregnet'
set @debug = 1

set @debug = 1

--først ryddes der op i SAGSHISTORIK og _tmp_SP_SAGSHISTORIK skabes
set @cmd = 'exec usp_MAD_SAGSHISTORIK'
if @debug = 1 print @cmd
exec (@cmd)

--lav _tmp_hjvisitation_PB 
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_MADVISITATION' AND type = 'U') DROP TABLE _tmp_MADVISITATION

set @cmd = 'Select * into _tmp_MADVISITATION ' +char(13)+
		   'FROM  (SELECT ID, SAGSID, IKRAFTDATO, SLUTDATO, 9999 AS dogninddeling ' +char(13)+
           'FROM   MADVISITATION ' +char(13)+
           'WHERE (SAGSID IN (SELECT SAGSID FROM   DIMSAGER))) AS derivedtbl_1'

   
if @debug = 1 print @cmd
exec (@cmd)

if @afregnet = 1 begin --hvis afregnet skal datoer skydes frem til følgende mandag
	--skyder visiikraft og visislut frem
	IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '__tmp_MADVISITATION' AND type = 'U') DROP TABLE __tmp_MADVISITATION

	select 
	ID, 
	SAGSID, 
	dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, ikraftdato - 1 ), 7 ))) as IKRAFTDATO, 
	case  when slutdato != '9999-01-01' then dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, SLUTDATO -1 ), 7 ))) 
	else slutdato end as SLUTDATO, 
	dogninddeling
	into __tmp_MADVISITATION
	from _tmp_MADVISITATION

	drop table _tmp_MADVISITATION

	exec sp_rename '__tmp_MADVISITATION','_tmp_MADVISITATION'
	--skyder sagikraft og sagslut frem
	IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '__tmp_MAD_SAGSHISTORIK' AND type = 'U') DROP TABLE __tmp_MAD_SAGSHISTORIK
	SELECT dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, ikraftdato - 1), 7 ))) as IKRAFTDATO, 
	case  when slutdato != '9999-01-01' then dateadd( Wk, 1, (dateadd( wk, datediff( wk, 7, SLUTDATO - 1 ), 7 ))) 
	else slutdato end as SLUTDATO, 
	MADVISI_STATUS, 
	MADVISI_STATUSID, 
    ID, 
	SAGSID
	into  __tmp_MAD_SAGSHISTORIK
	FROM  _tmp_MAD_SAGSHISTORIK

	IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_MAD_SAGSHISTORIK' AND type = 'U') DROP TABLE _tmp_MAD_SAGSHISTORIK
	exec sp_rename '__tmp_MAD_SAGSHISTORIK','_tmp_MAD_SAGSHISTORIK'	
end

--laver _FACT_SPVisiSag_Step1
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_MADVisiSag_Step1' AND type = 'U') DROP TABLE _FACT_MADVisiSag_Step1

set @cmd = 'SELECT dbo._tmp_MAD_SAGSHISTORIK.SAGSID, ' +char(13)+
			'dbo._tmp_MAD_SAGSHISTORIK.IKRAFTDATO AS sagikraft, ' +char(13)+
			'dbo._tmp_MAD_SAGSHISTORIK.SLUTDATO AS sagslut, ' +char(13)+
			'dbo._tmp_MAD_SAGSHISTORIK.MADVISI_STATUS, ' +char(13)+
			'dbo._tmp_MAD_SAGSHISTORIK.MADVISI_STATUSID, ' +char(13)+
			'dbo._tmp_MADVISITATION.dogninddeling AS dogninddeling, ' +char(13)+
			'dbo._tmp_MADVISITATION.IKRAFTDATO AS visiikraft, ' +char(13)+  
			'dbo._tmp_MADVISITATION.SLUTDATO AS visislut, ' +char(13)+  
			'dbo._tmp_MADVISITATION.ID AS visiid  ' +char(13)+ 
			'into _FACT_MADVisiSag_Step1 ' +char(13)+ 
			'FROM  dbo._tmp_MAD_SAGSHISTORIK INNER JOIN  ' +char(13)+
			'dbo._tmp_MADVISITATION ON dbo._tmp_MAD_SAGSHISTORIK.SAGSID = dbo._tmp_MADVISITATION.SAGSID AND  ' +char(13)+ 
			'dbo._tmp_MAD_SAGSHISTORIK.SLUTDATO > dbo._tmp_MADVISITATION.IKRAFTDATO AND  ' +char(13)+ 
			'dbo._tmp_MAD_SAGSHISTORIK.IKRAFTDATO < dbo._tmp_MADVISITATION.SLUTDATO  where dbo._tmp_MAD_SAGSHISTORIK.MADVISI_STATUSID is not null' 
if @debug = 1 print @cmd
exec (@cmd)

--laver _FACT_SPVisiSag_Step 2
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_MADVisiSag_Step2' AND type = 'U') DROP TABLE _FACT_MADVisiSag_Step2

set @cmd = 'SELECT SAGSID, sagikraft, sagslut, MADVISI_STATUS, MADVISI_STATUSID,' +char(13)+
			'dogninddeling, visiikraft, visislut,   visiid, sagikraft AS start, ' +char(13)+
			'			   sagslut AS slut, 1 AS type ' +char(13)+
			'into  _FACT_MADVisiSag_Step2 ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step1 ' +char(13)+
			'WHERE (visislut >= sagslut) AND (sagikraft >= visiikraft) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, MADVISI_STATUS, MADVISI_STATUSID, ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, sagikraft AS start,  ' +char(13)+
		    '				   visislut AS slut, 2 AS type ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step1 AS VisiSag_step1_1 ' +char(13)+
			'WHERE (sagikraft >= visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, MADVISI_STATUS, MADVISI_STATUSID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   visislut AS slut, 3 AS type ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step1 AS VisiSag_step1_4 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut < sagslut) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT SAGSID, sagikraft, sagslut, MADVISI_STATUS, MADVISI_STATUSID,  ' +char(13)+
			'dogninddeling, visiikraft, visislut,  visiid, visiikraft AS start,  ' +char(13)+
			'			   sagslut AS slut, 4 AS type ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step1 AS VisiSag_step1_3 ' +char(13)+
			'WHERE (sagikraft < visiikraft) AND (visislut >= sagslut) ' 
if @debug = 1 print @cmd
exec (@cmd)

-------smider jobid på og laver ny factabel
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +'Job'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +'Job'
if @debug = 1 print @cmd
exec (@cmd)
--cast((TPVISI * - 1) / 7 as float)

set @cmd =  'SELECT SAGSID, start AS dato, MADVISI_STATUS, MADVISI_STATUSID, 7777 as organization,cast(1.0 as float) as madleverancer, ' +char(13)+
			'cast(1.0 as float) as madleverancerHverdag, cast(1.0 as float) as madleverancerWeekend, ' +char(13)+
		    'dogninddeling, 2 AS specifikation, 1 AS count,COALESCE (MADVISIJOB.JOBID,9999) as JOBID, start, slut, JOBPRISER.INT_DAG as PRIS, jobpriser.startdato as pstart, jobpriser.slutdato as pslut, ' +char(13)+
	        'coalesce( FRITVALGLEV,8888) as FRITVALGLEV ' +char(13)+
			'into '+@DestinationDB+'.dbo.'+@tablePrefix +'Job ' +char(13)+
			'FROM  MADVISIJOB LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON MADVISIJOB.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
		    '_FACT_MADVisiSag_Step2 ON MADVISIJOB.MADVISI_ID = _FACT_MADVisiSag_Step2.visiid ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, MADVISI_STATUS, MADVISI_STATUSID, 7777 as organization,cast(-1/7.0 as float) as madleverancer, ' +char(13)+
			'cast(-1.0 as float) as madleverancerHverdag, cast(-1.0 as float) as madleverancerWeekend, ' +char(13)+
		    'dogninddeling, 3 AS specifikation, - 1 AS count,COALESCE (MADVISIJOB.JOBID,9999) as JOBID, start, slut, JOBPRISER.INT_DAG as PRIS, jobpriser.startdato as pstart, jobpriser.slutdato as pslut, ' +char(13)+
			'coalesce( FRITVALGLEV,8888) as FRITVALGLEV ' +char(13)+	
			'FROM  MADVISIJOB LEFT OUTER JOIN ' +char(13)+
            'JOBPRISER ON MADVISIJOB.JOBID = JOBPRISER.JOBID RIGHT OUTER JOIN ' +char(13)+
			'_FACT_MADVisiSag_Step2 ON MADVISIJOB.MADVISI_ID = _FACT_MADVisiSag_Step2.visiid ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' 

             
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'usp_Birthddays '''+@tablePrefix +'Job'', '''+@DestinationDB+''',''madleverancer'''
if @debug = 1 print @cmd
exec (@cmd)

Return

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  '''+@tablePrefix +''' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.'+@tablePrefix +''
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT SAGSID, start AS dato, MADVISI_STATUS, MADVISI_STATUSID, 7777 as organization,cast(1/7 as float) as madleverancer, ' +char(13)+
			'dogninddeling, 2 AS specifikation, 1 AS count, start, slut ' +char(13)+
	        'into '+@DestinationDB+'.dbo.'+@tablePrefix +' ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step2 ' +char(13)+
			--'WHERE (DATEPART(year, slut) not IN (9999)) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT  SAGSID, slut AS dato, MADVISI_STATUS, MADVISI_STATUSID, 7777 as organization,cast(-1/7 as float) as madleverancer, ' +char(13)+
		    'dogninddeling, 3 AS specifikation, - 1 AS count, start, slut ' +char(13)+
			'FROM  dbo._FACT_MADVisiSag_Step2 AS VisiSag_step2_1 ' +char(13)+
			'WHERE (DATEPART(year, slut) not IN (9999)) ' 
if @debug = 1 print @cmd
exec (@cmd)
--COALESCE (SYGEPLEJE_GRUPPEID, 9999) AS
set @cmd = 'usp_Birthddays '''+@tablePrefix +''', '''+@DestinationDB+''',''madleverancer'''
if @debug = 1 print @cmd
exec (@cmd)
return
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_FACT_MADVISIJOB_Step1' AND type = 'U') DROP TABLE _FACT_MADVISIJOB_Step1
set @cmd = 'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 1 AS dogninddeling,  YD_MORGEN AS MADVISIJOB, 1 as madleverancer' +char(13)+
			'into _FACT_MADVISIJOB_Step1 ' +char(13)+
			'FROM  dbo.MADVISIJOB ' +char(13)+
			'WHERE (YD_MORGEN = 1) AND (MADVISI_ID IN (SELECT ID FROM   dbo.MADVISITATION)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 2 AS dogninddeling,  YD_FORMIDDAG AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_11 ' +char(13)+
			'WHERE (YD_FORMIDDAG = 1) AND (MADVISI_ID IN  (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_11)) AND (HYPPIGHED = 0)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 3 AS dogninddeling,  YD_MIDDAG AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_10	WHERE (YD_MIDDAG = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_10)) AND (HYPPIGHED = 0)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 4 AS dogninddeling,  YD_EFTERMIDDAG AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_9  WHERE (YD_EFTERMIDDAG = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_9)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 5 AS dogninddeling,  YD_AFTEN1 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_8)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 6 AS dogninddeling,  YD_AFTEN2 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_7	WHERE (YD_AFTEN2 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_7)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 7 AS dogninddeling,  YD_AFTEN3 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_6	WHERE (YD_AFTEN3 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_6)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 8 AS dogninddeling,  YD_AFTEN4 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_5	WHERE (YD_AFTEN4 = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_5)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 9 AS dogninddeling,  YD_NAT1 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_4	WHERE (YD_NAT1 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_4)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 10 AS dogninddeling,  YD_NAT2 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_3	WHERE (YD_NAT2 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_3)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 11 AS dogninddeling,  YD_NAT3 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_2 WHERE (YD_NAT3 = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_2)) AND (HYPPIGHED = 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 12 AS dogninddeling,  YD_NAT4 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_1	WHERE (YD_NAT4 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_1)) AND (HYPPIGHED = 0) ' 

if @debug = 1 print @cmd
exec (@cmd)
	/*	 
set @cmd	='insert into _FACT_MADVISIJOB_Step1 ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 1 AS dogninddeling,  YD_MORGEN AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_13 WHERE (YD_MORGEN = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_13)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 2 AS dogninddeling,  YD_FORMIDDAG AS MADVISIJOB, 1 as madleverancer   ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_11  ' +char(13)+
			'WHERE (YD_FORMIDDAG = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_11)) AND (HYPPIGHED = 1)  ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 3 AS dogninddeling,  YD_MIDDAG AS MADVISIJOB, 1 as madleverancer   ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_10 WHERE (YD_MIDDAG = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_10)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 4 AS dogninddeling,  YD_EFTERMIDDAG AS MADVISIJOB, 1 as madleverancer   ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_9	WHERE (YD_EFTERMIDDAG = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_9)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 5 AS dogninddeling,  YD_AFTEN1 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_8)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 6 AS dogninddeling,  YD_AFTEN2 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_7 WHERE (YD_AFTEN2 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_7)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 7 AS dogninddeling,  YD_AFTEN3 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_6 WHERE (YD_AFTEN3 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_6)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 8 AS dogninddeling,  YD_AFTEN4 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_5 WHERE (YD_AFTEN4 = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_5)) AND (HYPPIGHED = 1)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 9 AS dogninddeling,  YD_NAT1 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_4 WHERE (YD_NAT1 = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_4)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 10 AS dogninddeling,  YD_NAT2 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_3  ' +char(13)+
			'WHERE (YD_NAT2 = 1) AND (MADVISI_ID IN  (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_3)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 11 AS dogninddeling,  YD_NAT3 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_2  ' +char(13)+
			'WHERE (YD_NAT3 = 1) AND (MADVISI_ID IN (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_2)) AND (HYPPIGHED = 1) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 12 AS dogninddeling,  YD_NAT4 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_1 WHERE (YD_NAT4 = 1) AND (MADVISI_ID IN (SELECT ID	FROM   dbo.MADVISITATION AS MADVISITATION_1)) AND (HYPPIGHED = 1) '  
print len(@cmd)
if @debug = 1 print @cmd
exec (@cmd)			 
			
set @cmd 	='insert into _FACT_MADVISIJOB_Step1 ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 1 AS dogninddeling,  YD_MORGEN AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_12 WHERE (YD_MORGEN = 1) AND (MADVISI_ID IN (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_12))  ' +char(13)+
			'AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 2 AS dogninddeling,  YD_FORMIDDAG AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_11 WHERE (YD_FORMIDDAG = 1) AND (MADVISI_ID IN (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_11))  ' +char(13)+
			'AND (HYPPIGHED = 2) AND (YD_GANGE <> 0)  ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 3 AS dogninddeling,  YD_MIDDAG AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_10  ' +char(13)+
			'WHERE (YD_MIDDAG = 1) AND (MADVISI_ID IN (SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_10)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 4 AS dogninddeling,  YD_EFTERMIDDAG AS MADVISIJOB, 1 as madleverancer   ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_9 WHERE (YD_EFTERMIDDAG = 1) AND (MADVISI_ID IN (SELECT ID  ' +char(13)+
			'FROM   dbo.MADVISITATION AS MADVISITATION_9)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 5 AS dogninddeling,  YD_AFTEN1 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_8 WHERE (YD_AFTEN1 = 1) AND (MADVISI_ID IN  ' +char(13)+
		    '(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_8)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 6 AS dogninddeling,  YD_AFTEN2 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_7 WHERE (YD_AFTEN2 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_7)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL  ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 7 AS dogninddeling,  YD_AFTEN3 AS MADVISIJOB, 1 as madleverancer  ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_6 WHERE (YD_AFTEN3 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_6)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 8 AS dogninddeling,  YD_AFTEN4 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_5 WHERE (YD_AFTEN4 = 1) AND (MADVISI_ID IN  ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_5)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 9 AS dogninddeling,  YD_NAT1 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_4 WHERE (YD_NAT1 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_4)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 10 AS dogninddeling,  YD_NAT2 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_3 WHERE (YD_NAT2 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_3)) AND (HYPPIGHED = 2)  ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 11 AS dogninddeling,  YD_NAT3 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_2 WHERE (YD_NAT3 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_2)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' +char(13)+
			'UNION ALL ' +char(13)+
			'SELECT ID, MADVISI_ID, JOBID, HYPPIGHED, 12 AS dogninddeling,  YD_NAT4 AS MADVISIJOB, 1 as madleverancer ' +char(13)+
			'FROM  dbo.MADVISIJOB AS MADVISIJOB_1	WHERE (YD_NAT4 = 1) AND (MADVISI_ID IN ' +char(13)+
			'(SELECT ID FROM   dbo.MADVISITATION AS MADVISITATION_1)) AND (HYPPIGHED = 2) AND (YD_GANGE <> 0) ' 
print len(@cmd)
if @debug = 1 print @cmd
exec (@cmd)
*/
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactTables_HJ]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Create_FactTables_HJ]
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

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=48)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (48,GETDATE())           
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Fact_Bruger]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Create_Fact_Bruger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

--tilgang
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBruger1'' AND type = ''U'') DROP TABLE dbo.tmp_FactBruger1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.BRUGERID,'+char(13)+ 
           '  MIN(A.OPRETTET) AS OPRETTET,  '+char(13)+ 
           '  CONVERT(DATE,MIN(A.OPRETTET),102) AS PK_DATE,'+char(13)+ 
           '  2 AS BEVAEGID,'+char(13)+ 
           '  99 AS BRUGERSTATUSID '+char(13)+
           'INTO tmp_FactBruger1'+char(13)+ 
           'FROM BRUGER_PASSW_HIST A'+char(13)+
           'JOIN BRUGER B ON A.BRUGERID=B.BRUGERID AND B.SYSTEMBRUGER=0'+char(13)+
           'GROUP BY A.BRUGERID '+char(13)+ 
           'ORDER BY A.BRUGERID'
if @debug = 1 print @cmd
exec (@cmd)  

/* fra UniqOmsorg
-1: Kontoen har ikke været deaktiveret.
 1: Medarbejderen er stoppet
 2: Medarbejderen er på orlov
 3: Administrativ (fejloprettelse)
 4: Gentagne login fejl
 5: Andre årsager
 
Er brugerens konto blevet deaktiveret
0: Nej
1: Ja 
*/ 

--afgang
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBruger2'' AND type = ''U'') DROP TABLE dbo.tmp_FactBruger2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.BRUGERID,'+char(13)+ 
           '  MAX(A.OPRETTET) AS DEAKTIVERET,  '+char(13)+ 
           '  CONVERT(DATE,MAX(A.OPRETTET),102) AS PK_DATE,'+char(13)+ 
           '  3 AS BEVAEGID,'+char(13)+
           '  B.KONTI_DISABLED_AARSAG AS BRUGERSTATUSID'+char(13)+ 
           'INTO tmp_FactBruger2'+char(13)+ 
           'FROM BRUGER_PASSW_HIST A '+char(13)+ 
           'JOIN BRUGER B ON A.BRUGERID=B.BRUGERID AND B.KONTI_DISABLED=1 AND B.SYSTEMBRUGER=0'+char(13)+  
           'GROUP BY A.BRUGERID,B.KONTI_DISABLED_AARSAG '+char(13)+ 
           'ORDER BY A.BRUGERID'
if @debug = 1 print @cmd
exec (@cmd)

--union
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBruger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBruger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  BRUGERID,'+char(13)+ 
           '  OPRETTET AS TABELDATO,  '+char(13)+ 
           '  PK_DATE,'+char(13)+ 
           '  BEVAEGID,'+char(13)+ 
           '  BRUGERSTATUSID'+char(13)+ 
           'INTO '+@DestinationDB+'.DBO.FactBruger'+char(13)+ 
           'FROM tmp_FactBruger1 '+char(13)+ 
           'UNION ALL '+char(13)+  
           'SELECT '+char(13)+
           '  BRUGERID,'+char(13)+ 
           '  DEAKTIVERET AS TABELDATO,  '+char(13)+ 
           '  PK_DATE,'+char(13)+ 
           '  BEVAEGID,'+char(13)+ 
           '  BRUGERSTATUSID'+char(13)+ 
           'FROM tmp_FactBruger2 '+char(13)+
           'UNION ALL '+char(13)+  
           'SELECT DISTINCT '+char(13)+
           '  BRUGERID,'+char(13)+ 
           '  ''2002-01-01'',  '+char(13)+ 
           '  ''2002-01-01'','+char(13)+ 
           '  100,'+char(13)+ 
           '  100'+char(13)+ 
           'FROM BRUGER '+char(13)+
           'WHERE SYSTEMBRUGER=0'
if @debug = 1 print @cmd
exec (@cmd)        

             
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=41)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (41,GETDATE())           
end

END
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Fact_Boliger]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Create_Fact_Boliger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

--------------------------------
-- borgers alder ved indflytning
--------------------------------

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligIndflyt'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligIndflyt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT'+char(13)+
           '  BOLIGSAGHIST.SAGSID,'+char(13)+
           '  MIN(BOLIGSAGHIST.INDFLYTNING) AS PK_DATE'+char(13)+
           'INTO tmp_FactBoligIndflyt'+char(13)+
           'FROM BOLIGSAGHIST '+char(13)+
           'GROUP BY BOLIGSAGHIST.SAGSID '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligIndflyt1'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligIndflyt1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT'+char(13)+
           '  tmp_FactBoligIndflyt.SAGSID,'+char(13)+
           '  BOLIGSAGHIST.BOLIGID,'+char(13)+
           '  tmp_FactBoligIndflyt.PK_DATE'+char(13)+
           'INTO tmp_FactBoligIndflyt1'+char(13)+
           'FROM BOLIGSAGHIST '+char(13)+
           'JOIN tmp_FactBoligIndflyt on BOLIGSAGHIST.SAGSID=tmp_FactBoligIndflyt.SAGSID AND BOLIGSAGHIST.INDFLYTNING=tmp_FactBoligIndflyt.PK_DATE'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBoligIndflyt'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBoligIndflyt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  t_bo.SAGSID,'+char(13)+
           '  t_bo.BOLIGID,'+char(13)+
           'CASE '+char(13)+
           ' WHEN t_bo.PK_DATE<''2002.01.01'' THEN ''2002.01.01'''+char(13)+
           'ELSE t_bo.PK_DATE '+char(13)+
           'END AS PK_DATE, '+char(13)+
           '  dbo.Age(SA.CPRNR,t_bo.PK_DATE) AS BORGERALDER'+CHAR(13)+
           'INTO '+@DestinationDB+'.dbo.FactBoligIndflyt'+char(13)+
           'FROM tmp_FactBoligIndflyt1 t_bo'+char(13)+
           'JOIN SAGER SA ON t_bo.SAGSID=SA.SAGSID '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

--------------------------------
-- fraflytninger
--------------------------------


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''_tmp_fraflyt1'' AND type = ''U'') DROP TABLE dbo._tmp_fraflyt1'
if @debug = 1 print @cmd
exec (@cmd)
-- hent alle hændelser fra boligsaghist og dødsfal på borgere der har boet i visiteret bolig
set @cmd = 'select * into _tmp_fraflyt1 from '+char(13)+ /*borgere flyttet fra almen plejeboliger til ældre/handicap*/ 
			'(select BOLIGER.DRIFTFORM, '+char(13)+
			'   BOLIGSAGHIST.SAGSID, '+char(13)+
            '   CASE WHEN BOLIGSAGHIST.INDFLYTNING<''2002.01.01'' THEN ''2002.01.01'' ELSE BOLIGSAGHIST.INDFLYTNING END AS startdato, '+char(13)+
			'   BOLIGSAGHIST.BOLIGID '+char(13)+
			'from BOLIGSAGHIST  '+char(13)+
			'join BOLIGER on BOLIGSAGHIST.BOLIGID=BOLIGER.ID '+char(13)+
			'where BOLIGSAGHIST.FRAFLYTNING is not null '+char(13)+
			'union all  '+char(13)+ /*døde borgere*/
			'select 99 as driftform,SAGSID,IKRAFTDATO,-1 '+char(13)+
			'from (select SAGSID,CASE WHEN IKRAFTDATO<''2002.01.01'' THEN ''2002.01.01'' ELSE IKRAFTDATO END AS IKRAFTDATO,row_number() over(partition by SAGSID order by IKRAFTDATO asc) as roworder '+char(13)+
			'from SAGSHISTORIK where SAGSHISTORIK.SAGS_STATUSID=6 and exists(select SAGSID from BOLIGSAGHIST where SAGSHISTORIK.SAGSID=BOLIGSAGHIST.SAGSID)) temp '+char(13)+ 
			'where temp.roworder = 1'+char(13)+			
			'union all  '+char(13)+ /*fraflyttede*/
			'select 98 as driftform,SAGSID,IKRAFTDATO,-1 '+char(13)+
			'from (select SAGSID,CASE WHEN IKRAFTDATO<''2002.01.01'' THEN ''2002.01.01'' ELSE IKRAFTDATO END AS IKRAFTDATO,row_number() over(partition by SAGSID order by IKRAFTDATO asc) as roworder '+char(13)+
			'from SAGSHISTORIK where SAGSHISTORIK.SAGS_STATUSID=10 and exists(select SAGSID from BOLIGSAGHIST where SAGSHISTORIK.SAGSID=BOLIGSAGHIST.SAGSID)) temp1 '+char(13)+ 
			''+char(13)+
			'where temp1.roworder = 1'+char(13)+			
			') tmp order by SAGSID,startdato '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
-- lav fact fraflyt
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_Fraflyt'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Fraflyt'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'create table AvaleoAnalytics_DW.dbo.Fact_Fraflyt '+char(13)+
			'(driftform int null, '+char(13)+
			'sagsid int null, '+char(13)+
			'pk_date date not null, '+char(13)+
			'fraflytid int not null, '+char(13)+
			'boligid int null) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--gennemse _tmp_fraflyt1 og find borgere der flyttet til plejebolig eller er døde
SET NOCOUNT ON; 

DECLARE @sagsid integer
DECLARE @driftform integer
DECLARE @pk_date date
DECLARE @old_sagsid integer
DECLARE @old_driftform integer
DECLARE @boligid integer
DECLARE @old_boligid integer
DECLARE @fraflytid integer

DECLARE FindFraflyt CURSOR FAST_FORWARD FOR
SELECT DRIFTFORM,SAGSID,startdato,boligid FROM _tmp_fraflyt1  

set @old_sagsid=0
set @fraflytid=0
set @old_driftform=0

OPEN FindFraflyt
FETCH NEXT FROM FindFraflyt
INTO @driftform,@sagsid,@pk_date,@boligid

WHILE @@fetch_status = 0
BEGIN    
  if (@sagsid=@old_sagsid)
  begin
    if ((@old_driftform in (4,8)) and (@driftform in (1,2,3,98,99)))
    begin
      if (@driftform=99)
      begin
        set @fraflytid=99
      end
      else if (@driftform=98)
      begin
        set @fraflytid=98
      end
      else 
        set @fraflytid=2
      insert into AvaleoAnalytics_DW.dbo.Fact_Fraflyt select @driftform as driftform,@sagsid as sagsid,@pk_date as pk_date,@fraflytid as fraflytid,@old_boligid as boligid 
    end
    else if ((@old_driftform in (4,8)) and (@driftform in (4,8)) and (@old_boligid<>@boligid))
    begin
      set @fraflytid=3
      insert into AvaleoAnalytics_DW.dbo.Fact_Fraflyt select @driftform as driftform,@sagsid as sagsid,@pk_date as pk_date,@fraflytid as fraflytid,@old_boligid as boligid 
    end
  end
     
  set @old_sagsid=@sagsid
  set @old_boligid=@boligid
  set @old_driftform=@driftform
  
  FETCH NEXT FROM FindFraflyt 
  INTO @driftform,@sagsid,@pk_date,@boligid

END
 
CLOSE FindFraflyt
DEALLOCATE FindFraflyt
-------------------------
--beboede boliger
-------------------------
set @cmd='IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_Bolig_Beboet'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Bolig_Beboet'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd='create table '+@DestinationDB+'.DBO.Fact_Bolig_Beboet ( '+char(13)+
			'ledig int null, '+char(13)+
			'beboet int null, '+char(13)+
			'pk_date date not null, '+char(13)+
			'boligid int not null, '+char(13)+
			'sagsid int null, '+char(13)+
			'cprnr varchar(10) null, '+char(13)+
			'aldergrp int null, '+char(13)+
			'kvinde int null, '+char(13)+
			'mand int null, '+char(13)+
			'BEBOET_DIST bigint null) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd='insert into '+@DestinationDB+'.dbo.fact_bolig_beboet '+char(13)+ 
			'select  '+char(13)+
			'  null as LEDIG, '+char(13)+
			'  1 as BEBOET, '+char(13)+
			'  Dim_Time.PK_Date, '+char(13)+
			'  BOLIGSAGHIST.BOLIGID, '+char(13)+
			'  BOLIGSAGHIST.SAGSID, '+char(13)+
			'  SAGER.CPRNR, '+char(13)+
			'  dbo.Age(SAGER.CPRNR,PK_Date) as ALDERGRP, '+char(13)+
			'  CASE when convert(int,RIGHT(SAGER.CPRNR,1))%2 = 0 then CONVERT(int,1) end as KVINDE,   '+char(13)+
			'  CASE when convert(int,RIGHT(SAGER.CPRNR,1))%2 <> 0 then CONVERT(int,1) end as MAND, '+char(13)+
			'  CONVERT(bigint, convert(varchar(3),datepart(DAYofyear,PK_Date))+convert(varchar(4),year(PK_Date))+CONVERT(varchar(20),BOLIGSAGHIST.BOLIGID) ) AS BEBOET_DIST '+char(13)+
			'from BOLIGSAGHIST '+char(13)+
			'join Dim_Time on Dim_Time.PK_Date>=BOLIGSAGHIST.indflytning and  Dim_Time.PK_Date<=COALESCE(BOLIGSAGHIST.KLAR_DATO,GETDATE()) '+char(13)+
			'join SAGER on SAGER.SAGSID=BOLIGSAGHIST.SAGSID '+char(13)+
			'where PK_Date>=boligsaghist.indflytning AND PK_Date<=GETDATE() '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--opdater fra alder til aldersgruppe
set @cmd='UPDATE '+@DestinationDB+'.dbo.Fact_Bolig_Beboet set '+@DestinationDB+'.dbo.Fact_Bolig_Beboet.ALDERGRP = '+char(13)+
			'CASE '+char(13)+   
			'  when ALDERGRP<20 then 1 '+char(13)+
			'  when ALDERGRP between 20 and 29 then 2 '+char(13)+
			'  when ALDERGRP between 30 and 39 then 3 '+char(13)+
			'  when ALDERGRP between 40 and 59 then 4 '+char(13)+
			'  when ALDERGRP between 60 and 64 then 5 '+char(13)+
			'  when ALDERGRP between 65 and 66 then 6  '+char(13)+
			'  when ALDERGRP between 67 and 74 then 7 '+char(13)+
			'  when ALDERGRP between 75 and 79 then 8 '+char(13)+
			'  when ALDERGRP between 80 and 84 then 9  '+char(13)+
			'  when ALDERGRP between 85 and 89 then 10 '+char(13)+
			'else 11  '+char(13)+
			'end '+char(13)  
if @debug = 1 print @cmd
exec (@cmd)
---------------------
--ledige boliger
---------------------
set @cmd='insert into '+@DestinationDB+'.dbo.fact_bolig_beboet '+char(13)+ 
			'select distinct  '+char(13)+
			'  1 as ledig,  '+char(13)+
			'  convert(int,null) as beboet,  '+char(13)+
			'  pk_date, '+char(13)+
			'  BOLIGID, '+char(13)+
			'  CONVERT(int,(select top 1 sagsid from '+@DestinationDB+'.dbo.DimSager where CprNr is null)) as sagsid, '+char(13)+
			'  CONVERT(varchar(10),null) as cprnr, '+char(13)+
 			'  CONVERT(int,0) as aldergrp, '+char(13)+
  			'  CONVERT(int,null) as mand, '+char(13)+
  			'  CONVERT(int,null) as kvinde, '+char(13)+
  			'  CONVERT(bigint,null) as beboet_dist  '+char(13)+
			'from BOLIGSAGHIST, Dim_Time '+char(13)+
			'where PK_Date between ''2002.01.01'' and GETDATE()  '+char(13)+
			'and BOLIGSAGHIST.FRAFLYTNING is not null  '+char(13)+
			'and pk_date>(select min(pk_date) from '+@DestinationDB+'.dbo.Fact_Bolig_Beboet where '+@DestinationDB+'.dbo.Fact_Bolig_Beboet.boligid=BOLIGSAGHIST.BOLIGID) '+char(13)+
			'and not exists(select * from '+@DestinationDB+'.dbo.Fact_Bolig_Beboet where (('+@DestinationDB+'.dbo.Fact_Bolig_Beboet.BOLIGID=BOLIGSAGHIST.BOLIGID) and  '+char(13)+
   			'('+@DestinationDB+'.dbo.Fact_Bolig_Beboet.PK_Date=Dim_Time.PK_Date)))   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
-----------------
--boligventeliste
-----------------
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste'
if @debug = 1 print @cmd
exec (@cmd)
--find tidligste tilbudsdato
set @cmd = 'SELECT '+char(13)+
           '  BT.BORGERID,'+char(13)+
           '  BT.BOLIGVISI_ID,'+char(13)+
           '  MIN(BT.TILBUD_DATO) AS TILBUD_DATO'+char(13)+
           'INTO tmp_Boligventeliste'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN BOLIGVISITATION BV ON BT.BORGERID=BV.SAGSID AND BT.BOLIGVISI_ID=BV.ID'+char(13)+
           'GROUP BY BT.BOLIGVISI_ID,BT.BORGERID'+char(13)+
           'ORDER BY BT.BOLIGVISI_ID'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste1'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste1'
if @debug = 1 print @cmd
exec (@cmd)
--indsæt resten af data
set @cmd = 'SELECT '+char(13)+
           '  BT.ID,'+char(13)+
           '  BT.BOLIGID,'+char(13)+
           '  BT.BORGERID AS SAGSID,'+char(13)+
           '  BT.TILBUD_DATO,'+char(13)+
           '  BT.UDLOB_DATO,'+char(13)+
           '  BT.AFVIST_DATO,'+char(13)+
           '  BT.FRA_GARANTI_LISTE,'+char(13)+
           '  BT.BOLIGVISI_ID'+char(13)+
           'INTO tmp_Boligventeliste1'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN tmp_Boligventeliste A ON A.BORGERID=BT.BORGERID AND A.BOLIGVISI_ID=BT.BOLIGVISI_ID AND A.TILBUD_DATO=BT.TILBUD_DATO '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste2'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  COALESCE(BT.TILBUD_DATO,BV.INDFLYTNING,GETDATE()) AS PK_DATE,'+char(13)+
           '  BV.SAGSID,'+char(13)+
           '  BV.ID,'+char(13)+
           '  BT.BOLIGID,'+char(13)+
           '  BV.IKRAFTDATO,'+char(13)+
           '  BT.TILBUD_DATO,'+char(13)+
           '  DATEDIFF(DD,BV.IKRAFTDATO,COALESCE(BT.TILBUD_DATO,BV.INDFLYTNING,GETDATE())) AS VENTETID_DAGE,'+char(13)+
           '  BV.DRIFTFORM,'+char(13)+ 
           '  BV.PLADSTYPE,'+char(13)+ 
           '  CAST(BV.DRIFTFORM AS NVARCHAR(1))+CAST(BV.PLADSTYPE AS NVARCHAR(1)) AS DFPTID,'+char(13)+         
           '  BT.FRA_GARANTI_LISTE,'+char(13)+
           '  BV.FRITVALGSVENTELISTE,'+char(13)+
           '  CASE '+char(13)+ 
           '    WHEN ((BT.FRA_GARANTI_LISTE=1) AND (BV.FRITVALGSVENTELISTE=1)) THEN 1'+char(13)+ --afslået tilbud - flyttet til fritvalg
           '    WHEN BV.FRITVALGSVENTELISTE=0 THEN 2'+char(13)+                          --garantiventeliste    
           '    WHEN BV.FRITVALGSVENTELISTE=1 THEN 3'+char(13)+                          --fritvaglsliste
           '  ELSE 9999 '+char(13)+ 
           '  END AS VENTELISTETYPEID,'+char(13)+             
           '  1 AS ANTAL_BORGERE'+char(13)+
           'INTO dbo.tmp_Boligventeliste2'+char(13)+           
           'FROM BOLIGVISITATION BV'+char(13)+
           'JOIN tmp_Boligventeliste1 BT ON BV.ID=BT.BOLIGVISI_ID '+char(13)+
           'ORDER BY BV.SAGSID '+char(13)        
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_Boligventeliste'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Boligventeliste'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_Boligventeliste '+char(13)+
           'FROM tmp_Boligventeliste2 WHERE DRIFTFORM>0 AND PLADSTYPE>0 '  
if @debug = 1 print @cmd
exec (@cmd) 

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=72)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (72,GETDATE())           
--end
 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dimensions]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Create_Dimensions]
					  @DestinationDB as  varchar(200)
AS
--DECLARE @DestinationDB as varchar(200)
DECLARE @cmd as varchar(max)
DECLARE @debug as bit
set @debug = 1
declare @defaultKommune as varchar(50)

set @defaultKommune = (select * from openquery(Omsorg, 'SELECT NAVN FROM REFUSIONSKOMMUNE 
                                                        JOIN OPSATNING ON OPSATNING.KOMMUNENR=REFUSIONSKOMMUNE.KOMMUNEKODE AND 
                                                          OPSATNING.ID=1'))

--lav dimSager
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSager' AND type = 'U') DROP TABLE DimSager

SELECT DISTINCT 
           derivedtbl_1.SAGSID as SagsId,
           SAGER.SAGSTYPE as SagsType,
           SAGER.CPRNR as CprNr, 
           fornavn + ' '+ Efternavn as Navn, 
           SAGER.ADRESSE as Adresse, 
           SAGER.POSTNR as PostNr, 
           COALESCE (SUBSTRING(SAGER.CPRNR, 5, 2), '99999') 
           AS Aargang, 
           CASE SAGER.CIVILSTAND 
           when 1 then 'Gift' 
           when 2 then 'Ugift' 
           when 3 then 'Enke/-mand' 
           when 4 then 'Samboende' 
           when 5 then 'Fraskilt' 
           when 6 then 'Mors' 
           else '9999' end as Civilstand, 
           CASE (RIGHT(sager.CPRNR, 1) % 2) 
           WHEN 1 THEN 'MAND' 
           WHEN 0 THEN 'KVINDE' 
           ELSE '99' END AS Kon,
           CASE SAGER.PLEJEKATEGORI 
           when 1 then 'SommerGæst' 
           when 5 then 'Refusion Modtage' 
           when 3 then 'Refusion Give' 
           else 'Uden Refusion' 
           end AS RefusionStatus,
           REFUSIONSKOMMUNE,
           COALESCE((SELECT NAVN FROM REFUSIONSKOMMUNE WHERE ID=SAGER.REFUSIONSKOMMUNE),@defaultKommune) AS RefusionskommuneNavn,
           COALESCE((SELECT BESKRIVELSE FROM PLEJEKATEGORI WHERE ID=SAGER.PLEJEKATEGORI),'Ingen') AS PlejeKategori,
           COALESCE((SELECT TOP 1 LAEGER.FORNAVN+' '+LAEGER.EFTERNAVN+' '+LAEGER.TELEFON 
                     FROM BORLAGEREL
                     JOIN LAEGER ON BORLAGEREL.LAEGEID=LAEGER.LAEGEID
                     WHERE BORLAGEREL.SAGSID=SAGER.SAGSID AND LAEGER.LAGETYPE=0 AND
                     LAEGER.LAGETYPEID=1),'Ukendt læge') AS LAEGENAVNTELEFON --lægetype 0 og lægetypeid 1=praktiserende læge
          into DimSager
		  FROM  (SELECT DISTINCT SAGSID
               FROM HJVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  SPVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  MADVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  TPVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  BOLIGVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  BOLIGSAGHIST
				union all
				select distinct sagsid 
			from sager where hjp_ansvarlig_forebygger is not null
			union all
		    select distinct sagsid from dbo.SAGSPLANRET
		    union all
		    select distinct sagsid from dbo.SAGSPLAN
				) AS derivedtbl_1 LEFT OUTER JOIN
               SAGER ON derivedtbl_1.SAGSID = SAGER.SAGSID
ORDER BY derivedtbl_1.SAGSID


--if @debug = 1 print @cmd
--exec (@cmd)
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSager'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSager'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Select * into '+@DestinationDB+'.dbo.DimSager from DimSager'
if @debug = 1 print @cmd
exec (@cmd)

--2. Lav DimOrganisation
-----------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimOrganisation'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimOrganisation'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT ' +char(13)+ 
           '  dbo.UAFDELINGER.UAFDELINGID,  ' +char(13)+
           '  dbo.UAFDELINGER.UAFDELINGNAVN, ' +char(13)+
           '  CASE dbo.UAFDELINGER.AKTIV ' +char(13)+
           '    WHEN 0 THEN ''Inaktiv'' ' +char(13)+
           '    WHEN 1 THEN ''Aktiv''' +char(13)+
           '  END AS ORGSTATUS, ' +char(13)+ 
		   '  dbo.AFDELINGER.AFDELINGID, ' +char(13)+
		   '  dbo.AFDELINGER.AFDELINGNAVN, ' +char(13)+
           '  dbo.ORGANISATIONER.ORGANISATIONID, ' +char(13)+
           '  dbo.ORGANISATIONER.ORGANISATIONNAVN, ' +char(13)+
		   '  1 AS OmraedeID ' +char(13)+
		   'into '+@DestinationDB+'.dbo.DimOrganisation' +char(13)+
		   'FROM  dbo.ORGANISATIONER INNER JOIN ' +char(13)+
			'			   dbo.AFDELINGER ON dbo.ORGANISATIONER.ORGANISATIONID = dbo.AFDELINGER.ORGANISATIONID INNER JOIN ' +char(13)+
			'			   dbo.UAFDELINGER ON dbo.AFDELINGER.AFDELINGID = dbo.UAFDELINGER.AFDELINGID ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'ALTER TABLE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'ADD OmraedeNavn  nvarchar(50)'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET OmraedeNavn = ' +char(13)+
           '(SELECT OmraedeNavn ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.LINK_OmraedeNavne ' +char(13)+
           'WHERE ('+@DestinationDB+'.dbo.DimOrganisation.OmraedeID = OmraedeID))'

if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET OmraedeNavn = OmraedeId ' +char(13)+
		   'WHERE (OmraedeId NOT IN ' +char(13)+
           '(SELECT OmraedeId FROM '+@DestinationDB+'.dbo.LINK_OmraedeNavne))'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'ALTER TABLE '+@DestinationDB+'.dbo.DimOrganisation' +char(13)+
		   'ADD Distrikt nvarchar(50)'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET Distrikt = LEFT(AFDELINGNAVN, 2)' +char(13)+
		   'WHERE (LEFT(AFDELINGNAVN, 2) in (''ND'',''NC'',''NR'',''SD'',''SC'',''SR'',''VD'',''VC'',''VR'', ''ØD'', ''ØC'') )'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET Distrikt = LEFT(AFDELINGNAVN, 1)' +char(13)+
		   'WHERE (LEFT(AFDELINGNAVN, 2) not in (''ND'',''NC'',''NR'',''SD'',''SC'',''SR'',''VD'',''VC'',''VR'', ''ØD'', ''ØC'') )'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',9999,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''8888'',''8888'',''8888'',''8888'',''8888'',''8888'',8888,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''7777'',''Madvisitation'',''7777'',''Madvisitation'',''7777'',''Madvisitation'',7777,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''5555'',''Mangler dag, aften eller nat gruppe'',''5555'',''Mangler dag, aften eller nat gruppe'',''5555'',''Mangler dag, aften eller nat gruppe'',5555,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)




--3.lav DimSagsstatus
----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'Sagaktiv' AND type = 'U') DROP TABLE Sagaktiv

CREATE TABLE [dbo].Sagaktiv(
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

INSERT sagaktiv(Id,Description) VALUES('1','Aktiv')
INSERT Sagaktiv(Id,Description) VALUES('2','Midlertidig inaktiv')
INSERT sagaktiv(Id,Description) VALUES('0','Inaktiv')
INSERT sagaktiv(Id,Description) VALUES('9999','Ej specificeret')


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSagsstatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSagsstatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT dbo.SAGSSTATUS.SAGSSTATUSID as SagsstatusID, dbo.SAGSSTATUS.STATUSNAVN as StatusNavn, dbo.SAGSSTATUS.SAGSTYPE as SagsType, dbo.SAGSTYPE.SAGSTYPENAVN as SagsTypeNavn, ' +char(13)+
           'dbo.SAGSSTATUS.SAGAKTIV SagsAktiv, '+DB_NAME()+'.dbo.SAGAKTIV.Description AS SagAktivNavn ' +char(13)+
		   'into '+@DestinationDB+'.dbo.DimSagsstatus ' +char(13)+
		   'FROM  '+DB_NAME()+'.dbo.SAGAKTIV INNER JOIN ' +char(13)+
           'dbo.SAGSSTATUS ON '+DB_NAME()+'.dbo.SAGAKTIV.ID = dbo.SAGSSTATUS.SAGAKTIV INNER JOIN ' +char(13)+
           'dbo.SAGSTYPE ON dbo.SAGSSTATUS.SAGSTYPE = dbo.SAGSTYPE.SAGSTYPEID '

if @debug = 1 print @cmd
exec (@cmd)

--4.Fact_borger
----------------------------------------------------------------------------------------------------
-- Borger historik ###

set @cmd = 'EXEC DBO.usp_LavBorgerHistorik'
if @debug = 1 print @cmd
exec (@cmd)

--###

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_BorgerÅrstal' AND type = 'U') DROP TABLE _BorgerÅrstal
SELECT     SAGSID as SagsId, CPRNR as CprNr, CASE WHEN (substring(cprnr, 7, 1)) < 4 THEN 19 WHEN (substring(cprnr, 7, 1)) > 4 AND (substring(cprnr, 5, 2)) 
                      < 37 THEN 20 WHEN (substring(cprnr, 7, 1)) = 4 AND (substring(cprnr, 5, 2)) > 36 THEN 19 WHEN (substring(cprnr, 7, 1)) = 9 AND (substring(cprnr, 5, 2)) 
                      > 36 THEN 19 WHEN (substring(cprnr, 7, 1)) > 4 AND (substring(cprnr, 7, 1)) < 8 AND (substring(cprnr, 5, 2)) < 37 THEN 20 WHEN (substring(cprnr, 7, 1)) 
                      > 4 AND (substring(cprnr, 7, 1)) < 8 AND (substring(cprnr, 5, 2)) > 36 THEN 18 END AS År
into _BorgerÅrstal
FROM         dbo.DimSager


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'linkFactBorger' AND type = 'U') DROP TABLE linkFactBorger
SELECT     SagsId , CprNr, LEFT(CPRNR, 2) AS day, SUBSTRING(CPRNR, 3, 2) AS month, SUBSTRING(CPRNR, 5, 2) AS year, CAST(LOWER(år) 
                      + SUBSTRING(CPRNR, 5, 2) + '-' + SUBSTRING(CPRNR, 3, 2) + '-' + LEFT(CPRNR, 2) AS datetime) AS Foedselsdag, LEFT(CPRNR, 2) 
                      + '-' + SUBSTRING(CPRNR, 3, 2) AS JoinFactor
into linkFactBorger
FROM         _BorgerÅrstal
WHERE     (LEFT(CPRNR, 2) IN (01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)) AND 
                      (SUBSTRING(CPRNR, 3, 2) IN (01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12))

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1a' AND type = 'U') DROP TABLE FactBorgerStep1a

SELECT dbo.linkFactBorger.SagsId, dbo.Link_Time.PK_Date as PKDate, dbo.linkFactBorger.Foedselsdag, CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float) AS AlderDage, (CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 AS AlderAar, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365) AS AlderAarAfrund, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) AS AlderGruppe, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) * 5 AS AlderGruppeStart, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) * 5 + 5 AS AlderGruppeSlut, 2 AS Specifikation, 1 AS Borger
into FactBorgerStep1a
FROM  dbo.Link_Time INNER JOIN
               dbo.linkFactBorger ON dbo.Link_Time.JoinFactor = dbo.linkFactBorger.JoinFactor
WHERE (CAST(dbo.Link_Time.PK_Date AS float) - CAST(dbo.linkFactBorger.Foedselsdag AS float) >= 0)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1b' AND type = 'U') DROP TABLE FactBorgerStep1b

SELECT SagsId, DATEPART(day, PKDate) AS Dag, DATEPART(month, PKDate) AS Md, 
	   DATEPART(year, PKDate) AS Aar, Foedselsdag, AlderDage, AlderAar, 
       AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut, Specifikation, Borger
	   into FactBorgerStep1b
FROM  dbo.FactBorgerStep1a

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1c' AND type = 'U') DROP TABLE FactBorgerStep1c

SELECT SAGSID, DATEADD(year, 1, CONVERT(datetime, CONVERT(nvarchar, dag) + '-' + CONVERT(nvarchar, md) + '-' + CONVERT(nvarchar, aar), 105)) AS PKDate, 
               Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut, 3 AS Specifikation, 
               - 1 AS Borger
into FactBorgerStep1c
FROM  dbo.FactBorgerStep1b

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBorger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBorger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT SAGSID, PKDate, Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut,Specifikation, Borger ' +char(13)+	
			'into '+@DestinationDB+'.dbo.FactBorger ' +char(13)+	
			'FROM  dbo.FactBorgerStep1a ' +char(13)+	
			'UNION ALL ' +char(13)+	
			'SELECT SAGSID, PKDate, Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut,Specifikation, Borger ' 	+char(13)+
			'FROM  dbo.FactBorgerStep1c '
if @debug = 1 print @cmd
exec (@cmd)


--5.aldersopdeling
----------------------------------------------------------------------------------------------------

DECLARE  @i as int 
CREATE TABLE #TempAlder (aar int)
SET @i=0
WHILE @i < 300
BEGIN
  INSERT INTO #TempAlder VALUES (@i)
  SET @i=@i+1
END

set @cmd = ' TRUNCATE table '+@DestinationDB+'.dbo.DimAldersopdeling'+char(13)+
           ' INSERT INTO    '+@DestinationDB+'.dbo.DimAldersopdeling ' + char(13) +
           ' SELECT aar [AlderAar]' + char(13) +
           ' ,FLOOR(aar/5)+1 [AldersGruppe]' + char(13) +
           ' ,aar -(aar % 5 )   [AldersGruppeStart]' + char(13) +
           ' ,aar + (5-(aar % 5 ))   [AldersGruppeSlut]' + char(13) +
           ' ,CAST(aar -(aar % 5 ) AS NVARCHAR(10)) + ''-'' + CAST(aar + (5-(aar % 5 )-1) AS NVARCHAR(10))  AS [AldersGruppeNavn]' + char(13) +
           ' ,CASE ' + char(13) +
           '   WHEN aar<65 THEN ''0-64'' ' + char(13) +
           '   ELSE ''65+'' ' + char(13) +
           ' END AS Pensionist, ' + char(13) +
           ' CASE ' + char(13) +
           '   WHEN aar<67 THEN ''0-67'' ' + char(13) +
           '   ELSE ''67+'' ' + char(13) +
           ' END AS YngreÆldre67 ' + char(13) +           
           ' FROM #TempAlder' + char(13) +
           ' UNION ALL' + char(13) +
           ' SELECT 9999,9999,9999,9999,''9999'',''9999'',''9999'' ' + char(13) 
exec (@cmd)

DROP TABLE #TempAlder 


--6.DimDognInddeling
---------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimDognInddeling'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimDognInddeling'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimDognInddeling' AND type = 'U') DROP TABLE DimDognInddeling

set @cmd = 'CREATE TABLE [dbo].[DimDognInddeling]( ' +char(13)+
		   '[Id] [int] NULL, ' +char(13)+
		   '[Description] [nvarchar](50) NULL ,' +char(13)+
  '[Døgninddeling] [nvarchar](50) NULL ,' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('0','0','Ukendt')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('1','Morgen','Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('3','Middag','Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('4','Eftermiddag', 'Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('5','Aften 1', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('6','Aften 2','Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('7','Aften 3', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('8','Aften 4', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('9','Nat 1', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('10','Nat 2', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('11','Nat 3', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('12','Nat 4', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('2','Formiddag', 'Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('9999','9999', 'Ukendt')

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimDognInddeling from DimDognInddeling'	  
if @debug = 1 print @cmd
exec (@cmd)

--7.DimSpecifikation
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSpecifikation'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSpecifikation'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSpecifikation' AND type = 'U') DROP TABLE DimSpecifikation

set @cmd = 'CREATE TABLE [dbo].[DimSpecifikation]( ' +char(13)+
		   '[Id] [int] NULL, ' +char(13)+
		   '[Description] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

INSERT DimSpecifikation(ID,Description) VALUES('1','Primo')
INSERT DimSpecifikation(ID,Description) VALUES('2','Tilgang')
INSERT DimSpecifikation(ID,Description) VALUES('3','Afgang')
INSERT DimSpecifikation(ID,Description) VALUES('4','Sagsplan')
INSERT DimSpecifikation(ID,Description) VALUES('5','Perioden')
INSERT DimSpecifikation(ID,Description) VALUES('9999','Ukendt')
INSERT DimSpecifikation(ID,Description) VALUES('7','Afgang Aldersgruppe')
INSERT DimSpecifikation(ID,Description) VALUES('6','Tilgang Aldersgruppe')
INSERT DimSpecifikation(ID,Description) VALUES('8','Sagsplan korrektion afgang')
INSERT DimSpecifikation(ID,Description) VALUES('9','Ukendt')


set @cmd = 'select * into '+@DestinationDB+'.dbo.DimSpecifikation from DimSpecifikation'	  
if @debug = 1 print @cmd
exec (@cmd)


--8.Dim_pakketyper
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyperJob'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperJob'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimPakkeTyperJob from Dim_JobTyper'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimPakkeTyperJob' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,PLEJETYPE,FALLES_SPROG_ART,PARAGRAF) ' +char(13) +
			'VALUES(''999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyperKatNavne'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select Jobnavn as KatNavn, KATEGORI as Kategori, FALLES_SPROG_ART as Falles_Sprog_Art into '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne from JOBTYPER where niveau1 = 0 and niveau2 = 0 and niveau3 = 0'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne ' +char(13) +
			'(KatNavn,Kategori,FALLES_SPROG_ART) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Delete from '+@DestinationDB+'.dbo.DimPakkeTyperJob where niveau1 = 0 and niveau2 = 0 and niveau3 = 0'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyper1'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyper1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.JOBID, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.JOBNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.KATEGORI, ' +char(13) +
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU2, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU3, ' +char(13) +
             '         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SLETTET_JOB, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SKRIVEBESKYTTET, ' +char(13) +
              '        '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_KAT_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV1_KODE, ' +char(13) +
               '       '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV2_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV3_KODE, ' +char(13) +
                '      '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SIDSTE_VITALE_AENDRING, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.PLEJETYPE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID2, ' +char(13) +
                 '     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID3, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FUNKKAT, ' +char(13) +
                  '    '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID3, ' +char(13) +
           '           '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_ART, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.PARAGRAF, ' +char(13) +
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.BTP, ' +char(13) +
           '           '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.KATNAVN, ''Fællessprog I'' AS FALLES_SPROG_NAVN, ''AKTIV'' AS Slettet_job_navn' +char(13) +
'Into '+@DestinationDB+'.dbo.DimPakkeTyper1 ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB INNER JOIN ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne ON '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.KATEGORI = '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.KATEGORI AND ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_ART = '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.FALLES_SPROG_ART   ' +char(13) +
'WHERE     ('+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.FALLES_SPROG_ART = 1) AND ('+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SLETTET_JOB = 0) ' +char(13) +
'UNION ALL  ' +char(13) +
'SELECT     DIMPAKKETYPERJOB3.JOBID, DIMPAKKETYPERJOB3.JOBNAVN, DIMPAKKETYPERJOB3.KATEGORI, DIMPAKKETYPERJOB3.NIVEAU1, ' +char(13) +
'                      DIMPAKKETYPERJOB3.NIVEAU2, DIMPAKKETYPERJOB3.NIVEAU3,' +char(13) +
 '                     DIMPAKKETYPERJOB3.SLETTET_JOB, DIMPAKKETYPERJOB3.SKRIVEBESKYTTET, DIMPAKKETYPERJOB3.FALLES_SPROG_KAT_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB3.FALLES_SPROG_NIV2_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB3.SIDSTE_VITALE_AENDRING, ' +char(13) +
   '                   DIMPAKKETYPERJOB3.PLEJETYPE, DIMPAKKETYPERJOB3.NORMTID2, DIMPAKKETYPERJOB3.NORMTID3, ' +char(13) +
    '                  DIMPAKKETYPERJOB3.NORMTID4, DIMPAKKETYPERJOB3.FUNKKAT,' +char(13) +
   '                   DIMPAKKETYPERJOB3.MAXTID2, DIMPAKKETYPERJOB3.MAXTID3, DIMPAKKETYPERJOB3.MAXTID4, ' +char(13) +
   '                   DIMPAKKETYPERJOB3.FALLES_SPROG_ART, DIMPAKKETYPERJOB3.PARAGRAF, DIMPAKKETYPERJOB3.NORMTID1, ' +char(13) +
    '                  DIMPAKKETYPERJOB3.MAXTID1, DIMPAKKETYPERJOB3.BTP, DIMPAKKETYPERKatNavne3.KATNAVN, ' +char(13) +
   '                   ''Fællessprog I'' AS FALLESSPROG_NAVN, ''SKJULT'' AS Slettet_job_navn ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB3 INNER JOIN  ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne3 ON   ' +char(13) +
 '                     DIMPAKKETYPERJOB3.KATEGORI = DIMPAKKETYPERKatNavne3.KATEGORI AND ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne3.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne3.FALLES_SPROG_ART = 1) AND (DIMPAKKETYPERJOB3.SLETTET_JOB = 1)   ' +char(13) +
'UNION ALL   ' +char(13) +
'SELECT     DIMPAKKETYPERJOB2.JOBID, DIMPAKKETYPERJOB2.JOBNAVN, DIMPAKKETYPERJOB2.KATEGORI, DIMPAKKETYPERJOB2.NIVEAU1, ' +char(13) +
 '                     DIMPAKKETYPERJOB2.NIVEAU2, DIMPAKKETYPERJOB2.NIVEAU3,' +char(13) +
  '                    DIMPAKKETYPERJOB2.SLETTET_JOB, DIMPAKKETYPERJOB2.SKRIVEBESKYTTET, DIMPAKKETYPERJOB2.FALLES_SPROG_KAT_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB2.FALLES_SPROG_NIV2_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB2.SIDSTE_VITALE_AENDRING, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.PLEJETYPE, DIMPAKKETYPERJOB2.NORMTID2, DIMPAKKETYPERJOB2.NORMTID3, ' +char(13) +
 '                     DIMPAKKETYPERJOB2.NORMTID4, DIMPAKKETYPERJOB2.FUNKKAT,' +char(13) +
  '                    DIMPAKKETYPERJOB2.MAXTID2, DIMPAKKETYPERJOB2.MAXTID3, DIMPAKKETYPERJOB2.MAXTID4, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_ART, DIMPAKKETYPERJOB2.PARAGRAF, DIMPAKKETYPERJOB2.NORMTID1, ' +char(13) +
   '                   DIMPAKKETYPERJOB2.MAXTID1, DIMPAKKETYPERJOB2.BTP, DIMPAKKETYPERKatNavne2.KATNAVN, ' +char(13) +
   '                  ''Fællessprog II'' AS FALLESSPROG_NAVN, ''AKTIV'' AS Slettet_job_navn  ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB2 INNER JOIN   ' +char(13) +
'                      '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne2 ON ' +char(13) +
'                      DIMPAKKETYPERJOB2.KATEGORI = DIMPAKKETYPERKatNavne2.KATEGORI AND ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne2.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne2.FALLES_SPROG_ART = 2) AND (DIMPAKKETYPERJOB2.SLETTET_JOB = 0)  ' +char(13) +
'UNION ALL   ' +char(13) +
'SELECT     DIMPAKKETYPERJOB1.JOBID, DIMPAKKETYPERJOB1.JOBNAVN, DIMPAKKETYPERJOB1.KATEGORI, DIMPAKKETYPERJOB1.NIVEAU1, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.NIVEAU2, DIMPAKKETYPERJOB1.NIVEAU3,' +char(13) +
 '                     DIMPAKKETYPERJOB1.SLETTET_JOB, DIMPAKKETYPERJOB1.SKRIVEBESKYTTET, DIMPAKKETYPERJOB1.FALLES_SPROG_KAT_KODE,   ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB1.FALLES_SPROG_NIV2_KODE, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB1.SIDSTE_VITALE_AENDRING, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.PLEJETYPE, DIMPAKKETYPERJOB1.NORMTID2, DIMPAKKETYPERJOB1.NORMTID3, ' +char(13) +
  '                    DIMPAKKETYPERJOB1.NORMTID4, DIMPAKKETYPERJOB1.FUNKKAT,' +char(13) +
  '                    DIMPAKKETYPERJOB1.MAXTID2, DIMPAKKETYPERJOB1.MAXTID3, DIMPAKKETYPERJOB1.MAXTID4, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_ART, DIMPAKKETYPERJOB1.PARAGRAF, DIMPAKKETYPERJOB1.NORMTID1, ' +char(13) +
  '                    DIMPAKKETYPERJOB1.MAXTID1, DIMPAKKETYPERJOB1.BTP, DIMPAKKETYPERKatNavne1.KATNAVN, ' +char(13) +
   '                   ''Fællessprog II'' AS FALLES_SPROG_NAVN, ''SKJULT'' AS Slettet_job_navn   ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB1 INNER JOIN   ' +char(13) +
  '                    '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne1 ON   ' +char(13) +
 '                     DIMPAKKETYPERJOB1.KATEGORI = DIMPAKKETYPERKatNavne1.KATEGORI AND ' +char(13) +
    '                  DIMPAKKETYPERJOB1.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne1.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne1.FALLES_SPROG_ART = 2) AND (DIMPAKKETYPERJOB1.SLETTET_JOB = 1)   ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_DimPakkeTyper'' AND type = ''U'') DROP TABLE dbo.tmp_DimPakkeTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     '+@DestinationDB+'.dbo.DIMPAKKETYPER1.JOBID, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.JOBNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATEGORI, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU1, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU3,' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SLETTET_JOB, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SKRIVEBESKYTTET, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_KAT_KODE, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV1_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV2_KODE, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV3_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SIDSTE_VITALE_AENDRING, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.PLEJETYPE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID3, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FUNKKAT,' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID3, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID4, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_ART, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.PARAGRAF, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID1, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATNAVN, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.Slettet_job_navn, CONVERT(nvarchar, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_KAT_KODE) + CONVERT(nvarchar, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATEGORI) AS Kat_nogle, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.ATAIBT, '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPKATEGORI, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPKATNAVN  ' +char(13)+
            ' into dbo.tmp_DimPakkeTyper' +CHAR(13)+
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPER1 INNER JOIN  ' +char(13)+
'                      '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP ON '+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP = '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPID   ' +char(13)+
'WHERE     ('+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP IS NOT NULL)  ' +char(13)+
'UNION ALL  ' +char(13)+
'SELECT     JOBID, JOBNAVN, KATEGORI, NIVEAU1, NIVEAU2, NIVEAU3,SLETTET_JOB, SKRIVEBESKYTTET, FALLES_SPROG_KAT_KODE,   ' +char(13)+
    '                  FALLES_SPROG_NIV1_KODE, FALLES_SPROG_NIV2_KODE, FALLES_SPROG_NIV3_KODE, SIDSTE_VITALE_AENDRING, PLEJETYPE, NORMTID2, ' +char(13)+
  '                    NORMTID3, NORMTID4, FUNKKAT,MAXTID2, MAXTID3, MAXTID4, FALLES_SPROG_ART, PARAGRAF, NORMTID1, MAXTID1, BTP,  ' +char(13)+
  '                    KATNAVN, FALLES_SPROG_NAVN, Slettet_job_navn, CONVERT(nvarchar, FALLES_SPROG_KAT_KODE) + CONVERT(nvarchar, KATEGORI) ' +char(13)+
 '                     AS Kat_nogle, ''Ikke defineret'' AS Expr2, ''IBT'' AS Expr3, 0 AS Expr4, ''Ikke defineret'' AS Expr5  ' +char(13)+
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPER1 AS DIMPAKKETYPER11  ' +char(13)+
'WHERE     (BTP IS NULL)  
UNION ALL  ' +char(13)+
'SELECT     BESOGID * 10000 AS Id, STATUSNAVN, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3, NULL AS Expr4, NULL AS Expr6, NULL ' +char(13)+
     '                 AS Expr7, NULL AS Expr8, NULL AS Expr9, NULL AS Expr10, NULL AS Expr11, NULL AS Expr12, NULL AS Expr13, NULL AS Expr14, NULL ' +char(13)+
    '                  AS Expr15, NULL AS Expr16, NULL AS Expr17,NULL AS Expr19, NULL AS Expr20, NULL AS Expr21, 9 AS Expr22, NULL ' +char(13)+
    '                  AS Expr23, NULL AS Expr24, NULL AS Expr25, NULL AS Expr26, ''Uden_Ydelse'' AS Expr27, ''Uden_Ydelse'' AS Expr28, ''Besøgsstatus'' AS Expr29, NULL ' +char(13)+
    '                   AS Expr30, NULL AS Expr31, NULL AS Expr32, NULL AS Expr33, NULL AS Expr34  ' +char(13)+
'FROM         '+@DestinationDB+'.dbo.Dimbesogstatus  ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,PLEJETYPE,FALLES_SPROG_ART,PARAGRAF,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''99999'',''99999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000001'',''Planlagt Standard Vejtid'',''1000000'',''0'',''0'',''1'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert dbo.tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000002'',''Udført Standard Vejtid'',''1000000'',''0'',''0'',''2'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000003'',''Mobil vejtid'',''1000000'',''0'',''0'',''3'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000004'',''Planlagt Standard Vejtid'',''1000000'',''0'',''0'',''4'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000005'',''Udført Standard Vejtid'',''1000000'',''0'',''0'',''5'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000006'',''Mobil vejtid'',''1000000'',''0'',''0'',''6'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--tilføj plejetype afhængig af fællessprog
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT *, '+char(13) +
           'COALESCE(CASE FALLES_SPROG_ART '+char(13) + 
           '  WHEN 1 THEN '+char(13) +
           '    CASE PLEJETYPE '+char(13) +
           '      WHEN 1 THEN ''Personlig pleje'' '+char(13) +
           '      WHEN 2 THEN ''Praktisk hjælp'' '+char(13) + 
           '      WHEN 3 THEN ''Genoptræning'' '+char(13) + 
           '      WHEN 4 THEN ''Vedl. træning'' '+char(13) + 
           '      WHEN 5 THEN ''Sygepleje'' '+char(13) + 
           '      WHEN 6 THEN ''Madservice'' '+char(13) + 
           '      WHEN 7 THEN ''Bolig'' '+char(13) + 
           '      WHEN 8 THEN ''Øvrig tid'' '+char(13) + 
           '    END '+char(13) + 
           '  WHEN 2 THEN '+char(13) + 
           '    CASE (SELECT PARAGRAF_GRUPPERING_ID FROM PARATYPER WHERE PARATYPER.ID=tmp_DimPakkeTyper.PARAGRAF) '+char(13) +
           '      WHEN 1 THEN ''Personlig pleje'' '+char(13) +
           '      WHEN 2 THEN ''Praktisk hjælp'' '+char(13) + 
           '      WHEN 3 THEN ''Genoptræning'' '+char(13) + 
           '      WHEN 4 THEN ''Vedl. træning'' '+char(13) + 
           '      WHEN 5 THEN ''Sygepleje'' '+char(13) + 
           '      WHEN 6 THEN ''Midlertidig bolig'' '+char(13) + 
           '      WHEN 7 THEN ''Permanent bolig'' '+char(13) + 
           '      WHEN 8 THEN ''Hjælpemiddel'' '+char(13) + 
           '      WHEN 9 THEN ''Madservice'' '+char(13) + 
           '    END '+char(13) + 
           'END,''Ukendt plejetype'') AS PLEJETYPE_NAVN, '+char(13) +
           'COALESCE(CASE FALLES_SPROG_ART '+char(13) + 
           '         WHEN 1 THEN PLEJETYPE '+char(13) + 
           '         WHEN 2 THEN (SELECT PARAGRAF_GRUPPERING_ID FROM PARATYPER WHERE PARATYPER.ID=tmp_DimPakkeTyper.PARAGRAF) '+char(13) + 
           '         END,9999) AS PLEJETYPE_PARAGRUPPE '+char(13) +
           'INTO '+@DestinationDB+'.dbo.DimPakkeTyper FROM tmp_DimPakkeTyper' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimYdelsesPakker'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimYdelsesPakker'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimYdelsesPakker from vDimYdelsespakker'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimYdelsesPakker ' +char(13) +
			'(Pakke_id, Pakke_Navn,status) ' +char(13) +
			'VALUES(''9999'',''Ukendt'',1)' +char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert '+@DestinationDB+'.dbo.DimYdelsesPakker ' +char(13) +
			'(Pakke_id, Pakke_Navn,status) ' +char(13) +
			'VALUES(''0'',''Ukendt'',1)' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--9.Dim_medarbejder

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimMedarbejderStatusStep1' AND type = 'U') DROP TABLE DimMedarbejderStatusStep1

CREATE TABLE [dbo].DimMedarbejderStatusStep1(
	[MedStatusId] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('1','Aktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('2','Midlertidig inaktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('0','Inaktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('9999','Ej specificeret')

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejder'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejder'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT coalesce(dbo.MEDSTATUS.MEDSTATUSID, 9999) as MedStatusId,  coalesce(dbo.MEDSTATUS.STATUSNAVN, ''9999'') as StatusNavn, ' +char(13)+
		    'coalesce(dbo.MEDSTATUS.MEDAKTIV,9999) as MedAktiv,' +char(13)+
           'dbo.DimMedarbejderStatusStep1.Description AS MedArbAktivNavn ' +char(13)+
		   	'into '+@DestinationDB+'.dbo.DimMedarbejder ' +char(13)+	
		   'FROM  dbo.DimMedarbejderStatusStep1 LEFT OUTER JOIN ' +char(13)+
           'dbo.MedStatus ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV '
if @debug = 1 print @cmd
exec (@cmd)

--10.DimMedarbejderStatus
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejderStatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejderStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT coalesce(dbo.MEDSTATUS.MEDSTATUSID, 9999) as MedStatusId, ' +char(13)+
			'coalesce(dbo.MEDSTATUS.STATUSNAVN, ''9999'') as StatusNavn,  ' +char(13)+
			'coalesce(dbo.MEDSTATUS.MEDAKTIV,9999) as MedAktiv, dbo.DimMedarbejderStatusStep1.Description ' +char(13)+
		   	'into '+@DestinationDB+'.dbo.DimMedarbejderStatus ' +char(13)+	
		   'FROM  dbo.DimMedarbejderStatusStep1 LEFT OUTER JOIN ' +char(13)+
           'dbo.MEDSTATUS ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV'

if @debug = 1 print @cmd
exec (@cmd)

--11.Dim_medarbejdere
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejdere'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejdere'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select *, '+char(13)+
           '  CASE WHEN MEDARBEJDERTYPE=0 THEN ''Medarbejder'' '+char(13)+
           '       WHEN MEDARBEJDERTYPE=1 THEN ''Fiktiv medarbejder'' '+char(13)+
           '       WHEN MEDARBEJDERTYPE=2 THEN ''Daghjem/dagcenter'' '+char(13)+ 
           '       ELSE ''Ukendt'' '+char(13)+
           '  END AS MEDARBEJDERTYPENAVN, '+char(13)+
           '  (round([Timer]/(2220.0),(2))) as Ansættelsesbrøk '+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimMedarbejdere from MEDARBEJDERE'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'update '+@DestinationDB+'.dbo.DimMedarbejdere' + CHAR(13)+
			'Set Cprnr = ''9999999'' '+ Char(13)+
			'where cprnr is null' + char(13)
			if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimMedarbejdere(MEDARBEJDERID,OPRETTET,FODDATO,MEDARBEJDER_STATUS,MEDARBEJDER_STATUSID,FORNAVN,EFTERNAVN,ADRESSE, ' +char(13)+
			'POSTNR,TIMER,STILLINGSID,UAFDELINGID,AFDELINGID,RETTET,KMD_MEDNR,ANSATDATO,EMAIL,UPDATPEN,TELEFON,ALTTELEFON, ' +char(13)+
			'MOBILTELEFON,TLF_HEMMELIGT,ALTTLF_HEMMELIGT,MOBIL_HEMMELIGT,MEDARBEJDERNR,MEDARBEJDERINIT,MEDARBEJDERTYPE,CPRNR,PERSONNR_EKSTRA, ' +char(13)+
			'COADR,VAGTER,FYLDFARVE,FONTFARVE,CPR_VEJNAVN,CPR_HUSNR,CPR_ETAGE,CPR_SIDEDOR,TRANSPORT,STARTFROM,STARTLOKALE, ' +char(13)+
			'ABP_FIKTIV,AFLON_FORM,ADR_ID,Ansættelsesbrøk,MEDARBEJDERTYPENAVN) VALUES(''9999'',convert(datetime,''2006-10-17 00:00:00.000'',121), ' +char(13)+
			'convert(datetime,''1899-12-30 00:00:00.000'',121),''1'',''1'',''Ukendt'',''Ukendt'',''Ukendt'','''',''0'',''9999'',''9999'',''334'',' +char(13)+
			'convert(datetime,''2007-01-10 14:27:22.000'',121),'''',convert(datetime,''2006-10-17 00:00:00.000'',121),'''', ' +char(13)+
			'convert(datetime,''2006-10-27 12:49:51.000'',121),'''','''','''',NULL,NULL,NULL,''2'','''',''1'','''',''0'','''',''3'',''8421631'',NULL,'''', ' +char(13)+
			''''','''','''',''0'',''0'',NULL,''0'',NULL,NULL,''0'',''Ukendt'') ' +char(13)
if @debug = 1 print @cmd
exec (@cmd)
--12.Dim medarbejder
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejder'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejder'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT dbo.MEDSTATUS.MEDSTATUSID as MedStatusId, dbo.MEDSTATUS.STATUSNAVN as StatusNavn, dbo.MEDSTATUS.MEDAKTIV as MedAktiv,  ' +char(13) +
            'dbo.DimMedarbejderStatusStep1.Description AS MedArbAktivNavn  ' +char(13)+
			'into '+@DestinationDB+'.dbo.DimMedarbejder '   +char(13) +
			'FROM  dbo.DimMedarbejderStatusStep1 INNER JOIN ' +char(13)+
            'dbo.MEDSTATUS ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimMedarbejder(MEDSTATUSID,STATUSNAVN,MEDAKTIV,MEDARBAKTIVNAVN) VALUES(''9999'',''9999'',''9999'',''Ej specificeret'')'	  
if @debug = 1 print @cmd
exec (@cmd)

--13. DimStillingbet
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimStillingbet'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimStillingbet'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimStillingbet from STILLINGBET'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimStillingbet(STILLINGID,STILLINGNAVN,PCVAGTID,PCVAGTSYNC) VALUES(''9999'',''Ukendt'',NULL,NULL)'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimStillingbet(STILLINGID,STILLINGNAVN,PCVAGTID,PCVAGTSYNC) VALUES(''0'',''Ukendt'',NULL,NULL)'	  
if @debug = 1 print @cmd
exec (@cmd)

--14. DimFritvalgLeverandor
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFritvalgLeverandor'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFritvalgLeverandor'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  ID as Id, '+char(13)+ 
           '  NAVN as Navn, '+char(13)+
		   '  Case levtype '+char(13)+ 
		   '    when 0 then ''Generel'' '+char(13)+ 
		   '    when 1 Then ''Fritvalg'' '+char(13)+ 
		   '    when  2 then ''Hjælpemiddel'' '+char(13)+ 
		   '    when 3 then ''MadService'' '+char(13)+ 
		   '    else ''Ukendt'' '+char(13)+ 
		   '  end as LevType, '+char(13)+
		   '  CASE STATUS '+char(13)+
		   '  WHEN 0 THEN ''INAKTIV'' '+char(13)+ 
		   '  WHEN 1 THEN ''AKTIV'' '+char(13)+
		   '  END AS LEVSTATUS '+char(13)+
		   ' into '+@DestinationDB+'.dbo.DimFritvalgLeverandor from HJPLEVERANDOR'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''8888'',''Kommunen'',''Kommunen'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''0'',''Ikke katogoriseret'',''Ukendt'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''9999'',''Ikke katogoriseret'',''Ukendt'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)



--15.DimBesogStatus
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBesogStatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBesogStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimBesogStatus from BESOGSTATUS'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimBesogStatus(BESOGID,STATUS,STAT_TYPE,STAT_GYLDIG,STATUSNAVN,FYLDFARVE,FONTFARVE) VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')'	  
if @debug = 1 print @cmd
exec (@cmd)

--16.DimFraværstyper - DimTjenestetyper

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFravaerstyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFravaerstyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select ID AS FRAVARID,NAVN,KMDID into '+@DestinationDB+'.dbo.DimFravaerstyper from VPL_FRAVAERSTYPER ' 	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert into  '+@DestinationDB+'.dbo.DimFravaerstyper values (999,''Ukendt Fraværstype'','''')'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimTjenestetyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimTjenestetyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select ID AS TJENESTEID,NAVN,KMDID,TJENESTETYPE into '+@DestinationDB+'.dbo.DimTjenestetyper from VPL_TJENESTETYPER ' 	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert into  '+@DestinationDB+'.dbo.DimTjenestetyper values (9999,''Ukendt Tjenestetype'','''',null)'



           --' union all '+char(13)+
           --'select '+char(13)+
           --' 17 '+char(13)+
           --',''Ukendt''  '+char(13)+
           --',KMDID'+char(13)+
           --',KATEGORI'+char(13)+
           --',NIVEAU1'+char(13)+
           --',NIVEAU2'+char(13)+
           --',NIVEAU3'+char(13)+
           --',FYLDFARVE'+char(13)+
           --',FONTFARVE'+char(13)+
           --'from FRAVARTYPER where FRAVARID=0 and 1 <> (select count(*) from  FRAVARTYPER where FRAVARID=17 ) '+char(13)+
           --   ' union all '+char(13)+
           --'select '+char(13)+
           --' 999 '+char(13)+
           --',''Arbjede''  '+char(13)+
           --',KMDID'+char(13)+
           --',KATEGORI'+char(13)+
           --',NIVEAU1'+char(13)+
           --',NIVEAU2'+char(13)+
           --',NIVEAU3'+char(13)+
           --',FYLDFARVE'+char(13)+
           --',FONTFARVE'+char(13)+
           --'from FRAVARTYPER where FRAVARID=0 and 1 <> (select count(*) from  FRAVARTYPER where FRAVARID=999 ) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimLeverandor'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimLeverandor'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT  *' +char(13)+
           'into '+@DestinationDB+'.dbo.DimLeverandor  FROM '+@DestinationDB+'.dbo.DimOrganisation'
if @debug = 1 print @cmd
exec (@cmd)


-- Følgende to har hardkodede værdier  - overvej om det kan laves mere dynamisk
-- Laver dimJobHyppighed

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobHyppighed'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobHyppighed'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'Create table '+@DestinationDB+'.dbo.DimJobHyppighed
(Id smallint null,
[Description] nvarchar(50) null) '
exec (@cmd)

set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(0, ''daglig'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(1, ''Ugentlig'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(2, ''Hver X uge'')' exec (@cmd)


--17.DimPakkeTyperBTP

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimPakkeTyperBTP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperBTP'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = '
Create table '+@DestinationDB+'.dbo.DimPakkeTyperBTP
(BTPId int not null,
BtpNavn nvarchar(50) null ,
AtaIbt nvarchar(50) null,
BtpKategori int null,
BtpKatNavn nvarchar(50) null)'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(0, ''Ikke defineret'',''IBT'',0, ''Ikke defineret'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(1, ''Personlig Pleje'',''ATA'',3, ''Direkte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(2, ''Praktisk bistand'',''ATA'',3, ''Direkte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(7, ''Fælles opgaver vdr flere borgere'',''ATA'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(9, ''Udvikling og uddannelse'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(10, ''Møder og frokost'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(11, ''Organisering og planlægning'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(6, ''Kontakt'',''ATA'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(8, ''Vejtid'',''IBT'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(9999,null,null,null,null)' exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimBrugerTidsProcent'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBrugerTidsProcent'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT BTPId, BtpNavn, BtpKategori, BtpKatNavn, 0 AS SORTERING into '+@DestinationDB+'.dbo.DimBrugerTidsProcent FROM '+@DestinationDB+'.dbo.DimPakkeTyperBTP'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set BtpNavn=''Ukendt'',BtpKatNavn=''Ukendt'', BtpKategori=9999, SORTERING=15 where BTPId=9999'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set BtpNavn=''Møder og frokost'', SORTERING=10 where BTPId=10'
exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (8888,''Fremmøde tid'',8888,''Fremmøde tid'', 14)'
exec (@cmd)  
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (7777,''Ledig tid'',7777,''Ledig tid'', 12)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (6666,''Direkte borgertid'',6666,''Direkte borgertid'', 1)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (5555,''Indirekte borgertid'',5555,''Indirekte borgertid'', 4)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (4444,''Kvalifikationstid'',4444,''Kvalifikationstid'', 8)'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=2 where BTPId=1'
exec (@cmd) 
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=3 where BTPId=2'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=5 where BTPId=6'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=6 where BTPId=7'
exec (@cmd)   
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=7 where BTPId=8'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=9 where BTPId=9'
exec (@cmd)  
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=11 where BTPId=11'
exec (@cmd) 
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=13 where BTPId=0'
exec (@cmd) 

--18.DimJobTyper
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimJobTyper from vdimJobtyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)
  print 'd'
set @cmd = 'IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name =  ''temp_DimJobTyper'' AND type = ''U'') DROP TABLE temp_DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

SELECT  
 null ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000 
+CAST(0 as bigint)			*100000000 
+CAST(0 as bigint)			*100000    
+CAST(0 as bigint)			*100       
+CAST(0 as bigint)         JobID      
,Falles_Sprog_Art
,0 as Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
,'Fælles Sprog '+cast(Falles_Sprog_Art as nvarchar(4)) Jobnavn  
into temp_DimJobTyper
from    [JOBTYPER]
group by Falles_Sprog_Art
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/

SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(0 as bigint)			*100000000
+CAST(0 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
, Jobnavn  
 from   [JOBTYPER]
where    Niveau1 = 0
  and    Niveau2 = 0
  and    Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(0 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
, CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  NIVEAU2 =0
  and    NIVEAU3 =0
  and    NIVEAU1 <>0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(Niveau1 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <>  0
  and    Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <> 0
  and    Niveau3 <>  0  
--union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
/*SELECT   distinct 
 CAST(FALLES_SPROG_ART as int)	*100000000000
+CAST(KATEGORI as int)			*100000000
+CAST(NIVEAU1 as int)			*100000
+CAST(NIVEAU2 as int)			*100
+CAST(Niveau3 as int) ParentID
,CAST(FALLES_SPROG_ART as int)	*100000000000
+CAST(KATEGORI as int)			*100000000
+CAST(NIVEAU1 as int)			*100000
+CAST(NIVEAU2 as int)			*100
+CAST(NIVEAU3 as int) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <> 0
  and    Niveau3 <>  0  */


  
set @cmd = ' SELECT [ParentID]
      ,[JobID]  ,[Falles_Sprog_Art]      ,[Kategori]      ,[Niveau1]      ,[Niveau2]      ,[Niveau3]
      ,[Jobnavn] into '+@DestinationDB+'.dbo.DimJobTyper  FROM  temp_DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimJobTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,FALLES_SPROG_ART) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--### DimBevaegelse
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBevaegelse'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBevaegelse'
if @debug = 1 print @cmd
exec (@cmd)

--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSpecifikation' AND type = 'U') DROP TABLE DimSpecifikation

set @cmd = 'CREATE TABLE '+@DestinationDB+'.[dbo].[DimBevaegelse]( ' +char(13)+
		   '[BEVAEG_ID] [int] NULL, ' +char(13)+
		   '[BEVAEG_NAVN] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''1'',''Primo'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''2'',''Tilgang'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''3'',''Afgang'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''4'',''Ultimo'')' 
exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''5'',''Periode'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''12'',''Tilgang leverandør'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''13'',''Afgang leverandør'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''14'',''Gruppeskift periode'')' 
--exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''15'',''Lev. skift Frit valg > Frit valg'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''16'',''Lev skift Kommune > Frit valg'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''17'',''Lev. skift Frit valg > Kommune'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''100'',''Bruger'')' 
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFunkNiveau'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFunkNiveau'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'CREATE TABLE '+@DestinationDB+'.[dbo].[DimFunkNiveau]( ' +char(13)+
		   '[FUNKNIVEAU_ID] [int] NULL, ' +char(13)+
		   '[FUNKNIVEAU_FSTYPE] [nvarchar](10) NULL, ' +char(13)+
		   '[FUNKNIVEAU_NAVN] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''1'',''FS1'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''2'',''FS1'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''3'',''FS1'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''4'',''FS1'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''5'',''FS1'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''6'',''FS2'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''7'',''FS2'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''8'',''FS2'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''9'',''FS2'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''10'',''FS2'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''11'',''GSB'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''12'',''GSB'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''13'',''GSB'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''14'',''GSB'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''15'',''GSB'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''9999'','''',''Score ikke kendt'')' 
exec (@cmd)


--Systembruger
set @cmd = 'EXEC dbo.usp_Create_Dim_Bruger '''+@DestinationDB+''',0'
if @debug = 1 print @cmd
exec (@cmd)


declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=42)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (42,GETDATE())           
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dim_Bruger]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_Create_Dim_Bruger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
declare @BRUGERSKIFTPASSINT as varchar(10)

set @BRUGERSKIFTPASSINT = (select * from openquery(omsorg,'select BRUGERSKIFTPASSINT from OPSATNING'))+30

BEGIN
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBruger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBruger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  B.BRUGERID,'+char(13)+ 
           '  B.MEDARBEJDER,'+char(13)+ 
           '  CASE WHEN (B.MEDARBEJDER IS NOT NULL) THEN '+char(13)+ 
           '    (SELECT CPRNR FROM MEDARBEJDERE WHERE MEDARBEJDERID=B.MEDARBEJDER) '+char(13)+ 
           '  ELSE ''Cprnr ikke opgivet'' '+char(13)+ 
           '  END AS MEDARBCPRNR,'+char(13)+ 
           '  B.UAFDELINGID,'+char(13)+ 
           '  LASTPWCHANGE,'+char(13)+ 
           '  CASE WHEN DATEDIFF(DD,LASTPWCHANGE,getdate())>'+@BRUGERSKIFTPASSINT+' THEN ''Login>120 dage'' '+char(13)+ 
           '  ELSE ''Login OK'' '+char(13)+ 
           '  END AS LOGINSTATUS,'+char(13)+ 
           '  CASE KONTI_DISABLED'+char(13)+ 
           '    WHEN 0 THEN ''Aktiv'''+char(13)+ 
           '    WHEN 1 THEN ''Deaktiveret'''+char(13)+ 
           '  END AS KONTOSTATUS,'+char(13)+ 
           '  CASE WHEN (B.UAFDELINGID IS NOT NULL) THEN '+char(13)+ 
           '    (SELECT UAFDELINGNAVN FROM UAFDELINGER WHERE UAFDELINGID=B.UAFDELINGID)'+char(13)+ 
           '  ELSE ''Gruppe ikke opgivet'''+char(13)+ 
           '  END AS GRUPPENAVN,'+char(13)+ 
           '  COALESCE((SELECT TOP 1 NAVN FROM BRUGERPROFIL BP 
                       JOIN BRUGERPROFILREL BPREL ON BP.ID=BPREL.PROFILID 
                       WHERE BPREL.BRUGERID=B.BRUGERID),''Profil ikke opgivet'') AS PROFILNAVN,'+char(13)+ 
           '  B.BRUGERNAVN,'+char(13)+ 
           '  COALESCE(B.FORNAVN+'' ''+B.EFTERNAVN,''Ukendt'') AS NAVN'+char(13)+  
           'INTO '+@DestinationDB+'.DBO.DimBruger'+char(13)+ 
           'FROM BRUGER B'+char(13)+ 
           'WHERE B.SYSTEMBRUGER=0'+char(13)+
           'ORDER BY B.BRUGERID'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBrugerStatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBrugerStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  KONTI_DISABLED_AARSAG AS BRUGERSTATUSID, '+char(13)+ 
           '  CASE KONTI_DISABLED_AARSAG  '+char(13)+ 
           '    WHEN -1 THEN ''Konto deaktiveret uden status'' '+char(13)+ 
           '    WHEN 1 THEN ''Bruger stoppet'' '+char(13)+ 
           '    WHEN 2 THEN ''Bruger på orlov'' '+char(13)+ 
           '    WHEN 3 THEN ''Admin. (fejloprettelse)'' '+char(13)+ 
           '    WHEN 4 THEN ''Gentagne login fejl'' '+char(13)+ 
           '    WHEN 5 THEN ''Andre årsager'' '+char(13)+ 
           '  END AS BRUGERSTATUS'+char(13)+           
           'INTO '+@DestinationDB+'.DBO.DimBrugerStatus'+char(13)+ 
           'FROM BRUGER'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'INSERT INTO '+@DestinationDB+'.DBO.DimBrugerStatus (BRUGERSTATUSID,BRUGERSTATUS) VALUES(99,''Bruger oprettet'')'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'INSERT INTO '+@DestinationDB+'.DBO.DimBrugerStatus (BRUGERSTATUSID,BRUGERSTATUS) VALUES(100,''Bruger'')'
if @debug = 1 print @cmd
exec (@cmd)

/* fra UniqOmsorg
-1: Kontoen har ikke været deaktiveret.
 1: Medarbejderen er stoppet
 2: Medarbejderen er på orlov
 3: Administrativ (fejloprettelse)
 4: Gentagne login fejl
 5: Andre årsager
*/         

             
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=40)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (40,GETDATE())           
end

END
GO
/****** Object:  StoredProcedure [dbo].[usp_LavVisitationTil_Afgang]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_LavVisitationTil_Afgang]
                       @DestinationDB as varchar(200),
		               @ExPart as Int=0,  
                       @Debug  as bit = 0  
AS
DECLARE @cmd as varchar(max)
DECLARE @sagsid_plejetype INT
DECLARE @old_sagsid_plejetype INT
DECLARE @visiid INT
DECLARE @old_visiid INT
DECLARE @BORGER_STATUS INT
DECLARE @leverandoerid INT
DECLARE @old_leverandoerid INT
DECLARE @old_borger_status INT
DECLARE @ikraftdato DATE
DECLARE @slutdato DATE
DECLARE @old_slutdato DATE
DECLARE @def_cprnr VARCHAR(20)
DECLARE @leverandoertaeller INT

if @ExPart=1 OR @ExPart=0
BEGIN

set @def_cprnr=substring(convert(nvarchar(10),getdate(),112),7,2)+substring(convert(nvarchar(10),getdate(),112),5,2)+substring(convert(nvarchar(10),getdate(),112),3,2)+'4000'

--Lav historik til tilgang
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  1 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'INTO tmp_VisitationsHistorik '+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'LEFT JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=1 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''5'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  5 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM SPVISITATION A '+char(13)+
           'LEFT JOIN SPVISIJOB B ON A.ID=B.SPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=5 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+           
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''3'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  3 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM TPVISITATION A '+char(13)+
           'LEFT JOIN TPVISIJOB B ON A.ID=B.TPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=3 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+           
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''6'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM MADVISITATION A '+char(13)+
           'LEFT JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=6 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)  

if @debug = 1 print @cmd
exec (@cmd)

--periode --skal udkommeteres hvis ønskes
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Periode'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Periode'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(A.CPRNR,B.PK_DATE),0) AS ALDER, '+char(13)+  
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS PERIODE, '+char(13)+  --antal
           '  5 AS SPECIFIKATION_NY '+char(13)+ --periode  
           'INTO tmp_VisitationTilAfgang_Periode '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE())'+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  B.PK_DATE>=BTH.IKRAFTDATO AND B.PK_DATE<BTH.SLUTDATO AND BTH.PLEJETYPE=A.PLEJETYPE '+char(13)+
           'ORDER BY PK_DATE,SAGSID'
--exec (@cmd)

--primo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Primo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Primo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  (B.PK_DATE+1) AS PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS PRIMO, '+char(13)+  --antal
           '  1 AS SPECIFIKATION_NY '+char(13)+ --primo  
           'INTO tmp_VisitationTilAfgang_Primo '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND ' +char(13)+
           '(B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH'+char(13)+ --den sidste i forrige måned
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--ultimo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Ultimo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Ultimo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS ULTIMO, '+char(13)+  --antal
           '  4 AS SPECIFIKATION_NY '+char(13)+ --ultimo  
           'INTO tmp_VisitationTilAfgang_Ultimo '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND ' +char(13)+
           '(B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--tilgang nye visitationer
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  MIN(IKRAFTDATO) AS PK_DATE, '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_Visitations_Tilgang_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik '+char(13)+
           'GROUP BY SAGSID_PLEJETYPE'+char(13)+
           'ORDER BY SAGSID_PLEJETYPE'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS TILGANG, '+char(13)+  --antal
           '  2 AS SPECIFIKATION_NY '+char(13)+ --tilgang  
           'INTO tmp_Visitations_Tilgang '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_Tilgang_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE AND A.PK_DATE=B.PK_DATE' 
if @debug = 1 print @cmd
exec (@cmd) 

--tilgang visitationer - borgere der har ikke har modtaget ydelser i 90 dage eller mere 
DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT VISIID,SAGSID_PLEJETYPE,BORGER_STATUS,IKRAFTDATO,SLUTDATO 
FROM tmp_VisitationsHistorik  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @visiid,@sagsid_plejetype,@borger_status,@ikraftdato,@slutdato

WHILE @@fetch_status = 0
BEGIN 
  IF (@sagsid_plejetype=@old_sagsid_plejetype) and (@old_borger_status=0) and (@borger_status<>0) and (DATEDIFF(dd,@old_slutdato,@ikraftdato)>=90)
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang 
    SELECT PK_DATE,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,1 AS TILGANG,22 AS SPECIFIKATION_NY
    FROM tmp_VisitationsHistorik
  END
   
  set @old_sagsid_plejetype=@sagsid_plejetype
  set @old_borger_status= @borger_status
  set @old_visiid=@visiid
  set @old_slutdato=@slutdato
  
  FETCH NEXT FROM FindVisitation 
  INTO @visiid,@sagsid_plejetype,@borger_status,@ikraftdato,@slutdato

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation
          

--find alle borgere med visitationer der ikke er afsluttede
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationUdenSlutDato'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationUdenSlutDato'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_VisitationUdenSlutDato '+char(13)+
           'FROM tmp_VisitationsHistorik'+char(13)+
           'WHERE DATEPART(YEAR,SLUTDATO) IN (9999)'
if @debug = 1 print @cmd
exec (@cmd)

--find borgere med afsluttede visitationer (inaktive) - seneste visitation
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Afgang_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Afgang_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  MAX(SLUTDATO) AS PK_DATE '+char(13)+
           'INTO tmp_Visitations_Afgang_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato B WHERE A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE) '+char(13)+
           'GROUP BY SAGSID_PLEJETYPE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Afgang'
if @debug = 1 print @cmd
exec (@cmd)  

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS AFGANG, '+char(13)+  --antal
           '  3 AS SPECIFIKATION_NY '+char(13)+ --afgang  
           'INTO tmp_Visitations_Afgang '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_Afgang_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE AND A.SLUTDATO=B.PK_DATE' 
if @debug = 1 print @cmd
exec (@cmd) 

--find til og afgang på leverandør
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_BorgerMedFritvalgLev_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_BorgerMedFritvalgLev_Step1'
if @debug = 1 print @cmd
exec (@cmd)  

--find borgere der har fritvalgsleverandør - begræns data mængde
set @cmd = 'SELECT DISTINCT '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_Visitations_BorgerMedFritvalgLev_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik '+char(13)+
           'WHERE LEVERANDOERID NOT IN (9999,8888) '
if @debug = 1 print @cmd
exec (@cmd)      

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_BorgerMedFritvalgLev_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_BorgerMedFritvalgLev_Step2'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'SELECT '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE '+char(13)+ 
           'INTO tmp_Visitations_BorgerMedFritvalgLev_Step2 '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_BorgerMedFritvalgLev_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE '+char(13)+ 
           'ORDER BY A.SAGSID_PLEJETYPE, A.IKRAFTDATO '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Lev_Bevaegelser'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Lev_Bevaegelser'
if @debug = 1 print @cmd
exec (@cmd)

SELECT TOP 1  --tabel oprettes
  PK_DATE,
  VISIID, 
  SAGSID, 
  SAGSID_PLEJETYPE,
  CPRNR,
  JOBID,
  ALDER,
  BORGER_ORG,
  BORGER_STATUS,
  BORGER_STATUSID,
  LEVERANDOERID,
  PLEJETYPE,
  NULL AS SPECIFIKATION_NY 
INTO tmp_Visitations_Lev_Bevaegelser 
FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 

set @cmd = 'DELETE FROM tmp_Visitations_Lev_Bevaegelser'
if @debug = 1 print @cmd
exec (@cmd)

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT VISIID,SAGSID_PLEJETYPE,LEVERANDOERID 
FROM tmp_Visitations_BorgerMedFritvalgLev_Step2  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @visiid,@sagsid_plejetype,@leverandoerid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid_plejetype=@old_sagsid_plejetype and @visiid<>@old_visiid --samme borger men forskellige visitationer
  BEGIN 
    set @leverandoertaeller =  (SELECT COUNT(*) -- nye leverandør må ikke findes på gamle visitation
                                FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
                                WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid AND 
                                      A.LEVERANDOERID IN (SELECT B.LEVERANDOERID FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 B 
                                                          WHERE B.SAGSID_PLEJETYPE=@sagsid_plejetype AND B.VISIID=@old_visiid))
  
            
    IF @leverandoertaeller=0 
    BEGIN
      IF @old_leverandoerid=8888 AND @leverandoerid<>8888 --skift fra kommune til fritvalg
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,16 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END
      ELSE IF @leverandoerid=8888 AND @old_leverandoerid<>8888 --skift fra fritvalg til kommune 
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,17 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END   
      ELSE IF @leverandoerid<>@old_leverandoerid AND @old_leverandoerid<>8888 AND @leverandoerid<>8888 --skift mellem fritvalg
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,15 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END              
    END         
  END
  
  set @old_sagsid_plejetype=@sagsid_plejetype
  set @old_leverandoerid=@leverandoerid
  set @old_visiid=@visiid
  
  FETCH NEXT FROM FindVisitation 
  INTO @visiid,@sagsid_plejetype,@leverandoerid

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

END

IF @ExPart=2 OR @ExPart=0
begin

--union 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_VisitationTilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_VisitationTilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT '+char(13)+ --periode
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  JOBID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  BORGER_STATUS, '+char(13)+
--           '  BORGER_STATUSID, '+char(13)+
--           '  LEVERANDOERID, '+char(13)+ 
--           '  PLEJETYPE, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
--           'FROM tmp_VisitationTilAfgang_periode'+char(13)+ 
--           'UNION ALL '+char(13)+
set @cmd = 'SELECT '+char(13)+ --tilgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
           'FROM tmp_Visitations_Tilgang'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --afgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_Visitations_Afgang'+char(13)+   
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --primo
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Primo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --ultimo
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Ultimo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --bevægelser
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+           
           'FROM tmp_Visitations_Lev_Bevaegelser'
           
                              
if @debug = 1 print @cmd
exec (@cmd) 

END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=36)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (36,GETDATE())           
end
GO
/****** Object:  StoredProcedure [dbo].[usp_LavFunktionsNiveau]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_LavFunktionsNiveau] 
                @DestinationDB as varchar(200),
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN
--FSII OBS!! IKKE GSB Henter Funktionsniveau hvor GSB ikke benyttes
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.ID AS VISI_ID, '+char(13)+
           'FA.RELEVANT, '+char(13)+
           'CAST(VU.NIVEAU AS NUMERIC(10,2)) AS NIVEAU '+char(13)+
           'INTO tmp_FunktionsNiveau_Step1 '+char(13)+
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN FAGLIGVURDERING FA ON HJ.ID=FA.VISI_ID AND FA.VISI_TYPE=0 '+char(13)+
           'JOIN VURDERINGSNIV VU ON FA.VURDNIV_ID=VU.ID AND VU.FALLES_SPROG_ART=2 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--Henter Funktionsniveau hvor Godsagsbehandling benyttes. På GSB er der kun 1 samlet score
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step11'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step11'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.ID AS VISI_ID, '+char(13)+
           'CAST(VU.NIVEAU AS NUMERIC(10,2)) AS GENNEMSNIT '+char(13)+
           'INTO tmp_FunktionsNiveau_Step11 '+char(13)+
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN GS_SAGER GSB ON HJ.GS_SAG_ID=GSB.SAG_ID '+char(13)+
           'JOIN VURDERINGSNIV VU ON GSB.SAMLET_FUNKTIONSNIVEAU_ID=VU.ID AND VU.FALLES_SPROG_ART=2 AND VU.ID<6 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--FSI
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step12'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step12'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'ID AS VISI_ID, '+char(13)+
           'CAST(((F1+F2+F3+F4+F5+F6+F7+F8+F9+F11+F12+F13)/12) AS NUMERIC(10,2)) AS GENNEMSNIT '+char(13)+
           'INTO tmp_FunktionsNiveau_Step12 '+char(13)+
           'FROM HJVISITATION '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmp_FunktionsNiveau_Step1 A WHERE HJVISITATION.ID=A.VISI_ID) AND'+char(13)+
           '  NOT EXISTS(SELECT * FROM tmp_FunktionsNiveau_Step11 B WHERE HJVISITATION.ID=B.VISI_ID) '+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step2'
if @debug = 1 print @cmd
exec (@cmd)
--Beregner gennemsnitlige funktionsniveau (FSII) og samler resultater fra ovenstående
set @cmd = 'SELECT '+char(13)+
           '  VISI_ID, '+char(13)+
           '  CASE WHEN SUM(RELEVANT)>0 THEN '+char(13)+
           '    CAST((SUM(NIVEAU)/SUM(RELEVANT))AS NUMERIC(10,2)) '+char(13)+
           '  ELSE 0 '+char(13)+
           '  END AS GENNEMSNIT, '+char(13)+
           '  ''FS2'' AS FS_TYPE'+char(13)+
           'INTO tmp_FunktionsNiveau_Step2 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step1 '+char(13)+
           'GROUP BY VISI_ID '+char(13)+
           'UNION ALL'+char(13)+
           'SELECT '+char(13)+
           '  VISI_ID,'+char(13)+
           '  GENNEMSNIT, '+char(13)+
           '  ''GSB'' AS FS_TYPE'+char(13)+
           'FROM tmp_FunktionsNiveau_Step11'+char(13)+
           'UNION ALL'+char(13)+
           'SELECT '+char(13)+
           '  VISI_ID,'+char(13)+
           '  GENNEMSNIT, '+char(13)+
           '  ''FS1'' AS FS_TYPE'+char(13)+
           'FROM tmp_FunktionsNiveau_Step12'+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--Sætter funktionsniveau i forhold til gennemsnit
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step3'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step3'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'SELECT '+char(13)+
           'VISI_ID, '+char(13)+
           'COALESCE(CASE FS_TYPE '+char(13)+
           '  WHEN ''FS1'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 1 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 2 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 3 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 4 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 5 '+char(13)+
           '  END '+char(13)+ 
           '  WHEN ''FS2'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 6 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 7 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 8 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 9 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 10 '+char(13)+
           '  END '+char(13)+
           '  WHEN ''GSB'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 11 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 12 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 13 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 14 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 15 '+char(13)+
           '  END '+char(13)+  
           'END,9999) AS DIM_FUNKNIVEAU_ID, '+char(13)+
           'FS_TYPE '+char(13)+  
           'INTO tmp_FunktionsNiveau_Step3 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step2 A '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)
--Har valgt at dele funktionsniveau og visiteret tid op da der ellers ville være alt for mange ting at holde styr på ;-) 
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step4'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step4'
if @debug = 1 print @cmd
exec (@cmd) 
--find visiterede tid pr visitation - hjemmepleje
set @cmd = 'SELECT '+char(13)+
           'A.ID AS VISI_ID, '+char(13)+
           'A.SAGSID, '+char(13)+
           'A.IKRAFTDATO, '+char(13)+
           'A.SLUTDATO, '+char(13)+
           'CAST(B.NORMTID AS NUMERIC(10,2)) AS NORMTID, '+char(13)+
           'B.HYPPIGHED, '+char(13)+
           'B.YD_GANGE, '+char(13)+
           'B.YD_MORGEN+B.YD_FORMIDDAG+B.YD_MIDDAG+B.YD_EFTERMIDDAG+ '+char(13)+
           'B.YD_AFTEN1+B.YD_AFTEN2+B.YD_AFTEN3+B.YD_AFTEN4+ '+char(13)+
           'B.YD_NAT1+B.YD_NAT2+B.YD_NAT3+B.YD_NAT4 '+char(13)+
           'AS YD_PR_DOEGN, '+char(13)+
           'B.YD_WEEKEND, '+char(13)+
           'B.PERSONER '+char(13)+
           'INTO tmp_FunktionsNiveau_Step4'+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

/*  Beregningsmetode				
			
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
*/

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step5'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step5'
if @debug = 1 print @cmd
exec (@cmd) 
--fordel visiterede tid på hverdag og weekend
set @cmd = 'SELECT '+char(13)+
           'VISI_ID, '+char(13)+
           'SAGSID, '+char(13)+
           'IKRAFTDATO, '+char(13)+
           'SLUTDATO, '+char(13)+
           'NORMTID, '+char(13)+
           'HYPPIGHED, '+char(13)+
           'YD_GANGE, '+char(13)+
           'YD_WEEKEND, '+char(13)+
           'PERSONER, '+char(13)+           
           'CASE '+char(13)+
           '  WHEN HYPPIGHED=0 THEN (NORMTID*YD_GANGE*PERSONER) '+char(13)+ --daglig
           '  WHEN HYPPIGHED=1 THEN'+char(13)+ --ugentlig
           '    CASE WHEN YD_WEEKEND=0 THEN (NORMTID*YD_GANGE*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '    ELSE (NORMTID*(YD_GANGE-YD_WEEKEND)*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '    END '+char(13)+
           '  WHEN HYPPIGHED=2 THEN '+char(13)+ --hver x. uge
           '    CASE WHEN YD_WEEKEND=0 THEN '+char(13)+--der er ikke ydelser i weekend
           '      CASE WHEN YD_GANGE>0 THEN ((NORMTID/YD_GANGE)*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '      ELSE 0 '+char(13)+
           '      END '+char(13)+ 
           '    END '+char(13)+
           'END AS VISI_TID_HVERDAG, '+char(13)+  
           'CASE '+char(13)+
           '  WHEN HYPPIGHED=0 THEN (NORMTID*YD_GANGE*PERSONER) '+char(13)+
           '  WHEN HYPPIGHED=1 THEN'+char(13)+ 
           '    CASE WHEN YD_WEEKEND>0 THEN (NORMTID*YD_WEEKEND*YD_PR_DOEGN*PERSONER)/2 '+char(13)+
           '    ELSE 0 '+char(13)+
           '    END '+char(13)+
           '  WHEN HYPPIGHED=2 THEN '+char(13)+
           '    CASE WHEN YD_WEEKEND>0 THEN ((NORMTID/YD_WEEKEND)*YD_PR_DOEGN*PERSONER)/2 '+char(13)+
           '    ELSE 0 '+char(13)+   
           '    END '+char(13)+
           'END AS VISI_TID_WEEKEND '+char(13)+       
           'INTO tmp_FunktionsNiveau_Step5 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step4' 
if @debug = 1 print @cmd
exec (@cmd)         
--summer visiteret tid pr visitation
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step6'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step6'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT '+char(13)+
           '  VISI_ID, '+char(13)+
           '  SAGSID, '+char(13)+
           '  IKRAFTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  SUM(VISI_TID_HVERDAG) AS VISI_TID_HVERDAG, '+char(13)+
           '  SUM(VISI_TID_WEEKEND) AS VISI_TID_WEEKEND '+char(13)+    
           'INTO tmp_FunktionsNiveau_Step6 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step5 '+char(13)+
           'GROUP BY SAGSID,VISI_ID,IKRAFTDATO,SLUTDATO '+char(13)
if @debug = 1 print @cmd
exec (@cmd) 
--join med funktionsniveau  
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step7'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step7'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.VISI_ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.IKRAFTDATO, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  A.VISI_TID_HVERDAG, '+char(13)+
           '  A.VISI_TID_WEEKEND, '+char(13)+ 
           '  B.DIM_FUNKNIVEAU_ID, '+char(13)+ 
           '  B.FS_TYPE '+char(13)+     
           'INTO tmp_FunktionsNiveau_Step7 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step6 A '+char(13)+
           'JOIN tmp_FunktionsNiveau_Step3 B ON A.VISI_ID=B.VISI_ID'+char(13)
if @debug = 1 print @cmd
exec (@cmd)  
--sæt pk_date på og join BORGER_TILHOER_HISTORIK for at få borger oplysninger
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_FunktionsNiveau'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_FunktionsNiveau'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+ 
           '  A.SAGSID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,B.PK_DATE),0) AS ALDER, '+char(13)+ 
           '  COALESCE(C.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(C.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(C.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+     
           '  A.DIM_FUNKNIVEAU_ID, '+char(13)+
           '  A.FS_TYPE, '+char(13)+
           '  CASE WHEN B.WEEKEND=0 THEN A.VISI_TID_HVERDAG ELSE 0 END AS VISI_TID_HVERDAG, '+char(13)+
           '  CASE WHEN B.WEEKEND=1 THEN A.VISI_TID_WEEKEND ELSE 0 END AS VISI_TID_WEEKEND, '+char(13)+
           '  CASE WHEN B.WEEKEND=1 THEN A.VISI_TID_WEEKEND ELSE A.VISI_TID_HVERDAG END AS VISI_TID_TOTAL '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_FunktionsNiveau '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step7 A '+char(13)+
           'JOIN DimWeekendHelligdag B ON A.IKRAFTDATO<=B.PK_DATE AND A.SLUTDATO>B.PK_DATE AND '+char(13)+
           '  B.PK_DATE > ''2008-01-01'' AND B.PK_DATE < GETDATE() '+char(13)+
           'LEFT JOIN BORGER_TILHOER_HISTORIK C ON A.SAGSID=C.SAGSID AND '+char(13)+
           '  B.PK_DATE>=C.IKRAFTDATO AND B.PK_DATE<C.SLUTDATO AND C.PLEJETYPE=1 '+char(13)            
if @debug = 1 print @cmd
exec (@cmd) 
             
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=35)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (35,GETDATE())           
end

END
GO
/****** Object:  StoredProcedure [dbo].[usp_LavBorgerHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HDJ Avaleo
-- Create date: 2010.11.16
-- Description: Genererer historik på borgere (sager)
-- =============================================
CREATE PROCEDURE [dbo].[usp_LavBorgerHistorik]
                 @Debug  as bit = 1 
                       
AS
DECLARE @cmd as varchar(max)
BEGIN

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_HJ'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_HJ'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  B.CPRNR, ' +char(13)+
           '  A.HJEMMEPLEJE_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  COALESCE(A.HJEMMEPLEJE_STATUS,0) AS STATUS, ' +char(13)+ 
           '  COALESCE(A.HJEMMEPLEJE_STATUSID,1) AS STATUSID, ' +char(13)+ 
           '  1 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_HJ ' +char(13)+ 
           'FROM SAGSHISTORIK A ' +char(13)+
           'JOIN SAGER B ON A.SAGSID=B.SAGSID '+char(13)+
           'WHERE A.HJEMMEPLEJE_GRUPPEID is not null ' +char(13)+
           'ORDER BY A.SAGSID,A.HJEMMEPLEJE_GRUPPEID,A.IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_SP'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_SP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  B.CPRNR, ' +char(13)+
           '  A.SYGEPLEJE_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  COALESCE(A.SYGEPLEJE_STATUS,0) AS STATUS, ' +char(13)+
           '  COALESCE(A.SYGEPLEJE_STATUSID,1) AS STATUSID, ' +char(13)+
           '  5 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_SP ' +char(13)+ 
           'FROM SAGSHISTORIK A ' +char(13)+
           'JOIN SAGER B ON A.SAGSID=B.SAGSID '+char(13)+
           'WHERE A.SYGEPLEJE_GRUPPEID is not null ' +char(13)+
           'ORDER BY A.SAGSID,A.SYGEPLEJE_GRUPPEID,A.IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_TP'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_TP'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  B.CPRNR, ' +char(13)+
           '  A.TERAPEUT_GRUPPEID AS BORGER_ORG, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  COALESCE(A.TERAPEUT_STATUS,0) AS STATUS, ' +char(13)+
           '  COALESCE(A.TERAPEUT_STATUSID,1) AS STATUSID, ' +char(13)+
           '  3 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_TP ' +char(13)+ 
           'FROM SAGSHISTORIK A ' +char(13)+
           'JOIN SAGER B ON A.SAGSID=B.SAGSID '+char(13)+
           'WHERE A.TERAPEUT_GRUPPEID is not null ' +char(13)+
           'ORDER BY A.SAGSID,A.TERAPEUT_GRUPPEID,A.IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''SAGSHISTORIK_MAD'' AND type = ''U'') DROP TABLE dbo.SAGSHISTORIK_MAD'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  A.SAGSID, ' +char(13)+
           '  B.CPRNR, ' +char(13)+
           '  7777 AS BORGER_ORG, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  COALESCE(A.MADVISI_STATUS,0) AS STATUS, ' +char(13)+
           '  COALESCE(A.MADVISI_STATUSID,1) AS STATUSID, ' +char(13)+
           '  6 AS PLEJETYPE ' +char(13)+
           'INTO SAGSHISTORIK_MAD ' +char(13)+ 
           'FROM SAGSHISTORIK A ' +char(13)+
           'JOIN SAGER B ON A.SAGSID=B.SAGSID '+char(13)+
           'WHERE A.MADVISI_STATUSID is not null ' +char(13)+
           'ORDER BY A.SAGSID,A.IKRAFTDATO'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''BORGER_TILHOER_HISTORIK'' AND type = ''U'') DROP TABLE dbo.BORGER_TILHOER_HISTORIK'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  CPRNR, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  STATUS, ' +char(13)+
           '  STATUSID, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'INTO BORGER_TILHOER_HISTORIK ' +char(13)+ 
           'FROM SAGSHISTORIK_HJ ' +char(13)+
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  CPRNR, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  STATUS, ' +char(13)+
           '  STATUSID, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_SP ' +char(13)+
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  CPRNR, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  STATUS, ' +char(13)+
           '  STATUSID, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_TP ' +char(13)+         
           'UNION '+char(13)+
           'SELECT ' +char(13)+
           '  SAGSID, ' +char(13)+
           '  CPRNR, ' +char(13)+
           '  BORGER_ORG, ' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  STATUS, ' +char(13)+
           '  STATUSID, ' +char(13)+
           '  PLEJETYPE' +char(13)+
           'FROM SAGSHISTORIK_MAD ' +char(13)+              
           ' '
if @debug = 1 print @cmd
exec (@cmd)
      
END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=29)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (29,GETDATE())           
end
GO
/****** Object:  StoredProcedure [dbo].[usp_ImportFireBirdData]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery7.sql|7|0|C:\Users\Avaleo\AppData\Local\Temp\4\~vsC66B.sql
/* MODDOC                                                                     
+----------------------------------------------------------------------------+
+-------------+--------------------------------------------------------------+
| DESCRIPTION |                                                       
| SUPPORT:    |                                                               
| VERSION:    |                                                    
| TEST:       |                                                               
+-------------+--------------------------------------------------------------+
| PURPOSE:  Importere en tabel fra den linkede firebird database over i dw.
                                                      
+---------+---------------+-----------+-------------+------------------------+
|HISTORY  |RuneG		  | 01MAJ2007 | Solitwork   | Initial coding.
+---------+---------------+-----------+-------------+------------------------+
                                                                              
MODULEDOCEND */

CREATE PROCEDURE [dbo].[usp_ImportFireBirdData]
                 @TableName VARCHAR(50)
				 
as
         

DECLARE @Cmd1 varchar(8000)
DECLARE @ColName varchar(50)
DECLARE @ColType varchar(50)
DECLARE @ColNull varchar(50)
DECLARE @Cmd varchar(MAX)
DECLARE @TableSchema VARCHAR(50)
DECLARE	@Database VARCHAR(50)
DECLARE	@TableType VARCHAR(50)
DECLARE @ColStr varchar(max)
declare @executionStart as datetime
declare @RowCount as int
declare @linkedserver as varchar(200)
declare @colstrRemoteTable as varchar(max)
declare @InsertCol as varchar(max)
declare @remoteDb as varchar(200)
set @remoteDb = ''


set @TableSchema = 'dbo'
set @tableType = @tablename
set @colstr = ''
set @InsertCol = ''
set @colstrRemoteTable = ''
set @linkedserver = 'OMSORG' 

 if lower(@TableName) = 'borgerjournal'
	return


SET @Cmd = 'IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(TABLE_NAME) = UPPER('+@Tablename+') AND TABLE_SCHEMA = '+@TableSchema+')' 

BEGIN
		  SET @Cmd1='drop table '+@TableSchema+'.'+@Tablename
		  print @cmd1
		  EXEC(@Cmd1)
END 
	
		SET @Cmd1='Create Table '+@TableSchema+'.'+@Tablename +char(13)+'('
		DECLARE CursorCreateTable CURSOR FOR 
		SELECT  ColName , ColType, ColNull from FireBirdDBDataDefinition
		where tablename =@TableType order by sortorder

		OPEN CursorCreateTable 
		FETCH NEXT FROM CursorCreateTable    into  @ColName,@ColType,@ColNull
		   WHILE (@@fetch_status <> -1)
		   BEGIN
			  if @coltype = 'datetime' 
				print @coltype
			  
			  SET @Cmd1=@Cmd1+@ColName+' '+@ColType+' '+@ColNull+char(13)+','
			  SEt @ColStr = @ColStr + @ColName + ','
			  set @colstrRemoteTable = @colstrRemoteTable + @ColName + ','
			  SEt @InsertCol = @InsertCol + @ColName + ','
			 -- print 'colstr ' + @colstr
			  FETCH NEXT FROM CursorCreateTable into  @ColName,@ColType,@ColNull
		   end
		CLOSE CursorCreateTable
		DEALLOCATE CursorCreateTable

if len(@colstr)  = 0  
 return
print @colstrRemoteTable 
SET @Cmd1 = substring(@Cmd1,1,len(@Cmd1)-1)
	SET @Cmd1=@Cmd1+')'
	PRINT @Cmd1
	exec(@Cmd1)

set @executionStart = CURRENT_TIMESTAMP
set @ColStr = substring(@colstr,1,len(@colstr) - 1)
set @colstrRemoteTable = substring(@colstrRemoteTable,1,len(@colstrRemoteTable) - 1)
set @InsertCol = substring(@InsertCol,1,len(@InsertCol) - 1)
set @cmd1 = 'insert into '+@TableSchema+'.' + @tablename + ' (' +  @InsertCol + ') ' +
			'SELECT ' + @ColStr + ' FROM ' +
			 ' OPENQUERY('+@linkedserver+', ''SELECT ' + @colstrRemoteTable + ' FROM ' +@tablename+''')'
print @cmd1
begin try
	exec(@Cmd1)
	set @rowcount = @@rowcount
end try
BEGIN CATCH
	update FireBirdDBDataDefinition set ErrorMessage = ERROR_MESSAGE(), ErrorNumber = ERROR_NUMBER(), errorcmd = @cmd1
	where tableName = @tableName
    SELECT 
        ERROR_NUMBER() as ErrorNumber,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH;

update FireBirdDBDataDefinition set LastImported =CURRENT_TIMESTAMP, rowsimported = @rowcount, 
ExecutionTime = datediff(s,@executionStart, IsNull(CURRENT_TIMESTAMP, @executionStart ))									
where tablename = @Tablename
GO
/****** Object:  StoredProcedure [dbo].[usp_Birthddays]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure that will cause an 
-- object resolution error.
CREATE PROCEDURE [dbo].[usp_Birthddays]
					   @TABLE as  varchar(200),
					   @Database as varchar(200),
					   @VisiColName as varchar(200)
AS
declare @count as int
declare @rownumber as int
declare @loop as int
declare @cmd as varchar(max)
DECLARE @c varchar(4000), @t varchar(128)
declare @Debug int
declare @tmpId int
declare @age as int
declare @maxDate as datetime
declare @tmpAge as int
declare @specifikation as int
declare @cprNr as nvarchar(12)
declare @birthday as datetime

set @debug = 1
set @c = ''
set @t= @TABLE 
set @tmpId = 0

if @debug = 1 print '1. Close Period                                       (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'



set @cmd = 'update '+@Database+'.DBO.'+@t+' set slut=CAST(DATEPART(YEAR,GETDATE()) + 1 AS varCHAR(4))+''-12-31'' where slut = ''9999-01-01 00:00:00.000'''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@Database+'.DBO.sysobjects WHERE name =  ''_'+@t+''' AND type = ''U'') DROP TABLE '+@Database+'.dbo._'+@t+''
if @debug = 1 print @cmd
exec (@cmd)

set @maxdate = (select max(pk_date) from dim_time)
print @maxdate
set @cmd = 'update ' + @Database+ '.dbo.'+@t+' set slut = '''+lower(@maxdate)+''' where slut > '''+lower(@maxdate) +''''
if @debug = 1 print @cmd
exec (@cmd)


/* 2. Use the age function to finde age of person på */

if @debug = 1 print '2. Find age                                           (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'Select Row_Number() OVER (order by a.sagsid asc) as RowNumber,  ' +char(13)+
		   'dbo.Age(b.CPRNR,a.start) as Alder,								' +char(13)+
		   'dbo.Age(b.CPRNR,a.slut) -										' +char(13)+
		   'dbo.Age(b.CPRNR,a.start) as birthdaysInPeriod,					' +char(13)+
		   'b.CPRNR,                                                        ' +char(13)+
		   'a.*																' +char(13)+
		   ' into ' + @Database+ '.dbo._'+@t+
		   ' from  ' + @Database+ '.dbo.'+@t+'  a' +char(13)+
		   ' inner join dimsager b on a.sagsid = b.sagsid '
if @debug = 1 print @cmd
exec (@cmd)

SET @t='_' + @t

/* 3. Find Columns */

if @debug = 1 print '3. Find columns in table and place then in @c         (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

IF OBJECT_ID (N'_tmpTableDef') IS NOT NULL
             DROP table _tmpTableDef;

set @cmd = 'select c.name + '', '' as col ' +char(13)+
			'into _tmpTableDef ' +char(13)+
			'from ' + @Database+ '.dbo.syscolumns c INNER JOIN ' + @Database+ '.dbo.sysobjects o '+char(13)+
			'on o.id = c.id WHERE o.name = ''' + @t +''''+char(13)+
			'order by colid' 
if @debug = 1 print @cmd
exec (@cmd)

SELECT @c = @c + c.col  
FROM _tmpTableDef as c




if @debug = 1 print ' '
if @debug = 1 print '4. Laver temp view                                    (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

IF OBJECT_ID (N'view_name') IS NOT NULL
    DROP view view_name;
set @cmd = 'CREATE VIEW view_name AS SELECT ' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ' from ' + @Database+ '.dbo.'+ @t
if @debug = 1 print @cmd
exec (@cmd)

IF OBJECT_ID (N'#tmp') IS NOT NULL
    DROP table #tmp;
CREATE TABLE #tmp
( 
    age INT, 
    rownumber int,
	birthday datetime
)



if @debug = 1 print ' '
if @debug = 1 print '5. Laver temp table over view                         (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

set @cmd='DECLARE CursorLoop CURSOR FOR '+
         --' Select ' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ' ' +
                        ' Select rownumber,birthdaysInPeriod, Alder, cprnr ' +char(13)+
         ' from view_name ' +char(13)+
		' WHERE (birthdaysInPeriod > 0) '
if @debug = 1 print @cmd
exec(@cmd)
set @loop = 0
set nocount on
OPEN CursorLoop
FETCH NEXT FROM CursorLoop into @rownumber,@count, @age, @cprnr
  WHILE @@FETCH_STATUS = 0
           BEGIN
                      while @loop < @count begin
                                 if @count > 20
									set @loop = @count
                                 set @loop = @loop + 1                              
                                 set @tmpage = @age + @loop
  								 set @birthday = dateadd(year,@tmpage,dbo.getbirthday(@cprnr))
								 insert into #tmp values (@tmpage,@rownumber,@birthday)
							     insert into #tmp values (-@tmpage+1,@rownumber,@birthday)								
                      end
                      set @loop = 0
FETCH NEXT FROM CursorLoop into @rownumber,@count, @age,@cprnr
end
CLOSE CursorLoop
DEALLOCATE CursorLoop
set nocount off

IF OBJECT_ID (N'tmp') IS NOT NULL
  DROP table tmp;

select * into tmp from #tmp



if @debug = 1 print ' '
if @debug = 1 print '6. Tilføje nye post med afgang og tilgang på alder specifikation 6 & 7 '
if @debug = 1 print '----------------------------------------------------------------------'

print @VisiColName
print Substring(@c, 1, Datalength(@c) - 2)
set @cmd = 'insert into ' + @Database+ '.dbo.'+ @t + ' (' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ') ' +char(13)+ 
		   ' select ' + replace(replace (replace (replace( replace( (SELECT Substring(@c, 1, Datalength(@c) - 2)), 'Alder', 'a.age'), 'dato', 'a.birthday as dato'), 'rownumber', 'a.rownumber'),'specifikation','6 as specifikation'), ''+@VisiColName+'', ''+@VisiColName+'' ) + ' ' +char(13)+
		   ' FROM  #tmp a INNER JOIN ' +char(13)+ 
           '' + @Database+ '.dbo.'+ @t + '  b ' +char(13)+ 
           ' on a.rownumber = b.RowNumber ' +char(13)+ 
		   ' where specifikation = 2 and age > 0 ' +char(13)+
			'union all ' +char(13)+ 
		   ' select ' + replace(replace(replace(replace(replace( replace( (SELECT Substring(@c, 1, Datalength(@c) - 2)), 
		    'Alder', 'a.age * -1'),
		    'dato', 'a.birthday as dato'),
		    'rownumber', 'a.rownumber'),
		    'specifikation','7 as specifikation'),
		    'pris','pris * -1 as PRIS'),
		     ''+@VisiColName+'', '-1*'+@VisiColName  ) +char(13)+
			' FROM  #tmp a INNER JOIN            ' +char(13)+ 
           '' + @Database+ '.dbo.'+ @t +  ' b      ' +char(13)+ 
           ' on a.rownumber = b.RowNumber        ' +char(13)+ 
		   ' where specifikation = 2 and age < 0 ' 

if @debug = 1 print @cmd
exec (@cmd)

--IF OBJECT_ID (N'#tmp') IS NOT NULL
  --DROP table #tmp;


if @debug = 1 print ' '
if @debug = 1 print '6. Tilrettet table og skifter den ud                  (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'IF EXISTS(SELECT name FROM '+@Database+'.DBO.sysobjects WHERE name =  '''+@TABLE+''' AND type = ''U'') DROP TABLE '+@Database+'.dbo.'+@TABLE+''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN birthdaysInPeriod'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN start'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN slut'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN RowNumber'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF OBJECT_ID (N'''+@TABLE+''') IS NOT NULL DROP table ' + @TABLE+';'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = @Database+ '.dbo.sp_rename '''+@t+''','''+@TABLE+''''
if @debug = 1 print @cmd
exec (@cmd)

IF OBJECT_ID (N'tmp') IS NOT NULL
    DROP table tmp;
select * into tmp from #tmp

--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'tmp' AND type = 'U') DROP TABLE tmp
--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmpTableDef' AND type = 'U') DROP TABLE _tmpTableDef
--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '__tmp_HJVISITATION_PB' AND type = 'U') DROP TABLE __tmp_HJVISITATION_PB

return

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=17)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (17,GETDATE())           
end
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareAnalysisdata]    Script Date: 10/06/2015 18:35:19 ******/
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
--20. Lav funktionsniveau


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
--8.Lav Planlagt - Udført (tidl SagsPlanMedArbejder) facttable
-----------------------------------------------------------------------------------------------------
if (@ExPart=8 or @ExPart=0  or (@ExPart>100 and @ExPart<=108))
begin
print '---------------------------------------------------------------------------------------------'
print '8.Lav Planlagt - Udført facttable'
print ''
set @cmd = 'exec usp_CreateFactPlanlagtUdfoertTid '''+@DestinationDB+''',1'
--set @cmd = 'exec usp_Create_FactTables_SagsPlan ''' + @DestinationDB + ''''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'exec usp_CreateFactPlanlagtUdfoertTid '''+@DestinationDB+''',2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'exec usp_CreateFactPlanlagtUdfoertTid '''+@DestinationDB+''',3'
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
			'COALESCE((SELECT ID FROM '+@DestinationDB+'.dbo.DimFritvalgLeverandor WHERE ID=FRITVALGLEV),9999) AS FRITVALGLEV, ' +char(13)+ --sikre at leverandør eksisterer
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
			'COALESCE((SELECT ID FROM '+@DestinationDB+'.dbo.DimFritvalgLeverandor WHERE ID=FRITVALGLEV),9999) AS FRITVALGLEV, ' +char(13)+ --sikre at leverandør eksisterer
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
			'COALESCE((SELECT ID FROM '+@DestinationDB+'.dbo.DimFritvalgLeverandor WHERE ID=FRITVALGLEV),9999) AS FRITVALGLEV, ' +char(13)+ --sikre at leverandør eksisterer
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
			'COALESCE((SELECT ID FROM '+@DestinationDB+'.dbo.DimFritvalgLeverandor WHERE ID=FRITVALGLEV),9999) AS FRITVALGLEV, ' +char(13)+ --sikre at leverandør eksisterer
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
--###
--Ny Tilgang/afgang (Visitations bevægelser)
set @cmd = 'exec usp_LavVisitationTil_Afgang ''' + @DestinationDB + ''',0'
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
 'SELECT A.Alder,' +char(13)+
   'A.CPRNR,' +char(13)+
   'A.SagsID,' +char(13)+
   'A.Dato,' + char (13) + 
   'A.HjemmePleje_Status,' +char(13)+
   'A.HjemmePleje_StatusID,' + char (13) +
   'A.Organization,' +char(13)+
   'A.Dogninddeling,' +char(13)+
   'A.Hjalptype,' +char(13)+ --HDJ
   '2 as Specifikation,' + char (13) + --tilgang
   'A.VisiJob,' +char(13)+
   'VisiJobHverdag,' +char(13)+
   'VisiJobWeekend,' +char(13)+
   'A.JobID,' +char(13)+
   'A.Pris,' +char(13)+
   'Convert(float,A.Antal_pakker) as Antal_pakker,' +char(13)+
   'A.FritValgLev,' + char (13) +
   'A.InternLeverandoerID, ' +char(13)+
   'A.BorgerStart,' +char(13)+
   'A.BorgerSlut, ' +char(13)+
   'DIMTIME.PK_Date,' + char (13) +
   'A.Antal as AntalTotal,'+char(13)+
   'A.VisiID'+char(13)+
 'into '+@DestDB+'.dbo.FACT_VISISAGJOB_Afregnet_udenJobpriser' +char(13)+
 'FROM '+@DestDB+'.dbo.FactVisisagjobAfregnet_TilAfgang A INNER JOIN' + char (13) +
    ''+@DestDB+'.dbo.DIMTIME ON A.BorgerStart='+@DestDB+'.dbo.DIMTIME.PK_Date AND' + char (13) +
    'A.BorgerSlut>='+@DestDB+'.dbo.DIMTIME.PK_Date AND' + char (13) +
    'A.PrisSLUT>'+@DestDB+'.dbo.DIMTIME.PK_Date and' + char (13) +
    'A.Prisstart<='+@DestDB+'.dbo.DIMTIME.PK_Date' + char (13) +
 'WHERE (A.specifikation=2)'+char(13)+ 
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
           '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 THEN VisijobHverdag     ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS VISITERET_TID_Hverdag, ' +char(13)+ 
		   '  CASE WHEN B.HELLIGDAG=0 THEN ' + char (13) +
		   '    CASE WHEN B.WEEKEND=1 then VisijobWeekend ' + char (13) +
		   '    ELSE 0 ' + char (13) +
		   '    END ' +char(13)+
		   '  END AS VISITERET_TID_Weekend, ' + char (13) +
		   '  CASE WHEN B.HELLIGDAG=1 THEN ' + char (13) +
	       '    CASE WHEN B.WEEKEND=0 THEN VisijobHverdag     ' + char (13) +
		   '    ELSE VisijobWeekend ' + char (13) +
		   '    END ' +char(13)+		   
		   '  ELSE 0 END AS VISITERET_TID_HELLIGDAG, ' +char(13)+				
				'       case                                               ' + char (13) +
				'          when a.jobid=0    then 9999                      ' + char (13) +
				--'          when a.jobid=9999 then 999                      ' + char (13) +
				'          else COALESCE(a.Jobid,9999)                      ' + char (13) +
				'       end       as JobID,                                '+char(13)+
				'       a.Pris                             as Pris,'+char(13)+
				'       a.Antal_Pakker                     as Antal_Pakker, ' + char (13) +
				'       a.Fritvalglev                      as FritValgLev,'+char(13)+
				'       a.INTERNLEVERANDOERID as InternLeverandoerID, ' +char(13)+
				'       a.BorgerStart                      as BorgerStart, ' + char (13) +
				'       a.BorgerSlut                       as BorgerSlut,'+char(13)+
				'       a.PK_Date,                           ' + char (13) +
				'     a.Antal_pakker                       as Antal, ' + char (13) +
				'     a.AntalTotal						   as AntalTotal,' + char (13) +
				'     a.VisiID,'											+char(13) +
				'     null								   as JobLeveringsTidID, ' + CHAR(13) +		
				'     Convert(float,null)                  as Funktionsscore,      ' + CHAR(13) +	  
				'     null                                 as FunktionsscoreNaevner,  ' + CHAR(13) +	  
				'     null                                 as FunktionsscoreTotal,      ' + CHAR(13) +
				'     null                                 as FunktionsscoreCounter      ' + CHAR(13) +						
				'into '+@DestinationDB+'.dbo.FactVisiSagJobAfregnet'											+char(13)+
				'FROM '+@DestinationDB+'.dbo.FACT_VISISAGJOB_Afregnet_udenJobpriser a ' +char(13)+
				'JOIN DimWeekendHelligdag B on A.PK_DATE=B.PK_DATE' +char(13)+
				' '+ +'' + char (13) + @DebugCmd
				
	 

	if @debug = 1 print @cmd
	exec (@cmd)

end  -- part 14
--------------------------------------------------------------------------------------------------
--15.Lav FACTVISISAGJobAfregnet - Sæt PakkeID ind
--Udelukkende til Gribskov derfor slettet
-----------------------------------------------------------------------------------------------------

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
                'WHERE PK_Date>CAST(DATEPART(YEAR,GETDATE()) + 1 AS varCHAR(4))+''-12-31'''--GETDATE() '
    if @debug = 1 print @cmd
	exec (@cmd)
    
    set @cmd = 	'DELETE  '+@DestinationDB+'.dbo.[FactVisiSagJobAfregnet_Pakker] '+ CHAR(13)+
                'WHERE PK_Date>CAST(DATEPART(YEAR,GETDATE()) + 1 AS varCHAR(4))+''-12-31'''--GETDATE()'
    if @debug = 1 print @cmd
    exec (@cmd)
	
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
  		    ' FROM	 '+@DestinationDB+'.DBO.DIM_TIME e ' +char(13)+
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
           '  CONVERT(DATETIME,NULL) AS IKRAFTDATO, ' +char(13)+
           '  CONVERT(DATETIME,NULL) AS SLUTDATO, ' +char(13)+
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
           '  CASE WHEN OMKOST_GRUPPE IS NOT NULL THEN ' +char(13)+  
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
           '  CONVERT(DATETIME,NULL) AS IKRAFTDATO, ' +char(13)+
           '  CONVERT(DATETIME,NULL) AS SLUTDATO, ' +char(13)+
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
if @debug = 1 print @cmd
exec (@cmd)
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

-----------------------------------------------------------------------------------------------------
--20. Lav Funktionsniveau
-----------------------------------------------------------------------------------------------------

if (@ExPart=20 or @ExPart=0)
begin
print '---------------------------------------------------------------------------------------------'
print '20. Lav Funktionsniveau'
print ''
 
set @cmd = 'exec usp_LavFunktionsNiveau ''' + @DestinationDB + ''''
if @debug = 1 print @cmd
exec (@cmd)
end -- end part 20

if (@ExPart=21 or @ExPart=0)
begin
print '---------------------------------------------------------------------------------------------'
print '21. Lav Systembruger'
print ''
 

set @cmd = 'EXEC dbo.usp_Create_Fact_Bruger '''+@DestinationDB+''',0'
if @debug = 1 print @cmd
exec (@cmd)
end -- end part 21





declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=43)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (43,GETDATE())           
end
GO
/****** Object:  View [dbo].[vDimYdelsespakker]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vDimYdelsespakker]
AS
SELECT     Pakke_ID, Pakke_Navn, Ydelse_Dag, Ydelse_Aften, Ydelse_Nat, Ydelse_Sumtype, Fra_Antal, Til_Antal, Pakke_Sumtype, Status
FROM         dbo.YDELSESPAKKER
GO
/****** Object:  View [dbo].[vDimJobTyper]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view
[dbo].[vDimJobTyper]
 as
SELECT  
 cast(null as int)  ParentID
,
cast(
CAST(FALLES_SPROG_ART  as int)	*100000000
+CAST(0 as int)			*100000
+CAST(0 as int)			*100
+CAST(0 as int)			
+CAST(0 as int)      as int  ) JobID
,Falles_Sprog_Art
,0 as Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
,'Fælles Sprog '+cast(Falles_Sprog_Art as nvarchar(4)) Jobnavn  

from    [dbo].[JOBTYPER]
group by Falles_Sprog_Art
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/

SELECT   distinct 
 CAST(FALLES_SPROG_ART as int)	*100000000
+CAST(0 as int)			*100000
+CAST(0 as int)			*100
+CAST(0 as int)			
+CAST(0 as int) ParentID
,Jobid
,Falles_Sprog_Art
,Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
, Jobnavn  
 from   [dbo].[JOBTYPER]
where    Niveau1 = 0
  and    Niveau2 = 0
  and    Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
b.ParentID
,a.JobID
,a.Falles_Sprog_Art
,a.Kategori
,a.Niveau1
,a.Niveau2
,a.Niveau3
,a.Jobnavn  
from   [dbo].[JOBTYPER] a left join 
(
SELECT   distinct 
 Jobid ParentID
,Falles_Sprog_Art
,Kategori
 from   [dbo].[JOBTYPER]
where    Niveau1 = 0
  and    Niveau2 = 0
  and    Niveau3 =  0  
) b on a.Falles_Sprog_Art=b.Falles_Sprog_Art and a.KATEGORI=b.KATEGORI
  where  NIVEAU2 =0
  and    NIVEAU3 =0
  and    NIVEAU1 <>0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 b.ParentID
,A.JobID
,A.Falles_Sprog_Art
,A.Kategori
,A.Niveau1
,A.Niveau2
,A.Niveau3
,A.Jobnavn  from   [dbo].[JOBTYPER] a left join 
(
SELECT   distinct 
 Jobid ParentID
,Falles_Sprog_Art
,Kategori
,Niveau1
 from   [dbo].[JOBTYPER]
where    Niveau1 <> 0
  and    Niveau2 = 0
  and    Niveau3 =  0  
) b on a.Falles_Sprog_Art=b.Falles_Sprog_Art and a.KATEGORI=b.KATEGORI and a.Niveau1=b.Niveau1
  where  A.Niveau1 <> 0
  and    A.Niveau2 <>  0
  and    A.Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 b.ParentID
,a.JobID
,a.Falles_Sprog_Art
,a.Kategori
,a.Niveau1
,a.Niveau2
,a.Niveau3
,a.Jobnavn  
from   [dbo].[JOBTYPER] a left join 
(
SELECT   distinct 
 Jobid ParentID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
 from   [dbo].[JOBTYPER]
where    Niveau1 <> 0
  and    Niveau2 <> 0
  and    Niveau3 =  0  
) b on
     a.Falles_Sprog_Art=b.Falles_Sprog_Art
 and a.KATEGORI=b.KATEGORI 
 and a.Niveau1=b.Niveau1 
 and A.Niveau2 = b.Niveau2
  where  a.Niveau1 <> 0
  and    a.Niveau2 <> 0
  and    a.Niveau3 <>  0
GO
/****** Object:  StoredProcedure [dbo].[usp_TP_SagsHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_TP_SagsHistorik]
  @debug as bit =0
AS

declare @DebugCmd as nvarchar(4000)

--Debug kode
 if (@debug=1)  set @DebugCmd = 'where sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_TP_SAGSHISTORIK' AND type = 'U') DROP TABLE _tmp_TP_SAGSHISTORIK

CREATE TABLE   #_tmp_TP_SAGSHISTORIK (
	
	[SLUTDATO] [datetime] NOT NULL,	
	[ID] [int] NULL
) ON [PRIMARY]

CREATE TABLE   #_tmp2_TP_SAGSHISTORIK (	
	[SLUTDATO] [datetime] NOT NULL,
	[ID] [int] NULL
) ON [PRIMARY]


declare @SAGSID as varchar(200)
declare @IKRAFTDATO as datetime
declare @SLUTDATO as datetime
declare @TERAPEUT_STATUS as varchar(200)
declare @TERAPEUT_STATUSID as varchar(200)
declare @TERAPEUT_GRUPPEID as varchar(200)
declare @cmd as varchar(max)
declare @SAGSID_Prev as varchar(200)
declare @IKRAFTDATO_Prev as datetime
declare @SLUTDATO_Prev as datetime
declare @TERAPEUT_STATUS_Prev as varchar(200)
declare @TERAPEUT_STATUSID_Prev as varchar(200)
declare @TERAPEUT_GRUPPEID_Prev as varchar(200)
declare @found as bit
declare @id as int
declare @tableID as int
declare @CurrentSLUTDATO as datetime
declare @PrevId as int
declare @tmpCounter as int
declare @prevFound as int
declare @prevSlutdato as datetime
declare @insertConunter as int
set @found = 0
set @id = 0
set @previd = 0
set @tmpcounter = 0
set @prevfound = 0
set @insertConunter = 0

--lav først view
IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Temp_TPSagshistorik' AND type = 'V') DROP View Temp_TPSagshistorik

set @cmd = 'CREATE VIEW [dbo].[Temp_TPSagshistorik] ' +
			'AS SELECT ID, SAGSID, ' +
			'IKRAFTDATO, SLUTDATO, ' +
			'COALESCE (TERAPEUT_STATUS, 1) AS TERAPEUT_STATUS, ' +
			'COALESCE (TERAPEUT_STATUSID, 1) AS TERAPEUT_STATUSID, ' +
			'COALESCE (TERAPEUT_GRUPPEID, 9999) AS TERAPEUT_GRUPPEID ' +
			'FROM  dbo.SAGSHISTORIK '+@DebugCmd
print @cmd
exec(@cmd)
--view færdig

DECLARE CursorLoopMemberid CURSOR FORWARD_ONLY for
SELECT     SAGSID, IKRAFTDATO, SLUTDATO, TERAPEUT_STATUS, TERAPEUT_STATUSID, TERAPEUT_GRUPPEID, id 
FROM         Temp_TPSagshistorik
WHERE     (TERAPEUT_STATUSID is not null)  --and TERAPEUT_STATUSid = 34)
order by sagsid,IKRAFTDATO, slutdato
SET NOCOUNT ON
OPEN CursorLoopMemberid
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @TERAPEUT_STATUS, @TERAPEUT_STATUSID, @TERAPEUT_GRUPPEID, @ID 
  WHILE @@FETCH_STATUS = 0
   BEGIN  		 
		/*
		print '@SAGSID ' + @SAGSID
		print  @IKRAFTDATO 
		print  @SLUTDATO 
		print '@TERAPEUT_STATUS ' + @TERAPEUT_STATUS
		print '@TERAPEUT_STATUSID ' + @TERAPEUT_STATUSID
		print '@TERAPEUT_GRUPPEID ' + @TERAPEUT_GRUPPEID
		*/
		
		if  @SAGSID_Prev = @SAGSID begin
			if  @TERAPEUT_STATUS_Prev = @TERAPEUT_STATUS begin
				if  @TERAPEUT_STATUSID_Prev = @TERAPEUT_STATUSID begin					
					if  @TERAPEUT_GRUPPEID_Prev = @TERAPEUT_GRUPPEID begin
						/*
						print '---------------------------------------'
						print '@SAGSID ' + @SAGSID
						print  @IKRAFTDATO 
						print  @SLUTDATO 
						print '@TERAPEUT_STATUS ' + @TERAPEUT_STATUS
						print '@TERAPEUT_STATUSID ' + @TERAPEUT_STATUSID
						print '@TERAPEUT_GRUPPEID ' + @TERAPEUT_GRUPPEID
						*/
						set @found = 1						
						--	set @tmpcounter = @tmpcounter + 1
						set @currentslutdato = @SLUTDATO
						set @slutdato = null
					end					
				end
			end
		end
			if @found = 0 and @prevfound = 1 begin			
			update #_tmp2_TP_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd -- and sagsid = @SAGSID_Prev
			--set @tmpcounter = @tmpcounter + 1
		end
		if(@slutdato is not null) begin			
		   if(@currentslutdato is null)
			 set @currentslutdato = @slutdato				
				insert into #_tmp_TP_SAGSHISTORIK select * from #_tmp2_TP_SAGSHISTORIK
				delete from #_tmp2_TP_SAGSHISTORIK				
				insert into #_tmp2_TP_SAGSHISTORIK values (@SLUTDATO,@ID)		
				--set @insertConunter = @insertConunter + 1				
			set @found = 0
			set @currentslutdato = null				
		end			
		set @prevfound = @found
		if(@found = 0) 
			set @previd = @id		
		set @found = 0
		set @SAGSID_Prev = @SAGSID
		set @IKRAFTDATO_Prev = @IKRAFTDATO
		set @SLUTDATO_Prev = @SLUTDATO
		set @TERAPEUT_STATUS_Prev = @TERAPEUT_STATUS
		set @TERAPEUT_STATUSID_Prev = @TERAPEUT_STATUSID
		set @TERAPEUT_GRUPPEID_Prev = @TERAPEUT_GRUPPEID
		set @prevslutdato = @currentslutdato  
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @TERAPEUT_STATUS, @TERAPEUT_STATUSID, @TERAPEUT_GRUPPEID, @id 
   end
CLOSE CursorLoopMemberid
DEALLOCATE CursorLoopMemberid
SET NOCOUNT OFF

if @found = 0 and @prevfound = 1 begin
	print 'exupdate'
	update #_tmp2_TP_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd
	set @tmpcounter = @tmpcounter + 1
end
insert into #_tmp_TP_SAGSHISTORIK select * from #_tmp2_TP_SAGSHISTORIK
--select * into _tmp_HJ_SAGSHISTORIK from #_tmp_HJ_SAGSHISTORIK 

SELECT SAGSHISTORIK.IKRAFTDATO, 
#_tmp_TP_SAGSHISTORIK.SLUTDATO, 
COALESCE (SAGSHISTORIK.TERAPEUT_STATUS, 1) AS TERAPEUT_STATUS, 
COALESCE (SAGSHISTORIK.TERAPEUT_STATUSID, 1) AS TERAPEUT_STATUSID, 
COALESCE (SAGSHISTORIK.TERAPEUT_GRUPPEID, 9999) AS TERAPEUT_GRUPPEID, 
SAGSHISTORIK.ID, SAGSHISTORIK.SAGSID
into _tmp_TP_SAGSHISTORIK
FROM  #_tmp_TP_SAGSHISTORIK INNER JOIN
	SAGSHISTORIK ON #_tmp_TP_SAGSHISTORIK.ID = SAGSHISTORIK.ID

Drop table #_tmp_TP_SAGSHISTORIK
Drop table #_tmp2_TP_SAGSHISTORIK

print lower(@tmpcounter) + ' updates'
print lower(@insertConunter) + ' inserts'

return

select * into _tmp_TP_SAGSHISTORIK from #_tmp_TP_SAGSHISTORIK 
Drop table #_tmp_TP_SAGSHISTORIK

return
GO
/****** Object:  StoredProcedure [dbo].[usp_SP_SagsHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_SP_SagsHistorik]
@debug as bit=0
AS
declare @DebugCmd as nvarchar(4000)


--Debug kode
 if (@debug=1)  set @DebugCmd = 'where sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_SP_SAGSHISTORIK' AND type = 'U') DROP TABLE _tmp_SP_SAGSHISTORIK

CREATE TABLE   #_tmp_SP_SAGSHISTORIK (
	
	[SLUTDATO] [datetime] NOT NULL,	
	[ID] [int] NULL
) ON [PRIMARY]

CREATE TABLE   #_tmp2_SP_SAGSHISTORIK (	
	[SLUTDATO] [datetime] NOT NULL,
	[ID] [int] NULL
) ON [PRIMARY]


declare @SAGSID as varchar(200)
declare @IKRAFTDATO as datetime
declare @SLUTDATO as datetime
declare @SYGEPLEJE_STATUS as varchar(200)
declare @SYGEPLEJE_STATUSID as varchar(200)
declare @SYGEPLEJE_GRUPPEID as varchar(200)
DECLARE @SYPL_AFTENGRP_ID AS varchar(200)
DECLARE @SYPL_NATGRP_ID AS varchar(200)
declare @cmd as varchar(max)
declare @SAGSID_Prev as varchar(200)
declare @IKRAFTDATO_Prev as datetime
declare @SLUTDATO_Prev as datetime
declare @SYGEPLEJE_STATUS_Prev as varchar(200)
declare @SYGEPLEJE_STATUSID_Prev as varchar(200)
declare @SYGEPLEJE_GRUPPEID_Prev as varchar(200)
declare @found as bit
declare @id as int
declare @tableID as int
declare @CurrentSLUTDATO as datetime
declare @PrevId as int
declare @tmpCounter as int
declare @prevFound as int
declare @prevSlutdato as datetime
declare @insertConunter as int
DECLARE @SYPL_AFTENGRP_ID_PREV AS varchar(200)
DECLARE @SYPL_NATGRP_ID_PREV AS varchar(200)
DECLARE @HJPL_DAGGRP_ID AS varchar(200)
DECLARE @HJPL_AFTENGRP_ID AS varchar(200)
DECLARE @HJPL_NATGRP_ID AS varchar(200)
DECLARE @HJPL_DAGGRP_ID_PREV AS varchar(200)
DECLARE @HJPL_AFTENGRP_ID_PREV AS varchar(200)
DECLARE @HJPL_NATGRP_ID_PREV AS varchar(200)
set @found = 0
set @id = 0
set @previd = 0
set @tmpcounter = 0
set @prevfound = 0
set @insertConunter = 0

--lav først view
IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Temp_SPSagshistorik' AND type = 'V') DROP View Temp_SPSagshistorik

set @cmd = 'CREATE VIEW [dbo].[Temp_SPSagshistorik] ' +    
			'AS SELECT ID, SAGSID, ' +
			'IKRAFTDATO, SLUTDATO, ' +
			'COALESCE (SYGEPLEJE_STATUS, 1) AS SYGEPLEJE_STATUS, ' +
			'COALESCE (SYGEPLEJE_STATUSID, 1) AS SYGEPLEJE_STATUSID, ' +
			'COALESCE (SYGEPLEJE_GRUPPEID, 9999) AS SYGEPLEJE_GRUPPEID, ' +
			'COALESCE (SPGRP_AFTEN_ID,5555) AS SYPL_AFTENGRP_ID, ' +
			'COALESCE (SPGRP_NAT_ID,5555) AS SYPL_NATGRP_ID, ' +
			'COALESCE (HJEMMEPLEJE_GRUPPEID,5555) AS HJPL_DAGGRP_ID, ' +     
			'COALESCE (HJGRP_AFTEN_ID,5555) AS HJPL_AFTENGRP_ID, ' +
			'COALESCE (HJGRP_NAT_ID,5555) AS HJPL_NATGRP_ID ' +
			'FROM  dbo.SAGSHISTORIK '+@DebugCmd
print @cmd
exec(@cmd)
--view færdig

DECLARE CursorLoopMemberid CURSOR FORWARD_ONLY for
SELECT     SAGSID, IKRAFTDATO, SLUTDATO, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID, id,
  SYPL_AFTENGRP_ID,SYPL_NATGRP_ID,HJPL_DAGGRP_ID,HJPL_AFTENGRP_ID,HJPL_NATGRP_ID
FROM         Temp_SPSagshistorik
WHERE     (SYGEPLEJE_STATUSID is not null)  --and SYGEPLEJE_STATUSid = 34)
order by sagsid,IKRAFTDATO, slutdato
SET NOCOUNT ON
OPEN CursorLoopMemberid
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @SYGEPLEJE_STATUS, @SYGEPLEJE_STATUSID, @SYGEPLEJE_GRUPPEID, 
  @ID,@SYPL_AFTENGRP_ID,@SYPL_NATGRP_ID,@HJPL_DAGGRP_ID,@HJPL_AFTENGRP_ID,@HJPL_NATGRP_ID 
  WHILE @@FETCH_STATUS = 0
   BEGIN  		 
		/*
		print '@SAGSID ' + @SAGSID
		print  @IKRAFTDATO 
		print  @SLUTDATO 
		print '@SYGEPLEJE_STATUS ' + @SYGEPLEJE_STATUS
		print '@SYGEPLEJE_STATUSID ' + @SYGEPLEJE_STATUSID
		print '@SYGEPLEJE_GRUPPEID ' + @SYGEPLEJE_GRUPPEID
		*/
		
		if  @SAGSID_Prev = @SAGSID begin
			if  @SYGEPLEJE_STATUS_Prev = @SYGEPLEJE_STATUS begin
				if  @SYGEPLEJE_STATUSID_Prev = @SYGEPLEJE_STATUSID begin					
					if  @SYGEPLEJE_GRUPPEID_Prev = @SYGEPLEJE_GRUPPEID begin
				       if @SYPL_AFTENGRP_ID_PREV=@SYPL_AFTENGRP_ID begin
				          if @SYPL_NATGRP_ID_PREV=@SYPL_NATGRP_ID begin 
					        
					        if  @HJPL_DAGGRP_ID_PREV = @HJPL_DAGGRP_ID begin
					          if  @HJPL_AFTENGRP_ID_PREV = @HJPL_AFTENGRP_ID begin
					            if  @HJPL_NATGRP_ID_PREV = @HJPL_NATGRP_ID begin				          
						/*
						print '---------------------------------------'
						print '@SAGSID ' + @SAGSID
						print  @IKRAFTDATO 
						print  @SLUTDATO 
						print '@SYGEPLEJE_STATUS ' + @SYGEPLEJE_STATUS
						print '@SYGEPLEJE_STATUSID ' + @SYGEPLEJE_STATUSID
						print '@SYGEPLEJE_GRUPPEID ' + @SYGEPLEJE_GRUPPEID
						*/
						set @found = 1						
						--	set @tmpcounter = @tmpcounter + 1
						set @currentslutdato = @SLUTDATO
						set @slutdato = null
						
						        end
						      end
						    end
						        
						end
					  end
					end					
				end
			end
		end
			if @found = 0 and @prevfound = 1 begin			
			update #_tmp2_SP_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd -- and sagsid = @SAGSID_Prev
			--set @tmpcounter = @tmpcounter + 1
		end
		if(@slutdato is not null) begin			
		   if(@currentslutdato is null)
			 set @currentslutdato = @slutdato				
				insert into #_tmp_SP_SAGSHISTORIK select * from #_tmp2_SP_SAGSHISTORIK
				delete from #_tmp2_SP_SAGSHISTORIK				
				insert into #_tmp2_SP_SAGSHISTORIK values (@SLUTDATO,@ID)		
				--set @insertConunter = @insertConunter + 1				
			set @found = 0
			set @currentslutdato = null				
		end			
		set @prevfound = @found
		if(@found = 0) 
			set @previd = @id		
		set @found = 0
		set @SAGSID_Prev = @SAGSID
		set @IKRAFTDATO_Prev = @IKRAFTDATO
		set @SLUTDATO_Prev = @SLUTDATO
		set @SYGEPLEJE_STATUS_Prev = @SYGEPLEJE_STATUS
		set @SYGEPLEJE_STATUSID_Prev = @SYGEPLEJE_STATUSID
		set @SYGEPLEJE_GRUPPEID_Prev = @SYGEPLEJE_GRUPPEID
		set @SYPL_AFTENGRP_ID_PREV=@SYPL_AFTENGRP_ID
		set @SYPL_NATGRP_ID_PREV=@SYPL_NATGRP_ID	
		set @HJPL_DAGGRP_ID_PREV = @HJPL_DAGGRP_ID	
        set @HJPL_AFTENGRP_ID_PREV = @HJPL_AFTENGRP_ID
		set @HJPL_NATGRP_ID_PREV = @HJPL_NATGRP_ID			
		set @prevslutdato = @currentslutdato  
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @SYGEPLEJE_STATUS, @SYGEPLEJE_STATUSID, @SYGEPLEJE_GRUPPEID, @id,
  @SYPL_AFTENGRP_ID,@SYPL_NATGRP_ID,@HJPL_DAGGRP_ID,@HJPL_AFTENGRP_ID,@HJPL_NATGRP_ID
   end
CLOSE CursorLoopMemberid
DEALLOCATE CursorLoopMemberid
SET NOCOUNT OFF

if @found = 0 and @prevfound = 1 begin
	print 'exupdate'
	update #_tmp2_SP_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd
	set @tmpcounter = @tmpcounter + 1
end
insert into #_tmp_SP_SAGSHISTORIK select * from #_tmp2_SP_SAGSHISTORIK
--select * into _tmp_HJ_SAGSHISTORIK from #_tmp_HJ_SAGSHISTORIK 

SELECT SAGSHISTORIK.IKRAFTDATO, 
#_tmp_SP_SAGSHISTORIK.SLUTDATO, 
COALESCE (SAGSHISTORIK.SYGEPLEJE_STATUS, 1) AS SYGEPLEJE_STATUS, 
COALESCE (SAGSHISTORIK.SYGEPLEJE_STATUSID, 1) AS SYGEPLEJE_STATUSID, 
COALESCE (SAGSHISTORIK.SYGEPLEJE_GRUPPEID, 9999) AS SYGEPLEJE_GRUPPEID, 
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.SPGRP_AFTEN_ID),5555) AS SYPL_AFTENGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.SPGRP_NAT_ID),5555) AS SYPL_NATGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.HJEMMEPLEJE_GRUPPEID),5555) AS HJPL_DAGGRP_ID, 
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.HJGRP_AFTEN_ID),5555) AS HJPL_AFTENGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.HJGRP_NAT_ID),5555) AS HJPL_NATGRP_ID,
SAGSHISTORIK.ID, SAGSHISTORIK.SAGSID
into _tmp_SP_SAGSHISTORIK
FROM  #_tmp_SP_SAGSHISTORIK INNER JOIN
	SAGSHISTORIK ON #_tmp_SP_SAGSHISTORIK.ID = SAGSHISTORIK.ID

Drop table #_tmp_SP_SAGSHISTORIK
Drop table #_tmp2_SP_SAGSHISTORIK

print lower(@tmpcounter) + ' updates'
print lower(@insertConunter) + ' inserts'

return

select * into _tmp_SP_SAGSHISTORIK from #_tmp_SP_SAGSHISTORIK 
Drop table #_tmp_SP_SAGSHISTORIK

return
GO
/****** Object:  StoredProcedure [dbo].[usp_Mad_SagsHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_Mad_SagsHistorik]

AS

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_MAD_SAGSHISTORIK' AND type = 'U') DROP TABLE _tmp_MAD_SAGSHISTORIK

CREATE TABLE   #_tmp_MAD_SAGSHISTORIK (
	
	[SLUTDATO] [datetime] NOT NULL,	
	[ID] [int] NULL
) ON [PRIMARY]

CREATE TABLE   #_tmp2_MAD_SAGSHISTORIK (	
	[SLUTDATO] [datetime] NOT NULL,
	[ID] [int] NULL
) ON [PRIMARY]


declare @SAGSID as varchar(200)
declare @IKRAFTDATO as datetime
declare @SLUTDATO as datetime
declare @MAD_STATUS as varchar(200)
declare @MAD_STATUSID as varchar(200)
declare @MAD_GRUPPEID as varchar(200)
declare @cmd as varchar(max)
declare @SAGSID_Prev as varchar(200)
declare @IKRAFTDATO_Prev as datetime
declare @SLUTDATO_Prev as datetime
declare @MAD_STATUS_Prev as varchar(200)
declare @MAD_STATUSID_Prev as varchar(200)
declare @MAD_GRUPPEID_Prev as varchar(200)
declare @found as bit
declare @id as int
declare @tableID as int
declare @CurrentSLUTDATO as datetime
declare @PrevId as int
declare @tmpCounter as int
declare @prevFound as int
declare @prevSlutdato as datetime
declare @insertConunter as int
set @found = 0
set @id = 0
set @previd = 0
set @tmpcounter = 0
set @prevfound = 0
set @insertConunter = 0

--lav først view
IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Temp_MADSagshistorik' AND type = 'V') DROP View Temp_MADSagshistorik

set @cmd = 'CREATE VIEW [dbo].[Temp_MADSagshistorik] ' +
			'AS SELECT ID, SAGSID, ' +
			'IKRAFTDATO, SLUTDATO, ' +
			'COALESCE (MADVISI_STATUS, 0) AS MADVISI_STATUS, ' +
			'COALESCE (MADVISI_STATUSID, 1) AS MADVISI_STATUSID ' +
	--		',COALESCE (HJEMMEPLEJE_GRUPPEID, 99999) AS MAD_GRUPPEID ' +
			'FROM  dbo.SAGSHISTORIK where madvisi_statusid is not null'---where sagsid = ''30638'''-- ''26098'''
print @cmd
exec(@cmd)
--view færdig
declare  @counter  as int
set @counter = 0
DECLARE MADCursorLoop CURSOR FAST_FORWARD for
SELECT     SAGSID, IKRAFTDATO, SLUTDATO, MADVISI_STATUS, MADVISI_STATUSID, ID 
FROM         Temp_MADSagshistorik
WHERE     (MADVISI_STATUSID is not null)  --and SYGEPLEJE_STATUSid = 34)
order by sagsid,IKRAFTDATO, slutdato

SET NOCOUNT ON
OPEN MADCursorLoop
FETCH NEXT FROM MADCursorLoop  into @SAGSID, @IKRAFTDATO, @SLUTDATO, @MAD_STATUS, @MAD_STATUSID, @ID 
  WHILE @@FETCH_STATUS = 0
   BEGIN  
		/*		 
		print '-----------------------------------------------------------------------------------'
		print '1 @SAGSID ' + @SAGSID
		print '2 @IKRAFTDATO ' + lower( @IKRAFTDATO )
		print '3 @SLUTDATO ' + lower(@SLUTDATO)
		print '4 MADVISI_STATUS ' + @MAD_STATUS
		print '5 MADVISI_STATUSID ' +@MAD_STATUSID
		PRINT '6 @prevfound ' +  LOWER(@prevfound)
		print '7 @SAGSID ' + @SAGSID
		print '8 @SAGSID_Prev ' + @SAGSID_Prev 		
        print '9 @MAD_STATUS ' + @MAD_STATUS				
		print '10 @MAD_STATUS_Prev ' + @MAD_STATUS_Prev
	    print '11 @MAD_STATUSID ' +@MAD_STATUSID				
		print '12 @MAD_STATUSID_Prev ' +@MAD_STATUSID_Prev
		*/
		if  @SAGSID_Prev = @SAGSID begin
			if  @MAD_STATUS_Prev = @MAD_STATUS begin
				if  @MAD_STATUSID_Prev = @MAD_STATUSID begin					
					--if  @MAD_GRUPPEID_Prev = @MAD_GRUPPEID begin
						/*
						--print '---------------------------------------'
						print '@SAGSID ' + @SAGSID
						print '@SAGSID_Prev ' + @SAGSID_Prev 		
				        print '@MAD_STATUS ' + @MAD_STATUS				
						print '@MAD_STATUS_Prev ' + @MAD_STATUS_Prev
					    print '@MAD_STATUSID ' +@MAD_STATUSID				
						print '@MAD_STATUSID_Prev ' +@MAD_STATUSID_Prev
						*/
						set @found = 1						
						--	set @tmpcounter = @tmpcounter + 1
						set @currentslutdato = @SLUTDATO
						set @slutdato = null					
				end
			end
		end
				/*
		if @found = 0 and @prevfound = 1 begin			
			update #_tmp_MAD_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd -- and sagsid = @SAGSID_Prev
			select * from #_tmp_MAD_SAGSHISTORIK
			print '@found = 0 and @prevfound = 1'
			--set @tmpcounter = @tmpcounter + 1
		end
*/
		if(@slutdato is not null) begin			
		   if(@currentslutdato is null)
			 set @currentslutdato = @slutdato		
				print '----insert into #_tmp_MAD_SAGSHISTORIK---- '	
				--select * from 	#_tmp2_MAD_SAGSHISTORIK				
				insert into #_tmp_MAD_SAGSHISTORIK select * from #_tmp2_MAD_SAGSHISTORIK
				delete from #_tmp2_MAD_SAGSHISTORIK				
				insert into #_tmp2_MAD_SAGSHISTORIK values (@SLUTDATO,@ID)		
				--select * from #_tmp2_MAD_SAGSHISTORIK									
				--set @insertConunter = @insertConunter + 1				
			set @found = 0
			set @currentslutdato = null				
		end		
			----temp test
			if @found = 0 and @prevfound = 1 begin			
				update #_tmp_MAD_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd -- and sagsid = @SAGSID_Prev
				--select * from #_tmp_MAD_SAGSHISTORIK
				print '@found = 0 and @prevfound = 1'			
			--set @tmpcounter = @tmpcounter + 1
			end	
		set @prevfound = @found
		if(@found = 0) 
			set @previd = @id		
		set @found = 0
		set @SAGSID_Prev = @SAGSID
		set @IKRAFTDATO_Prev = @IKRAFTDATO
		set @SLUTDATO_Prev = @SLUTDATO
		set @MAD_STATUS_Prev = @MAD_STATUS
		set @MAD_STATUSID_Prev = @MAD_STATUSID
		set @prevslutdato = @currentslutdato 
		--set @MAD_GRUPPEID_Prev = @MAD_GRUPPEID
  
FETCH NEXT FROM MADCursorLoop into @SAGSID, @IKRAFTDATO, @SLUTDATO, @MAD_STATUS, @MAD_STATUSID, @ID 
end
CLOSE MADCursorLoop
DEALLOCATE MADCursorLoop
SET NOCOUNT OFF

if @found = 0 and @prevfound = 1 begin
	print 'exupdate'
	update #_tmp2_MAD_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd
	set @tmpcounter = @tmpcounter + 1
end
insert into #_tmp_MAD_SAGSHISTORIK select * from #_tmp2_MAD_SAGSHISTORIK
--select * into _tmp_HJ_SAGSHISTORIK from #_tmp_HJ_SAGSHISTORIK 
---skal slettes
--select * from #_tmp_MAD_SAGSHISTORIK
--select * from  #_tmp2_MAD_SAGSHISTORIK


SELECT SAGSHISTORIK.IKRAFTDATO, 
#_tmp_MAD_SAGSHISTORIK.SLUTDATO, 
COALESCE (SAGSHISTORIK.MADVISI_STATUS, 0) AS MADVISI_STATUS, 
COALESCE (SAGSHISTORIK.MADVISI_STATUSID, 0) AS MADVISI_STATUSID,
SAGSHISTORIK.ID, SAGSHISTORIK.SAGSID
into _tmp_MAD_SAGSHISTORIK
FROM  #_tmp_MAD_SAGSHISTORIK INNER JOIN
	SAGSHISTORIK ON #_tmp_MAD_SAGSHISTORIK.ID = SAGSHISTORIK.ID

Drop table #_tmp_MAD_SAGSHISTORIK
Drop table #_tmp2_MAD_SAGSHISTORIK

return
print lower(@tmpcounter) + ' updates'
print lower(@insertConunter) + ' inserts'

select * into _tmp_MAD_SAGSHISTORIK from #_tmp_MAD_SAGSHISTORIK 
Drop table #_tmp_MAD_SAGSHISTORIK

return
/*
DECLARE CursorLoopMemberid CURSOR FORWARD_ONLY for
SELECT     SAGSID, IKRAFTDATO, SLUTDATO, SYGEPLEJE_STATUS, SYGEPLEJE_STATUSID, SYGEPLEJE_GRUPPEID
FROM         TEMP_SPSagshistorik
WHERE     (SYGEPLEJE_STATUSID is not null)  --and SYGEPLEJE_STATUSid = 34)
order by sagsid,IKRAFTDATO, slutdato

OPEN CursorLoopMemberid
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @SYGEPLEJE_STATUS, @SYGEPLEJE_STATUSID, @SYGEPLEJE_GRUPPEID
  WHILE @@FETCH_STATUS = 0
   BEGIN  		 
		--print '@SAGSID ' + @SAGSID
		--print  @IKRAFTDATO 
		--print  @SLUTDATO 
		--print '@SYGEPLEJE_STATUS ' + @SYGEPLEJE_STATUS
		--print '@SYGEPLEJE_STATUSID ' + @SYGEPLEJE_STATUSID
		--print '@SYGEPLEJE_GRUPPEID ' + @SYGEPLEJE_GRUPPEID
		
		if  @SAGSID_Prev = @SAGSID begin
			if  @SYGEPLEJE_STATUS_Prev = @SYGEPLEJE_STATUS begin
				if  @SYGEPLEJE_STATUSID_Prev = @SYGEPLEJE_STATUSID begin
					if  @SYGEPLEJE_STATUS_Prev = @SYGEPLEJE_STATUS begin
						if  @SYGEPLEJE_GRUPPEID_Prev = @SYGEPLEJE_GRUPPEID begin
							print '---------------------------------------'
							print '@SAGSID ' + @SAGSID
							print  @IKRAFTDATO 
							print  @SLUTDATO 
							print '@SYGEPLEJE_STATUS ' + @SYGEPLEJE_STATUS
							print '@SYGEPLEJE_STATUSID ' + @SYGEPLEJE_STATUSID
							print '@SYGEPLEJE_GRUPPEID ' + @SYGEPLEJE_GRUPPEID
							set @found = 1							
							--update _tmp_SP_SAGSHISTORIK set SLUTDATO = @SLUTDATO where id = @id
						end
					end
				end
			end
		end
		set @id = @id + 1
		if   @found = 0 begin
			print 'inserting ' 
			--insert into _tmp_SP_SAGSHISTORIK values (@SAGSID, @IKRAFTDATO, @SLUTDATO, @SYGEPLEJE_STATUS, @SYGEPLEJE_STATUSID, @SYGEPLEJE_GRUPPEID, @id)
		end
		set @found = 0
		set @SAGSID_Prev = @SAGSID
		set @IKRAFTDATO_Prev = @IKRAFTDATO
		set @SLUTDATO_Prev = @SLUTDATO
		set @SYGEPLEJE_STATUS_Prev = @SYGEPLEJE_STATUS
		set @SYGEPLEJE_STATUSID_Prev = @SYGEPLEJE_STATUSID
		set @SYGEPLEJE_GRUPPEID_Prev = @SYGEPLEJE_GRUPPEID
  
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @SYGEPLEJE_STATUS, @SYGEPLEJE_STATUSID, @SYGEPLEJE_GRUPPEID
   end
CLOSE CursorLoopMemberid
DEALLOCATE CursorLoopMemberid

*/
GO
/****** Object:  StoredProcedure [dbo].[usp_HJ_SagsHistorik]    Script Date: 10/06/2015 18:35:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_HJ_SagsHistorik]
@debug as bit =0
AS

declare @DebugCmd as nvarchar(4000)
--Debug kode
 if (@debug=1)  set @DebugCmd = 'where sagsid in (select sagsid from sager where cprnr in (select cprnr from dbo.FireBirdTestUser)) ' + CHAR(13)
 else set @DebugCmd=''

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmp_HJ_SAGSHISTORIK' AND type = 'U') DROP TABLE _tmp_HJ_SAGSHISTORIK


CREATE TABLE   #_tmp_HJ_SAGSHISTORIK (
	
	[SLUTDATO] [datetime] NOT NULL,	
	[ID] [int] NULL
) ON [PRIMARY]

CREATE TABLE   #_tmp2_HJ_SAGSHISTORIK (	
	[SLUTDATO] [datetime] NOT NULL,
	[ID] [int] NULL
) ON [PRIMARY]


declare @SAGSID as varchar(200)
declare @IKRAFTDATO as datetime
declare @SLUTDATO as datetime
declare @HJEMMEPLEJE_STATUS as varchar(200)
declare @HJEMMEPLEJE_STATUSID as varchar(200)
declare @HJEMMEPLEJE_GRUPPEID as varchar(200)
declare @cmd as varchar(max)
declare @SAGSID_Prev as varchar(200)
declare @IKRAFTDATO_Prev as datetime
declare @SLUTDATO_Prev as datetime
declare @HJEMMEPLEJE_STATUS_Prev as varchar(200)
declare @HJEMMEPLEJE_STATUSID_Prev as varchar(200)
declare @HJEMMEPLEJE_GRUPPEID_Prev as varchar(200)
declare @found as bit
declare @id as int
declare @tableID as int
declare @CurrentSLUTDATO as datetime
declare @PrevId as int
declare @tmpCounter as int
declare @prevFound as int
declare @prevSlutdato as datetime
declare @insertConunter as int
DECLARE @SYPL_DAGGRP_ID AS varchar(200)
DECLARE @SYPL_AFTENGRP_ID AS varchar(200)
DECLARE @SYPL_NATGRP_ID AS varchar(200)
DECLARE @SYPL_DAGGRP_ID_PREV AS varchar(200)
DECLARE @SYPL_AFTENGRP_ID_PREV AS varchar(200)
DECLARE @SYPL_NATGRP_ID_PREV AS varchar(200)
DECLARE @HJPL_AFTENGRP_ID AS varchar(200)
DECLARE @HJPL_NATGRP_ID AS varchar(200)
DECLARE @HJPL_AFTENGRP_ID_PREV AS varchar(200)
DECLARE @HJPL_NATGRP_ID_PREV AS varchar(200)
set @found = 0
set @id = 0
set @previd = 0
set @tmpcounter = 0
set @prevfound = 0
set @insertConunter = 0

--lav først view
IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name = 'Temp_HJSagshistorik' AND type = 'V') DROP View Temp_HJSagshistorik

set @cmd = 'CREATE VIEW [dbo].[Temp_HJSagshistorik] ' +
			'AS SELECT ID, SAGSID, ' +
			'IKRAFTDATO, SLUTDATO, ' +
			'COALESCE (HJEMMEPLEJE_STATUS, 1) AS HJEMMEPLEJE_STATUS, ' +
			'COALESCE (HJEMMEPLEJE_STATUSID, 1) AS HJEMMEPLEJE_STATUSID, ' +
			'COALESCE (HJEMMEPLEJE_GRUPPEID, 9999) AS HJEMMEPLEJE_GRUPPEID, ' +		
			'COALESCE (HJGRP_AFTEN_ID,5555) AS HJPL_AFTENGRP_ID, ' +
			'COALESCE (HJGRP_NAT_ID,5555) AS HJPL_NATGRP_ID, ' +				
			'COALESCE (SYGEPLEJE_GRUPPEID,5555) AS SYGEPLEJE_GRUPPEID, ' +
			'COALESCE (SPGRP_AFTEN_ID,5555) AS SYPL_AFTENGRP_ID, ' +
			'COALESCE (SPGRP_NAT_ID,5555) AS SYPL_NATGRP_ID ' +	
			'FROM  dbo.SAGSHISTORIK '+@DebugCmd		
print @cmd
exec(@cmd)

DECLARE CursorLoopMemberid CURSOR FORWARD_ONLY for
SELECT     SAGSID, IKRAFTDATO, SLUTDATO, HJEMMEPLEJE_STATUS, HJEMMEPLEJE_STATUSID, HJEMMEPLEJE_GRUPPEID, id,
  HJPL_AFTENGRP_ID,HJPL_NATGRP_ID,SYGEPLEJE_GRUPPEID,SYPL_AFTENGRP_ID,SYPL_NATGRP_ID 
FROM         Temp_HJSagshistorik
WHERE     (HJEMMEPLEJE_STATUSID is not null) --and sagsid = 114)
order by sagsid,IKRAFTDATO, slutdato
SET NOCOUNT ON

OPEN CursorLoopMemberid
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @HJEMMEPLEJE_STATUS, @HJEMMEPLEJE_STATUSID, @HJEMMEPLEJE_GRUPPEID,@id, 
  @HJPL_AFTENGRP_ID,@HJPL_NATGRP_ID,@SYPL_DAGGRP_ID,@SYPL_AFTENGRP_ID,@SYPL_NATGRP_ID  
  WHILE @@FETCH_STATUS = 0
   BEGIN			
		if  @SAGSID_Prev = @SAGSID begin
			if  @HJEMMEPLEJE_STATUS_Prev = @HJEMMEPLEJE_STATUS begin
				if  @HJEMMEPLEJE_STATUSID_Prev = @HJEMMEPLEJE_STATUSID begin				
					if  @HJEMMEPLEJE_GRUPPEID_Prev = @HJEMMEPLEJE_GRUPPEID begin
					  
					  if  @HJPL_AFTENGRP_ID_PREV = @HJPL_AFTENGRP_ID begin
					    if  @HJPL_NATGRP_ID_PREV = @HJPL_NATGRP_ID begin
					      if  @SYPL_DAGGRP_ID_PREV = @SYPL_DAGGRP_ID begin
					        if  @SYPL_AFTENGRP_ID_PREV = @SYPL_AFTENGRP_ID begin
					          if  @SYPL_NATGRP_ID_PREV = @SYPL_NATGRP_ID begin
						--print '---------------------------------------'
						--print '@SAGSID ' + @SAGSID
						--print  @IKRAFTDATO 
						--print  @SLUTDATO 
						--print '@HJEMMEPLEJE_STATUS ' + @HJEMMEPLEJE_STATUS
						--print '@HJEMMEPLEJE_STATUSID ' + @HJEMMEPLEJE_STATUSID
						--print '@HJEMMEPLEJE_GRUPPEID ' + @HJEMMEPLEJE_GRUPPEID
						set @found = 1						
						--	set @tmpcounter = @tmpcounter + 1
						set @currentslutdato = @SLUTDATO
						set @slutdato = null
						      end
						    end
						  end
						end
					  end	      
					end					
				end
			end
		end		
		
		if @found = 0 and @prevfound = 1 begin			
			update #_tmp2_HJ_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd -- and sagsid = @SAGSID_Prev
			--set @tmpcounter = @tmpcounter + 1
		end
		if(@slutdato is not null) begin			
		   if(@currentslutdato is null)
			 set @currentslutdato = @slutdato				
				insert into #_tmp_HJ_SAGSHISTORIK select * from #_tmp2_HJ_SAGSHISTORIK
				delete from #_tmp2_HJ_SAGSHISTORIK				
				insert into #_tmp2_HJ_SAGSHISTORIK values (@SLUTDATO,@ID)		
				--set @insertConunter = @insertConunter + 1				
			set @found = 0
			set @currentslutdato = null				
		end			
		set @prevfound = @found
		if(@found = 0) 
			set @previd = @id		
		set @found = 0
		set @SAGSID_Prev = @SAGSID
		set @IKRAFTDATO_Prev = @IKRAFTDATO
		set @SLUTDATO_Prev = @SLUTDATO
		set @HJEMMEPLEJE_STATUS_Prev = @HJEMMEPLEJE_STATUS
		set @HJEMMEPLEJE_STATUSID_Prev = @HJEMMEPLEJE_STATUSID
		set @HJEMMEPLEJE_GRUPPEID_Prev = @HJEMMEPLEJE_GRUPPEID

        set @HJPL_AFTENGRP_ID_PREV = @HJPL_AFTENGRP_ID
		set @HJPL_NATGRP_ID_PREV = @HJPL_NATGRP_ID
		set @SYPL_DAGGRP_ID_PREV = @SYPL_DAGGRP_ID 
		set @SYPL_AFTENGRP_ID_PREV = @SYPL_AFTENGRP_ID 
		set @SYPL_NATGRP_ID_PREV = @SYPL_NATGRP_ID
		
		set @prevslutdato = @currentslutdato  
FETCH NEXT FROM CursorLoopMemberid into @SAGSID, @IKRAFTDATO, @SLUTDATO, @HJEMMEPLEJE_STATUS, @HJEMMEPLEJE_STATUSID, @HJEMMEPLEJE_GRUPPEID ,@id,
  @HJPL_AFTENGRP_ID,@HJPL_NATGRP_ID,@SYPL_DAGGRP_ID,@SYPL_AFTENGRP_ID,@SYPL_NATGRP_ID
   end
CLOSE CursorLoopMemberid
DEALLOCATE CursorLoopMemberid
SET NOCOUNT OFF

if @found = 0 and @prevfound = 1 begin
	print 'exupdate'
	update #_tmp2_HJ_SAGSHISTORIK set slutdato = @prevslutdato where id = @previd
	set @tmpcounter = @tmpcounter + 1
end
insert into #_tmp_HJ_SAGSHISTORIK select * from #_tmp2_HJ_SAGSHISTORIK
--select * into _tmp_HJ_SAGSHISTORIK from #_tmp_HJ_SAGSHISTORIK 

SELECT SAGSHISTORIK.IKRAFTDATO, 
#_tmp_HJ_SAGSHISTORIK.SLUTDATO, 
COALESCE (SAGSHISTORIK.HJEMMEPLEJE_STATUS, 1) AS HJEMMEPLEJE_STATUS, 
COALESCE (SAGSHISTORIK.HJEMMEPLEJE_STATUSID, 1) AS HJEMMEPLEJE_STATUSID, 
COALESCE (SAGSHISTORIK.HJEMMEPLEJE_GRUPPEID, 9999) AS HJEMMEPLEJE_GRUPPEID, 
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.HJGRP_AFTEN_ID),5555) AS HJPL_AFTENGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.HJGRP_NAT_ID),5555) AS HJPL_NATGRP_ID,			
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.SYGEPLEJE_GRUPPEID),5555) AS SYPL_DAGGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.SPGRP_AFTEN_ID),5555) AS SYPL_AFTENGRP_ID,
COALESCE ((select UAFDELINGID from UAFDELINGER where UAFDELINGID=SAGSHISTORIK.SPGRP_NAT_ID),5555) AS SYPL_NATGRP_ID,
SAGSHISTORIK.ID, SAGSHISTORIK.SAGSID
into _tmp_HJ_SAGSHISTORIK
FROM  #_tmp_HJ_SAGSHISTORIK INNER JOIN
	SAGSHISTORIK ON #_tmp_HJ_SAGSHISTORIK.ID = SAGSHISTORIK.ID

Drop table #_tmp_HJ_SAGSHISTORIK
Drop table #_tmp2_HJ_SAGSHISTORIK

print lower(@tmpcounter) + ' updates'
print lower(@insertConunter) + ' inserts'

return
GO
