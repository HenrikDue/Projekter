USE [AvaleoAnalytics_Staging_Clean]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavVisitationTil_Afgang]    Script Date: 01/20/2011 09:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_LavVisitationTil_Afgang]
                       @DestinationDB as varchar(200),  
                       @Debug  as bit = 1  
AS
DECLARE @cmd as varchar(max)
DECLARE @sagsid INT
DECLARE @sagsid_plejetype INT
DECLARE @alder INT
DECLARE @id INT
DECLARE @statusid INT
DECLARE @status INT
DECLARE @cprnr VARCHAR(20)
DECLARE @leverandoerid INT
DECLARE @old_leverandoerid INT
DECLARE @old_status INT
DECLARE @borger_org INT
DECLARE @old_borger_org INT
DECLARE @old_sagsid INT
DECLARE @pk_date DATE
DECLARE @ikraftdato DATE
DECLARE @slutdato DATE
DECLARE @old_slutdato DATE
DECLARE @plejetype INT
DECLARE @old_plejetype INT
DECLARE @jobid INT
DECLARE @old_jobid INT

BEGIN

--Lav historik til tilgang
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik_Tilgang'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik_Tilgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+      
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+     
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+ --ikraftdato skal være primære dato
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  1 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'INTO tmp_VisitationsHistorik_Tilgang '+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'LEFT JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''3'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  3 AS PLEJETYPE '+char(13)+ 
           'FROM TPVISITATION A '+char(13)+
           'LEFT JOIN TPVISIJOB B ON A.ID=B.TPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''5'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  5 AS PLEJETYPE '+char(13)+ 
           'FROM SPVISITATION A '+char(13)+
           'LEFT JOIN SPVISIJOB B ON A.ID=B.SPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''6'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE '+char(13)+ 
           'FROM MADVISITATION A '+char(13)+
           'LEFT JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'''+char(13)+
           'ORDER BY SAGSID,PLEJETYPE,IKRAFTDATO ASC '+char(13)+
           ''
if @debug = 1 print @cmd
exec (@cmd)

--datoer før primær dato i tidsdimensionen slettes
--set @cmd = 'DELETE FROM tmp_VisitationsHistorik_Tilgang WHERE PK_DATE<''01-01-2002'' '
--if @debug = 1 print @cmd
--exec (@cmd)

--periode
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Periode'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Periode'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  DBO.AGE(A.CPRNR,B.PK_DATE) AS ALDER,'+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '    WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '    BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '    B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '    B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+ --org. og status skal tages på dagen
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '     B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '     B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+
           '  A.PLEJETYPE, '+char(13)+
           '  1 AS PERIODE, '+char(13)+  --antal
           '  5 AS SPECIFIKATION_NY, '+char(13)+ --periode  
           '  B.DAYSINMONTH '+char(13)+
           'INTO tmp_VisitationTilAfgang_Periode '+char(13)+
           'FROM tmp_VisitationsHistorik_Tilgang A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()+365)'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--primo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Primo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Primo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  CPRNR, '+char(13)+
           '  JOBID, '+char(13)+
           '  ALDER,'+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  1 AS PRIMO, '+char(13)+  --antal
           '  1 AS SPECIFIKATION_NY '+char(13)+ --primo  
           'INTO tmp_VisitationTilAfgang_Primo '+char(13)+
           'FROM tmp_VisitationTilAfgang_periode '+char(13)+
           'WHERE DATEPART(DD,(PK_Date))=01'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--hvis primo tages som sidste dag i forrige måned
--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Primo SET PK_DATE=PK_DATE+1' 
--exec (@cmd)

--ultimo
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Ultimo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Ultimo'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  CPRNR, '+char(13)+
           '  JOBID, '+char(13)+
           '  ALDER,'+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  STATUSID, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  1 AS ULTIMO, '+char(13)+  --antal
           '  4 AS SPECIFIKATION_NY '+char(13)+ --ultimo  
           'INTO tmp_VisitationTilAfgang_Ultimo '+char(13)+
           'FROM tmp_VisitationTilAfgang_periode '+char(13)+
           'WHERE DATEPART(DD,PK_Date)=DAYSINMONTH'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

--hvis ultimo tages som den 1. i måneden efter
--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Ultimo SET PK_DATE=PK_DATE-1' 
--exec (@cmd)

