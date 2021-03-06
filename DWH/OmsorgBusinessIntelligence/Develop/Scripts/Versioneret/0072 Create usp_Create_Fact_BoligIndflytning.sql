USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Fact_Boliger]    Script Date: 06/26/2013 09:40:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Fact_Boliger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

--------------------------------
-- borgers alder ved indflytning
--------------------------------

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligIndflyt'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligIndflyt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT'+char(13)+
           '  BOLIGSAGHIST.SAGSID,'+char(13)+
           '  MIN(BOLIGSAGHIST.INDFLYTNING) AS PK_DATE'+char(13)+
           'INTO tmp_FactBoligIndflyt'+char(13)+
           'FROM BOLIGSAGHIST '+char(13)+
           'GROUP BY BOLIGSAGHIST.SAGSID '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligIndflyt1'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligIndflyt1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT'+char(13)+
           '  tmp_FactBoligIndflyt.SAGSID,'+char(13)+
           '  BOLIGSAGHIST.BOLIGID,'+char(13)+
           '  tmp_FactBoligIndflyt.PK_DATE'+char(13)+
           'INTO tmp_FactBoligIndflyt1'+char(13)+
           'FROM BOLIGSAGHIST '+char(13)+
           'JOIN tmp_FactBoligIndflyt on BOLIGSAGHIST.SAGSID=tmp_FactBoligIndflyt.SAGSID AND BOLIGSAGHIST.INDFLYTNING=tmp_FactBoligIndflyt.PK_DATE'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBoligIndflyt'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBoligIndflyt'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  t_bo.SAGSID,'+char(13)+
           '  t_bo.BOLIGID,'+char(13)+
           'CASE '+char(13)+
           ' WHEN t_bo.PK_DATE<''2002.01.01'' THEN ''2002.01.01'''+char(13)+
           'ELSE t_bo.PK_DATE '+char(13)+
           'END AS PK_DATE, '+char(13)+
           '  dbo.Age(SA.CPRNR,t_bo.PK_DATE) AS BORGERALDER'+CHAR(13)+
           'INTO '+@DestinationDB+'.dbo.FactBoligIndflyt'+char(13)+
           'FROM tmp_FactBoligIndflyt1 t_bo'+char(13)+
           'JOIN SAGER SA ON t_bo.SAGSID=SA.SAGSID '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

--------------------------------
-- fraflytninger
--------------------------------


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name = ''_tmp_fraflyt1'' AND type = ''U'') DROP TABLE dbo._tmp_fraflyt1'
if @debug = 1 print @cmd
exec (@cmd)
-- hent alle hændelser fra boligsaghist og dødsfal på borgere der har boet i visiteret bolig
set @cmd = 'select * into _tmp_fraflyt1 from '+char(13)+ 
			'(select BOLIGER.DRIFTFORM, '+char(13)+
			'   BOLIGSAGHIST.SAGSID, '+char(13)+
            '   BOLIGSAGHIST.INDFLYTNING startdato, '+char(13)+
			'   BOLIGSAGHIST.BOLIGID '+char(13)+
			'from BOLIGSAGHIST  '+char(13)+
			'join BOLIGER on BOLIGSAGHIST.BOLIGID=BOLIGER.ID '+char(13)+
			'where BOLIGSAGHIST.FRAFLYTNING is not null '+char(13)+
			'union all  '+char(13)+
			'select 99 as driftform,SAGSID,IKRAFTDATO,-1 '+char(13)+
			'from (select SAGSID,IKRAFTDATO,row_number() over(partition by SAGSID order by IKRAFTDATO asc) as roworder '+char(13)+
			'from SAGSHISTORIK where SAGSHISTORIK.SAGS_STATUSID=6 and exists(select SAGSID from BOLIGSAGHIST where SAGSHISTORIK.SAGSID=BOLIGSAGHIST.SAGSID)) temp '+char(13)+
			'where roworder = 1) tmp order by SAGSID,startdato '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
