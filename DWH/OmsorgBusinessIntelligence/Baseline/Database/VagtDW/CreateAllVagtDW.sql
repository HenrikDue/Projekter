USE [master]
GO

/****** Object:  Database [AvaleoAnalyticsVagtplan_DW]    Script Date: 11/25/2010 07:17:45 ******/
CREATE DATABASE [AvaleoAnalyticsVagtplan_DW] ON  PRIMARY 
( NAME = N'AvaleoAnalyticsVagtplanDW', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplanDW.mdf' , SIZE = 13312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AvaleoAnalyticsVagtplanDW_log', FILENAME = N'C:\Programmer\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\AvaleoAnalyticsVagtplanDW_log.ldf' , SIZE = 8384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AvaleoAnalyticsVagtplan_DW].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ARITHABORT OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET  DISABLE_BROKER 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET  READ_WRITE 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET RECOVERY FULL 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET  MULTI_USER 
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [AvaleoAnalyticsVagtplan_DW] SET DB_CHAINING OFF 
GO

