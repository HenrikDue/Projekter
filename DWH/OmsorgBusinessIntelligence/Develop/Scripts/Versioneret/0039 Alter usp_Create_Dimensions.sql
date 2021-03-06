USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dimensions]    Script Date: 06/30/2011 23:09:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[usp_Create_Dimensions]
					  @DestinationDB as  varchar(200)
AS
--DECLARE @DestinationDB as varchar(200)
DECLARE @cmd as varchar(max)
DECLARE @debug as bit
set @debug = 1
declare @defaultKommune as varchar(50)

set @defaultKommune = (select * from openquery(Omsorg, 'SELECT NAVN FROM REFUSIONSKOMMUNE 
                                                        JOIN OPSATNING ON OPSATNING.KOMMUNENR=REFUSIONSKOMMUNE.KOMMUNEKODE AND 
                                                          OPSATNING.ID=1'))

--lav dimSager
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSager' AND type = 'U') DROP TABLE DimSager

SELECT DISTINCT 
           derivedtbl_1.SAGSID as SagsId,
           SAGER.SAGSTYPE as SagsType,
           SAGER.CPRNR as CprNr, 
           fornavn + ' '+ Efternavn as Navn, 
           SAGER.ADRESSE as Adresse, 
           SAGER.POSTNR as PostNr, 
           COALESCE (SUBSTRING(SAGER.CPRNR, 5, 2), '99999') 
           AS Aargang, 
           CASE SAGER.CIVILSTAND 
           when 1 then 'Gift' 
           when 2 then 'Ugift' 
           when 3 then 'Enke/-mand' 
           when 4 then 'Samboende' 
           when 5 then 'Fraskilt' 
           when 6 then 'Mors' 
           else '9999' end as Civilstand, 
           CASE (RIGHT(sager.CPRNR, 1) % 2) 
           WHEN 1 THEN 'MAND' 
           WHEN 0 THEN 'KVINDE' 
           ELSE '99' END AS Kon,
           CASE SAGER.PLEJEKATEGORI 
           when 1 then 'SommerGæst' 
           when 5 then 'Refusion Modtage' 
           when 3 then 'Refusion Give' 
           else 'Uden Refusion' 
           end AS RefusionStatus,
           REFUSIONSKOMMUNE,
           COALESCE((SELECT NAVN FROM REFUSIONSKOMMUNE WHERE ID=SAGER.REFUSIONSKOMMUNE),@defaultKommune) AS RefusionskommuneNavn,
           COALESCE((SELECT BESKRIVELSE FROM PLEJEKATEGORI WHERE ID=SAGER.PLEJEKATEGORI),'Ingen') AS PlejeKategori,
           COALESCE((SELECT TOP 1 LAEGER.FORNAVN+' '+LAEGER.EFTERNAVN+' '+LAEGER.TELEFON 
                     FROM BORLAGEREL
                     JOIN LAEGER ON BORLAGEREL.LAEGEID=LAEGER.LAEGEID
                     WHERE BORLAGEREL.SAGSID=SAGER.SAGSID AND LAEGER.LAGETYPE=0 AND
                     LAEGER.LAGETYPEID=1),'Ukendt læge') AS LAEGENAVNTELEFON --lægetype 0 og lægetypeid 1=praktiserende læge
          into DimSager
		  FROM  (SELECT DISTINCT SAGSID
               FROM HJVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  SPVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  MADVISITATION
               UNION ALL
               SELECT DISTINCT SAGSID
               FROM  TPVISITATION
				union all
				select distinct sagsid 
			from sager where hjp_ansvarlig_forebygger is not null
			union all
		    select distinct sagsid from dbo.SAGSPLANRET
		    union all
		    select distinct sagsid from dbo.SAGSPLAN
				) AS derivedtbl_1 LEFT OUTER JOIN
               SAGER ON derivedtbl_1.SAGSID = SAGER.SAGSID
ORDER BY derivedtbl_1.SAGSID


--if @debug = 1 print @cmd
--exec (@cmd)
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSager'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSager'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Select * into '+@DestinationDB+'.dbo.DimSager from DimSager'
if @debug = 1 print @cmd
exec (@cmd)

--2. Lav DimOrganisation
-----------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimOrganisation'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimOrganisation'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'SELECT ' +char(13)+ 
           '  dbo.UAFDELINGER.UAFDELINGID,  ' +char(13)+
           '  dbo.UAFDELINGER.UAFDELINGNAVN, ' +char(13)+
           '  CASE dbo.UAFDELINGER.AKTIV ' +char(13)+
           '    WHEN 0 THEN ''Inaktiv'' ' +char(13)+
           '    WHEN 1 THEN ''Aktiv''' +char(13)+
           '  END AS ORGSTATUS, ' +char(13)+ 
		   '  dbo.AFDELINGER.AFDELINGID, ' +char(13)+
		   '  dbo.AFDELINGER.AFDELINGNAVN, ' +char(13)+
           '  dbo.ORGANISATIONER.ORGANISATIONID, ' +char(13)+
           '  dbo.ORGANISATIONER.ORGANISATIONNAVN, ' +char(13)+
		   '  1 AS OmraedeID ' +char(13)+
		   'into '+@DestinationDB+'.dbo.DimOrganisation' +char(13)+
		   'FROM  dbo.ORGANISATIONER INNER JOIN ' +char(13)+
			'			   dbo.AFDELINGER ON dbo.ORGANISATIONER.ORGANISATIONID = dbo.AFDELINGER.ORGANISATIONID INNER JOIN ' +char(13)+
			'			   dbo.UAFDELINGER ON dbo.AFDELINGER.AFDELINGID = dbo.UAFDELINGER.AFDELINGID ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'ALTER TABLE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'ADD OmraedeNavn  nvarchar(50)'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET OmraedeNavn = ' +char(13)+
           '(SELECT OmraedeNavn ' +char(13)+
           'FROM '+@DestinationDB+'.dbo.LINK_OmraedeNavne ' +char(13)+
           'WHERE ('+@DestinationDB+'.dbo.DimOrganisation.OmraedeID = OmraedeID))'

if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET OmraedeNavn = OmraedeId ' +char(13)+
		   'WHERE (OmraedeId NOT IN ' +char(13)+
           '(SELECT OmraedeId FROM '+@DestinationDB+'.dbo.LINK_OmraedeNavne))'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'ALTER TABLE '+@DestinationDB+'.dbo.DimOrganisation' +char(13)+
		   'ADD Distrikt nvarchar(50)'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET Distrikt = LEFT(AFDELINGNAVN, 2)' +char(13)+
		   'WHERE (LEFT(AFDELINGNAVN, 2) in (''ND'',''NC'',''NR'',''SD'',''SC'',''SR'',''VD'',''VC'',''VR'', ''ØD'', ''ØC'') )'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'UPDATE '+@DestinationDB+'.dbo.DimOrganisation ' +char(13)+
		   'SET Distrikt = LEFT(AFDELINGNAVN, 1)' +char(13)+
		   'WHERE (LEFT(AFDELINGNAVN, 2) not in (''ND'',''NC'',''NR'',''SD'',''SC'',''SR'',''VD'',''VC'',''VR'', ''ØD'', ''ØC'') )'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',9999,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''8888'',''8888'',''8888'',''8888'',''8888'',''8888'',8888,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''7777'',''Madvisitation'',''7777'',''Madvisitation'',''7777'',''Madvisitation'',7777,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimOrganisation ' +char(13) +
			'(UafdelingID, Uafdelingnavn, afdelingid, afdelingnavn, organisationid, organisationnavn,OmraedeID,ORGSTATUS) ' +char(13) +
			'VALUES(''5555'',''Mangler dag, aften eller nat gruppe'',''5555'',''Mangler dag, aften eller nat gruppe'',''5555'',''Mangler dag, aften eller nat gruppe'',5555,''Aktiv'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)




--3.lav DimSagsstatus
----------------------------------------------------------------------------------------------------
IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'Sagaktiv' AND type = 'U') DROP TABLE Sagaktiv

