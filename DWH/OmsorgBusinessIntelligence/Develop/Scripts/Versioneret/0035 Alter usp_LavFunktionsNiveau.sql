USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavFunktionsNiveau]    Script Date: 05/24/2011 09:24:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[usp_LavFunktionsNiveau] 
                @DestinationDB as varchar(200),
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN
--FSII OBS!! IKKE GSB Henter Funktionsniveau hvor GSB ikke benyttes
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.ID AS VISI_ID, '+char(13)+
           'FA.RELEVANT, '+char(13)+
           'CAST(VU.NIVEAU AS NUMERIC(10,2)) AS NIVEAU '+char(13)+
           'INTO tmp_FunktionsNiveau_Step1 '+char(13)+
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN FAGLIGVURDERING FA ON HJ.ID=FA.VISI_ID AND FA.VISI_TYPE=0 '+char(13)+
           'JOIN VURDERINGSNIV VU ON FA.VURDNIV_ID=VU.ID AND VU.FALLES_SPROG_ART=2 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--Henter Funktionsniveau hvor Godsagsbehandling benyttes. På GSB er der kun 1 samlet score
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step11'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step11'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.ID AS VISI_ID, '+char(13)+
           'CAST(VU.NIVEAU AS NUMERIC(10,2)) AS GENNEMSNIT '+char(13)+
           'INTO tmp_FunktionsNiveau_Step11 '+char(13)+
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN GS_SAGER GSB ON HJ.GS_SAG_ID=GSB.SAG_ID '+char(13)+
           'JOIN VURDERINGSNIV VU ON GSB.SAMLET_FUNKTIONSNIVEAU_ID=VU.ID AND VU.FALLES_SPROG_ART=2 AND VU.ID<6 '+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--FSI
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step12'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step12'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'ID AS VISI_ID, '+char(13)+
           'CAST(((F1+F2+F3+F4+F5+F6+F7+F8+F9+F11+F12+F13)/12) AS NUMERIC(10,2)) AS GENNEMSNIT '+char(13)+
           'INTO tmp_FunktionsNiveau_Step12 '+char(13)+
           'FROM HJVISITATION '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmp_FunktionsNiveau_Step1 A WHERE HJVISITATION.ID=A.VISI_ID) AND'+char(13)+
           '  NOT EXISTS(SELECT * FROM tmp_FunktionsNiveau_Step11 B WHERE HJVISITATION.ID=B.VISI_ID) '+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step2'
if @debug = 1 print @cmd
exec (@cmd)
--Beregner gennemsnitlige funktionsniveau (FSII) og samler resultater fra ovenstående
set @cmd = 'SELECT '+char(13)+
           '  VISI_ID, '+char(13)+
           '  CASE WHEN SUM(RELEVANT)>0 THEN '+char(13)+
           '    CAST((SUM(NIVEAU)/SUM(RELEVANT))AS NUMERIC(10,2)) '+char(13)+
           '  ELSE 0 '+char(13)+
           '  END AS GENNEMSNIT, '+char(13)+
           '  ''FS2'' AS FS_TYPE'+char(13)+
           'INTO tmp_FunktionsNiveau_Step2 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step1 '+char(13)+
           'GROUP BY VISI_ID '+char(13)+
           'UNION ALL'+char(13)+
           'SELECT '+char(13)+
           '  VISI_ID,'+char(13)+
           '  GENNEMSNIT, '+char(13)+
           '  ''GSB'' AS FS_TYPE'+char(13)+
           'FROM tmp_FunktionsNiveau_Step11'+char(13)+
           'UNION ALL'+char(13)+
           'SELECT '+char(13)+
           '  VISI_ID,'+char(13)+
           '  GENNEMSNIT, '+char(13)+
           '  ''FS1'' AS FS_TYPE'+char(13)+
           'FROM tmp_FunktionsNiveau_Step12'+char(13)
