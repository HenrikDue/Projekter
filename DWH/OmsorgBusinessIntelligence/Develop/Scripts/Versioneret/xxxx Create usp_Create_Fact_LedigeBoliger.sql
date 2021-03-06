USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Fact_LedigeBoliger]    Script Date: 07/15/2011 04:05:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Alter PROCEDURE [dbo].[usp_Create_Fact_Boliger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
DECLARE @sidsteInsert as varchar(10)
BEGIN
------------------------
--boligventeliste
------------------------
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligventeliste'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligventeliste'
if @debug = 1 print @cmd
exec (@cmd)
--find tidligste tilbudsdato
set @cmd = 'SELECT '+char(13)+
           '  BT.BORGERID,'+char(13)+
           '  BT.BOLIGVISI_ID,'+char(13)+
           '  MIN(BT.TILBUD_DATO) AS TILBUD_DATO'+char(13)+
           'INTO tmp_FactBoligventeliste'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN BOLIGVISITATION BV ON BT.BORGERID=BV.SAGSID AND BT.BOLIGVISI_ID=BV.ID'+char(13)+
           'GROUP BY BT.BOLIGVISI_ID,BT.BORGERID'+char(13)+
           'ORDER BY BT.BOLIGVISI_ID'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligventeliste1'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligventeliste1'
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
           'INTO tmp_FactBoligventeliste1'+char(13)+
           'FROM BOLIG_TILBUD BT'+char(13)+
           'JOIN tmp_FactBoligventeliste A ON A.BORGERID=BT.BORGERID AND A.BOLIGVISI_ID=BT.BOLIGVISI_ID AND A.TILBUD_DATO=BT.TILBUD_DATO '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_FactBoligventeliste2'' AND type = ''U'') DROP TABLE dbo.tmp_FactBoligventeliste2'
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
           'INTO dbo.tmp_FactBoligventeliste2'+char(13)+           
           'FROM BOLIGVISITATION BV'+char(13)+
           'JOIN tmp_FactBoligventeliste1 BT ON BV.ID=BT.BOLIGVISI_ID '+char(13)+
           'ORDER BY BV.SAGSID '+char(13)
        
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_Boligventeliste'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Boligventeliste'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT * '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_Boligventeliste '+char(13)+
           'FROM tmp_FactBoligventeliste2 WHERE DRIFTFORM>0 AND PLADSTYPE>0 '  
if @debug = 1 print @cmd
exec (@cmd) 

------------------------
--ledige boliger
------------------------

--opret permanent tabel til Fact_LedigeBoliger
set @cmd = 'IF NOT EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_LedigeBoliger'' AND type = ''U'')'+char(13)+
           'SELECT CAST(NULL AS DATE) AS PK_DATE,CAST(NULL AS INTEGER) AS BOLIGID,CAST(NULL AS INTEGER) AS DFPTID INTO '+@DestinationDB+'.dbo.Fact_LedigeBoliger'
if @debug = 1 print @cmd
exec (@cmd)

--find sidste opdatering
set @sidsteInsert=(SELECT MAX(PK_DATE) FROM  AvaleoAnalytics_DW.dbo.Fact_LedigeBoliger)

if cast(getdate()as date)>cast(@sidsteInsert as date)
begin
--indsæt ledige boliger pr. dags dato i Fact_LedigeBoliger 
set @cmd = 'INSERT INTO '+@DestinationDB+'.dbo.Fact_LedigeBoliger'+char(13)+
           'SELECT '+char(13)+
           '  GETDATE() AS PK_DATE,'+char(13)+
           '  BO.ID,'+char(13)+
           '  CAST(CAST(BO.DRIFTFORM AS NVARCHAR(1))+CAST(BO.PLADSTYPE AS NVARCHAR(1))AS INTEGER)'+char(13)+
           'FROM BOLIGER BO '+char(13)+
           'WHERE ((TILDELTPR IS NULL) OR (LEDIGPR IS NOT NULL)) '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)
end

------------------------
--boligliste med beboere
------------------------

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmp_Fact_Boligliste'' AND type = ''U'') DROP TABLE dbo.tmp_Fact_Boligliste'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  BSH.ID,'+char(13)+
           '  COALESCE(BSH.BOLIGID,9999) AS BOLIGID,'+char(13)+
           '  BSH.SAGSID,'+char(13)+
           '  CASE WHEN BSH.INDFLYTNING<''2002-01-01'' THEN ''2002-01-01'' '+char(13)+
           '  ELSE BSH.INDFLYTNING'+char(13)+
           '  END AS INDFLYTNING,'+char(13)+
           '  BSH.FRAFLYTNING,'+char(13)+
           '  BSH.KLAR_DATO,'+char(13)+
           '  CAST(BO.DRIFTFORM AS NVARCHAR(1))+CAST(BO.PLADSTYPE AS NVARCHAR(1)) AS DFPTID'+char(13)+  
           'INTO tmp_Fact_Boligliste '+char(13)+
           'FROM BOLIGSAGHIST BSH '+char(13)+
           'LEFT JOIN BOLIGER BO ON BSH.BOLIGID=BO.ID  '+char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimSager DS ON BSH.SAGSID=DS.SAGSID'+char(13)+ --kun borger med boligvisitation
           'WHERE BSH.FRAFLYTNING>''2002-01-01'''+char(13)+
           'ORDER BY BOLIGID  '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_Boligliste'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_Boligliste'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  DT.PK_DATE,'+char(13)+
           '  tmp_BL.ID,'+char(13)+
           '  tmp_BL.BOLIGID,'+char(13)+
           '  tmp_BL.SAGSID,'+char(13)+
           '  tmp_BL.INDFLYTNING,'+char(13)+
           '  tmp_BL.FRAFLYTNING,'+char(13)+
           '  tmp_BL.KLAR_DATO,'+char(13)+
           '  tmp_BL.DFPTID'+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_Boligliste '+char(13)+
           'FROM tmp_Fact_Boligliste tmp_BL '+char(13)+
           'JOIN '+@DestinationDB+'.dbo.DimTime DT ON DT.PK_DATE>=tmp_BL.INDFLYTNING AND DT.PK_DATE<=tmp_BL.FRAFLYTNING  '+char(13)+
           'WHERE tmp_BL.FRAFLYTNING>''2002-01-01'' AND PK_DATE<GETDATE() '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

END