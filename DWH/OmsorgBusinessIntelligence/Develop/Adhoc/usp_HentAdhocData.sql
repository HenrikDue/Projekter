USE [Adhoc_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_HentAdhocData]    Script Date: 03/22/2011 13:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_HentAdhocData]
AS
DECLARE @cmd as varchar(max)
DECLARE @debug as bit
declare @sourceSRV as varchar(100)
declare @sourceDB as varchar(100)
set @debug = 1
set @sourceSRV='SRVMSSQL01'
set @sourceDB='Adhocitsql75'

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''DimAnsvarlig'' AND type = ''U'') DROP TABLE dbo.DimAnsvarlig'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT DISTINCT '+char(13)+
--           ' LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) as ANSVARLIG, '+char(13)+
--           ' B.NAVN'+char(13)+           
--           ' '+char(13)+
--           'INTO DimAnsvarlig '+char(13)+
--           'FROM '+@sourceSRV+'.'+@sourceDB+'.dbo.OpgaveHistorik A '+char(13)+
--           'LEFT JOIN '+@sourceSRV+'.'+@sourceDB+'.dbo.ANSVARLIG B ON LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling)))))=B.INITIALER '+char(13)+ 
--           'WHERE TID>''2009-01-01'' AND '+char(13)+
--           '  NOT (LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%@%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%''''%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%1%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%2%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%3%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%4%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%5%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%6%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%7%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%8%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%9%'' OR '+char(13)+
--           '  LTRIM(rtrim(SUBSTRING(A.handling,(charindex(''->'',A.HANDLING)+3),(LEN(A.handling))))) LIKE ''%0%'') '+char(13)+
--           'ORDER BY ANSVARLIG '
--if @debug = 1 print @cmd
--exec (@cmd)

--set @cmd = 'DELETE FROM dbo.DimAnsvarlig WHERE ANSVARLIG='''''
--if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Sta_Opgave'' AND type = ''U'') DROP TABLE dbo.Sta_Opgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * INTO Sta_Opgave FROM '+@sourceSRV+'.'+@sourceDB+'.dbo.Opgave  ORDER BY ID'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Sta_OpgaveHistorik'' AND type = ''U'') DROP TABLE dbo.Sta_OpgaveHistorik'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * INTO Sta_OpgaveHistorik FROM '+@sourceSRV+'.'+@sourceDB+'.dbo.OpgaveHistorik  ORDER BY ID'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Sta_OpgaveBesked'' AND type = ''U'') DROP TABLE dbo.Sta_OpgaveBesked'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * INTO Sta_OpgaveBesked FROM '+@sourceSRV+'.'+@sourceDB+'.dbo.OpgaveBesked ORDER BY ID'
if @debug = 1 print @cmd
exec (@cmd)
