USE [AvaleoAnalytics_Staging_Clean]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavVisitationTil_Afgang]    Script Date: 12/22/2010 08:48:22 ******/
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

--visitationshistorik SKAL FLYTTES TIL CREATE DIMENSIONS
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik_Step1'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT DISTINCT '+char(13)+
--           '  A.ID, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+
--           '  C.CPRNR, '+char(13)+
--           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
--           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
--           '  A.IKRAFTDATO, ' +char(13)+
--           '  A.SLUTDATO, ' +char(13)+
--           '  1 AS PLEJETYPE '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
--           'INTO tmp_VisitationsHistorik_Step1 '+char(13)+
--           'FROM HJVISITATION  A '+char(13)+
--           'LEFT JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)+
--           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT DISTINCT '+char(13)+
--           '  A.ID, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''3''  AS SAGSID_PLEJETYPE, '+char(13)+
--           '  C.CPRNR, '+char(13)+
--           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
--           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
--           '  A.IKRAFTDATO, ' +char(13)+
--           '  A.SLUTDATO, ' +char(13)+
--           '  3 AS PLEJETYPE '+char(13)+ 
--           'FROM TPVISITATION  A '+char(13)+
--           'LEFT JOIN TPVISIJOB B ON A.ID=B.TPVISIID '+char(13)+
--           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT DISTINCT '+char(13)+
--           '  A.ID, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''5''  AS SAGSID_PLEJETYPE, '+char(13)+
--           '  C.CPRNR, '+char(13)+
--           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
--           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
--           '  A.IKRAFTDATO, ' +char(13)+
--           '  A.SLUTDATO, ' +char(13)+
--           '  5 AS PLEJETYPE '+char(13)+ 
--           'FROM SPVISITATION  A '+char(13)+
--           'LEFT JOIN SPVISIJOB B ON A.ID=B.SPVISIID '+char(13)+
--           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT DISTINCT '+char(13)+
--           '  A.ID, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''6''  AS SAGSID_PLEJETYPE, '+char(13)+
--           '  C.CPRNR, '+char(13)+
--           '  COALESCE(B.JOBID,9999) AS JOBID, '+char(13)+
--           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
--           '  A.IKRAFTDATO, ' +char(13)+
--           '  A.SLUTDATO, ' +char(13)+
--           '  6 AS PLEJETYPE '+char(13)+ 
--           'FROM MADVISITATION  A '+char(13)+
--           'LEFT JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
--           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
--           'ORDER BY SAGSID,PLEJETYPE,IKRAFTDATO'
--if @debug = 1 print @cmd
--exec (@cmd)  

--tilgang
--første visitation er altid en tilgang
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step1'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT '+char(13)+ 
--           '  MIN(IKRAFTDATO) AS PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(CPRNR,MIN(IKRAFTDATO)) AS ALDER,'+char(13)+
--           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=tmp_VisitationsHistorik_Step1.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=tmp_VisitationsHistorik_Step1.PLEJETYPE AND '+char(13)+ 
--           '  MIN(tmp_VisitationsHistorik_Step1.IKRAFTDATO)>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  MIN(tmp_VisitationsHistorik_Step1.IKRAFTDATO)<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
--           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=tmp_VisitationsHistorik_Step1.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=tmp_VisitationsHistorik_Step1.PLEJETYPE AND '+char(13)+ 
--           '  MIN(tmp_VisitationsHistorik_Step1.IKRAFTDATO)>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  MIN(tmp_VisitationsHistorik_Step1.IKRAFTDATO)<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
--           '  PLEJETYPE, '+char(13)+ --1=hjemmepleje,3=terapi,5=sygepleje,6=mad
--           '  1 AS TILGANG, '+char(13)+  --antal
--           '  2 AS SPECIFIKATION_NY '+char(13)+ --tilgang   
--           'INTO tmp_VisitationTilAfgang_Step1 '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 '+char(13)+
--           'GROUP BY SAGSID,CPRNR,SAGSID_PLEJETYPE,PLEJETYPE '+char(13)+ 
--           'ORDER BY SAGSID '
--exec (@cmd)     