if @debug = 1 print @cmd
exec (@cmd)
--Sætter funktionsniveau i forhold til gennemsnit
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step3'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step3'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'SELECT '+char(13)+
           'VISI_ID, '+char(13)+
           'COALESCE(CASE FS_TYPE '+char(13)+
           '  WHEN ''FS1'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 1 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 2 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 3 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 4 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 5 '+char(13)+
           '  END '+char(13)+ 
           '  WHEN ''FS2'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 6 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 7 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 8 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 9 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 10 '+char(13)+
           '  END '+char(13)+
           '  WHEN ''GSB'' THEN '+char(13)+ 
           '  CASE '+char(13)+
           '    WHEN A.GENNEMSNIT=0 THEN 11 '+char(13)+
           '    WHEN A.GENNEMSNIT>0 AND A.GENNEMSNIT<=1 THEN 12 '+char(13)+
           '    WHEN A.GENNEMSNIT>1 AND A.GENNEMSNIT<=2 THEN 13 '+char(13)+
           '    WHEN A.GENNEMSNIT>2 AND A.GENNEMSNIT<=3 THEN 14 '+char(13)+
           '    WHEN A.GENNEMSNIT>3 AND A.GENNEMSNIT<=4 THEN 15 '+char(13)+
           '  END '+char(13)+  
           'END,9999) AS DIM_FUNKNIVEAU_ID, '+char(13)+
           'FS_TYPE '+char(13)+  
           'INTO tmp_FunktionsNiveau_Step3 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step2 A '+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)
--Har valgt at dele funktionsniveau og visiteret tid op da der ellers ville være alt for mange ting at holde styr på ;-) 
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step4'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step4'
if @debug = 1 print @cmd
exec (@cmd) 
--find visiterede tid pr visitation - hjemmepleje
set @cmd = 'SELECT '+char(13)+
           'A.ID AS VISI_ID, '+char(13)+
           'A.SAGSID, '+char(13)+
           'A.IKRAFTDATO, '+char(13)+
           'A.SLUTDATO, '+char(13)+
           'CAST(B.NORMTID AS NUMERIC(10,2)) AS NORMTID, '+char(13)+
           'B.HYPPIGHED, '+char(13)+
           'B.YD_GANGE, '+char(13)+
           'B.YD_MORGEN+B.YD_FORMIDDAG+B.YD_MIDDAG+B.YD_EFTERMIDDAG+ '+char(13)+
           'B.YD_AFTEN1+B.YD_AFTEN2+B.YD_AFTEN3+B.YD_AFTEN4+ '+char(13)+
           'B.YD_NAT1+B.YD_NAT2+B.YD_NAT3+B.YD_NAT4 '+char(13)+
           'AS YD_PR_DOEGN, '+char(13)+
           'B.YD_WEEKEND, '+char(13)+
           'B.PERSONER '+char(13)+
           'INTO tmp_FunktionsNiveau_Step4'+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