CREATE TABLE [dbo].Sagaktiv(
	[Id] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

INSERT sagaktiv(Id,Description) VALUES('1','Aktiv')
INSERT Sagaktiv(Id,Description) VALUES('2','Midlertidig inaktiv')
INSERT sagaktiv(Id,Description) VALUES('0','Inaktiv')
INSERT sagaktiv(Id,Description) VALUES('9999','Ej specificeret')


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSagsstatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSagsstatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT dbo.SAGSSTATUS.SAGSSTATUSID as SagsstatusID, dbo.SAGSSTATUS.STATUSNAVN as StatusNavn, dbo.SAGSSTATUS.SAGSTYPE as SagsType, dbo.SAGSTYPE.SAGSTYPENAVN as SagsTypeNavn, ' +char(13)+
           'dbo.SAGSSTATUS.SAGAKTIV SagsAktiv, '+DB_NAME()+'.dbo.SAGAKTIV.Description AS SagAktivNavn ' +char(13)+
		   'into '+@DestinationDB+'.dbo.DimSagsstatus ' +char(13)+
		   'FROM  '+DB_NAME()+'.dbo.SAGAKTIV INNER JOIN ' +char(13)+
           'dbo.SAGSSTATUS ON '+DB_NAME()+'.dbo.SAGAKTIV.ID = dbo.SAGSSTATUS.SAGAKTIV INNER JOIN ' +char(13)+
           'dbo.SAGSTYPE ON dbo.SAGSSTATUS.SAGSTYPE = dbo.SAGSTYPE.SAGSTYPEID '

if @debug = 1 print @cmd
exec (@cmd)

--4.Fact_borger
----------------------------------------------------------------------------------------------------
-- Borger historik ###

set @cmd = 'EXEC DBO.usp_LavBorgerHistorik'
if @debug = 1 print @cmd
exec (@cmd)

--###

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_BorgerÅrstal' AND type = 'U') DROP TABLE _BorgerÅrstal
SELECT     SAGSID as SagsId, CPRNR as CprNr, CASE WHEN (substring(cprnr, 7, 1)) < 4 THEN 19 WHEN (substring(cprnr, 7, 1)) > 4 AND (substring(cprnr, 5, 2)) 
                      < 37 THEN 20 WHEN (substring(cprnr, 7, 1)) = 4 AND (substring(cprnr, 5, 2)) > 36 THEN 19 WHEN (substring(cprnr, 7, 1)) = 9 AND (substring(cprnr, 5, 2)) 
                      > 36 THEN 19 WHEN (substring(cprnr, 7, 1)) > 4 AND (substring(cprnr, 7, 1)) < 8 AND (substring(cprnr, 5, 2)) < 37 THEN 20 WHEN (substring(cprnr, 7, 1)) 
                      > 4 AND (substring(cprnr, 7, 1)) < 8 AND (substring(cprnr, 5, 2)) > 36 THEN 18 END AS År
into _BorgerÅrstal
FROM         dbo.DimSager


IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'linkFactBorger' AND type = 'U') DROP TABLE linkFactBorger
SELECT     SagsId , CprNr, LEFT(CPRNR, 2) AS day, SUBSTRING(CPRNR, 3, 2) AS month, SUBSTRING(CPRNR, 5, 2) AS year, CAST(LOWER(år) 
                      + SUBSTRING(CPRNR, 5, 2) + '-' + SUBSTRING(CPRNR, 3, 2) + '-' + LEFT(CPRNR, 2) AS datetime) AS Foedselsdag, LEFT(CPRNR, 2) 
                      + '-' + SUBSTRING(CPRNR, 3, 2) AS JoinFactor
into linkFactBorger
FROM         _BorgerÅrstal
WHERE     (LEFT(CPRNR, 2) IN (01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31)) AND 
                      (SUBSTRING(CPRNR, 3, 2) IN (01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12))

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1a' AND type = 'U') DROP TABLE FactBorgerStep1a

SELECT dbo.linkFactBorger.SagsId, dbo.Link_Time.PK_Date as PKDate, dbo.linkFactBorger.Foedselsdag, CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float) AS AlderDage, (CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 AS AlderAar, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365) AS AlderAarAfrund, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) AS AlderGruppe, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) * 5 AS AlderGruppeStart, FLOOR((CAST(dbo.Link_Time.PK_Date AS float) 
               - CAST(dbo.linkFactBorger.Foedselsdag AS float)) / 365 / 5) * 5 + 5 AS AlderGruppeSlut, 2 AS Specifikation, 1 AS Borger
into FactBorgerStep1a
FROM  dbo.Link_Time INNER JOIN
               dbo.linkFactBorger ON dbo.Link_Time.JoinFactor = dbo.linkFactBorger.JoinFactor
WHERE (CAST(dbo.Link_Time.PK_Date AS float) - CAST(dbo.linkFactBorger.Foedselsdag AS float) >= 0)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1b' AND type = 'U') DROP TABLE FactBorgerStep1b

SELECT SagsId, DATEPART(day, PKDate) AS Dag, DATEPART(month, PKDate) AS Md, 
	   DATEPART(year, PKDate) AS Aar, Foedselsdag, AlderDage, AlderAar, 
       AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut, Specifikation, Borger
	   into FactBorgerStep1b
FROM  dbo.FactBorgerStep1a

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'FactBorgerStep1c' AND type = 'U') DROP TABLE FactBorgerStep1c

SELECT SAGSID, DATEADD(year, 1, CONVERT(datetime, CONVERT(nvarchar, dag) + '-' + CONVERT(nvarchar, md) + '-' + CONVERT(nvarchar, aar), 105)) AS PKDate, 
               Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut, 3 AS Specifikation, 
               - 1 AS Borger
into FactBorgerStep1c
FROM  dbo.FactBorgerStep1b

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactBorger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactBorger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT SAGSID, PKDate, Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut,Specifikation, Borger ' +char(13)+	
			'into '+@DestinationDB+'.dbo.FactBorger ' +char(13)+	
			'FROM  dbo.FactBorgerStep1a ' +char(13)+	
			'UNION ALL ' +char(13)+	
			'SELECT SAGSID, PKDate, Foedselsdag, AlderDage, AlderAar, AlderAarAfrund, AlderGruppe, AlderGruppeStart, AlderGruppeSlut,Specifikation, Borger ' 	+char(13)+
			'FROM  dbo.FactBorgerStep1c '
