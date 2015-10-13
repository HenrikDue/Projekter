USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Fact_Bruger]    Script Date: 09/05/2011 11:23:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Fact_Bruger] 
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
           '  B.UAFDELINGID,'+char(13)+
           '  MIN(A.OPRETTET) AS OPRETTET,  '+char(13)+ 
           '  CONVERT(DATE,MIN(A.OPRETTET),102) AS PK_DATE,'+char(13)+ 
           '  2 AS BEVAEGID,'+char(13)+ 
           '  99 AS BRUGERSTATUSID '+char(13)+
           'INTO tmp_FactBruger1'+char(13)+ 
           'FROM BRUGER_PASSW_HIST A'+char(13)+
           'JOIN BRUGER B ON A.BRUGERID=B.BRUGERID AND B.SYSTEMBRUGER=0'+char(13)+
           'GROUP BY A.BRUGERID,B.UAFDELINGID '+char(13)+ 
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
           '  B.UAFDELINGID,'+char(13)+
           '  MAX(A.OPRETTET) AS DEAKTIVERET,  '+char(13)+ 
           '  CONVERT(DATE,MAX(A.OPRETTET),102) AS PK_DATE,'+char(13)+ 
           '  3 AS BEVAEGID,'+char(13)+
           '  B.KONTI_DISABLED_AARSAG AS BRUGERSTATUSID'+char(13)+ 
           'INTO tmp_FactBruger2'+char(13)+ 
           'FROM BRUGER_PASSW_HIST A '+char(13)+ 
           'JOIN BRUGER B ON A.BRUGERID=B.BRUGERID AND B.KONTI_DISABLED=1 AND B.SYSTEMBRUGER=0'+char(13)+  
           'GROUP BY A.BRUGERID,B.KONTI_DISABLED_AARSAG,B.UAFDELINGID '+char(13)+ 
           'ORDER BY A.BRUGERID'
if @debug = 1 print @cmd
exec (@cmd)

--union
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBruger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBruger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  BRUGERID,'+char(13)+ 
           '  COALESCE(UAFDELINGID,9999) AS MEDARBGRP, '+char(13)+
           '  OPRETTET AS TABELDATO,  '+char(13)+ 
           '  PK_DATE,'+char(13)+ 
           '  BEVAEGID,'+char(13)+ 
           '  BRUGERSTATUSID'+char(13)+ 
           'INTO '+@DestinationDB+'.DBO.FactBruger'+char(13)+ 
           'FROM tmp_FactBruger1 '+char(13)+ 
           'UNION ALL '+char(13)+  
           'SELECT '+char(13)+
           '  B.BRUGERID,'+char(13)+  
           '  COALESCE(UAFDELINGID,9999) AS MEDARBGRP, '+char(13)+
           '  DEAKTIVERET AS TABELDATO,  '+char(13)+ 
           '  B.PK_DATE,'+char(13)+ 
           '  B.BEVAEGID,'+char(13)+ 
           '  B.BRUGERSTATUSID'+char(13)+ 
           'FROM tmp_FactBruger2 B'+char(13)+
           'UNION ALL '+char(13)+  
           'SELECT DISTINCT '+char(13)+
           '  C.BRUGERID,'+char(13)+  
           '  COALESCE(UAFDELINGID,9999) AS MEDARBGRP, '+char(13)+
           '  ''2002-01-01'',  '+char(13)+ 
           '  ''2002-01-01'','+char(13)+ 
           '  100,'+char(13)+ 
           '  100'+char(13)+ 
           'FROM BRUGER C'+char(13)+
           'WHERE SYSTEMBRUGER=0'
if @debug = 1 print @cmd
exec (@cmd)        

             
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=41)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (41,GETDATE())           
--end

END
