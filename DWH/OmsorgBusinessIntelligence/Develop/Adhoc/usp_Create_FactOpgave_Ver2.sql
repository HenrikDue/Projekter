USE [Adhoc_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_FactOpgave]    Script Date: 03/18/2011 12:41:03 ******/
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
DECLARE @targetDB as varchar(max)
set @debug = 1
set @targetDB='Adhoc_DW'

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_opgave'' AND type = ''U'') DROP TABLE dbo.tmp_opgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  ID AS OPGAVEID, '+char(13)+
           '  REGISTRERET AS STARTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  ANSVARLIG, '+char(13)+
           '  LTRIM(RTRIM(REKVIRENT)) AS KUNDEID, '+char(13)+
           '  CAST(AFSLUTTET AS INTEGER) AS STATUS, '+char(13)+
           '  DATEDIFF(DD,REGISTRERET,COALESCE(SLUTDATO,GETDATE())) AS OPGAVE_ENDELIG_AFSLUT '+char(13)+
           '   '+char(13)+
           '   '+char(13)+
           'INTO tmp_opgave '+char(13)+
           'FROM Sta_Opgave '+char(13)+
           'ORDER BY ID'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_opgave_foerste_svar_step1'' AND type = ''U'') DROP TABLE dbo.tmp_opgave_foerste_svar_step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           ' OPGAVE AS OPGAVEID,   '+char(13)+
           ' MIN(TID) AS SVARDATO  '+char(13)+
           'INTO tmp_opgave_foerste_svar_step1 '+char(13)+
           'FROM Sta_OpgaveBesked   '+char(13)+
           'GROUP BY OPGAVE '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_opgave_foerste_svar_step2'' AND type = ''U'') DROP TABLE dbo.tmp_opgave_foerste_svar_step2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.OPGAVEID,   '+char(13)+
           '  A.STARTDATO, '+char(13)+
           '  B.SVARDATO AS SLUTDATO, '+char(13)+
           '  A.ANSVARLIG, '+char(13)+
           '  A.KUNDEID, '+char(13)+
           '  A.STATUS, '+char(13)+
           '  DATEDIFF(DD,A.STARTDATO,B.SVARDATO) AS DAGE_FOERSTE_SVAR'+char(13)+
           'INTO tmp_opgave_foerste_svar_step2 '+char(13)+
           'FROM tmp_opgave A  '+char(13)+
           'JOIN tmp_opgave_foerste_svar_step1 B ON A.OPGAVEID=B.OPGAVEID'+char(13)+
           '   '+char(13)+
           '   '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_opgave_foerste_afslut_step1'' AND type = ''U'') DROP TABLE dbo.tmp_opgave_foerste_afslut_step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  OPGAVE AS OPGAVEID,   '+char(13)+
           '  MIN(TID) AS AFSLUTDATO  '+char(13)+
           'INTO tmp_opgave_foerste_afslut_step1 '+char(13)+
           'FROM Sta_OpgaveHistorik   '+char(13)+
           'WHERE HANDLING like ''%Opgave afsluttet%''   '+char(13)+
           'GROUP BY OPGAVE '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_opgave_foerste_afslut_step2'' AND type = ''U'') DROP TABLE dbo.tmp_opgave_foerste_afslut_step2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.OPGAVEID,   '+char(13)+
           '  A.STARTDATO, '+char(13)+
           '  B.AFSLUTDATO AS SLUTDATO, '+char(13)+
           '  '''' AS ANSVARLIG, '+char(13)+
           '  A.KUNDEID, '+char(13)+
           '  A.STATUS, '+char(13)+
           '  DATEDIFF(DD,A.STARTDATO,B.AFSLUTDATO) AS DAGE_FOERSTE_AFSLUT'+char(13)+
           'INTO tmp_opgave_foerste_afslut_step2 '+char(13)+
           'FROM tmp_opgave A  '+char(13)+
           'JOIN tmp_opgave_foerste_afslut_step1 B ON A.OPGAVEID=B.OPGAVEID'+char(13)+
           '   '+char(13)+
           '   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

--union
set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''FactOpgave'' AND type = ''U'') DROP TABLE '+@targetDB+'.dbo.FactOpgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.OPGAVEID,   '+char(13)+
           --'  STARTDATO, '+char(13)+
           '  CAST(COALESCE(A.SLUTDATO,GETDATE()) AS DATE) AS PK_DATE, '+char(13)+
           '  A.ANSVARLIG, '+char(13)+
           '  CASE WHEN ((A.KUNDEID='''') OR (A.KUNDEID IS NULL)) THEN ''Kunde ukendt'' '+char(13)+
           '  ELSE A.KUNDEID '+char(13)+
           '  END AS KUNDEID,'+char(13)+
           '  A.STATUS, '+char(13)+
           '  C.DAGE_FOERSTE_SVAR, '+char(13)+
           '  B.DAGE_FOERSTE_AFSLUT, '+char(13)+
           '  A.OPGAVE_ENDELIG_AFSLUT '+char(13)+
           'INTO '+@targetDB+'.DBO.FactOpgave '+char(13)+
           'FROM tmp_opgave A  '+char(13)+
           'LEFT JOIN tmp_opgave_foerste_afslut_step2 B ON A.OPGAVEID=B.OPGAVEID '+char(13)+
           'LEFT JOIN tmp_opgave_foerste_svar_step2 C on A.OPGAVEID=C.OPGAVEID '+char(13)+
           '   '+char(13)           
           --'UNION ALL '+char(13)+
           --'SELECT '+char(13)+
           --'  OPGAVEID,   '+char(13)+
           --'  STARTDATO, '+char(13)+
           --'  SLUTDATO, '+char(13)+
           --'  ANSVARLIG, '+char(13)+
           --'  KUNDE, '+char(13)+
           --'  STATUS, '+char(13)+
           --'  DAGE_FOERSTE_SVAR, '+char(13)+
           --'  0 AS DAGE_FOERSTE_AFSLUT, '+char(13)+
           --'  0 AS OPGAVE_ENDELIG_AFSLUT '+char(13)+
           --'FROM tmp_opgave_foerste_svar_step2 '+char(13)+
           --'UNION ALL '+char(13)+
           --'SELECT '+char(13)+
           --'  OPGAVEID,   '+char(13)+
           --'  STARTDATO, '+char(13)+
           --'  SLUTDATO, '+char(13)+
           --'  ANSVARLIG, '+char(13)+
           --'  KUNDE, '+char(13)+
           --'  STATUS, '+char(13)+
           --'  0 AS DAGE_FOERSTE_SVAR, '+char(13)+
           --'  0 AS DAGE_FOERSTE_AFSLUT, '+char(13)+
           --'  OPGAVE_ENDELIG_AFSLUT '+char(13)+
           --'FROM tmp_opgave '+char(13)+           
           --'   '+char(13)+
           --'   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