-- lav fact fraflyt
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_Fraflyt'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Fraflyt'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'create table AvaleoAnalytics_DW.dbo.Fact_Fraflyt '+char(13)+
			'(driftform int null, '+char(13)+
			'sagsid int null, '+char(13)+
			'pk_date date not null, '+char(13)+
			'fraflytid int not null, '+char(13)+
			'boligid int null) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--gennemse _tmp_fraflyt1 og find borgere der flyttet til plejebolig eller er døde
SET NOCOUNT ON; 

DECLARE @sagsid integer
DECLARE @driftform integer
DECLARE @pk_date date
DECLARE @old_sagsid integer
DECLARE @old_driftform integer
DECLARE @boligid integer
DECLARE @old_boligid integer
DECLARE @fraflytid integer

DECLARE FindFraflyt CURSOR FAST_FORWARD FOR
SELECT DRIFTFORM,SAGSID,startdato,boligid FROM _tmp_fraflyt1  

set @old_sagsid=0
set @fraflytid=0
set @old_driftform=0

OPEN FindFraflyt
FETCH NEXT FROM FindFraflyt
INTO @driftform,@sagsid,@pk_date,@boligid

WHILE @@fetch_status = 0
BEGIN    
  if (@sagsid=@old_sagsid)
  begin
    if ((@old_driftform in (4,8)) and (@driftform in (1,2,3,99)))
    begin
      if (@driftform=99)
      begin
        set @fraflytid=99
      end
      else 
        set @fraflytid=2
      insert into AvaleoAnalytics_DW.dbo.Fact_Fraflyt select @driftform as driftform,@sagsid as sagsid,@pk_date as pk_date,@fraflytid as fraflytid,@old_boligid as boligid 
    end
  end
     
  set @old_sagsid=@sagsid
  set @old_boligid=@boligid
  set @old_driftform=@driftform
  
  FETCH NEXT FROM FindFraflyt 
  INTO @driftform,@sagsid,@pk_date,@boligid

END
 
