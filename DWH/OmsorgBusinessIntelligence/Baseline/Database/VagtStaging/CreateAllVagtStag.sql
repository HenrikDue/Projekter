USE [master]
GO

/****** Object:  Database [AvaleoAnalyticsVagtplan_Staging]    Script Date: 11/25/2010 07:18:43 ******/
CREATE DATABASE [AvaleoAnalyticsVagtplan_Staging] ON  PRIMARY 
( NAME = N'AvaleoAnalyticsVagtplan_Staging', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplan_Staging.mdf' , SIZE = 72704KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalyticsVagtplan_Staging_log', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplan_Staging_log.ldf' , SIZE = 20096KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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