--tilgang

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang'
if @debug = 1 print @cmd
exec (@cmd)

SELECT TOP 1  --tabel oprettes
  SAGSID,
  SAGSID_PLEJETYPE,
  'xxxxxxxxxx' AS CPRNR,
  JOBID,
  ALDER,
  STATUSID,
  BORGER_ORG,
  LEVERANDOERID,
  IKRAFTDATO AS PK_DATE,
  PLEJETYPE,
  1 AS LEV_TILGANG,
  NULL AS SPECIFIKATION_NY 
INTO tmp_Visitations_Tilgang 
FROM tmp_VisitationsHistorik_Tilgang 

set @cmd = 'DELETE FROM tmp_Visitations_Tilgang'--tøm tabel
if @debug = 1 print @cmd
exec (@cmd)  

--loop igennem historikken, find førstegangsvisitationer 
DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE FROM tmp_VisitationsHistorik_Tilgang

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid<>@old_sagsid --første visitation er en tilgang  
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,12) --leverandør tilgang
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,2) --visitation tilgang    
  END
  
  SET @old_sagsid=@sagsid
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--loop igennem historikken, find leverandørtilgang 
DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Tilgang ORDER BY SAGSID,LEVERANDOERID,IKRAFTDATO ASC --### ændret sortering

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid=@old_sagsid and @leverandoerid<>@old_leverandoerid --samme borger, men anden leverandør, uanset jobtype er det leverandør tilgang
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,12)
  END
  
  SET @old_sagsid=@sagsid
  SET @old_leverandoerid=@leverandoerid
  SET @old_jobid=@jobid
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--loop igennem historikken, find leverandørskift 
DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Tilgang ORDER BY SAGSID,JOBID,IKRAFTDATO ASC --### ændret sortering

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid=@old_sagsid and @old_jobid=@jobid and @leverandoerid<>@old_leverandoerid --er borger den samme, samme job, men anden leverandør, er det leverandør tilgang
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,12)
    --afgang
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@old_leverandoerid,@ikraftdato,@plejetype,1,13)
  END
  
  SET @old_sagsid=@sagsid
  SET @old_leverandoerid=@leverandoerid
  SET @old_jobid=@jobid
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation


--er borger revisiteret og sidste visitation foretaget for mere end 90 dage siden og borger har haft status inaktiv skal disse tælles som tilgang
--hent og sorter efter sagsid,plejetype, ikraftdato
--alle borgere + status iht plejetype på slutdato
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Over90Dage_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Over90Dage_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER, '+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.STATUSID, '+char(13)+
           '  A.STATUS, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+     
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.PLEJETYPE '+char(13)+
           'INTO tmp_VisitationTilAfgang_Over90Dage_Step1 '+char(13)+
           'FROM tmp_VisitationsHistorik_Tilgang A'+char(13)+
           'ORDER BY SAGSID,SAGSID_PLEJETYPE'
if @debug = 1 print @cmd
exec (@cmd)

--find borgere der har været inaktive
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Over90Dage_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Over90Dage_Step2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT'+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUS '+char(13)+
           'INTO tmp_VisitationTilAfgang_Over90Dage_Step2 '+char(13)+
           'FROM tmp_VisitationTilAfgang_Over90Dage_Step1 '+char(13)+
           'WHERE STATUS=0' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Over90Dage_Step3'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Over90Dage_Step3'
if @debug = 1 print @cmd
exec (@cmd)
--find visitationer på borgere der har været inaktive 
set @cmd = 'SELECT DISTINCT'+char(13)+
           '  A.SAGSID, '+char(13)+
           '  B.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  A.ALDER,'+char(13)+
           '  A.BORGER_ORG, '+char(13)+
           '  A.STATUSID, '+char(13)+
           '  A.LEVERANDOERID, '+char(13)+           
           '  A.STATUS, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  A.PLEJETYPE '+char(13)+
           'INTO tmp_VisitationTilAfgang_Over90Dage_Step3 '+char(13)+
           'FROM tmp_VisitationTilAfgang_Over90Dage_Step1 A '+char(13)+
           'JOIN tmp_VisitationTilAfgang_Over90Dage_Step2 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE '+char(13)+
           'ORDER BY A.SAGSID,A.PLEJETYPE,A.IKRAFTDATO'

