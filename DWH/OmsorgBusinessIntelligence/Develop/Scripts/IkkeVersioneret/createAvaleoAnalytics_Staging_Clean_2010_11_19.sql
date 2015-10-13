USE [master]
GO

/****** Object:  Database [AvaleoAnalytics_Staging_Clean]    Script Date: 11/19/2010 10:18:09 ******/
CREATE DATABASE [AvaleoAnalytics_Staging_Clean] ON  PRIMARY 
( NAME = N'AvaleoAnalytics_Staging_Clean', FILENAME = N'E:\SQL Data\AvaleoAnalytics_Staging_Clean.mdf' , SIZE = 7698496KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalytics_Staging_log_Clean', FILENAME = N'E:\SQL Logs\AvaleoAnalytics_Staging_log_Clean.ldf' , SIZE = 2376256KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AvaleoAnalytics_Staging_Clean].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ARITHABORT OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET  DISABLE_BROKER 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET  READ_WRITE 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET  MULTI_USER 
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [AvaleoAnalytics_Staging_Clean] SET DB_CHAINING OFF 
GO