CLOSE FindFraflyt
DEALLOCATE FindFraflyt
-------------------------
--beboede boliger
-------------------------
set @cmd='IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name = ''Fact_Bolig_Beboet'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Bolig_Beboet'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd='create table '+@DestinationDB+'.DBO.Fact_Bolig_Beboet ( '+char(13)+
			'ledig int null, '+char(13)+
			'beboet int null, '+char(13)+
			'pk_date date not null, '+char(13)+
			'boligid int not null, '+char(13)+
			'sagsid int null, '+char(13)+
			'cprnr varchar(10) null, '+char(13)+
			'aldergrp int null, '+char(13)+
			'kvinde int null, '+char(13)+
			'mand int null, '+char(13)+
			'BEBOET_DIST bigint null) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd='insert into '+@DestinationDB+'.dbo.fact_bolig_beboet '+char(13)+ 
			'select  '+char(13)+
			'  null as LEDIG, '+char(13)+
			'  1 as BEBOET, '+char(13)+
			'  Dim_Time.PK_Date, '+char(13)+
			'  BOLIGSAGHIST.BOLIGID, '+char(13)+
			'  BOLIGSAGHIST.SAGSID, '+char(13)+
			'  SAGER.CPRNR, '+char(13)+
			'  dbo.Age(SAGER.CPRNR,PK_Date) as ALDERGRP, '+char(13)+
			'  CASE when convert(int,RIGHT(SAGER.CPRNR,1))%2 = 0 then CONVERT(int,1) end as KVINDE,   '+char(13)+
			'  CASE when convert(int,RIGHT(SAGER.CPRNR,1))%2 <> 0 then CONVERT(int,1) end as MAND, '+char(13)+
			'  CONVERT(bigint, convert(varchar(3),datepart(DAYofyear,PK_Date))+convert(varchar(4),year(PK_Date))+CONVERT(varchar(20),BOLIGSAGHIST.BOLIGID) ) AS BEBOET_DIST '+char(13)+
			'from BOLIGSAGHIST '+char(13)+
			'join Dim_Time on Dim_Time.PK_Date>=BOLIGSAGHIST.indflytning and  Dim_Time.PK_Date<=COALESCE(BOLIGSAGHIST.KLAR_DATO,GETDATE()) '+char(13)+
			'join SAGER on SAGER.SAGSID=BOLIGSAGHIST.SAGSID '+char(13)+
			'where PK_Date>=boligsaghist.indflytning AND PK_Date<=GETDATE() '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--opdater fra alder til aldersgruppe
set @cmd='UPDATE '+@DestinationDB+'.dbo.Fact_Bolig_Beboet set '+@DestinationDB+'.dbo.Fact_Bolig_Beboet.ALDERGRP = '+char(13)+
			'CASE '+char(13)+   
			'  when ALDERGRP<20 then 1 '+char(13)+
			'  when ALDERGRP between 20 and 29 then 2 '+char(13)+
			'  when ALDERGRP between 30 and 39 then 3 '+char(13)+
			'  when ALDERGRP between 40 and 59 then 4 '+char(13)+
			'  when ALDERGRP between 60 and 64 then 5 '+char(13)+
			'  when ALDERGRP between 65 and 66 then 6  '+char(13)+
			'  when ALDERGRP between 67 and 74 then 7 '+char(13)+
			'  when ALDERGRP between 75 and 79 then 8 '+char(13)+
			'  when ALDERGRP between 80 and 84 then 9  '+char(13)+
			'  when ALDERGRP between 85 and 89 then 10 '+char(13)+
			'else 11  '+char(13)+
			'end '+char(13)  
if @debug = 1 print @cmd
exec (@cmd)
---------------------
--ledige boliger
---------------------
set @cmd='insert into '+@DestinationDB+'.dbo.fact_bolig_beboet '+char(13)+ 
			'select distinct  '+char(13)+
			'  1 as ledig,  '+char(13)+
			'  convert(int,null) as beboet,  '+char(13)+
			'  pk_date, '+char(13)+
			'  BOLIGID, '+char(13)+
			'  CONVERT(int,(select top 1 sagsid from '+@DestinationDB+'.dbo.DimSager where CprNr is null)) as sagsid, '+char(13)+
			'  CONVERT(varchar(10),null) as cprnr, '+char(13)+
 			'  CONVERT(int,0) as aldergrp, '+char(13)+
  			'  CONVERT(int,null) as mand, '+char(13)+
  			'  CONVERT(int,null) as kvinde, '+char(13)+
  			'  CONVERT(bigint,null) as beboet_dist  '+char(13)+
			'from BOLIGSAGHIST, Dim_Time '+char(13)+
			'where PK_Date between ''2002.01.01'' and ''2012.01.01''  '+char(13)+
			'and BOLIGSAGHIST.FRAFLYTNING is not null  '+char(13)+
			'and pk_date>(select min(pk_date) from '+@DestinationDB+'.dbo.Fact_Bolig_Beboet where '+@DestinationDB+'.dbo.Fact_Bolig_Beboet.boligid=BOLIGSAGHIST.BOLIGID) '+char(13)+
			'and not exists(select * from '+@DestinationDB+'.dbo.Fact_Bolig_Beboet where (('+@DestinationDB+'.dbo.Fact_Bolig_Beboet.BOLIGID=BOLIGSAGHIST.BOLIGID) and  '+char(13)+
   			'('+@DestinationDB+'.dbo.Fact_Bolig_Beboet.PK_Date=Dim_Time.PK_Date)))   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
-----------------
--boligventeliste
-----------------
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste'
if @debug = 1 print @cmd
exec (@cmd)
--find tidligste tilbudsdato
set @cmd = 'SELECT '+char(13)+
           '  BT.BORGERID,'+char(13)+
           '  BT.BOLIGVISI_ID,'+char(13)+
           '  MIN(BT.TILBUD_DATO) AS TILBUD_DATO'+char(13)+
           'INTO tmp_Boligventeliste'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN BOLIGVISITATION BV ON BT.BORGERID=BV.SAGSID AND BT.BOLIGVISI_ID=BV.ID'+char(13)+
           'GROUP BY BT.BOLIGVISI_ID,BT.BORGERID'+char(13)+
           'ORDER BY BT.BOLIGVISI_ID'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste1'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste1'
if @debug = 1 print @cmd
exec (@cmd)
--indsæt resten af data
set @cmd = 'SELECT '+char(13)+
           '  BT.ID,'+char(13)+
           '  BT.BOLIGID,'+char(13)+
           '  BT.BORGERID AS SAGSID,'+char(13)+
           '  BT.TILBUD_DATO,'+char(13)+
           '  BT.UDLOB_DATO,'+char(13)+
           '  BT.AFVIST_DATO,'+char(13)+
           '  BT.FRA_GARANTI_LISTE,'+char(13)+
           '  BT.BOLIGVISI_ID'+char(13)+
           'INTO tmp_Boligventeliste1'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN tmp_Boligventeliste A ON A.BORGERID=BT.BORGERID AND A.BOLIGVISI_ID=BT.BOLIGVISI_ID AND A.TILBUD_DATO=BT.TILBUD_DATO '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Boligventeliste2'' AND type = ''U'') DROP TABLE dbo.tmp_Boligventeliste2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  COALESCE(BT.TILBUD_DATO,BV.INDFLYTNING,GETDATE()) AS PK_DATE,'+char(13)+
           '  BV.SAGSID,'+char(13)+
           '  BV.ID,'+char(13)+
           '  BT.BOLIGID,'+char(13)+
           '  BV.IKRAFTDATO,'+char(13)+
           '  BT.TILBUD_DATO,'+char(13)+
           '  DATEDIFF(DD,BV.IKRAFTDATO,COALESCE(BT.TILBUD_DATO,BV.INDFLYTNING,GETDATE())) AS VENTETID_DAGE,'+char(13)+
           '  BV.DRIFTFORM,'+char(13)+ 
           '  BV.PLADSTYPE,'+char(13)+ 
           '  CAST(BV.DRIFTFORM AS NVARCHAR(1))+CAST(BV.PLADSTYPE AS NVARCHAR(1)) AS DFPTID,'+char(13)+         
           '  BT.FRA_GARANTI_LISTE,'+char(13)+
           '  BV.FRITVALGSVENTELISTE,'+char(13)+
           '  CASE '+char(13)+ 
           '    WHEN ((BT.FRA_GARANTI_LISTE=1) AND (BV.FRITVALGSVENTELISTE=1)) THEN 1'+char(13)+ --afslået tilbud - flyttet til fritvalg
           '    WHEN BV.FRITVALGSVENTELISTE=0 THEN 2'+char(13)+                          --garantiventeliste    
           '    WHEN BV.FRITVALGSVENTELISTE=1 THEN 3'+char(13)+                          --fritvaglsliste
           '  ELSE 9999 '+char(13)+ 
           '  END AS VENTELISTETYPEID,'+char(13)+             
           '  1 AS ANTAL_BORGERE'+char(13)+
           'INTO dbo.tmp_Boligventeliste2'+char(13)+           
           'FROM BOLIGVISITATION BV'+char(13)+
           'JOIN tmp_Boligventeliste1 BT ON BV.ID=BT.BOLIGVISI_ID '+char(13)+
           'ORDER BY BV.SAGSID '+char(13)        
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_Boligventeliste'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Boligventeliste'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_Boligventeliste '+char(13)+
           'FROM tmp_Boligventeliste2 WHERE DRIFTFORM>0 AND PLADSTYPE>0 '  
if @debug = 1 print @cmd
exec (@cmd) 

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=72)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (72,GETDATE())           
--end
 
END