--er visitationen ældre end 90 dage og borger har haft status inaktiv skal disse tælles som tilgang
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step2'
if @debug = 1 print @cmd
exec (@cmd)
--alle borgeres visitationer og status
--set @cmd = 'SELECT '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  CPRNR, '+char(13)+
--           '  (SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO) AS STATUS, '+char(13)+
--           '  IKRAFTDATO, ' +char(13)+
--           '  SLUTDATO, ' +char(13)+
--           '  PLEJETYPE '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Step2 '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 A'+char(13)+
--           'ORDER BY SAGSID,PLEJETYPE,IKRAFTDATO'
--if @debug = 1 print @cmd
--exec (@cmd) 

--find borgere der har været inaktive
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step3'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step3'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT DISTINCT'+char(13)+
--           '  SAGSID '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Step3 '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Step2 '+char(13)+
--           'WHERE STATUS=0' 
--if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step4'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step4'
if @debug = 1 print @cmd
exec (@cmd)
--find alle visitationer på borgere der har været inaktive 
--set @cmd = 'SELECT DISTINCT'+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  A.SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(A.CPRNR,A.IKRAFTDATO) AS ALDER,'+char(13)+
--           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
--           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '  A.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  A.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
--           '  A.STATUS, '+char(13)+
--           '  A.IKRAFTDATO, ' +char(13)+
--           '  A.SLUTDATO, ' +char(13)+
--           '  A.PLEJETYPE '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Step4 '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Step2 A '+char(13)+
--           'JOIN tmp_VisitationTilAfgang_Step3 B ON A.SAGSID=B.SAGSID '+char(13)+
--           'ORDER BY A.SAGSID,A.PLEJETYPE,A.IKRAFTDATO'

--if @debug = 1 print @cmd
--exec (@cmd)           

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step5'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step5'
if @debug = 1 print @cmd
exec (@cmd)

--SELECT TOP 1  --tabel oprettes
--  SAGSID,
--  SAGSID_PLEJETYPE,
--  ALDER,
--  STATUSID,
--  STATUS,
--  BORGER_ORG,
--  IKRAFTDATO AS PK_DATE,
--  PLEJETYPE,
--  1 AS TILGANG,
--  2 AS SPECIFIKATION_NY 
--INTO tmp_VisitationTilAfgang_Step5 
--FROM tmp_VisitationTilAfgang_Step4 

--set @cmd = 'DELETE FROM tmp_VisitationTilAfgang_Step5'
--if @debug = 1 print @cmd
--exec (@cmd)  



--DECLARE FindBorger CURSOR FAST_FORWARD FOR
--SELECT SAGSID,SAGSID_PLEJETYPE,ALDER,STATUSID,STATUS,BORGER_ORG,IKRAFTDATO,SLUTDATO,PLEJETYPE FROM tmp_VisitationTilAfgang_Step4 --order by SAGSID,IKRAFTDATO,PLEJETYPE

--OPEN FindBorger
--FETCH NEXT FROM FindBorger
--INTO @sagsid,@sagsid_plejetype,@alder,@statusid,@status,@borger_org,@ikraftdato,@slutdato,@plejetype

--SET @old_status=@status
--SET @old_slutdato=@slutdato
--SET @old_sagsid=@sagsid
--SET @old_plejetype=@plejetype

--WHILE @@fetch_status = 0
--BEGIN
--  IF (@sagsid=@old_sagsid) and (@old_status=0) and (@status<>0) and (@old_plejetype=@plejetype) and 
--    (DATEDIFF(dd,@old_slutdato,@ikraftdato)>=90)
--  BEGIN 
--    --print @ikraftdato print @old_slutdato print @old_status print @old_sagsid print DATEDIFF(dd,@old_slutdato,@ikraftdato)
--    INSERT INTO tmp_VisitationTilAfgang_Step5
--    VALUES (@sagsid,@sagsid_plejetype,@alder,@statusid,@status,@borger_org,@ikraftdato,@plejetype,1,2)
--  END
  
--  SET @old_sagsid=@sagsid
--  SET @old_status=@status
--  SET @old_slutdato=@slutdato
--  SET @old_plejetype=@plejetype
  