if @debug = 1 print @cmd
exec (@cmd)
--loop igennem hentede visitationer
DECLARE FindVisitationOver90Dage CURSOR FAST_FORWARD FOR
SELECT SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,STATUS,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE FROM tmp_VisitationTilAfgang_Over90Dage_Step3 --order by SAGSID,IKRAFTDATO,PLEJETYPE

OPEN FindVisitationOver90Dage
FETCH NEXT FROM FindVisitationOver90Dage
INTO @sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@status,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_status=@status
SET @old_slutdato=@slutdato
SET @old_sagsid=@sagsid
SET @old_plejetype=@plejetype

WHILE @@fetch_status = 0
BEGIN
  IF (@sagsid=@old_sagsid) and (@old_status=0) and (@status<>0) and (@old_plejetype=@plejetype) and 
    (DATEDIFF(dd,@old_slutdato,@ikraftdato)>=90)
  BEGIN 
    --print @ikraftdato print @old_slutdato print @old_status print @old_sagsid print DATEDIFF(dd,@old_slutdato,@ikraftdato)
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,2) --visitation tilgang  
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,12) --leverandør tilgang
  END
  
  SET @old_sagsid=@sagsid
  SET @old_status=@status
  SET @old_slutdato=@slutdato
  SET @old_plejetype=@plejetype
  
  FETCH NEXT FROM FindVisitationOver90Dage 
  INTO @sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@status,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
  
END
 
CLOSE FindVisitationOver90Dage
DEALLOCATE FindVisitationOver90Dage

--gruppeskift tæller ikke med i til og afgang, men tælles med i primo,ultimo og periode
--find gruppeskift start

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsGruppeskift'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsGruppeskift'
if @debug = 1 print @cmd
exec (@cmd)

SELECT TOP 1  --tabel oprettes     
  SAGSID,
  SAGSID_PLEJETYPE,
  'xxxxxxxxxx' AS CPRNR,
  JOBID,
  ALDER,
  STATUSID,
  BORGER_ORG,
  LEVERANDOERID,
  PK_DATE,
  PLEJETYPE,
  1 AS GRUPPESKIFT,
  14 AS SPECIFIKATION_NY 
INTO tmp_VisitationsGruppeskift 
FROM tmp_VisitationTilAfgang_periode 

set @cmd = 'DELETE FROM tmp_VisitationsGruppeskift'
if @debug = 1 print @cmd
exec (@cmd)  

DECLARE Gruppeskift CURSOR FAST_FORWARD FOR
SELECT SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,PK_DATE,PLEJETYPE FROM tmp_VisitationTilAfgang_periode ORDER BY SAGSID,PLEJETYPE,PK_DATE

OPEN Gruppeskift
FETCH NEXT FROM Gruppeskift
INTO @sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@pk_date,@plejetype

SET @old_sagsid=@sagsid
SET @old_borger_org=@borger_org
SET @old_plejetype=@plejetype

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid=@old_sagsid and @borger_org<>@old_borger_org and @plejetype=@old_plejetype
  BEGIN
    INSERT INTO tmp_VisitationsGruppeskift
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@pk_date,@plejetype,1,14)
  END
  
  SET @old_sagsid=@sagsid
  SET @old_borger_org=@borger_org
  SET @old_plejetype=@plejetype
  
  FETCH NEXT FROM Gruppeskift 
  INTO @sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@pk_date,@plejetype
  
END
 
CLOSE Gruppeskift
DEALLOCATE Gruppeskift

--gruppeskift slut

----Lav historik til afgang 
--sorteres på slutdato faldende

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik_Afgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  1 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
           'INTO tmp_VisitationsHistorik_Afgang '+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'' ' +char(13)+--AND DATEPART(YEAR,A.SLUTDATO) NOT IN (9999) ' +char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''3'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  3 AS PLEJETYPE '+char(13)+ 
           'FROM TPVISITATION A '+char(13)+
           'JOIN TPVISIJOB B ON A.ID=B.TPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'' ' +char(13)+--AND DATEPART(YEAR,A.SLUTDATO) NOT IN (9999) ' +char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''5'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  5 AS PLEJETYPE '+char(13)+ 
           'FROM SPVISITATION A '+char(13)+
           'JOIN SPVISIJOB B ON A.ID=B.SPVISIID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'' ' +char(13)+--AND DATEPART(YEAR,A.SLUTDATO) NOT IN (9999) ' +char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''6'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.IKRAFTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),0) AS STATUS, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE '+char(13)+ 
           'FROM MADVISITATION A '+char(13)+
           'JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'' ' +char(13)+--AND DATEPART(YEAR,A.SLUTDATO) NOT IN (9999) ' +char(13)+
           'ORDER BY A.SAGSID,PLEJETYPE,A.SLUTDATO DESC'
