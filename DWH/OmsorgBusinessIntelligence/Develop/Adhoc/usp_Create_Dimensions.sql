USE [Adhoc_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dimensions]    Script Date: 03/24/2011 08:44:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Dimensions]
AS
DECLARE @cmd as varchar(max)
DECLARE @debug as bit
declare @targetDB as varchar(100)
set @debug = 1
set @targetDB='Adhoc_DW'

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimAnsvarlig'' AND type = ''U'') DROP TABLE '+@targetDB+'.dbo.DimAnsvarlig'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
          -- '  ANSVARLIGID=IDENTITY(int,1,1), '+char(13)+ 
           ' LTRIM(RTRIM(ANSVARLIG)) AS ANSVARLIG '+char(13)+     
           'INTO '+@targetDB+'.DBO.DimAnsvarlig '+char(13)+
           'FROM Sta_Opgave '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimOpgaveStatus'' AND type = ''U'') DROP TABLE '+@targetDB+'.DBO.DimOpgaveStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT TOP 1 '+char(13)+
           '  0 AS STATUS, '+char(13)+
           '  ''Opgave åben       '' AS BESKRIVELSE '+char(13)+
           'INTO '+@targetDB+'.DBO.DimOpgaveStatus '+char(13)+
           'FROM Sta_Opgave '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT INTO '+@targetDB+'.DBO.DimOpgaveStatus '+char(13)+
           'VALUES(1,''Opgave afsluttet'') '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'EXEC DBO.usp_Create_Time_Dimension '+@targetDB+',''2005-01-01'',''2020-01-01'' '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimOpgaver'' AND type = ''U'') DROP TABLE '+@targetDB+'.DBO.DimOpgaver'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  ID AS OPGAVEID, '+char(13)+
           '  CASE WHEN ((KATEGORI IS NULL) OR (KATEGORI='''')) THEN ''Ikke defineret'' '+char(13)+ 
           '  ELSE KATEGORI'+char(13)+
           '  END AS KATEGORI, '+char(13)+
           '  REKVIRENT AS KUNDE '+char(13)+
           'INTO '+@targetDB+'.DBO.DimOpgaver '+char(13)+
           'FROM Sta_Opgave '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''DimKunderStep1'' AND type = ''U'') DROP TABLE DBO.DimKunderStep1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  LTRIM(RTRIM(SUBSTRING(REKVIRENT,(CHARINDEX(''@'',REKVIRENT)+1),(LEN(REKVIRENT))))) AS KUNDE '+char(13)+
           'INTO DimKunderStep1 '+char(13)+
           'FROM Sta_Opgave '+char(13)+
           'WHERE REKVIRENT LIKE ''%@%'' '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''DimKunderStep2'' AND type = ''U'') DROP TABLE DBO.DimKunderStep2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  LTRIM(RTRIM(SUBSTRING(REKVIRENT,1,(CHARINDEX(''@'',REKVIRENT)-1)))) AS KUNDENAVN, '+char(13)+
           '  B.KUNDE, '+char(13)+
           '  LTRIM(RTRIM(A.REKVIRENT)) AS KUNDEID '+char(13)+
           'INTO DimKunderStep2 '+char(13)+
           'FROM Sta_Opgave A '+char(13)+
           'JOIN DimKunderStep1 B ON LTRIM(RTRIM(SUBSTRING(A.REKVIRENT,(CHARINDEX(''@'',A.REKVIRENT)+1),(LEN(A.REKVIRENT))))) = B.KUNDE'+char(13)+
           'WHERE A.REKVIRENT LIKE ''%@%'' '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''DimKunderStep3'' AND type = ''U'') DROP TABLE DBO.DimKunderStep3'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  KUNDEID, '+char(13)+
           '  KUNDENAVN, '+char(13)+
           '  SUBSTRING(KUNDE,1,(CHARINDEX(''.'',KUNDE)-1)) AS KUNDE '+char(13)+
           'INTO DimKunderStep3 '+char(13)+
           'FROM DimKunderStep2 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT INTO DimKunderStep3 '+char(13)+
           'SELECT DISTINCT REKVIRENT,REKVIRENT,''Avaleo intern'' FROM Sta_Opgave WHERE REKVIRENT NOT LIKE ''%@%'' '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT INTO DimKunderStep3 (KUNDEID,KUNDENAVN,KUNDE) '+char(13)+
           'VALUES (''Kunde ukendt'',''Kunde ukendt'',''Kunde ukendt'') '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimKunder'' AND type = ''U'') DROP TABLE '+@targetDB+'.DBO.DimKunder'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  KUNDEID,'+char(13)+
           '  KUNDENAVN, '+char(13)+
           '  KUNDE '+char(13)+
           'INTO '+@targetDB+'.DBO.DimKunder '+char(13)+
           'FROM DimKunderStep3 '+char(13)+
           'WHERE KUNDEID<>''''  '+char(13)
if @debug = 1 print @cmd
exec (@cmd)