--  FETCH NEXT FROM FindBorger 
--  INTO @sagsid,@sagsid_plejetype,@alder,@statusid,@status,@borger_org,@ikraftdato,@slutdato,@plejetype
  
--END
 
--CLOSE FindBorger
--DEALLOCATE FindBorger

--afgang

--er borgers seneste visitation med slutdato der ikke er xx-xx-9999 skal den tælles som afgang
--find borgere
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Step10'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Step10'
if @debug = 1 print @cmd
exec (@cmd)
--set @cmd = 'SELECT '+char(13)+
--           '  MAX(SLUTDATO) AS PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  CPRNR,'+char(13)+
--           '  PLEJETYPE '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Step10 '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 '+char(13)+
--           'WHERE (DATEPART(YEAR, SLUTDATO) IN (9999)) ' +char(13)+
--           'GROUP BY SAGSID,CPRNR,SAGSID_PLEJETYPE,PLEJETYPE '+char(13)+
--           'ORDER BY SAGSID'
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Afgang'
if @debug = 1 print @cmd
exec (@cmd)
--set @cmd = 'SELECT '+char(13)+
--           '  MAX(SLUTDATO) AS PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(CPRNR,MAX(SLUTDATO)) AS ALDER,'+char(13)+
--           '  0 AS STATUSID, '+char(13)+
--           '  0 AS BORGER_ORG, '+char(13)+
--           '  PLEJETYPE, '+char(13)+
--           '  1 AS AFGANG, '+char(13)+  --antal
--           '  3 AS SPECIFIKATION_NY '+char(13)+ --afgang    
--           'INTO tmp_VisitationTilAfgang_Afgang '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 A '+char(13)+
--           'WHERE ' +char(13)+
--           '  NOT EXISTS(SELECT * FROM tmp_VisitationTilAfgang_Step10 WHERE tmp_VisitationTilAfgang_Step10.SAGSID=A.SAGSID AND ' +char(13)+
--           '    tmp_VisitationTilAfgang_Step10.PLEJETYPE=A.PLEJETYPE) ' +char(13)+
--           'GROUP BY SAGSID,CPRNR,SAGSID_PLEJETYPE,PLEJETYPE '+char(13)+
--           'ORDER BY SAGSID'
--exec (@cmd)

--borger org. skal på
--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Afgang  '+char(13)+ 
--           'SET BORGER_ORG=COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           'WHERE BORGER_TILHOER_HISTORIK.SAGSID=tmp_VisitationTilAfgang_Afgang.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=tmp_VisitationTilAfgang_Afgang.PLEJETYPE AND '+char(13)+ 
--           '  tmp_VisitationTilAfgang_Afgang.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  tmp_VisitationTilAfgang_Afgang.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999)' 
--if @debug = 1 print @cmd
--exec (@cmd)

--borger status skal på
--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Afgang  '+char(13)+ 
--           'SET STATUSID=COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           'WHERE BORGER_TILHOER_HISTORIK.SAGSID=tmp_VisitationTilAfgang_Afgang.SAGSID AND '+char(13)+ 
--           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=tmp_VisitationTilAfgang_Afgang.PLEJETYPE AND '+char(13)+ 
--           '  tmp_VisitationTilAfgang_Afgang.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '  tmp_VisitationTilAfgang_Afgang.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1)' 
--if @debug = 1 print @cmd
--exec (@cmd)

--periode

--set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_periode'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_periode'
--if @debug = 1 print @cmd
--exec (@cmd)
--set @cmd = 'SELECT '+char(13)+
--           '  B.PK_DATE, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  A.SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(A.CPRNR,B.PK_DATE) AS ALDER,'+char(13)+
--           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '    WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '    BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '    B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '    B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
--           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '     B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '     B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
--           '  A.PLEJETYPE, '+char(13)+
--           '  1 AS PERIODE, '+char(13)+  --antal
--           '  5 AS SPECIFIKATION_NY, '+char(13)+ --periode  
--           '  B.DAYSINMONTH '+char(13)+
--           'INTO tmp_VisitationTilAfgang_periode '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 A '+char(13)+
--           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()+365)'+char(13)+
--           'ORDER BY PK_DATE,SAGSID'
--exec (@cmd)