if @debug = 1 print @cmd
exec (@cmd)


--5.aldersopdeling
----------------------------------------------------------------------------------------------------

DECLARE  @i as int 
CREATE TABLE #TempAlder (aar int)
SET @i=0
WHILE @i < 120
BEGIN
  INSERT INTO #TempAlder VALUES (@i)
  SET @i=@i+1
END

set @cmd = ' TRUNCATE table '+@DestinationDB+'.dbo.DimAldersopdeling'+char(13)+
           ' INSERT INTO    '+@DestinationDB+'.dbo.DimAldersopdeling ' + char(13) +
           ' SELECT aar [AlderAar]' + char(13) +
           ' ,FLOOR(aar/5)+1 [AldersGruppe]' + char(13) +
           ' ,aar -(aar % 5 )   [AldersGruppeStart]' + char(13) +
           ' ,aar + (5-(aar % 5 ))   [AldersGruppeSlut]' + char(13) +
           ' ,CAST(aar -(aar % 5 ) AS NVARCHAR(10)) + ''-'' + CAST(aar + (5-(aar % 5 )-1) AS NVARCHAR(10))  AS [AldersGruppeNavn]' + char(13) +
           ' ,CASE ' + char(13) +
           '   WHEN aar<65 THEN ''0-64'' ' + char(13) +
           '   ELSE ''65+'' ' + char(13) +
           ' END AS Pensionist, ' + char(13) +
           ' CASE ' + char(13) +
           '   WHEN aar<67 THEN ''0-67'' ' + char(13) +
           '   ELSE ''67+'' ' + char(13) +
           ' END AS YngreÆldre67 ' + char(13) +           
           ' FROM #TempAlder' + char(13) +
           ' UNION ALL' + char(13) +
           ' SELECT 9999,9999,9999,9999,''9999'',''9999'',''9999'' ' + char(13) 
exec (@cmd)

DROP TABLE #TempAlder 


--6.DimDognInddeling
---------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimDognInddeling'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimDognInddeling'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimDognInddeling' AND type = 'U') DROP TABLE DimDognInddeling

