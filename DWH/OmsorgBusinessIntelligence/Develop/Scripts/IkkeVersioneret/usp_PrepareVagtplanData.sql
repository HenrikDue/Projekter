USE [AvaleoAnalyticsVagtplan_Staging]
GO
/****** Object:  StoredProcedure [dbo].[usp_PrepareVagtplanData]    Script Date: 11/15/2010 14:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp_PrepareVagtplanData]
		@DestinationDB as varchar(200),
		@ExPart as Int=0,
		@Debug  as bit = 1
		
AS

DECLARE @cmd as varchar(max)

if @ExPart=1 
--hent komme gå nærvær og fravær
begin

--hent fra komme_gaa_ud og find vagter over midnat
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep1'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+ 
           '  B.MEDARBEJDERID AS MEDID, ' +char(13)+ 
           '  C.UAFDELINGID AS MEDARB_ORG, ' +char(13)+
           '  A.PERSONNR, ' +char(13)+ 
           '  A.DATO_FRA, ' +char(13)+ 
           '  A.DATO_TIL, ' +char(13)+ 
           '  A.TJENESTE_TYPE, ' +char(13)+ 
           'CASE WHEN (DATEPART(DAYOFYEAR,DATO_TIL)-DATEPART(DAYOFYEAR,DATO_FRA))>0 THEN 1 ' +char(13)+ 
           'ELSE 0 ' +char(13)+                   --her skal der medid og gruppetilhør fra historik
           'END AS VAGT_OVER_MIDNAT ' +char(13)+ 
           'INTO FactVagtplanStep1 ' +char(13)+
           'FROM dbo.VAGTPLAN_KOMME_GAA_UD A ' +char(13)+
           'JOIN AvaleoAnalyticsDW.dbo.MEDARBEJDERE B ON A.PERSONNR=B.CPRNR'+char(13)+
           'JOIN AvaleoAnalyticsDW.dbo.MEDHISTORIK C ON B.MEDARBEJDERID=C.MEDARBEJDERID AND '+char(13)+
           '  CONVERT(DATETIME,SUBSTRING(A.DATO_FRA,1,16),102)<C.SLUTDATO AND CONVERT(DATETIME,SUBSTRING(A.DATO_FRA,1,16),102)>=C.IKRAFTDATO '
if @debug = 1 print @cmd           
exec (@cmd)

--dubler vagter over midnat
set @cmd = 'INSERT INTO FactVagtplanStep1 ' +char(13)+
           'SELECT ' +char(13)+
           '  B.MEDID, '  +char(13)+
           '  B.MEDARB_ORG,  ' +char(13)+
           '  B.PERSONNR, ' +char(13)+
           '  B.DATO_FRA, ' +char(13)+
           '  B.DATO_TIL, ' +char(13)+
           '  B.TJENESTE_TYPE,' +char(13)+
           '  2 AS VAGT_OVER_MIDNAT ' +char(13)+
           'FROM FactVagtplanStep1 B' +char(13)+
           'WHERE B.VAGT_OVER_MIDNAT=1' 
exec (@cmd)

--del vagter over midnat
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep2'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           'CASE WHEN VAGT_OVER_MIDNAT=2 THEN CONVERT(DATETIME,(SUBSTRING(DATO_TIL,1,10)+ '' 00:00:00''))' +char(13)+
           'ELSE CONVERT(DATETIME,SUBSTRING(DATO_FRA,1,16)) ' +char(13)+
           'END AS DATO_FRA, ' +char(13)+
           'CASE WHEN VAGT_OVER_MIDNAT=1 THEN CONVERT(DATETIME,(SUBSTRING(DATO_TIL,1,10)+ '' 00:00:00''))' +char(13)+
           'ELSE CONVERT(DATETIME,SUBSTRING(DATO_TIL,1,16)) ' +char(13)+
           'END AS DATO_TIL, ' +char(13)+ 
           '  TJENESTE_TYPE,' +char(13)+
           '  VAGT_OVER_MIDNAT' +char(13)+          
           'INTO FactVagtplanStep2' +char(13)+
           'FROM FactVagtplanStep1' 
if @debug = 1 print @cmd           
exec (@cmd)

-- tid til minutter
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanStep3'' AND type = ''U'') DROP TABLE dbo.FactVagtplanStep3'
if @debug = 1 print @cmd
exec (@cmd)
           
set @cmd = 'SELECT ' +char(13)+
           '  FactVagtplanStep2.PERSONNR, ' +char(13)+
           '  FactVagtplanStep2.MEDID, '  +char(13)+
           '  FactVagtplanStep2.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanStep2.DATO_FRA, ' +char(13)+
           '  FactVagtplanStep2.DATO_TIL, ' +char(13)+ --nedenstående for at få tidspunkt 00:00:00 efter dato
           '  Convert(datetime,substring(convert(varchar, convert(date,FactVagtplanStep2.DATO_FRA)),1,10)) AS PK_DATE, ' +char(13)+
           '  DATEDIFF(MINUTE,FactVagtplanStep2.DATO_FRA,FactVagtplanStep2.DATO_TIL) AS TJENESTETID_MINUTTER, ' +char(13)+  
           '  FactVagtplanStep2.TJENESTE_TYPE, ' +char(13)+
           '  VAGTPLAN_TJENESTE_TYPE.TJENESTE_TYPE_NAERVAER  ' +char(13)+
           'INTO FactVagtplanStep3 ' +char(13)+
           'FROM FactVagtplanStep2 ' +char(13)+
           'JOIN VAGTPLAN_TJENESTE_TYPE ON FactVagtplanStep2.TJENESTE_TYPE=VAGTPLAN_TJENESTE_TYPE.TJENESTE_TYPE'
exec (@cmd)

--del tjeneste i nærvær og fravær
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanNaervaer'' AND type = ''U'') DROP TABLE dbo.FactVagtplanNaervaer'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  TJENESTETID_MINUTTER, ' +char(13)+
           '  TJENESTE_TYPE ' +char(13)+
           'INTO FactVagtplanNaervaer ' +char(13)+
           'FROM FactVagtplanStep3 ' +char(13)+
           'WHERE TJENESTE_TYPE_NAERVAER>0'
exec (@cmd) 


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.dbo.sysobjects WHERE name =  ''FactVagtplanFravaer'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVagtplanFravaer'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  TJENESTETID_MINUTTER,' +char(13)+
           '  TJENESTE_TYPE' +char(13)+ 
           'INTO '+@DestinationDB+'.dbo.FactVagtplanFravaer ' +char(13)+
           'FROM FactVagtplanStep3' +char(13)+
           'WHERE TJENESTE_TYPE_NAERVAER=0'
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep1'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep1'
if @debug = 1 print @cmd
exec (@cmd)

--henter fravær hvor der er nærvær (der kan være fravær uden nærvær)
set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  F.PERSONNR, ' +char(13)+
           '  F.MEDID, '  +char(13)+
           '  F.MEDARB_ORG, '  +char(13)+
           '  CASE WHEN F.DATO_FRA>N.DATO_FRA THEN F.DATO_FRA ELSE N.DATO_FRA END AS DATO_FRA, ' +char(13)+
           '  CASE WHEN F.DATO_TIL<N.DATO_TIL THEN F.DATO_TIL ELSE N.DATO_TIL END AS DATO_TIL,' +char(13)+
           '  F.PK_DATE, ' +char(13)+
           '  F.TJENESTETID_MINUTTER,' +char(13)+
           '  F.TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep1 ' +char(13)+             
           'FROM '+@DestinationDB+'.dbo.FactVagtplanFravaer F ' +char(13)+   
           'JOIN FactVagtplanNaervaer N ON F.MEDID=N.MEDID AND ' +char(13)+        
           '  F.PK_DATE=N.PK_DATE AND ' +char(13)+        
           '  ((F.DATO_FRA<N.DATO_TIL) AND (F.DATO_TIL>N.DATO_FRA))'  --fravær skal ligge indenfor nærvær      
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep2'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep2'
if @debug = 1 print @cmd
exec (@cmd)

--grupper på dagen for at få samlede tjenestetid og periode
set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  MIN(DATO_FRA) AS DATO_FRA, ' +char(13)+
           '  MAX(DATO_TIL) AS DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  SUM(TJENESTETID_MINUTTER) AS TJENESTETID_MINUTTER,' +char(13)+
           '  -1 AS TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep2 ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep1 ' +char(13)+      
           'GROUP BY PERSONNR,MEDID,MEDARB_ORG, ' +char(13)+
           '  PK_DATE' 
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFravaerStep3'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFravaerStep3'
if @debug = 1 print @cmd
exec (@cmd)

--lav fraværs periode
set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  DATO_FRA, ' +char(13)+
           '  DATO_TIL, ' +char(13)+
           '  PK_DATE, ' +char(13)+
           '  DATEDIFF(MINUTE,DATO_FRA,DATO_TIL) AS PERIODE_MINUTTER, '+char(13)+
           '  TJENESTETID_MINUTTER,' +char(13)+
           '  TJENESTE_TYPE ' +char(13)+  
           'INTO FactVagtplanBTPFravaerStep3 ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep2 '  
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactVagtplanBTPFremmoedeTmp'' AND type = ''U'') DROP TABLE dbo.FactVagtplanBTPFremmoedeTmp'
if @debug = 1 print @cmd
exec (@cmd)

--saml nærvær og fravær (laves negativt) i samme tabel
set @cmd = 'SELECT ' +char(13)+
           '  FactVagtplanNaervaer.PERSONNR, ' +char(13)+
           '  FactVagtplanNaervaer.MEDID, '  +char(13)+
           '  FactVagtplanNaervaer.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanNaervaer.DATO_FRA, ' +char(13)+
           '  FactVagtplanNaervaer.DATO_TIL, ' +char(13)+
           '  FactVagtplanNaervaer.PK_DATE, ' +char(13)+
           '  FactVagtplanNaervaer.TJENESTETID_MINUTTER,' +char(13)+
           '  FactVagtplanNaervaer.TJENESTE_TYPE' +char(13)+ 
           'INTO FactVagtplanBTPFremmoedeTmp ' +char(13)+
           'FROM FactVagtplanNaervaer' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.PERSONNR, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.MEDID, '  +char(13)+
           '  FactVagtplanBTPFravaerStep3.MEDARB_ORG, '  +char(13)+
           '  FactVagtplanBTPFravaerStep3.DATO_FRA, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.DATO_TIL, ' +char(13)+
           '  FactVagtplanBTPFravaerStep3.PK_DATE, ' +char(13)+   --er fravær tjenestetiden større end fraværet i periode er der overlap og beregnet fraværperiode vælges  
           '  CASE WHEN FactVagtplanBTPFravaerStep3.TJENESTETID_MINUTTER>FactVagtplanBTPFravaerStep3.PERIODE_MINUTTER THEN '+char(13)+
           '  (FactVagtplanBTPFravaerStep3.PERIODE_MINUTTER)*-1 ' +char(13)+ 
           '  ELSE (FactVagtplanBTPFravaerStep3.TJENESTETID_MINUTTER)*-1 ' +char(13)+ --ellers er tjenestetiden ok 
           '  END AS TJENESTETID_MINUTTER,' +char(13)+
           '  FactVagtplanBTPFravaerStep3.TJENESTE_TYPE ' +char(13)+             
           'FROM FactVagtplanBTPFravaerStep3 ' +char(13)+           
           'UNION ALL ' +char(13)+
           'SELECT ' +char(13)+
           '  A.PERSONNR, ' +char(13)+
           '  A.MEDID, '  +char(13)+
           '  A.MEDARB_ORG, '  +char(13)+
           '  A.DATO_FRA, ' +char(13)+
           '  A.DATO_TIL, ' +char(13)+
           '  A.PK_DATE, ' +char(13)+
           '  A.TJENESTETID_MINUTTER,' +char(13)+
           '  A.TJENESTE_TYPE ' +char(13)+            
           'FROM '+@DestinationDB+'.dbo.FactVagtplanFravaer A' +char(13)+
           'WHERE (A.TJENESTE_TYPE=204)'  --kurser hentes da de tæller med i BTP                  
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactVagtplanBTPFremmoede'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.FactVagtplanBTPFremmoede'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  PERSONNR, ' +char(13)+
           '  MEDID, '  +char(13)+
           '  MEDARB_ORG, '  +char(13)+
           '  SUM(TJENESTETID_MINUTTER) AS TJENESTETID_MINUTTER, ' +char(13)+
           '  PK_DATE' +char(13)+
           'INTO '+@DestinationDB+'.dbo.FactVagtplanBTPFremmoede ' +char(13)+
           'FROM FactVagtplanBTPFremmoedeTmp' +char(13)+
           'GROUP BY PERSONNR,MEDID,MEDARB_ORG,PK_DATE'   
if @debug = 1 print @cmd
exec (@cmd)

end

if @ExPart=2 
--hent KMD tjenestetyper
begin

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimKMDFravaerstyper'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimKMDFravaerstyper'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  TJENESTE_TYPE, ' +char(13)+
           '  TJENESTE_TYPE_NAVN,' +char(13)+
           '  TJENESTE_TYPE_BESK' +char(13)+
           'INTO '+@DestinationDB+'.dbo.DimKMDFravaerstyper' +char(13)+
           'FROM AvaleoAnalyticsVagtplan_Staging.dbo.VAGTPLAN_TJENESTE_TYPE' +char(13)+
           'WHERE VAGTPLAN_TJENESTE_TYPE.TJENESTE_TYPE_NAERVAER=0' +char(13)+
           '' +char(13)+
           ''   
exec (@cmd)

end