/*  Beregningsmetode				
			
			--Weekend
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*YD_WEEKEND*Personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid/YD_WEEKEND*personer)/2 ' +char(13)+
			'    end ' +char(13)+
			'end as HJVISIJOBWeekend, ' +char(13)+
*/

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step5'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step5'
if @debug = 1 print @cmd
exec (@cmd) 
--fordel visiterede tid på hverdag og weekend
set @cmd = 'SELECT '+char(13)+
           'VISI_ID, '+char(13)+
           'SAGSID, '+char(13)+
           'IKRAFTDATO, '+char(13)+
           'SLUTDATO, '+char(13)+
           'NORMTID, '+char(13)+
           'HYPPIGHED, '+char(13)+
           'YD_GANGE, '+char(13)+
           'YD_WEEKEND, '+char(13)+
           'PERSONER, '+char(13)+           
           'CASE '+char(13)+
           '  WHEN HYPPIGHED=0 THEN (NORMTID*YD_GANGE*PERSONER) '+char(13)+ --daglig
           '  WHEN HYPPIGHED=1 THEN'+char(13)+ --ugentlig
           '    CASE WHEN YD_WEEKEND=0 THEN (NORMTID*YD_GANGE*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '    ELSE (NORMTID*(YD_GANGE-YD_WEEKEND)*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '    END '+char(13)+
           '  WHEN HYPPIGHED=2 THEN '+char(13)+ --hver x. uge
           '    CASE WHEN YD_WEEKEND=0 THEN '+char(13)+--der er ikke ydelser i weekend
           '      CASE WHEN YD_GANGE>0 THEN ((NORMTID/YD_GANGE)*YD_PR_DOEGN*PERSONER)/5 '+char(13)+
           '      ELSE 0 '+char(13)+
           '      END '+char(13)+ 
           '    END '+char(13)+
           'END AS VISI_TID_HVERDAG, '+char(13)+  
           'CASE '+char(13)+
           '  WHEN HYPPIGHED=0 THEN (NORMTID*YD_GANGE*PERSONER) '+char(13)+
           '  WHEN HYPPIGHED=1 THEN'+char(13)+ 
           '    CASE WHEN YD_WEEKEND>0 THEN (NORMTID*YD_WEEKEND*YD_PR_DOEGN*PERSONER)/2 '+char(13)+
           '    ELSE 0 '+char(13)+
           '    END '+char(13)+
           '  WHEN HYPPIGHED=2 THEN '+char(13)+
           '    CASE WHEN YD_WEEKEND>0 THEN ((NORMTID/YD_WEEKEND)*YD_PR_DOEGN*PERSONER)/2 '+char(13)+
           '    ELSE 0 '+char(13)+   
           '    END '+char(13)+
           'END AS VISI_TID_WEEKEND '+char(13)+       
           'INTO tmp_FunktionsNiveau_Step5 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step4' 
if @debug = 1 print @cmd
exec (@cmd)         
--summer visiteret tid pr visitation
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step6'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step6'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT '+char(13)+
           '  VISI_ID, '+char(13)+
           '  SAGSID, '+char(13)+
           '  IKRAFTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  SUM(VISI_TID_HVERDAG) AS VISI_TID_HVERDAG, '+char(13)+
           '  SUM(VISI_TID_WEEKEND) AS VISI_TID_WEEKEND '+char(13)+    
           'INTO tmp_FunktionsNiveau_Step6 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step5 '+char(13)+
           'GROUP BY SAGSID,VISI_ID,IKRAFTDATO,SLUTDATO '+char(13)
if @debug = 1 print @cmd
exec (@cmd) 
--join med funktionsniveau  
set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step7'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step7'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT DISTINCT '+char(13)+
           '  A.VISI_ID, '+char(13)+
           '  A.SAGSID, '+char(13)+
           '  A.IKRAFTDATO, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  A.VISI_TID_HVERDAG, '+char(13)+
           '  A.VISI_TID_WEEKEND, '+char(13)+ 
           '  B.DIM_FUNKNIVEAU_ID, '+char(13)+ 
           '  B.FS_TYPE '+char(13)+     
           'INTO tmp_FunktionsNiveau_Step7 '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step6 A '+char(13)+
           'JOIN tmp_FunktionsNiveau_Step3 B ON A.VISI_ID=B.VISI_ID'+char(13)
if @debug = 1 print @cmd
exec (@cmd)  
--sæt pk_date på og join BORGER_TILHOER_HISTORIK for at få borger oplysninger
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''Fact_FunktionsNiveau'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.Fact_FunktionsNiveau'
if @debug = 1 print @cmd
exec (@cmd)            

set @cmd = 'SELECT '+char(13)+
           '  B.PK_DATE, '+char(13)+ 
           '  A.SAGSID, '+char(13)+
           '  COALESCE(DBO.AGE(C.CPRNR,B.PK_DATE),0) AS ALDER, '+char(13)+ 
           '  COALESCE(C.STATUS,0) AS BORGER_STATUS, '+char(13)+     
           '  COALESCE(C.STATUSID,1) AS BORGER_STATUSID, '+char(13)+
           '  COALESCE(C.BORGER_ORG,9999) AS BORGER_ORG, '+char(13)+     
           '  A.DIM_FUNKNIVEAU_ID, '+char(13)+
           '  A.FS_TYPE, '+char(13)+
           '  CASE WHEN B.WEEKEND=0 THEN A.VISI_TID_HVERDAG ELSE 0 END AS VISI_TID_HVERDAG, '+char(13)+
           '  CASE WHEN B.WEEKEND=1 THEN A.VISI_TID_WEEKEND ELSE 0 END AS VISI_TID_WEEKEND, '+char(13)+
           '  CASE WHEN B.WEEKEND=1 THEN A.VISI_TID_WEEKEND ELSE A.VISI_TID_HVERDAG END AS VISI_TID_TOTAL '+char(13)+
           'INTO '+@DestinationDB+'.dbo.Fact_FunktionsNiveau '+char(13)+ 
           'FROM tmp_FunktionsNiveau_Step7 A '+char(13)+
           'JOIN DimWeekendHelligdag B ON A.IKRAFTDATO<=B.PK_DATE AND A.SLUTDATO>B.PK_DATE AND '+char(13)+
           '  B.PK_DATE > ''2008-01-01'' AND B.PK_DATE < GETDATE() '+char(13)+
           'LEFT JOIN BORGER_TILHOER_HISTORIK C ON A.SAGSID=C.SAGSID AND '+char(13)+
           '  B.PK_DATE>=C.IKRAFTDATO AND B.PK_DATE<C.SLUTDATO AND C.PLEJETYPE=1 '+char(13)            
if @debug = 1 print @cmd
exec (@cmd) 
             
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=35)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (35,GETDATE())           
end

END