--primo (pr måned)

--set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Primo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Primo'
--if @debug = 1 print @cmd
--exec (@cmd)

--set @cmd = 'SELECT '+char(13)+
--           '  B.PK_DATE, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  A.SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(A.CPRNR,B.PK_DATE) AS ALDER,'+char(13)+
--           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '    WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '    BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '    B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '    B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
--           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '     B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '     B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
--           '  A.PLEJETYPE, '+char(13)+
--           '  1 AS PRIMO, '+char(13)+  --antal
--           '  1 AS SPECIFIKATION_NY, '+char(13)+ --primo  
--           '  B.DAYSINMONTH '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Primo '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 A '+char(13)+
--           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()+365) AND DATEPART(DD,(B.PK_Date))=B.DAYSINMONTH'+char(13)+
--           'ORDER BY PK_DATE,SAGSID'
--exec (@cmd)

--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Primo SET PK_DATE=PK_DATE+1' 
--exec (@cmd)

--ultimo (pr måned)

--set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Ultimo'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Ultimo'
--if @debug = 1 print @cmd
--exec (@cmd)

--set @cmd = 'SELECT '+char(13)+
--           '  B.PK_DATE, '+char(13)+
--           '  A.SAGSID, '+char(13)+
--           '  A.SAGSID_PLEJETYPE, '+char(13)+
--           '  DBO.AGE(A.CPRNR,B.PK_DATE) AS ALDER,'+char(13)+
--           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '    WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '    BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '    B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '    B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
--           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
--           '     WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
--           '     BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
--           '     B.PK_DATE>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
--           '     B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
--           '  A.PLEJETYPE, '+char(13)+
--           '  1 AS ULTIMO, '+char(13)+  --antal
--           '  4 AS SPECIFIKATION_NY, '+char(13)+ --ultimo  
--           '  B.DAYSINMONTH '+char(13)+
--           'INTO tmp_VisitationTilAfgang_Ultimo '+char(13)+
--           'FROM tmp_VisitationsHistorik_Step1 A '+char(13)+
--           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE()+365) AND DATEPART(DD,B.PK_Date)=01'+char(13)+
--           'ORDER BY PK_DATE,SAGSID'
--exec (@cmd)

--set @cmd = 'UPDATE tmp_VisitationTilAfgang_Ultimo SET PK_DATE=PK_DATE-1' 
--exec (@cmd)

--find gruppeskift start

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsGruppeskift'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsGruppeskift'
if @debug = 1 print @cmd
exec (@cmd)

--SELECT TOP 1  --tabel oprettes
--  SAGSID,
--  SAGSID_PLEJETYPE,
--  ALDER,
--  STATUSID,
--  BORGER_ORG,
--  PK_DATE,
--  PLEJETYPE,
--  1 AS GRUPPESKIFT,
--  14 AS SPECIFIKATION_NY 
--INTO tmp_VisitationsGruppeskift 
--FROM tmp_VisitationTilAfgang_periode 

--set @cmd = 'DELETE FROM tmp_VisitationsGruppeskift'
--if @debug = 1 print @cmd
--exec (@cmd)  

--DECLARE Gruppeskift CURSOR FAST_FORWARD FOR
--SELECT SAGSID,SAGSID_PLEJETYPE,ALDER,STATUSID,BORGER_ORG,PK_DATE,PLEJETYPE FROM tmp_VisitationTilAfgang_periode ORDER BY SAGSID,PLEJETYPE,PK_DATE

--OPEN Gruppeskift
--FETCH NEXT FROM Gruppeskift
--INTO @sagsid,@sagsid_plejetype,@alder,@statusid,@borger_org,@pk_date,@plejetype

--SET @old_sagsid=@sagsid
--SET @old_borger_org=@borger_org
--SET @old_plejetype=@plejetype

