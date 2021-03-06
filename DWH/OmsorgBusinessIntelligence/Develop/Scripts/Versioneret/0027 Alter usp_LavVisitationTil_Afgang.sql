USE [AvaleoAnalytics_Sta]
--use AvaleoAnalytics_STA_Blank
GO
/****** Object:  StoredProcedure [dbo].[usp_LavVisitationTil_Afgang]    Script Date: 02/16/2011 11:49:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_LavVisitationTil_Afgang]
                       @DestinationDB as varchar(200),
		               @ExPart as Int=0,  
                       @Debug  as bit = 0  
AS
DECLARE @cmd as varchar(max)
DECLARE @sagsid_plejetype INT
DECLARE @old_sagsid_plejetype INT
DECLARE @visiid INT
DECLARE @old_visiid INT
DECLARE @BORGER_STATUS INT
DECLARE @leverandoerid INT
DECLARE @old_leverandoerid INT
DECLARE @old_borger_status INT
DECLARE @ikraftdato DATE
DECLARE @slutdato DATE
DECLARE @old_slutdato DATE
DECLARE @def_cprnr VARCHAR(20)
DECLARE @leverandoertaeller INT

if @ExPart=1 OR @ExPart=0
BEGIN

set @def_cprnr=substring(convert(nvarchar(10),getdate(),112),7,2)+substring(convert(nvarchar(10),getdate(),112),5,2)+substring(convert(nvarchar(10),getdate(),112),3,2)+'4000'

--Lav historik til tilgang
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  1 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'INTO tmp_VisitationsHistorik '+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'LEFT JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=1 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''5'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  5 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM SPVISITATION A '+char(13)+
           'LEFT JOIN SPVISIJOB B ON A.ID=B.SPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=5 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+           
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''3'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  3 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM TPVISITATION A '+char(13)+
           'LEFT JOIN TPVISIJOB B ON A.ID=B.TPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=3 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+           
           'UNION ALL '+char(13)+
           'SELECT DISTINCT '+char(13)+
           '  A.ID AS VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''6'' AS SAGSID_PLEJETYPE, '+char(13)+ --sammensat nøgle
           '  COALESCE(C.CPRNR,'''+@def_cprnr+''') AS CPRNR, '+char(13)+
           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,A.IKRAFTDATO),0) AS ALDER, '+char(13)+      
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(DBO.CHECKLEVERANDOER(B.FRITVALGLEV),8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'FROM MADVISITATION A '+char(13)+
           'LEFT JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  A.IKRAFTDATO>=BTH.IKRAFTDATO AND A.IKRAFTDATO<BTH.SLUTDATO AND BTH.PLEJETYPE=6 '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)  

if @debug = 1 print @cmd
exec (@cmd)

--periode --skal udkommeteres hvis ønskes
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Periode'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Periode'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  COALESCE(DBO.AGE(A.CPRNR,B.PK_DATE),0) AS ALDER, '+char(13)+  
           '  COALESCE(BTH.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(BTH.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(BTH.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS PERIODE, '+char(13)+  --antal
           '  5 AS SPECIFIKATION_NY '+char(13)+ --periode  
           'INTO tmp_VisitationTilAfgang_Periode '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE())'+char(13)+
           'JOIN BORGER_TILHOER_HISTORIK BTH ON BTH.SAGSID=A.SAGSID AND '+char(13)+
           '  B.PK_DATE>=BTH.IKRAFTDATO AND B.PK_DATE<BTH.SLUTDATO AND BTH.PLEJETYPE=A.PLEJETYPE '+char(13)+
           'ORDER BY PK_DATE,SAGSID'
--exec (@cmd)

--primo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Primo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Primo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS PRIMO, '+char(13)+  --antal
           '  1 AS SPECIFIKATION_NY '+char(13)+ --primo  
           'INTO tmp_VisitationTilAfgang_Primo '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND ' +char(13)+
           '(B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=01'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--ultimo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Ultimo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Ultimo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS ULTIMO, '+char(13)+  --antal
           '  4 AS SPECIFIKATION_NY '+char(13)+ --ultimo  
           'INTO tmp_VisitationTilAfgang_Ultimo '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND ' +char(13)+
           '(B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--tilgang nye visitationer
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  MIN(IKRAFTDATO) AS PK_DATE, '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_Visitations_Tilgang_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik '+char(13)+
           'GROUP BY SAGSID_PLEJETYPE'+char(13)+
           'ORDER BY SAGSID_PLEJETYPE'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS TILGANG, '+char(13)+  --antal
           '  2 AS SPECIFIKATION_NY '+char(13)+ --tilgang  
           'INTO tmp_Visitations_Tilgang '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_Tilgang_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE AND A.PK_DATE=B.PK_DATE' 
if @debug = 1 print @cmd
exec (@cmd) 

--tilgang visitationer - borgere der har ikke har modtaget ydelser i 90 dage eller mere 
DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT VISIID,SAGSID_PLEJETYPE,BORGER_STATUS,IKRAFTDATO,SLUTDATO 
FROM tmp_VisitationsHistorik  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @visiid,@sagsid_plejetype,@borger_status,@ikraftdato,@slutdato

WHILE @@fetch_status = 0
BEGIN 
  IF (@sagsid_plejetype=@old_sagsid_plejetype) and (@old_borger_status=0) and (@borger_status<>0) and (DATEDIFF(dd,@old_slutdato,@ikraftdato)>=90)
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang 
    SELECT PK_DATE,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,1 AS TILGANG,22 AS SPECIFIKATION_NY
    FROM tmp_VisitationsHistorik
  END
   
  set @old_sagsid_plejetype=@sagsid_plejetype
  set @old_borger_status= @borger_status
  set @old_visiid=@visiid
  set @old_slutdato=@slutdato
  
  FETCH NEXT FROM FindVisitation 
  INTO @visiid,@sagsid_plejetype,@borger_status,@ikraftdato,@slutdato

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation
          

--find alle borgere med visitationer der ikke er afsluttede
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationUdenSlutDato'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationUdenSlutDato'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_VisitationUdenSlutDato '+char(13)+
           'FROM tmp_VisitationsHistorik'+char(13)+
           'WHERE DATEPART(YEAR,SLUTDATO) IN (9999)'
if @debug = 1 print @cmd
exec (@cmd)

--find borgere med afsluttede visitationer (inaktive) - seneste visitation
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Afgang_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Afgang_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  MAX(SLUTDATO) AS PK_DATE '+char(13)+
           'INTO tmp_Visitations_Afgang_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato B WHERE A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE) '+char(13)+
           'GROUP BY SAGSID_PLEJETYPE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Afgang'
if @debug = 1 print @cmd
exec (@cmd)  

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS AFGANG, '+char(13)+  --antal
           '  3 AS SPECIFIKATION_NY '+char(13)+ --afgang  
           'INTO tmp_Visitations_Afgang '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_Afgang_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE AND A.IKRAFTDATO=B.PK_DATE' 
if @debug = 1 print @cmd
exec (@cmd) 

--find til og afgang på leverandør
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_BorgerMedFritvalgLev_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_BorgerMedFritvalgLev_Step1'
if @debug = 1 print @cmd
exec (@cmd)  

--find borgere der har fritvalgsleverandør - begræns data mængde
set @cmd = 'SELECT DISTINCT '+char(13)+
           '  SAGSID_PLEJETYPE '+char(13)+
           'INTO tmp_Visitations_BorgerMedFritvalgLev_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik '+char(13)+
           'WHERE LEVERANDOERID NOT IN (9999,8888) '
if @debug = 1 print @cmd
exec (@cmd)      

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_BorgerMedFritvalgLev_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_BorgerMedFritvalgLev_Step2'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'SELECT '+char(13)+
           '  A.IKRAFTDATO AS PK_DATE, ' +char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.VISIID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.BORGER_STATUS, '+char(13)+
           '  A.BORGER_STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE '+char(13)+ 
           'INTO tmp_Visitations_BorgerMedFritvalgLev_Step2 '+char(13)+
           'FROM tmp_VisitationsHistorik A '+char(13)+
           'JOIN tmp_Visitations_BorgerMedFritvalgLev_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE '+char(13)+ 
           'ORDER BY A.SAGSID_PLEJETYPE, A.IKRAFTDATO '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Lev_Bevaegelser'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Lev_Bevaegelser'
if @debug = 1 print @cmd
exec (@cmd)

SELECT TOP 1  --tabel oprettes
  PK_DATE,
  VISIID, 
  SAGSID, 
  SAGSID_PLEJETYPE,
  CPRNR,
  JOBID,
  ALDER,
  BORGER_ORG,
  BORGER_STATUS,
  BORGER_STATUSID,
  LEVERANDOERID,
  PLEJETYPE,
  NULL AS SPECIFIKATION_NY 
INTO tmp_Visitations_Lev_Bevaegelser 
FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 

set @cmd = 'DELETE FROM tmp_Visitations_Lev_Bevaegelser'
if @debug = 1 print @cmd
exec (@cmd)

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT VISIID,SAGSID_PLEJETYPE,LEVERANDOERID 
FROM tmp_Visitations_BorgerMedFritvalgLev_Step2  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @visiid,@sagsid_plejetype,@leverandoerid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid_plejetype=@old_sagsid_plejetype and @visiid<>@old_visiid --samme borger men forskellige visitationer
  BEGIN 
    set @leverandoertaeller =  (SELECT COUNT(*) -- nye leverandør må ikke findes på gamle visitation
                                FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
                                WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid AND 
                                      A.LEVERANDOERID IN (SELECT B.LEVERANDOERID FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 B 
                                                          WHERE B.SAGSID_PLEJETYPE=@sagsid_plejetype AND B.VISIID=@old_visiid))
  
            
    IF @leverandoertaeller=0 
    BEGIN
      IF @old_leverandoerid=8888 AND @leverandoerid<>8888 --skift fra kommune til fritvalg
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,16 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END
      ELSE IF @leverandoerid=8888 AND @old_leverandoerid<>8888 --skift fra fritvalg til kommune 
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,17 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END   
      ELSE IF @leverandoerid<>@old_leverandoerid AND @old_leverandoerid<>8888 AND @leverandoerid<>8888 --skift mellem fritvalg
      BEGIN
        INSERT INTO tmp_Visitations_Lev_Bevaegelser 
        SELECT PK_DATE,VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,BORGER_ORG,BORGER_STATUS,BORGER_STATUSID,LEVERANDOERID,PLEJETYPE,15 
        FROM tmp_Visitations_BorgerMedFritvalgLev_Step2 A
        WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid 
      END              
    END         
  END
  
  set @old_sagsid_plejetype=@sagsid_plejetype
  set @old_leverandoerid=@leverandoerid
  set @old_visiid=@visiid
  
  FETCH NEXT FROM FindVisitation 
  INTO @visiid,@sagsid_plejetype,@leverandoerid

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

END

IF @ExPart=2 OR @ExPart=0
begin

--union 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_VisitationTilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_VisitationTilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT '+char(13)+ --periode
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  JOBID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  BORGER_STATUS, '+char(13)+
--           '  BORGER_STATUSID, '+char(13)+
--           '  LEVERANDOERID, '+char(13)+ 
--           '  PLEJETYPE, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
--           'FROM tmp_VisitationTilAfgang_periode'+char(13)+ 
--           'UNION ALL '+char(13)+
set @cmd = 'SELECT '+char(13)+ --tilgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
           'FROM tmp_Visitations_Tilgang'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --afgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_Visitations_Afgang'+char(13)+   
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --primo
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Primo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --ultimo
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Ultimo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --bevægelser
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  JOBID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  BORGER_STATUS, '+char(13)+
           '  BORGER_STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+           
           'FROM tmp_Visitations_Lev_Bevaegelser'
           
                              
if @debug = 1 print @cmd
exec (@cmd) 

END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=27)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (27,GETDATE())           
--end