if @debug = 1 print @cmd
exec (@cmd)

--datoer før primær dato i tidsdimensionen slettes
--set @cmd = 'DELETE FROM tmp_VisitationsHistorik_Afgang WHERE PK_DATE<''01-01-2002'' '
--if @debug = 1 print @cmd
--exec (@cmd)

--find alle borgere med visitationer der ikke er afsluttede
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationUdenSlutDato'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationUdenSlutDato'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT DISTINCT '+char(13)+
           '  SAGSID '+char(13)+
           'INTO tmp_VisitationUdenSlutDato '+char(13)+
           'FROM tmp_VisitationsHistorik_Afgang A'+char(13)+
           'WHERE DATEPART(YEAR,A.SLUTDATO) IN (9999)'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Afgang'
if @debug = 1 print @cmd
exec (@cmd)

SELECT TOP 1  --tabel oprettes
  --ID,
  SAGSID,
  SAGSID_PLEJETYPE,
  'xxxxxxxxxx' AS CPRNR,
  JOBID,
  ALDER,
  STATUS,
  STATUSID,
  BORGER_ORG,
  LEVERANDOERID,
  IKRAFTDATO AS PK_DATE,
  --SLUTDATO,
  PLEJETYPE,
  1 AS LEV_AFGANG,
  NULL AS SPECIFIKATION_NY 
INTO tmp_Visitations_Afgang 
FROM tmp_VisitationsHistorik_Afgang 

set @cmd = 'DELETE FROM tmp_Visitations_Afgang'
if @debug = 1 print @cmd
exec (@cmd)  

--find leverandørafgang på aktive borgere der bliver midlertidig inaktive 

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUS,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Afgang A 
WHERE EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato WHERE tmp_VisitationUdenSlutDato.SAGSID=A.SAGSID) AND
  DATEPART(YEAR,A.SLUTDATO) NOT IN (9999)

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

WHILE @@fetch_status = 0
BEGIN
  IF (@status=0) /*status=0 borger kan være midlertidig inaktiv*/
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)
  END
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--find leverandørafgang og afgang på inaktive borgere (med afsluttede visitationer og ikke revisiterede)

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUS,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Afgang A 
WHERE NOT EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato WHERE tmp_VisitationUdenSlutDato.SAGSID=A.SAGSID)
  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF (@sagsid<>@old_sagsid) or (@status=0) --borgers seneste visitation (blevet inaktiv) og derfor afgang 
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)--leverandør afgang
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,3)--visitation afgang    
  END --borger endnu ikke inaktiv, men leverandørskift
  ELSE IF @sagsid=@old_sagsid and @old_jobid=@jobid and @leverandoerid<>@old_leverandoerid
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)
  END
    
  SET @old_sagsid=@sagsid
  SET @old_leverandoerid=@leverandoerid
  SET @old_jobid=@jobid
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
  
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--union 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_VisitationTilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_VisitationTilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --periode
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
           'FROM tmp_VisitationTilAfgang_periode'+char(13)+ 
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --tilgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_Visitations_Tilgang'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ --afgang
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
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
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
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
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Ultimo'+char(13)+
           'UNION ALL '+char(13)+ 
           'SELECT '+char(13)+ --gruppeskift periode
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  ALDER, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationsGruppeskift'    
           
                              
if @debug = 1 print @cmd
exec (@cmd)  

--datoer før primær dato i tidsdimensionen slettes
set @cmd = 'DELETE FROM '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang WHERE PK_DATE<''01-01-2002'' '
if @debug = 1 print @cmd
exec (@cmd)                 


END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=16)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (16,GETDATE())           
end