--WHILE @@fetch_status = 0
--BEGIN
--  IF @sagsid=@old_sagsid and @borger_org<>@old_borger_org and @plejetype=@old_plejetype
--  BEGIN
--    INSERT INTO tmp_VisitationsGruppeskift
--    VALUES (@sagsid,@sagsid_plejetype,@alder,@statusid,@borger_org,@pk_date,@plejetype,1,14)
--  END
  
--  SET @old_sagsid=@sagsid
--  SET @old_borger_org=@borger_org
--  SET @old_plejetype=@plejetype
  
--  FETCH NEXT FROM Gruppeskift 
--  INTO @sagsid,@sagsid_plejetype,@alder,@statusid,@borger_org,@pk_date,@plejetype
  
--END
 
--CLOSE Gruppeskift
--DEALLOCATE Gruppeskift

--gruppeskift slut

--union

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Fact_VisitationTilAfgang'' AND type = ''U'') DROP TABLE dbo.tmp_Fact_VisitationTilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

--set @cmd = 'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  PLEJETYPE, '+char(13)+
--           '  TILGANG AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'INTO tmp_Fact_VisitationTilAfgang '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Step1 '+char(13)+
--           'WHERE EXISTS(SELECT * FROM tmp_VisitationTilAfgang_periode WHERE tmp_VisitationTilAfgang_periode.SAGSID=SAGSID AND '+char(13)+ 
--           '   tmp_VisitationTilAfgang_periode.PK_DATE=PK_DATE) '+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  PLEJETYPE, '+char(13)+
--           '  TILGANG AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Step5 '+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  PLEJETYPE, '+char(13)+
--           '  AFGANG AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Afgang'+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  PLEJETYPE, '+char(13)+
--           '  PERIODE AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationTilAfgang_periode'+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  NULL AS PLEJETYPE, '+char(13)+
--           '  PRIMO AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Primo'+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  NULL AS PLEJETYPE, '+char(13)+
--           '  ULTIMO AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationTilAfgang_Ultimo'+char(13)+
--           'UNION ALL '+char(13)+
--           'SELECT '+char(13)+ 
--           '  PK_DATE, '+char(13)+
--           '  SAGSID, '+char(13)+
--           '  SAGSID_PLEJETYPE, '+char(13)+
--           '  ALDER, '+char(13)+
--           '  STATUSID, '+char(13)+
--           '  BORGER_ORG, '+char(13)+
--           '  8888 AS LEVERANDOERID, '+char(13)+
--           '  NULL AS PLEJETYPE, '+char(13)+
--           '  GRUPPESKIFT AS ANTAL_TIL_AFGANG, '+char(13)+
--           '  SPECIFIKATION_NY '+char(13)+
--           'FROM tmp_VisitationsGruppeskift'           
           
--exec (@cmd) 

--leverandør tilgang 

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
           'ORDER BY SAGSID,PLEJETYPE,JOBID,IKRAFTDATO ASC '+char(13)+
           ''
if @debug = 1 print @cmd
exec (@cmd)

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
           '    B.PK_DATE<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
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
           '  1 AS SPECIFIKATION_NY, '+char(13)+ --primo  
           '  DAYSINMONTH '+char(13)+
           'INTO tmp_VisitationTilAfgang_Primo '+char(13)+
           'FROM tmp_VisitationTilAfgang_periode '+char(13)+
           'WHERE DATEPART(DD,(PK_Date))=DAYSINMONTH'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

set @cmd = 'UPDATE tmp_VisitationTilAfgang_Primo SET PK_DATE=PK_DATE+1' 
exec (@cmd)

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
           '  4 AS SPECIFIKATION_NY, '+char(13)+ --ultimo  
           '  DAYSINMONTH '+char(13)+
           'INTO tmp_VisitationTilAfgang_Ultimo '+char(13)+
           'FROM tmp_VisitationTilAfgang_periode '+char(13)+
           'WHERE DATEPART(DD,PK_Date)=01'+char(13)+
           'ORDER BY PK_DATE,SAGSID'
exec (@cmd)

set @cmd = 'UPDATE tmp_VisitationTilAfgang_Ultimo SET PK_DATE=PK_DATE-1' 
exec (@cmd)

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