set @cmd = 'CREATE TABLE [dbo].[DimDognInddeling]( ' +char(13)+
		   '[Id] [int] NULL, ' +char(13)+
		   '[Description] [nvarchar](50) NULL ,' +char(13)+
  '[Døgninddeling] [nvarchar](50) NULL ,' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('0','0','Ukendt')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('1','Morgen','Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('3','Middag','Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('4','Eftermiddag', 'Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('5','Aften 1', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('6','Aften 2','Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('7','Aften 3', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('8','Aften 4', 'Aften')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('9','Nat 1', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('10','Nat 2', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('11','Nat 3', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('12','Nat 4', 'Nat')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('2','Formiddag', 'Dag')
INSERT DimDognInddeling(ID,Description,Døgninddeling) VALUES('9999','9999', 'Ukendt')

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimDognInddeling from DimDognInddeling'	  
if @debug = 1 print @cmd
exec (@cmd)

--7.DimSpecifikation
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimSpecifikation'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimSpecifikation'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSpecifikation' AND type = 'U') DROP TABLE DimSpecifikation

set @cmd = 'CREATE TABLE [dbo].[DimSpecifikation]( ' +char(13)+
		   '[Id] [int] NULL, ' +char(13)+
		   '[Description] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

INSERT DimSpecifikation(ID,Description) VALUES('1','Primo')
INSERT DimSpecifikation(ID,Description) VALUES('2','Tilgang')
INSERT DimSpecifikation(ID,Description) VALUES('3','Afgang')
INSERT DimSpecifikation(ID,Description) VALUES('4','Sagsplan')
INSERT DimSpecifikation(ID,Description) VALUES('5','Perioden')
INSERT DimSpecifikation(ID,Description) VALUES('9999','Ukendt')
INSERT DimSpecifikation(ID,Description) VALUES('7','Afgang Aldersgruppe')
INSERT DimSpecifikation(ID,Description) VALUES('6','Tilgang Aldersgruppe')
INSERT DimSpecifikation(ID,Description) VALUES('8','Sagsplan korrektion afgang')
INSERT DimSpecifikation(ID,Description) VALUES('9','Ukendt')


set @cmd = 'select * into '+@DestinationDB+'.dbo.DimSpecifikation from DimSpecifikation'	  
if @debug = 1 print @cmd
exec (@cmd)


--8.Dim_pakketyper
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyperJob'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperJob'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimPakkeTyperJob from Dim_JobTyper'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimPakkeTyperJob' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,PLEJETYPE,FALLES_SPROG_ART,PARAGRAF) ' +char(13) +
			'VALUES(''999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyperKatNavne'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select Jobnavn as KatNavn, KATEGORI as Kategori, FALLES_SPROG_ART as Falles_Sprog_Art into '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne from JOBTYPER where niveau1 = 0 and niveau2 = 0 and niveau3 = 0'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimPakkeTyperKatNavne ' +char(13) +
			'(KatNavn,Kategori,FALLES_SPROG_ART) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'Delete from '+@DestinationDB+'.dbo.DimPakkeTyperJob where niveau1 = 0 and niveau2 = 0 and niveau3 = 0'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyper1'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyper1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.JOBID, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.JOBNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.KATEGORI, ' +char(13) +
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU2, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NIVEAU3, ' +char(13) +
             '         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SLETTET_JOB, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SKRIVEBESKYTTET, ' +char(13) +
              '        '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_KAT_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV1_KODE, ' +char(13) +
               '       '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV2_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_NIV3_KODE, ' +char(13) +
                '      '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SIDSTE_VITALE_AENDRING, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.PLEJETYPE, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID2, ' +char(13) +
                 '     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID3, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FUNKKAT, ' +char(13) +
                  '    '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID3, ' +char(13) +
           '           '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_ART, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.PARAGRAF, ' +char(13) +
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.NORMTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.MAXTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.BTP, ' +char(13) +
           '           '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.KATNAVN, ''Fællessprog I'' AS FALLES_SPROG_NAVN, ''AKTIV'' AS Slettet_job_navn' +char(13) +
'Into '+@DestinationDB+'.dbo.DimPakkeTyper1 ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB INNER JOIN ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne ON '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.KATEGORI = '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.KATEGORI AND ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.FALLES_SPROG_ART = '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.FALLES_SPROG_ART   ' +char(13) +
'WHERE     ('+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne.FALLES_SPROG_ART = 1) AND ('+@DestinationDB+'.dbo.DIMPAKKETYPERJOB.SLETTET_JOB = 0) ' +char(13) +
'UNION ALL  ' +char(13) +
'SELECT     DIMPAKKETYPERJOB3.JOBID, DIMPAKKETYPERJOB3.JOBNAVN, DIMPAKKETYPERJOB3.KATEGORI, DIMPAKKETYPERJOB3.NIVEAU1, ' +char(13) +
'                      DIMPAKKETYPERJOB3.NIVEAU2, DIMPAKKETYPERJOB3.NIVEAU3,' +char(13) +
 '                     DIMPAKKETYPERJOB3.SLETTET_JOB, DIMPAKKETYPERJOB3.SKRIVEBESKYTTET, DIMPAKKETYPERJOB3.FALLES_SPROG_KAT_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB3.FALLES_SPROG_NIV2_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB3.SIDSTE_VITALE_AENDRING, ' +char(13) +
   '                   DIMPAKKETYPERJOB3.PLEJETYPE, DIMPAKKETYPERJOB3.NORMTID2, DIMPAKKETYPERJOB3.NORMTID3, ' +char(13) +
    '                  DIMPAKKETYPERJOB3.NORMTID4, DIMPAKKETYPERJOB3.FUNKKAT,' +char(13) +
   '                   DIMPAKKETYPERJOB3.MAXTID2, DIMPAKKETYPERJOB3.MAXTID3, DIMPAKKETYPERJOB3.MAXTID4, ' +char(13) +
   '                   DIMPAKKETYPERJOB3.FALLES_SPROG_ART, DIMPAKKETYPERJOB3.PARAGRAF, DIMPAKKETYPERJOB3.NORMTID1, ' +char(13) +
    '                  DIMPAKKETYPERJOB3.MAXTID1, DIMPAKKETYPERJOB3.BTP, DIMPAKKETYPERKatNavne3.KATNAVN, ' +char(13) +
   '                   ''Fællessprog I'' AS FALLESSPROG_NAVN, ''SKJULT'' AS Slettet_job_navn ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB3 INNER JOIN  ' +char(13) +
 '                     '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne3 ON   ' +char(13) +
 '                     DIMPAKKETYPERJOB3.KATEGORI = DIMPAKKETYPERKatNavne3.KATEGORI AND ' +char(13) +
  '                    DIMPAKKETYPERJOB3.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne3.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne3.FALLES_SPROG_ART = 1) AND (DIMPAKKETYPERJOB3.SLETTET_JOB = 1)   ' +char(13) +
'UNION ALL   ' +char(13) +
'SELECT     DIMPAKKETYPERJOB2.JOBID, DIMPAKKETYPERJOB2.JOBNAVN, DIMPAKKETYPERJOB2.KATEGORI, DIMPAKKETYPERJOB2.NIVEAU1, ' +char(13) +
 '                     DIMPAKKETYPERJOB2.NIVEAU2, DIMPAKKETYPERJOB2.NIVEAU3,' +char(13) +
  '                    DIMPAKKETYPERJOB2.SLETTET_JOB, DIMPAKKETYPERJOB2.SKRIVEBESKYTTET, DIMPAKKETYPERJOB2.FALLES_SPROG_KAT_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB2.FALLES_SPROG_NIV2_KODE, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB2.SIDSTE_VITALE_AENDRING, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.PLEJETYPE, DIMPAKKETYPERJOB2.NORMTID2, DIMPAKKETYPERJOB2.NORMTID3, ' +char(13) +
 '                     DIMPAKKETYPERJOB2.NORMTID4, DIMPAKKETYPERJOB2.FUNKKAT,' +char(13) +
  '                    DIMPAKKETYPERJOB2.MAXTID2, DIMPAKKETYPERJOB2.MAXTID3, DIMPAKKETYPERJOB2.MAXTID4, ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_ART, DIMPAKKETYPERJOB2.PARAGRAF, DIMPAKKETYPERJOB2.NORMTID1, ' +char(13) +
   '                   DIMPAKKETYPERJOB2.MAXTID1, DIMPAKKETYPERJOB2.BTP, DIMPAKKETYPERKatNavne2.KATNAVN, ' +char(13) +
   '                  ''Fællessprog II'' AS FALLESSPROG_NAVN, ''AKTIV'' AS Slettet_job_navn  ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB2 INNER JOIN   ' +char(13) +
'                      '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne2 ON ' +char(13) +
'                      DIMPAKKETYPERJOB2.KATEGORI = DIMPAKKETYPERKatNavne2.KATEGORI AND ' +char(13) +
  '                    DIMPAKKETYPERJOB2.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne2.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne2.FALLES_SPROG_ART = 2) AND (DIMPAKKETYPERJOB2.SLETTET_JOB = 0)  ' +char(13) +
'UNION ALL   ' +char(13) +
'SELECT     DIMPAKKETYPERJOB1.JOBID, DIMPAKKETYPERJOB1.JOBNAVN, DIMPAKKETYPERJOB1.KATEGORI, DIMPAKKETYPERJOB1.NIVEAU1, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.NIVEAU2, DIMPAKKETYPERJOB1.NIVEAU3,' +char(13) +
 '                     DIMPAKKETYPERJOB1.SLETTET_JOB, DIMPAKKETYPERJOB1.SKRIVEBESKYTTET, DIMPAKKETYPERJOB1.FALLES_SPROG_KAT_KODE,   ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_NIV1_KODE, DIMPAKKETYPERJOB1.FALLES_SPROG_NIV2_KODE, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_NIV3_KODE, DIMPAKKETYPERJOB1.SIDSTE_VITALE_AENDRING, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.PLEJETYPE, DIMPAKKETYPERJOB1.NORMTID2, DIMPAKKETYPERJOB1.NORMTID3, ' +char(13) +
  '                    DIMPAKKETYPERJOB1.NORMTID4, DIMPAKKETYPERJOB1.FUNKKAT,' +char(13) +
  '                    DIMPAKKETYPERJOB1.MAXTID2, DIMPAKKETYPERJOB1.MAXTID3, DIMPAKKETYPERJOB1.MAXTID4, ' +char(13) +
 '                     DIMPAKKETYPERJOB1.FALLES_SPROG_ART, DIMPAKKETYPERJOB1.PARAGRAF, DIMPAKKETYPERJOB1.NORMTID1, ' +char(13) +
  '                    DIMPAKKETYPERJOB1.MAXTID1, DIMPAKKETYPERJOB1.BTP, DIMPAKKETYPERKatNavne1.KATNAVN, ' +char(13) +
   '                   ''Fællessprog II'' AS FALLES_SPROG_NAVN, ''SKJULT'' AS Slettet_job_navn   ' +char(13) +
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPERJOB AS DIMPAKKETYPERJOB1 INNER JOIN   ' +char(13) +
  '                    '+@DestinationDB+'.dbo.DIMPAKKETYPERKatNavne AS DIMPAKKETYPERKatNavne1 ON   ' +char(13) +
 '                     DIMPAKKETYPERJOB1.KATEGORI = DIMPAKKETYPERKatNavne1.KATEGORI AND ' +char(13) +
    '                  DIMPAKKETYPERJOB1.FALLES_SPROG_ART = DIMPAKKETYPERKatNavne1.FALLES_SPROG_ART   ' +char(13) +
'WHERE     (DIMPAKKETYPERKatNavne1.FALLES_SPROG_ART = 2) AND (DIMPAKKETYPERJOB1.SLETTET_JOB = 1)   ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_DimPakkeTyper'' AND type = ''U'') DROP TABLE dbo.tmp_DimPakkeTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT     '+@DestinationDB+'.dbo.DIMPAKKETYPER1.JOBID, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.JOBNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATEGORI, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU1, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NIVEAU3,' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SLETTET_JOB, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SKRIVEBESKYTTET, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_KAT_KODE, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV1_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV2_KODE, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NIV3_KODE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.SIDSTE_VITALE_AENDRING, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.PLEJETYPE, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID3, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID4, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FUNKKAT,' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID2, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID3, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID4, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_ART, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.PARAGRAF, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.NORMTID1, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.MAXTID1, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATNAVN, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_NAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.Slettet_job_navn, CONVERT(nvarchar, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPER1.FALLES_SPROG_KAT_KODE) + CONVERT(nvarchar, '+@DestinationDB+'.dbo.DIMPAKKETYPER1.KATEGORI) AS Kat_nogle, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPNAVN, '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.ATAIBT, '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPKATEGORI, ' +char(13)+
            '          '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPKATNAVN  ' +char(13)+
            ' into dbo.tmp_DimPakkeTyper' +CHAR(13)+
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPER1 INNER JOIN  ' +char(13)+
'                      '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP ON '+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP = '+@DestinationDB+'.dbo.DIMPAKKETYPERBTP.BTPID   ' +char(13)+
'WHERE     ('+@DestinationDB+'.dbo.DIMPAKKETYPER1.BTP IS NOT NULL)  ' +char(13)+
'UNION ALL  ' +char(13)+
'SELECT     JOBID, JOBNAVN, KATEGORI, NIVEAU1, NIVEAU2, NIVEAU3,SLETTET_JOB, SKRIVEBESKYTTET, FALLES_SPROG_KAT_KODE,   ' +char(13)+
    '                  FALLES_SPROG_NIV1_KODE, FALLES_SPROG_NIV2_KODE, FALLES_SPROG_NIV3_KODE, SIDSTE_VITALE_AENDRING, PLEJETYPE, NORMTID2, ' +char(13)+
  '                    NORMTID3, NORMTID4, FUNKKAT,MAXTID2, MAXTID3, MAXTID4, FALLES_SPROG_ART, PARAGRAF, NORMTID1, MAXTID1, BTP,  ' +char(13)+
  '                    KATNAVN, FALLES_SPROG_NAVN, Slettet_job_navn, CONVERT(nvarchar, FALLES_SPROG_KAT_KODE) + CONVERT(nvarchar, KATEGORI) ' +char(13)+
 '                     AS Kat_nogle, ''Ikke defineret'' AS Expr2, ''IBT'' AS Expr3, 0 AS Expr4, ''Ikke defineret'' AS Expr5  ' +char(13)+
'FROM         '+@DestinationDB+'.dbo.DIMPAKKETYPER1 AS DIMPAKKETYPER11  ' +char(13)+
'WHERE     (BTP IS NULL)  
UNION ALL  ' +char(13)+
'SELECT     BESOGID * 10000 AS Id, STATUSNAVN, NULL AS Expr1, NULL AS Expr2, NULL AS Expr3, NULL AS Expr4, NULL AS Expr6, NULL ' +char(13)+
     '                 AS Expr7, NULL AS Expr8, NULL AS Expr9, NULL AS Expr10, NULL AS Expr11, NULL AS Expr12, NULL AS Expr13, NULL AS Expr14, NULL ' +char(13)+
    '                  AS Expr15, NULL AS Expr16, NULL AS Expr17,NULL AS Expr19, NULL AS Expr20, NULL AS Expr21, 9 AS Expr22, NULL ' +char(13)+
    '                  AS Expr23, NULL AS Expr24, NULL AS Expr25, NULL AS Expr26, ''Uden_Ydelse'' AS Expr27, ''Uden_Ydelse'' AS Expr28, ''Besøgsstatus'' AS Expr29, NULL ' +char(13)+
    '                   AS Expr30, NULL AS Expr31, NULL AS Expr32, NULL AS Expr33, NULL AS Expr34  ' +char(13)+
'FROM         '+@DestinationDB+'.dbo.Dimbesogstatus  ' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,PLEJETYPE,FALLES_SPROG_ART,PARAGRAF,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''99999'',''99999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000001'',''Planlagt Standard Vejtid'',''1000000'',''0'',''0'',''1'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert dbo.tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000002'',''Udført Standard Vejtid'',''1000000'',''0'',''0'',''2'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000003'',''Mobil vejtid'',''1000000'',''0'',''0'',''3'',''8'',''4'',''Indirekte brugertid'',''1'',''Vejtid Besøg'',''Fællessprog I'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000004'',''Planlagt Standard Vejtid'',''1000000'',''0'',''0'',''4'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000005'',''Udført Standard Vejtid'',''1000000'',''0'',''0'',''5'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert tmp_DimPakkeTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,BTP,BTPKATEGORI,BTPKATNAVN,FALLES_SPROG_ART,KATNAVN,FALLES_SPROG_NAVN,Slettet_job_navn) ' +char(13) +
			'VALUES(''1000006'',''Mobil vejtid'',''1000000'',''0'',''0'',''6'',''8'',''4'',''Indirekte brugertid'',''2'',''Vejtid Besøg'',''Fællessprog II'',''Vejtid Besøg'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--tilføj plejetype afhængig af fællessprog
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimPakkeTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT *, '+char(13) +
           'COALESCE(CASE FALLES_SPROG_ART '+char(13) + 
           '  WHEN 1 THEN '+char(13) +
           '    CASE PLEJETYPE '+char(13) +
           '      WHEN 1 THEN ''Personlig pleje'' '+char(13) +
           '      WHEN 2 THEN ''Praktisk hjælp'' '+char(13) + 
           '      WHEN 3 THEN ''Genoptræning'' '+char(13) + 
           '      WHEN 4 THEN ''Vedl. træning'' '+char(13) + 
           '      WHEN 5 THEN ''Sygepleje'' '+char(13) + 
           '      WHEN 6 THEN ''Madservice'' '+char(13) + 
           '      WHEN 7 THEN ''Bolig'' '+char(13) + 
           '      WHEN 8 THEN ''Øvrig tid'' '+char(13) + 
           '    END '+char(13) + 
           '  WHEN 2 THEN '+char(13) + 
           '    CASE (SELECT PARAGRAF_GRUPPERING_ID FROM PARATYPER WHERE PARATYPER.ID=tmp_DimPakkeTyper.PARAGRAF) '+char(13) +
           '      WHEN 1 THEN ''Personlig pleje'' '+char(13) +
           '      WHEN 2 THEN ''Praktisk hjælp'' '+char(13) + 
           '      WHEN 3 THEN ''Genoptræning'' '+char(13) + 
           '      WHEN 4 THEN ''Vedl. træning'' '+char(13) + 
           '      WHEN 5 THEN ''Sygepleje'' '+char(13) + 
           '      WHEN 6 THEN ''Midlertidig bolig'' '+char(13) + 
           '      WHEN 7 THEN ''Permanent bolig'' '+char(13) + 
           '      WHEN 8 THEN ''Hjælpemiddel'' '+char(13) + 
           '      WHEN 9 THEN ''Madservice'' '+char(13) + 
           '    END '+char(13) + 
           'END,''Ukendt plejetype'') AS PLEJETYPE_NAVN, '+char(13) +
           'COALESCE(CASE FALLES_SPROG_ART '+char(13) + 
           '         WHEN 1 THEN PLEJETYPE '+char(13) + 
           '         WHEN 2 THEN (SELECT PARAGRAF_GRUPPERING_ID FROM PARATYPER WHERE PARATYPER.ID=tmp_DimPakkeTyper.PARAGRAF) '+char(13) + 
           '         END,9999) AS PLEJETYPE_PARAGRUPPE '+char(13) +
           'INTO '+@DestinationDB+'.dbo.DimPakkeTyper FROM tmp_DimPakkeTyper' 
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimYdelsesPakker'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimYdelsesPakker'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimYdelsesPakker from vDimYdelsespakker'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimYdelsesPakker ' +char(13) +
			'(Pakke_id, Pakke_Navn,status) ' +char(13) +
			'VALUES(''9999'',''Ukendt'',1)' +char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert '+@DestinationDB+'.dbo.DimYdelsesPakker ' +char(13) +
			'(Pakke_id, Pakke_Navn,status) ' +char(13) +
			'VALUES(''0'',''Ukendt'',1)' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--9.Dim_medarbejder

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimMedarbejderStatusStep1' AND type = 'U') DROP TABLE DimMedarbejderStatusStep1

CREATE TABLE [dbo].DimMedarbejderStatusStep1(
	[MedStatusId] [int] NULL,
	[Description] [nvarchar](50) NULL
) ON [PRIMARY]

INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('1','Aktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('2','Midlertidig inaktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('0','Inaktiv')
INSERT DimMedarbejderStatusStep1(MedStatusId,Description) VALUES('9999','Ej specificeret')

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejder'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejder'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'SELECT coalesce(dbo.MEDSTATUS.MEDSTATUSID, 9999) as MedStatusId,  coalesce(dbo.MEDSTATUS.STATUSNAVN, ''9999'') as StatusNavn, ' +char(13)+
		    'coalesce(dbo.MEDSTATUS.MEDAKTIV,9999) as MedAktiv,' +char(13)+
           'dbo.DimMedarbejderStatusStep1.Description AS MedArbAktivNavn ' +char(13)+
		   	'into '+@DestinationDB+'.dbo.DimMedarbejder ' +char(13)+	
		   'FROM  dbo.DimMedarbejderStatusStep1 LEFT OUTER JOIN ' +char(13)+
           'dbo.MedStatus ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV '
if @debug = 1 print @cmd
exec (@cmd)

--10.DimMedarbejderStatus
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejderStatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejderStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT coalesce(dbo.MEDSTATUS.MEDSTATUSID, 9999) as MedStatusId, ' +char(13)+
			'coalesce(dbo.MEDSTATUS.STATUSNAVN, ''9999'') as StatusNavn,  ' +char(13)+
			'coalesce(dbo.MEDSTATUS.MEDAKTIV,9999) as MedAktiv, dbo.DimMedarbejderStatusStep1.Description ' +char(13)+
		   	'into '+@DestinationDB+'.dbo.DimMedarbejderStatus ' +char(13)+	
		   'FROM  dbo.DimMedarbejderStatusStep1 LEFT OUTER JOIN ' +char(13)+
           'dbo.MEDSTATUS ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV'

if @debug = 1 print @cmd
exec (@cmd)

--11.Dim_medarbejdere
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejdere'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejdere'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select *, '+char(13)+
           '  CASE WHEN MEDARBEJDERTYPE=0 THEN ''Medarbejder'' '+char(13)+
           '       WHEN MEDARBEJDERTYPE=1 THEN ''Fiktiv medarbejder'' '+char(13)+
           '       WHEN MEDARBEJDERTYPE=2 THEN ''Daghjem/dagcenter'' '+char(13)+ 
           '       ELSE ''Ukendt'' '+char(13)+
           '  END AS MEDARBEJDERTYPENAVN, '+char(13)+
           '  (round([Timer]/(2220.0),(2))) as Ansættelsesbrøk '+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimMedarbejdere from MEDARBEJDERE'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'update '+@DestinationDB+'.dbo.DimMedarbejdere' + CHAR(13)+
			'Set Cprnr = ''9999999'' '+ Char(13)+
			'where cprnr is null' + char(13)
			if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimMedarbejdere(MEDARBEJDERID,OPRETTET,FODDATO,MEDARBEJDER_STATUS,MEDARBEJDER_STATUSID,FORNAVN,EFTERNAVN,ADRESSE, ' +char(13)+
			'POSTNR,TIMER,STILLINGSID,UAFDELINGID,AFDELINGID,RETTET,KMD_MEDNR,ANSATDATO,EMAIL,UPDATPEN,TELEFON,ALTTELEFON, ' +char(13)+
			'MOBILTELEFON,TLF_HEMMELIGT,ALTTLF_HEMMELIGT,MOBIL_HEMMELIGT,MEDARBEJDERNR,MEDARBEJDERINIT,MEDARBEJDERTYPE,CPRNR,PERSONNR_EKSTRA, ' +char(13)+
			'COADR,VAGTER,FYLDFARVE,FONTFARVE,CPR_VEJNAVN,CPR_HUSNR,CPR_ETAGE,CPR_SIDEDOR,TRANSPORT,STARTFROM,STARTLOKALE, ' +char(13)+
			'ABP_FIKTIV,AFLON_FORM,ADR_ID,Ansættelsesbrøk,MEDARBEJDERTYPENAVN) VALUES(''9999'',convert(datetime,''2006-10-17 00:00:00.000'',121), ' +char(13)+
			'convert(datetime,''1899-12-30 00:00:00.000'',121),''1'',''1'',''Ukendt'',''Ukendt'',''Ukendt'','''',''0'',''9999'',''9999'',''334'',' +char(13)+
			'convert(datetime,''2007-01-10 14:27:22.000'',121),'''',convert(datetime,''2006-10-17 00:00:00.000'',121),'''', ' +char(13)+
			'convert(datetime,''2006-10-27 12:49:51.000'',121),'''','''','''',NULL,NULL,NULL,''2'','''',''1'','''',''0'','''',''3'',''8421631'',NULL,'''', ' +char(13)+
			''''','''','''',''0'',''0'',NULL,''0'',NULL,NULL,''0'',''Ukendt'') ' +char(13)
if @debug = 1 print @cmd
exec (@cmd)
--12.Dim medarbejder
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimMedarbejder'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimMedarbejder'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT dbo.MEDSTATUS.MEDSTATUSID as MedStatusId, dbo.MEDSTATUS.STATUSNAVN as StatusNavn, dbo.MEDSTATUS.MEDAKTIV as MedAktiv,  ' +char(13) +
            'dbo.DimMedarbejderStatusStep1.Description AS MedArbAktivNavn  ' +char(13)+
			'into '+@DestinationDB+'.dbo.DimMedarbejder '   +char(13) +
			'FROM  dbo.DimMedarbejderStatusStep1 INNER JOIN ' +char(13)+
            'dbo.MEDSTATUS ON dbo.DimMedarbejderStatusStep1.MEDSTATUSID = dbo.MEDSTATUS.MEDAKTIV' +char(13)

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimMedarbejder(MEDSTATUSID,STATUSNAVN,MEDAKTIV,MEDARBAKTIVNAVN) VALUES(''9999'',''9999'',''9999'',''Ej specificeret'')'	  
if @debug = 1 print @cmd
exec (@cmd)

--13. DimStillingbet
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimStillingbet'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimStillingbet'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimStillingbet from STILLINGBET'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimStillingbet(STILLINGID,STILLINGNAVN,PCVAGTID,PCVAGTSYNC) VALUES(''9999'',''Ukendt'',NULL,NULL)'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimStillingbet(STILLINGID,STILLINGNAVN,PCVAGTID,PCVAGTSYNC) VALUES(''0'',''Ukendt'',NULL,NULL)'	  
if @debug = 1 print @cmd
exec (@cmd)

--14. DimFritvalgLeverandor
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFritvalgLeverandor'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFritvalgLeverandor'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  ID as Id, '+char(13)+ 
           '  NAVN as Navn, '+char(13)+
		   '  Case levtype '+char(13)+ 
		   '    when 0 then ''Generel'' '+char(13)+ 
		   '    when 1 Then ''Fritvalg'' '+char(13)+ 
		   '    when  2 then ''Hjælpemiddel'' '+char(13)+ 
		   '    when 3 then ''MadService'' '+char(13)+ 
		   '    else ''Ukendt'' '+char(13)+ 
		   '  end as LevType, '+char(13)+
		   '  CASE STATUS '+char(13)+
		   '  WHEN 0 THEN ''INAKTIV'' '+char(13)+ 
		   '  WHEN 1 THEN ''AKTIV'' '+char(13)+
		   '  END AS LEVSTATUS '+char(13)+
		   ' into '+@DestinationDB+'.dbo.DimFritvalgLeverandor from HJPLEVERANDOR'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''8888'',''Kommunen'',''Kommunen'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''0'',''Ikke katogoriseret'',''Ukendt'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimFritvalgLeverandor(Id, Navn, levtype, LEVSTATUS) VALUES(''9999'',''Ikke katogoriseret'',''Ukendt'',''AKTIV'')'	  
if @debug = 1 print @cmd
exec (@cmd)



--15.DimBesogStatus
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBesogStatus'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBesogStatus'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimBesogStatus from BESOGSTATUS'	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.dbo.DimBesogStatus(BESOGID,STATUS,STAT_TYPE,STAT_GYLDIG,STATUSNAVN,FYLDFARVE,FONTFARVE) VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')'	  
if @debug = 1 print @cmd
exec (@cmd)

--16.DimFraværstyper - DimTjenestetyper

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFravaerstyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFravaerstyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select ID AS FRAVARID,NAVN,KMDID into '+@DestinationDB+'.dbo.DimFravaerstyper from VPL_FRAVAERSTYPER ' 	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert into  '+@DestinationDB+'.dbo.DimFravaerstyper values (999,''Ukendt Fraværstype'','''')'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimTjenestetyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimTjenestetyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select ID AS TJENESTEID,NAVN,KMDID,TJENESTETYPE into '+@DestinationDB+'.dbo.DimTjenestetyper from VPL_TJENESTETYPER ' 	  
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert into  '+@DestinationDB+'.dbo.DimTjenestetyper values (9999,''Ukendt Tjenestetype'','''',null)'



           --' union all '+char(13)+
           --'select '+char(13)+
           --' 17 '+char(13)+
           --',''Ukendt''  '+char(13)+
           --',KMDID'+char(13)+
           --',KATEGORI'+char(13)+
           --',NIVEAU1'+char(13)+
           --',NIVEAU2'+char(13)+
           --',NIVEAU3'+char(13)+
           --',FYLDFARVE'+char(13)+
           --',FONTFARVE'+char(13)+
           --'from FRAVARTYPER where FRAVARID=0 and 1 <> (select count(*) from  FRAVARTYPER where FRAVARID=17 ) '+char(13)+
           --   ' union all '+char(13)+
           --'select '+char(13)+
           --' 999 '+char(13)+
           --',''Arbjede''  '+char(13)+
           --',KMDID'+char(13)+
           --',KATEGORI'+char(13)+
           --',NIVEAU1'+char(13)+
           --',NIVEAU2'+char(13)+
           --',NIVEAU3'+char(13)+
           --',FYLDFARVE'+char(13)+
           --',FONTFARVE'+char(13)+
           --'from FRAVARTYPER where FRAVARID=0 and 1 <> (select count(*) from  FRAVARTYPER where FRAVARID=999 ) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimLeverandor'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimLeverandor'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT  *' +char(13)+
           'into '+@DestinationDB+'.dbo.DimLeverandor  FROM '+@DestinationDB+'.dbo.DimOrganisation'
if @debug = 1 print @cmd
exec (@cmd)


-- Følgende to har hardkodede værdier  - overvej om det kan laves mere dynamisk
-- Laver dimJobHyppighed

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobHyppighed'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobHyppighed'
if @debug = 1 print @cmd
exec (@cmd)
set @cmd = 'Create table '+@DestinationDB+'.dbo.DimJobHyppighed
(Id smallint null,
[Description] nvarchar(50) null) '
exec (@cmd)

set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(0, ''daglig'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(1, ''Ugentlig'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimJobHyppighed values(2, ''Hver X uge'')' exec (@cmd)


--17.DimPakkeTyperBTP

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimPakkeTyperBTP'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimPakkeTyperBTP'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = '
Create table '+@DestinationDB+'.dbo.DimPakkeTyperBTP
(BTPId int not null,
BtpNavn nvarchar(50) null ,
AtaIbt nvarchar(50) null,
BtpKategori int null,
BtpKatNavn nvarchar(50) null)'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(0, ''Ikke defineret'',''IBT'',0, ''Ikke defineret'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(1, ''Personlig Pleje'',''ATA'',3, ''Direkte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(2, ''Praktisk bistand'',''ATA'',3, ''Direkte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(7, ''Fælles opgaver vdr flere borgere'',''ATA'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(9, ''Udvikling og uddannelse'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(10, ''Møder og frokost'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(11, ''Organisering og planlægning'',''IBT'',5, ''Kvalifikationstid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(6, ''Kontakt'',''ATA'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(8, ''Vejtid'',''IBT'',4, ''Indirekte brugertid'')' exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimPakkeTyperBTP values(9999,null,null,null,null)' exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimBrugerTidsProcent'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBrugerTidsProcent'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT BTPId, BtpNavn, BtpKategori, BtpKatNavn, 0 AS SORTERING into '+@DestinationDB+'.dbo.DimBrugerTidsProcent FROM '+@DestinationDB+'.dbo.DimPakkeTyperBTP'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set BtpNavn=''Ukendt'',BtpKatNavn=''Ukendt'', BtpKategori=9999, SORTERING=15 where BTPId=9999'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set BtpNavn=''Møder og frokost'', SORTERING=10 where BTPId=10'
exec (@cmd)
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (8888,''Fremmøde tid'',8888,''Fremmøde tid'', 14)'
exec (@cmd)  
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (7777,''Ledig tid'',7777,''Ledig tid'', 12)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (6666,''Direkte borgertid'',6666,''Direkte borgertid'', 1)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (5555,''Indirekte borgertid'',5555,''Indirekte borgertid'', 4)'
exec (@cmd) 
set @cmd = 'insert into '+@DestinationDB+'.dbo.DimBrugerTidsProcent values (4444,''Kvalifikationstid'',4444,''Kvalifikationstid'', 8)'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=2 where BTPId=1'
exec (@cmd) 
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=3 where BTPId=2'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=5 where BTPId=6'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=6 where BTPId=7'
exec (@cmd)   
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=7 where BTPId=8'
exec (@cmd)
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=9 where BTPId=9'
exec (@cmd)  
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=11 where BTPId=11'
exec (@cmd) 
set @cmd = 'update '+@DestinationDB+'.dbo.DimBrugerTidsProcent set SORTERING=13 where BTPId=0'
exec (@cmd) 

--18.DimJobTyper
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'select * into '+@DestinationDB+'.dbo.DimJobTyper from vdimJobtyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''DimJobTyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)
  print 'd'
set @cmd = 'IF EXISTS(SELECT name FROM dbo.sysobjects WHERE name =  ''temp_DimJobTyper'' AND type = ''U'') DROP TABLE temp_DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

SELECT  
 null ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000 
+CAST(0 as bigint)			*100000000 
+CAST(0 as bigint)			*100000    
+CAST(0 as bigint)			*100       
+CAST(0 as bigint)         JobID      
,Falles_Sprog_Art
,0 as Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
,'Fælles Sprog '+cast(Falles_Sprog_Art as nvarchar(4)) Jobnavn  
into temp_DimJobTyper
from    [JOBTYPER]
group by Falles_Sprog_Art
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/

SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(0 as bigint)			*100000000
+CAST(0 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,0 as Niveau1
,0 as Niveau2
,0 as Niveau3
, Jobnavn  
 from   [JOBTYPER]
where    Niveau1 = 0
  and    Niveau2 = 0
  and    Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(0 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
, CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  NIVEAU2 =0
  and    NIVEAU3 =0
  and    NIVEAU1 <>0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(Niveau1 as bigint)			*100000
+CAST(0 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <>  0
  and    Niveau3 =  0  
union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
SELECT   distinct 
 CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(0 as bigint) ParentID
,CAST(FALLES_SPROG_ART as bigint)	*100000000000
+CAST(KATEGORI as bigint)			*100000000
+CAST(NIVEAU1 as bigint)			*100000
+CAST(NIVEAU2 as bigint)			*100
+CAST(NIVEAU3 as bigint) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <> 0
  and    Niveau3 <>  0  
--union all
/* --------------------------------------------------------*/
/**/
/* --------------------------------------------------------*/
/*SELECT   distinct 
 CAST(FALLES_SPROG_ART as int)	*100000000000
+CAST(KATEGORI as int)			*100000000
+CAST(NIVEAU1 as int)			*100000
+CAST(NIVEAU2 as int)			*100
+CAST(Niveau3 as int) ParentID
,CAST(FALLES_SPROG_ART as int)	*100000000000
+CAST(KATEGORI as int)			*100000000
+CAST(NIVEAU1 as int)			*100000
+CAST(NIVEAU2 as int)			*100
+CAST(NIVEAU3 as int) JobID
,Falles_Sprog_Art
,Kategori
,Niveau1
,Niveau2
,Niveau3
,Jobnavn  from   [JOBTYPER]
  where  Niveau1 <> 0
  and    Niveau2 <> 0
  and    Niveau3 <>  0  */


  
set @cmd = ' SELECT [ParentID]
      ,[JobID]  ,[Falles_Sprog_Art]      ,[Kategori]      ,[Niveau1]      ,[Niveau2]      ,[Niveau3]
      ,[Jobnavn] into '+@DestinationDB+'.dbo.DimJobTyper  FROM  temp_DimJobTyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'insert '+@DestinationDB+'.dbo.DimJobTyper' +char(13) +
			'(jobid, JOBNAVN,KATEGORI,NIVEAU1,NIVEAU2,NIVEAU3,FALLES_SPROG_ART) ' +char(13) +
			'VALUES(''9999'',''9999'',''9999'',''9999'',''9999'',''9999'',''9999'')' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--### DimBevaegelse
--------------------------------------------------------------------------------------------------------
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBevaegelse'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBevaegelse'
if @debug = 1 print @cmd
exec (@cmd)

--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimSpecifikation' AND type = 'U') DROP TABLE DimSpecifikation

set @cmd = 'CREATE TABLE '+@DestinationDB+'.[dbo].[DimBevaegelse]( ' +char(13)+
		   '[BEVAEG_ID] [int] NULL, ' +char(13)+
		   '[BEVAEG_NAVN] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''1'',''Primo'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''2'',''Tilgang'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''3'',''Afgang'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''4'',''Ultimo'')' 
exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''5'',''Periode'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''12'',''Tilgang leverandør'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''13'',''Afgang leverandør'')' 
--exec (@cmd)
--set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''14'',''Gruppeskift periode'')' 
--exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''15'',''Lev. skift Frit valg > Frit valg'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''16'',''Lev skift Kommune > Frit valg'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''17'',''Lev. skift Frit valg > Kommune'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimBevaegelse(BEVAEG_ID,BEVAEG_NAVN) VALUES(''100'',''Bruger'')' 
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimFunkNiveau'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimFunkNiveau'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'CREATE TABLE '+@DestinationDB+'.[dbo].[DimFunkNiveau]( ' +char(13)+
		   '[FUNKNIVEAU_ID] [int] NULL, ' +char(13)+
		   '[FUNKNIVEAU_FSTYPE] [nvarchar](10) NULL, ' +char(13)+
		   '[FUNKNIVEAU_NAVN] [nvarchar](50) NULL ' +char(13)+
		   ') ON [PRIMARY]'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''1'',''FS1'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''2'',''FS1'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''3'',''FS1'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''4'',''FS1'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''5'',''FS1'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''6'',''FS2'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''7'',''FS2'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''8'',''FS2'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''9'',''FS2'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''10'',''FS2'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''11'',''GSB'',''Score: 0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''12'',''GSB'',''Score: 0.1 - 1.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''13'',''GSB'',''Score: 1.1 - 2.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''14'',''GSB'',''Score: 2.1 - 3.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''15'',''GSB'',''Score: 3.1 - 4.0'')' 
exec (@cmd)
set @cmd = 'INSERT '+@DestinationDB+'.DBO.DimFunkNiveau(FUNKNIVEAU_ID,FUNKNIVEAU_FSTYPE,FUNKNIVEAU_NAVN) VALUES(''9999'','''',''Score ikke kendt'')' 
exec (@cmd)


--Systembruger
set @cmd = 'EXEC dbo.usp_Create_Dim_Bruger '''+@DestinationDB+''',0'
if @debug = 1 print @cmd
exec (@cmd)


declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=39)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (39,GETDATE())           
end
