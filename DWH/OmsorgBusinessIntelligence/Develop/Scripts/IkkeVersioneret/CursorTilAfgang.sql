use AvaleoAnalytics_Staging_Clean

DECLARE @cmd as varchar(max)
DECLARE @sagsid INT
DECLARE @sagsid_plejetype INT
DECLARE @old_sagsid_plejetype INT
DECLARE @alder INT
DECLARE @visiid INT
DECLARE @old_visiid INT
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

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_Visitations_Tilgang_TEST'' AND type = ''U'') DROP TABLE dbo.tmp_Visitations_Tilgang_TEST'
--if @debug = 1 print @cmd
--exec (@cmd)

delete from tmp_Visitations_Tilgang_TEST

DECLARE FindVisitation CURSOR FAST_FORWARD FOR
SELECT top 3000 VISIID,SAGSID,SAGSID_PLEJETYPE,CPRNR,JOBID,ALDER,STATUS,STATUSID,BORGER_ORG,LEVERANDOERID,IKRAFTDATO,SLUTDATO,PLEJETYPE FROM tmp_VisitationsHistorik_Tilgang order by SAGSID,PLEJETYPE,IKRAFTDATO

OPEN FindVisitation
FETCH NEXT FROM FindVisitation
INTO @visiid,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype

SET @old_sagsid=0
set @old_sagsid_plejetype=0
SET @old_visiid=@visiid
set @old_leverandoerid=@leverandoerid


WHILE @@fetch_status = 0
BEGIN 

if @old_sagsid_plejetype=@sagsid_plejetype
begin
insert into tmp_Visitations_Tilgang_TEST
SELECT A.SAGSID,A.SAGSID_PLEJETYPE,/*A.CPRNR,A.JOBID,A.ALDER,A.STATUSID,A.BORGER_ORG,*/A.LEVERANDOERID,/*A.IKRAFTDATO,PLEJETYPE,1,*/
  Case
    when (@old_leverandoerid<>@leverandoerid) and (@old_leverandoerid<>8888) and (@leverandoerid<>8888) then 15 
    when A.LEVERANDOERID=8888 then 16 
    when @old_leverandoerid=8888 then 17
  end AS specifikation_ny,
  @old_leverandoerid as gl_lev,
  @leverandoerid as ny_lev,
   @old_visiid as gl_visiid,
  @visiid as visiid--,@sagsid as sagsid,@old_sagsid as gl_sagsid
  --into tmp_Visitations_Tilgang_TEST
    FROM tmp_VisitationsHistorik_Tilgang A 
    WHERE A.SAGSID_PLEJETYPE=@sagsid_plejetype AND A.VISIID=@visiid AND NOT EXISTS
    (SELECT * FROM tmp_VisitationsHistorik_Tilgang B
     WHERE B.SAGSID_PLEJETYPE=@sagsid_plejetype AND B.VISIID=@old_visiid AND B.LEVERANDOERID=A.LEVERANDOERID)
     
end     
     
  SET @old_sagsid=@sagsid
  SET @old_slutdato=@slutdato
  SET @old_borger_org=@borger_org
  set @old_sagsid_plejetype=@sagsid_plejetype 
  SET @old_visiid=@visiid
  set @old_leverandoerid=@leverandoerid
  
  FETCH NEXT FROM FindVisitation 
  INTO @visiid,@sagsid,@sagsid_plejetype,@cprnr,@jobid,@alder,@status,@statusid,@borger_org,@leverandoerid,@ikraftdato,@slutdato,@plejetype
END
 
CLOSE FindVisitation
DEALLOCATE FindVisitation   

select * from tmp_Visitations_Tilgang_TEST  