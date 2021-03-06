USE [AvaleoAnalytics_Sta]
GO
/****** Object:  StoredProcedure [dbo].[usp_LavFunktionsNiveau]    Script Date: 01/11/2011 14:17:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[usp_LavFunktionsNiveau] 
                --@DestinationDB as varchar(200),
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step1'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'HJ.SAGSID, '+char(13)+
           'HJ.IKRAFTDATO AS VISI_IKRAFTDATO, '+char(13)+
           'HJ.SLUTDATO AS VISI_SLUTDATO, '+char(13)+
           'FA.VISI_ID, '+char(13)+
           'FA.IKRAFTDATO AS FUNK_IKRAFTDATO, '+char(13)+
           'FA.SLUTDATO AS FUNK_SLUTDATO, '+char(13)+
           'FA.BRUGER_ID, '+char(13)+
           'FA.RELEVANT, '+char(13)+
           'VU.NIVEAUNAVN, '+char(13)+
           'CAST(VU.NIVEAU AS NUMERIC(10,2)) AS NIVEAU '+char(13)+
           'INTO tmp_FunktionsNiveau_Step1 '+char(13)+
           'FROM HJVISITATION HJ '+char(13)+
           'JOIN FAGLIGVURDERINGHIST FA ON HJ.ID=FA.VISI_ID AND FA.VISI_TYPE=0 AND HJ.IKRAFTDATO<FA.SLUTDATO AND HJ.SLUTDATO>FA.IKRAFTDATO '+char(13)+
           'JOIN VURDERINGSNIV VU ON FA.VURDNIV_ID=VU.ID AND VU.FALLES_SPROG_ART=2 '+char(13)
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step2'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           'SAGSID, '+char(13)+
           'VISI_ID, '+char(13)+
           'VISI_IKRAFTDATO AS IKRAFTDATO, '+char(13)+
           'VISI_SLUTDATO AS SLUTDATO, '+char(13)+
           'BRUGER_ID, '+char(13)+
           'SUM(RELEVANT) AS RELEVANT, '+char(13)+
           'SUM(NIVEAU) AS NIVEAU, '+char(13)+
           'CASE WHEN SUM(RELEVANT)>0 THEN '+char(13)+
           '  CAST((SUM(NIVEAU)/SUM(RELEVANT))AS NUMERIC(10,2)) '+char(13)+
           '  ELSE 0 '+char(13)+
           'END AS GENNEMSNIT '+char(13)+
           'INTO tmp_FunktionsNiveau_Step2 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step1 '+char(13)+
           'GROUP BY SAGSID,VISI_ID,VISI_IKRAFTDATO,VISI_SLUTDATO,BRUGER_ID '
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step3'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step3'
if @debug = 1 print @cmd
exec (@cmd) 

set @cmd = 'SELECT '+char(13)+
           'A.SAGSID, '+char(13)+
           'A.VISI_ID, '+char(13)+
           'A.IKRAFTDATO, '+char(13)+
           'A.SLUTDATO, '+char(13)+
           'A.BRUGER_ID, '+char(13)+
           'A.RELEVANT, '+char(13)+
           'A.NIVEAU, '+char(13)+
           'A.GENNEMSNIT, '+char(13)+
           'CASE '+char(13)+
           '  WHEN A.GENNEMSNIT=0 THEN 0 '+char(13)+
           '  WHEN A.GENNEMSNIT BETWEEN 0.10 AND 1.00 THEN 1 '+char(13)+
           '  WHEN A.GENNEMSNIT BETWEEN 1.10 AND 2.00 THEN 2 '+char(13)+
           '  WHEN A.GENNEMSNIT BETWEEN 2.10 AND 3.00 THEN 3 '+char(13)+
           '  WHEN A.GENNEMSNIT BETWEEN 3.10 AND 4.00 THEN 4 '+char(13)+
           'ELSE 9999 '+char(13)+ 
           'END AS DIM_FUNKNIVEAU_ID, '+char(13)+
           'B.PK_DATE '+char(13)+
           'INTO tmp_FunktionsNiveau_Step3 '+char(13)+
           'FROM tmp_FunktionsNiveau_Step2 A '+char(13)+
           'JOIN DimWeekendHelligdag B ON (B.PK_DATE>=A.IKRAFTDATO) AND (B.PK_DATE<A.SLUTDATO) AND (B.PK_DATE BETWEEN ''2008-01-01'' AND GETDATE())'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''tmp_FunktionsNiveau_Step4'' AND type = ''U'') DROP TABLE dbo.tmp_FunktionsNiveau_Step4'
if @debug = 1 print @cmd
exec (@cmd) 
--find samlede visiterede tid pr visitation - hjemmepleje
set @cmd = 'SELECT '+char(13)+
           'A.ID, '+char(13)+
           'B.NORMTID AS VISI_TID_HVERDAG '+char(13)+
           --'B.NORMTID '+char(13)+
          -- 'SUM(B.NORMTID) AS VISITERET_TID '+char(13)+
           'INTO tmp_FunktionsNiveau_Step4'+char(13)+
           'FROM HJVISITATION A '+char(13)+
           'JOIN HJVISIJOB B ON A.ID=B.HJVISIID '+char(13)
           --'GROUP BY A.ID'
if @debug = 1 print @cmd
exec (@cmd)

/*
			--Hverdage
			'case ' +char(13)+ 
			'  when a.Hyppighed = 0 then (a.NormTid*YD_GANGE*Personer) ' +char(13)+		--Dagligt 
			'  when a.Hyppighed = 1 then   ' +char(13)+		--Ugentlig indsats kan forekomme hverdage og weekend 
			'    case when a.YD_WEEKEND is null then (a.NormTid*YD_GANGE*Personer)/5 ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid*(YD_GANGE-YD_WEEKEND)*Personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'  when a.Hyppighed = 2 then ' +char(13)+		--X. uge kan forekomme enten på 1 hverdag eller 1 weekenddag
			'    case when a.YD_WEEKEND is not null then null ' +char(13)+
			'    else ' +char(13)+
			'    (a.NormTid/YD_GANGE*personer)/5 ' +char(13)+
			'    end ' +char(13)+
			'end as HJVISIJOBHverdag, ' +char(13)+				
			
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
                  

END