set @cmd = 'DELETE FROM tmp_Visitations_Tilgang'
if @debug = 1 print @cmd
exec (@cmd)  

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE FROM tmp_VisitationsHistorik_Tilgang

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid<>@old_sagsid --første visitation er en tilgang til leverandør  2 AS SPECIFIKATION_NY
  BEGIN
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,12) --leverandør tilgang
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,2) --visitation tilgang    
  END
  ELSE IF @sagsid=@old_sagsid and @old_jobid=@jobid and @leverandoerid<>@old_leverandoerid --er borger den samme, men har anden leverandør på samme job er det en tilgang
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

--er borger revisiteret og sidste visitation foretaget for mere end 90 dage siden og borger har haft status inaktiv skal disse tælles som tilgang
--vælg og sorter efter sagsid,plejetype, ikraftdato
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationTilAfgang_Over90Dage_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationTilAfgang_Over90Dage_Step1'
if @debug = 1 print @cmd
exec (@cmd)
--alle borgere + status iht plejetype på slutdato
set @cmd = 'SELECT '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  A.CPRNR, '+char(13)+
           '  A.JOBID, '+char(13)+
           '  DBO.AGE(A.CPRNR,A.IKRAFTDATO) AS ALDER,'+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  (SELECT STATUS FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=A.PLEJETYPE AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO) AS STATUS, '+char(13)+
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
           '  B.SAGSID, '+char(13)+
           '  A.SAGSID_PLEJETYPE, '+char(13)+
           '  B.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  B.ALDER,'+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=B.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=B.PLEJETYPE AND '+char(13)+ 
           '  B.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  B.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=B.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=B.PLEJETYPE AND '+char(13)+ 
           '  B.IKRAFTDATO>=BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  B.IKRAFTDATO<BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  B.LEVERANDOERID, '+char(13)+           
           '  B.STATUS, '+char(13)+
           '  B.IKRAFTDATO, ' +char(13)+
           '  B.SLUTDATO, ' +char(13)+
           '  B.PLEJETYPE '+char(13)+
           'INTO tmp_VisitationTilAfgang_Over90Dage_Step3 '+char(13)+
           'FROM tmp_VisitationTilAfgang_Over90Dage_Step2 A '+char(13)+
           'JOIN tmp_VisitationTilAfgang_Over90Dage_Step1 B ON A.SAGSID_PLEJETYPE=B.SAGSID_PLEJETYPE '+char(13)+
           'ORDER BY B.SAGSID,B.PLEJETYPE,B.IKRAFTDATO'

if @debug = 1 print @cmd
exec (@cmd)

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
    print @ikraftdato print @old_slutdato print @old_status print @old_sagsid print DATEDIFF(dd,@old_slutdato,@ikraftdato)--###
    INSERT INTO tmp_Visitations_Tilgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@plejetype,1,22) --visitation tilgang  
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

--gruppeskift

--afgang

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_VisitationsHistorik_Afgang'' AND type = ''U'') DROP TABLE dbo.tmp_VisitationsHistorik_Afgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  CAST(A.SAGSID*-1 AS VARCHAR(20))+''1'' AS SAGSID_PLEJETYPE, '+char(13)+
           '  C.CPRNR, '+char(13)+
           '  B.JOBID, '+char(13)+
           '  DBO.AGE(CPRNR,A.SLUTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=1 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
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
           '  DBO.AGE(CPRNR,A.SLUTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=3 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
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
           '  DBO.AGE(CPRNR,A.SLUTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=5 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
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
           '  DBO.AGE(CPRNR,A.SLUTDATO) AS ALDER, '+char(13)+
           '  COALESCE((SELECT STATUSID FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),1) AS STATUSID, '+char(13)+
           '  COALESCE((SELECT BORGER_ORG FROM BORGER_TILHOER_HISTORIK '+char(13)+ 
           '  WHERE BORGER_TILHOER_HISTORIK.SAGSID=A.SAGSID AND '+char(13)+ 
           '  BORGER_TILHOER_HISTORIK.PLEJETYPE=6 AND '+char(13)+ 
           '  A.SLUTDATO>BORGER_TILHOER_HISTORIK.IKRAFTDATO AND '+char(13)+
           '  A.SLUTDATO<=BORGER_TILHOER_HISTORIK.SLUTDATO),9999) AS BORGER_ORG, '+char(13)+
           '  COALESCE(B.FRITVALGLEV,8888) AS LEVERANDOERID, '+char(13)+
           '  A.IKRAFTDATO, ' +char(13)+
           '  A.SLUTDATO, ' +char(13)+
           '  6 AS PLEJETYPE '+char(13)+ 
           'FROM MADVISITATION A '+char(13)+
           'JOIN MADVISIJOB B ON A.ID=B.MADVISI_ID '+char(13)+
           'JOIN SAGER C ON A.SAGSID=C.SAGSID '+char(13)+
           'WHERE A.SLUTDATO>''2008-01-01'' ' +char(13)+--AND DATEPART(YEAR,A.SLUTDATO) NOT IN (9999) ' +char(13)+
           'ORDER BY A.SAGSID,PLEJETYPE,B.JOBID,A.SLUTDATO DESC'
