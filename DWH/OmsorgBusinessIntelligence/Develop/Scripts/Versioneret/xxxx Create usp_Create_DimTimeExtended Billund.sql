USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_DimTimeExtended]    Script Date: 11/02/2011 11:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[usp_Create_DimTimeExtended] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1,
				@start_date as varchar(max),
				@end_date as varchar(max)
AS
DECLARE @cmd as varchar(max)
BEGIN
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimTimeExtended'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimTimeExtended'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  DT.*, '+char(13)+
           '  CASE WHEN (DWH.helligdag=1) THEN ''Y'' ELSE ''N'' END AS Helligdag, '+char(13)+
           '  CASE WHEN (DWH.helligdag=1) OR (DWH.weekend=1) THEN ''N'' ELSE ''Y'' END AS Arbejdsdag'+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimTimeExtended '+char(13)+
           'FROM Dim_Time DT'+char(13)+
           'JOIN DimWeekendHelligdag DWH ON DT.PK_Date=DWH.PK_Date'+char(13)+
           'WHERE DT.PK_Date>='''+@start_date+''' AND DT.PK_Date<='''+@end_date+''' '+char(13)+
           'ORDER BY DT.PK_Date'+char(13)+
           ''+char(13)+
           ''+char(13)
if @debug = 1 print @cmd
exec (@cmd)

--fejl ved generering af MSSQL ugedag

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimTimeExtended'+char(13)+
           'SET Week_Of_Year=dbo.udf_GetISOWeekNumberFromDate(pk_date),'+char(13)+
           '  Week_Of_Year_Name=''Uge ''+cast(dbo.udf_GetISOWeekNumberFromDate(pk_date) as varchar(5)) '+char(13)           
exec (@cmd)
if @debug = 1 print @cmd

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimTimeExtended'+char(13)+
           'SET Week_Name=''Uge 1,''+cast(DATEPART(yy,pk_date)+1 as varchar(4))'+char(13)+
           'WHERE week_of_year=1 AND DATEPART(mm,pk_date)=12'+char(13)           
exec (@cmd)
if @debug = 1 print @cmd

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimTimeExtended'+char(13)+
           'SET Week_Name=''Uge 52,''+cast(DATEPART(yy,pk_date)-1 as varchar(4))'+char(13)+
           'WHERE week_of_year=52 AND DATEPART(mm,pk_date)=1'+char(13)           
exec (@cmd)
if @debug = 1 print @cmd

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimTimeExtended'+char(13)+
           'SET Week_Name=''Uge 53,''+cast(DATEPART(yy,pk_date)-1 as varchar(4))'+char(13)+
           'where week_of_year=53 and DATEPART(mm,pk_date)=1'+char(13)           
exec (@cmd)
if @debug = 1 print @cmd           

END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=54)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (54,GETDATE())           
--end
