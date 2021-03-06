USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dim_Bruger]    Script Date: 08/01/2011 08:58:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Dim_Bruger] 
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
           '    (SELECT COALESCE(CPRNR,''Cprnr ikke opgivet'') FROM MEDARBEJDERE WHERE MEDARBEJDERID=B.MEDARBEJDER) '+char(13)+ 
           '  ELSE ''Cprnr ikke opgivet'' '+char(13)+ 
           '  END AS MEDARBCPRNR,'+char(13)+ 
           '  COALESCE(B.UAFDELINGID,9999) AS UAFDELINGID,'+char(13)+ 
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
           '  B.FORNAVN+'' ''+B.EFTERNAVN AS NAVN'+char(13)+  
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

             
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=40)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (40,GETDATE())           
--end

END