if @debug = 1 print @cmd
exec (@cmd)

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

--find aktive borger med leverandørskift (afgang) 

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Afgang A 
WHERE EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato WHERE tmp_VisitationUdenSlutDato.SAGSID=A.SAGSID) AND
  DATEPART(YEAR,A.SLUTDATO) NOT IN (9999)

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid=@old_sagsid and @old_jobid=@jobid and @leverandoerid<>@old_leverandoerid
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)
  END
    
  SET @old_sagsid=@sagsid
  SET @old_leverandoerid=@leverandoerid
  SET @old_jobid=@jobid
  --print cast(@sagsid as varchar)+' gammelt sagsid '+cast(@old_sagsid as varchar)+' '+cast(@leverandoerid as varchar)+ 'gl lev'+cast(@old_leverandoerid as varchar)
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--find inaktive borgere (med afsluttede visitationer og ikke genvisiterede) med leverandørskift (afgang)  

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT ID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE 
FROM tmp_VisitationsHistorik_Afgang A 
WHERE NOT EXISTS(SELECT * FROM tmp_VisitationUdenSlutDato WHERE tmp_VisitationUdenSlutDato.SAGSID=A.SAGSID)
  

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=@sagsid
SET @old_leverandoerid=@leverandoerid
SET @old_jobid=@jobid

WHILE @@fetch_status = 0
BEGIN
  IF @sagsid<>@old_sagsid --borgers seneste visitation (blevet inaktiv) og derfor afgang 
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)--leverandør afgang
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,3)--visitation afgang    
  END --borger endnu ikke inaktiv, men leverandørskift
  ELSE IF @sagsid=@old_sagsid and @old_jobid=@jobid and @leverandoerid<>@old_leverandoerid
  BEGIN
    INSERT INTO tmp_Visitations_Afgang
    VALUES (@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@slutdato,@plejetype,1,13)
  END
    
  SET @old_sagsid=@sagsid
  SET @old_leverandoerid=@leverandoerid
  SET @old_jobid=@jobid
  
  FETCH NEXT FROM FindVisitation 
  INTO @id,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
  
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation

--union 

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_VisitationTilAfgang'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_VisitationTilAfgang'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+ 
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'INTO '+@DestinationDB+'.DBO.Fact_VisitationTilAfgang'+char(13)+
           'FROM tmp_VisitationTilAfgang_periode'+char(13)+ 
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_Visitations_Tilgang'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_Visitations_Afgang'+char(13)+   
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Primo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationTilAfgang_Ultimo'+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+ 
           '  PK_DATE, '+char(13)+
           '  SAGSID, '+char(13)+
           '  SAGSID_PLEJETYPE, '+char(13)+
           '  STATUSID, '+char(13)+
           '  BORGER_ORG, '+char(13)+
           '  LEVERANDOERID, '+char(13)+
           '  PLEJETYPE, '+char(13)+
           '  SPECIFIKATION_NY '+char(13)+
           'FROM tmp_VisitationsGruppeskift'    
           
                              
if @debug = 1 print @cmd
exec (@cmd)                   


END
