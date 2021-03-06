USE [Adhoc_DW]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactOpgave]    Script Date: 03/17/2011 08:57:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_FactOpgave]
AS
DECLARE @cmd as varchar(max)
DECLARE @debug as bit
declare @sourceDB as varchar(100)
set @debug = 1
set @sourceDB='Adhoc'

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactOpgave'' AND type = ''U'') DROP TABLE dbo.FactOpgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  ID AS OPGAVEID, '+char(13)+
           '  CAST(REGISTRERET AS DATE) AS PK_DATE, '+char(13)+
           '  ANSVARLIG, '+char(13)+
           '  STATUS, '+char(13)+
           '  PABEGYNDTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  DATEDIFF(DD,REGISTRERET,SLUTDATO) AS FORBRUGTE_DAGE '+char(13)+
           'INTO FactOpgave '+char(13)+
           'FROM  '+@sourceDB+'.dbo.Opgave' 
if @debug = 1 print @cmd
exec (@cmd)
