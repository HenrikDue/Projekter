USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Vagtplan_KMD]    Script Date: 12/20/2011 13:01:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
/*
Denne procedure henter vagtplan ud for medarbejdere med KMD vagtplan

Først hentes almindelige tjenester som opdeles i vagter over midnat, på arbejde og ikke på arbejde.

Derefter beregnes planlagt vagt tid (planlagttimer) ved sammenligning med planlagte fridage (KMDID - AD, PF, AF osv.) 
hvor der IKKE er fravær (SY, BA osv.)

Derefter tilføjes ekstra arbejde

Derefter tilføjes fravær som negativ planlagt tid

Alt samles vha. UNION ALL i FactTimerPlan 

*/
-- =============================================
ALTER PROCEDURE [dbo].[usp_Create_Vagtplan_KMD]
		@DestinationDB as varchar(200)='AvaleoAnalytics_DW',
		@ExPart as Int=0,
		@Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step1'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step1'
exec (@cmd)
--aktive medarbejdere hentes med gennemsnitstimer i en periode 1 år tilbage fra dagsdato
SET @cmd =	' SELECT					' +char(13)+
			' e.PK_DATE,				' +char(13)+
			' a.MEDARBEJDERID as MedID, ' +char(13)+
			' a.IKRAFTDATO,				' +char(13)+
			' a.SLUTDATO,				' +char(13)+
  			' a.VAGTER,					' +char(13)+
  		    ' c.UAFDELINGID,			' +char(13)+
  		    ' d.STATUSNAVN,				' +char(13)+
  		    ' b.STILLINGNAVN,			' +char(13)+
  		    ' b.STILLINGID,			' +char(13)+
  		    ' Convert(decimal(18,10),a.TIMER)/60/7 as GennemsnitTimer,' +char(13)+
  		    ' Convert(decimal(18,10),null)      as PlanlagtTimer,    ' +char(13)+
  		    ' Convert(decimal(18,10),null)      as FravaersTimer,      ' +char(13)+
  		    ' Convert(decimal(18,10),null)									  FravaersDage,      ' +char(13)+
  		   	' ''''									  Delvist_Syg,    ' +char(13)+
  		    ' Convert(decimal(18,10),null)           as SygdomsPeriod,    ' +char(13)+
  		    ' 999									  FravaerTypeID ,   ' +char(13)+
  		    ' 0									     TjenesteTyperID,    ' +char(13)+
  		    ' 0									     TjenesteGroupID    ' +char(13)+
  		    ' into Tmp_Vagtplan_FactTimerPlan_Step1 ' +char(13)+
  		    ' FROM	 '+@DestinationDB+'.DBO.DIM_TIME e ' +char(13)+
  		    ' left join MEDHISTORIK a	 ON PK_DATE >a.IKRAFTDATO AND PK_DATE <a.SLUTDATO ' +char(13)+
  		    ' LEFT JOIN STILLINGBET b ON b.STILLINGID  =a.STILLINGSID'			+char(13)+
  		    ' LEFT JOIN UAFDELINGER c ON c.UAFDELINGID =a.UAFDELINGID'			+char(13)+
  		    ' LEFT JOIN MEDSTATUS   d ON d.MEDSTATUSID =a.MEDARBEJDER_STATUSID' +char(13)+
  		    ' ' +char(13)+
  		    ' WHERE  YEAR(e.PK_DATE) >= 2007 ' +char(13)+
  		    ' and    PK_DATE < GETDATE() ' +char(13)
  		   -- ' and    d.STATUSNAVN=''Aktiv'' ' +char(13)
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step2'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step2'
exec (@cmd)
--der hentes vagter ud for alle medarbejdere i en periode 1 år tilbage fra dagsdato
--er der vagt over midnat markeres disse VAGT_OVER_MIDNAT=1
set @cmd = 'SELECT ' +char(13)+
           '  A.MEDARBEJDER, ' +char(13)+
           '  A.OMKOST_GRUPPE, ' +char(13)+
           '  COALESCE(A.OMKOST_GRUPPE,A.MEDARB_GRUPPE) AS MEDARB_GRUPPE, ' +char(13)+
           '  (SELECT DISTINCT STATUSNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STATUSNAVN, ' +char(13)+
  		   '  (SELECT DISTINCT STILLINGNAVN FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGNAVN, ' +char(13)+
  		   '  (SELECT DISTINCT STILLINGID FROM Tmp_Vagtplan_FactTimerPlan_Step1 B WHERE A.MEDARBEJDER=B.MEDID AND CAST(A.STARTTIDSPUNKT AS DATE)=B.PK_DATE) AS STILLINGID, ' +char(13)+
           '  A.STARTTIDSPUNKT, ' +char(13)+
           '  A.SLUT, ' +char(13)+
           '  A.TJENESTE, ' +char(13)+
           '  C.TJENESTETYPE, ' +char(13)+
           '  C.KMDID, ' +char(13)+
           '  CASE WHEN (DATEPART(DAYOFYEAR,DATEADD(mi,-1,A.SLUT))-DATEPART(DAYOFYEAR,A.STARTTIDSPUNKT))>0 THEN 1 ' +char(13)+ 
           '  ELSE 0 ' +char(13)+                  
           '  END AS VAGT_OVER_MIDNAT, ' +char(13)+
           '  C.PAA_ARBEJDE,  ' +char(13)+ 
           '  A.ANNULLERET  ' +char(13)+ 
           'INTO Tmp_Vagtplan_FactTimerPlan_Step2' +char(13)+
           'FROM VPL_TJENESTER A' +char(13)+
           'JOIN VPL_TJENESTETYPER C ON A.TJENESTE=C.ID ' +char(13)+
           'WHERE YEAR(A.STARTTIDSPUNKT)>=2007 AND ' +char(13)+
  		   '  A.STARTTIDSPUNKT<GETDATE()'+char(13)

if @debug = 1 print @cmd
exec (@cmd)

--vagter over midnat dubleres
set @cmd = 'INSERT INTO Tmp_Vagtplan_FactTimerPlan_Step2 ' +char(13)+
           'SELECT ' +char(13)+
           '  MEDARBEJDER, '  +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE,  ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  2 AS VAGT_OVER_MIDNAT, ' +char(13)+
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET  ' +char(13)+ 
           'FROM Tmp_Vagtplan_FactTimerPlan_Step2 ' +char(13)+
           'WHERE VAGT_OVER_MIDNAT=1' 
exec (@cmd)

-- vagter over midnat opdeles
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Step3'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Step3'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  CASE WHEN VAGT_OVER_MIDNAT=2 THEN CONVERT(DATETIME,SUBSTRING(CONVERT(CHAR,SLUT,120),1,10)+ '' 00:00:00'') ' +char(13)+ --vagt skal starte ved midnat ved vagt hen over midnat
           '  ELSE STARTTIDSPUNKT ' +char(13)+
           '  END AS STARTTIDSPUNKT, ' +char(13)+
           '  CASE WHEN VAGT_OVER_MIDNAT=1 THEN CONVERT(DATETIME,SUBSTRING(CONVERT(CHAR,SLUT,120),1,10)+ '' 00:00:00'')' +char(13)+ --vagt skal slutte ved midnat ved vagt hen over midnat
           '  ELSE SLUT ' +char(13)+
           '  END AS SLUT, ' +char(13)+ 
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET  ' +char(13)+ 
           'INTO Tmp_Vagtplan_FactTimerPlan_Step3' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step2 '

if @debug = 1 print @cmd
exec (@cmd)

-- på arbejde=1 - tjeneste opdeles i på arbejde almindelig tjeneste
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+           
           '  CASE WHEN OMKOST_GRUPPE IS NOT NULL THEN ' +char(13)+  
           '    COALESCE(CAST(DATEDIFF(MINUTE,STARTTIDSPUNKT,SLUT) AS NUMERIC(18,2)),0) ' +char(13)+
           '  ELSE NULL ' +char(13)+ 
           '  END AS OMFORDELTTID, ' +char(13)+ 
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+ 
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET  ' +char(13)+ 
           'INTO Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step3 '+char(13)+
           'WHERE PAA_ARBEJDE=1 AND ANNULLERET=0 AND KMDID IN (''NT'',''RB'',''RV'',''DB'',''DV'',''PP'',''VT'',''VU'',''FX'',''BV'')' 

if @debug = 1 print @cmd
exec (@cmd)

-- på arbejde=0 - tjeneste opdeles - afspadsering, fridage osv.
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+ 
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE, ' +char(13)+
           '  ANNULLERET  ' +char(13)+ 
           'INTO Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step3 '+char(13)+
           'WHERE PAA_ARBEJDE=0 AND ANNULLERET=0 ' 

if @debug = 1 print @cmd
exec (@cmd)

--fravaer hentes - sygdom, orlov, barsel osv.
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Fravaer'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Fravaer'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  VF.MEDARBEJDER, ' +char(13)+
           '  VF.MEDARB_GRUPPE, ' +char(13)+
           '  VF.DELVIST_SYG, ' +char(13)+
           '  VF.STARTTIDSPUNKT, ' +char(13)+
           '  VF.SLUT, ' +char(13)+         
           '  VF.FRAVAER, ' +char(13)+ 
           '  1 AS FRAVAERSDAGE , ' +char(13)+ 
  	       '  CASE WHEN (DATEDIFF(DD,VF.STARTTIDSPUNKT,VF.SLUT))-1 < 0 THEN NULL ' +char(13)+
  		   ' 	ELSE (DATEDIFF(DD,VF.STARTTIDSPUNKT,VF.SLUT))-1 ' +char(13)+
  		   '  END AS SYGDOMSPERIOD, ' +char(13)+  
           '  VFT.KMDID' +char(13)+
           '' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Fravaer' +char(13)+
           'FROM VPL_FRAVAER VF' +char(13)+
           'JOIN VPL_FRAVAERSTYPER VFT ON VF.FRAVAER=VFT.ID ' +char(13)+
           'WHERE VF.STARTTIDSPUNKT>=''2007-01-01'' AND ' +char(13)+
           '  VF.STARTTIDSPUNKT<GETDATE()'

if @debug = 1 print @cmd
exec (@cmd)

--først sammemlignes almindelig tjeneste med afspadsering, fridag osv, 
--hvor der er almindelig tjeneste og afspad., fridag i samme periode og IKKE sygdom 
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fridag'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fridag'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  NPA.MEDARBEJDER, ' +char(13)+
           '  NPA.OMKOST_GRUPPE, ' +char(13)+
           '  NPA.MEDARB_GRUPPE, ' +char(13)+
           '  NPA.STATUSNAVN,' +char(13)+
           '  NPA.STILLINGNAVN,' +char(13)+
           '  NPA.STILLINGID,' +char(13)+
           '  NPA.STARTTIDSPUNKT, ' +char(13)+
           '  NPA.SLUT, ' +char(13)+ 
           --hvis der ikke er sygdom, (FRA.STARTTIDSPUNKT IS NULL) 
           '  CASE WHEN FRA.STARTTIDSPUNKT IS NULL THEN'+char(13)+
           '    COALESCE(' +char(13)+ --fridag start,slut er større end arbejdstid start,slut så arbejdstid ellers fridag 
           '    CASE WHEN DATEDIFF(MI,IPA.STARTTIDSPUNKT,IPA.SLUT)>DATEDIFF(MI,NPA.STARTTIDSPUNKT,NPA.SLUT) THEN' +char(13)+
           '      DATEDIFF(MI,NPA.STARTTIDSPUNKT,NPA.SLUT)*-1' +char(13)+
           '    ELSE ' +char(13)+
           '      DATEDIFF(MI,IPA.STARTTIDSPUNKT,IPA.SLUT)*-1' +char(13)+
           '    END,0) ' +char(13)+
           '  ELSE 0' +char(13)+
           '  END AS VAGTMINUTTER,' +char(13)+
           --ikke sikker på om fravær af denne type er rigtig fravær og skal tælle med  
           '  CASE WHEN FRA.STARTTIDSPUNKT IS NULL THEN'+char(13)+
           '    COALESCE(' +char(13)+ --fridag start,slut er større end arbejdstid start,slut så arbejdstid ellers fridag 
           '    CASE WHEN DATEDIFF(MI,IPA.STARTTIDSPUNKT,IPA.SLUT)>DATEDIFF(MI,NPA.STARTTIDSPUNKT,NPA.SLUT) THEN' +char(13)+
           '      DATEDIFF(MI,NPA.STARTTIDSPUNKT,NPA.SLUT)' +char(13)+
           '    ELSE ' +char(13)+
           '      DATEDIFF(MI,IPA.STARTTIDSPUNKT,IPA.SLUT)' +char(13)+
           '    END,0) ' +char(13)+
           '  ELSE 0' +char(13)+
           '  END AS FRAVAERMINUTTER,' +char(13)+         
         --  '  0 AS FRAVAERMINUTTER, ' +char(13)+         
           '  IPA.TJENESTE, ' +char(13)+
           '  NPA.TJENESTETYPE, ' +char(13)+
           '  NPA.KMDID, ' +char(13)+
           '  NPA.VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  NPA.PAA_ARBEJDE ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fridag' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde NPA '+char(13)+
           'JOIN Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde IPA ON NPA.MEDARBEJDER=IPA.MEDARBEJDER AND '+char(13)+
           '  (NPA.STARTTIDSPUNKT<IPA.SLUT) AND (NPA.SLUT>IPA.STARTTIDSPUNKT)'+char(13)+
           'LEFT JOIN Tmp_Vagtplan_FactTimerPlan_Fravaer FRA ON NPA.MEDARBEJDER=FRA.MEDARBEJDER AND ' +char(13)+
           '  (NPA.STARTTIDSPUNKT<FRA.SLUT) AND (NPA.SLUT>FRA.STARTTIDSPUNKT)' +char(13)
if @debug = 1 print @cmd
exec (@cmd)

--næst, der er IKKE almindelig tjeneste, men afspad. eller anden fridag   
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde_Minus_Fridag'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde_Minus_Fridag'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+ 
           '  0 AS VAGTMINUTTER, ' +char(13)+
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde_Minus_Fridag' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde' +char(13)+
           'WHERE NOT EXISTS(SELECT * FROM Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fridag A' +char(13)+
           '                 WHERE A.MEDARBEJDER=Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde.MEDARBEJDER AND' +char(13)+
           '                      (A.STARTTIDSPUNKT<Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde.SLUT) AND' +char(13)+
           '                      (A.SLUT>Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde.STARTTIDSPUNKT))' +char(13)
           
if @debug = 1 print @cmd
exec (@cmd)

-- på arbejde=1 - tjeneste opdeles i på arbejde EKSTRA tjeneste
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Ekstra_Paa_Arbejde'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Ekstra_Paa_Arbejde'
exec (@cmd)

set @cmd = 'SELECT ' +char(13)+
           '  MEDARBEJDER, ' +char(13)+
           '  OMKOST_GRUPPE, ' +char(13)+
           '  MEDARB_GRUPPE, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  STARTTIDSPUNKT, ' +char(13)+
           '  SLUT, ' +char(13)+ 
           '  DATEDIFF(MI,STARTTIDSPUNKT,SLUT) AS VAGTMINUTTER,' +char(13)+
           '  TJENESTE, ' +char(13)+
           '  TJENESTETYPE, ' +char(13)+
           '  KMDID, ' +char(13)+
           '  VAGT_OVER_MIDNAT, ' +char(13)+ 
           '  PAA_ARBEJDE ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Ekstra_Paa_Arbejde' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step3 '+char(13)+
           'WHERE PAA_ARBEJDE=1 AND KMDID IN (''OA'',''OP'',''TK'',''EX'',''ET'',''OF'',''OM'',''PO'',''TO'',''MV'')' 

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Samlet_Tid1'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Samlet_Tid1'
exec (@cmd)
--samler delresultater for almindelig tjeneste, afspad., fridage på dage med almindelig tjeneste og fridage eks AD (KMDID) hvor der IKKE er almindelig tjeneste  
set @cmd = 'SELECT '  +char(13)+
           '  STARTTIDSPUNKT AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID,' +char(13)+
           '  STARTTIDSPUNKT AS IKRAFTDATO, ' +char(13)+
           '  SLUT AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  NULL AS GENNEMSNITTIMER, ' +char(13)+
           '  DATEDIFF(MI,STARTTIDSPUNKT,SLUT) AS PLANLAGTTIMER, ' +char(13)+
           '  OMFORDELTTID, ' +char(13)+
           '  NULL AS FRAVAERSTIMER, ' +char(13)+
           '  NULL AS FRAVAERSDAGE, ' +char(13)+
           '  NULL AS DELVIST_SYG, ' +char(13)+
           '  NULL AS SYGDOMSPERIOD, ' +char(13)+
           '  NULL AS FRAVAERTYPEID, ' +char(13)+
           '  TJENESTE AS TJENESTETYPERID, ' +char(13)+
           '  TJENESTETYPE AS TJENESTEGROUPID, ' +char(13)+
           '  KMDID ' +char(13)+
           'INTO Tmp_Vagtplan_FactTimerPlan_Samlet_Tid1  ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde ' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+
           '  STARTTIDSPUNKT AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID,' +char(13)+
           '  STARTTIDSPUNKT AS IKRAFTDATO, ' +char(13)+
           '  SLUT AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  NULL AS GENNEMSNITTIMER, ' +char(13)+
           '  VAGTMINUTTER AS PLANLAGTTIMER, ' +char(13)+
           '  NULL AS OMFORDELTTID, ' +char(13)+
           '  FRAVAERMINUTTER AS FRAVAERSTIMER, ' +char(13)+
           '  NULL AS FRAVAERSDAGE, ' +char(13)+
           '  NULL AS DELVIST_SYG, ' +char(13)+
           '  NULL AS SYGDOMSPERIOD, ' +char(13)+
           '  NULL AS FRAVAERTYPEID, ' +char(13)+
           '  TJENESTE AS TJENESTETYPERID, ' +char(13)+
           '  TJENESTETYPE AS TJENESTEGROUPID, ' +char(13)+
           '  KMDID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fridag '+char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+
           '  STARTTIDSPUNKT AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID,' +char(13)+
           '  STARTTIDSPUNKT AS IKRAFTDATO, ' +char(13)+
           '  SLUT AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  NULL AS GENNEMSNITTIMER, ' +char(13)+
           '  VAGTMINUTTER AS PLANLAGTTIMER, ' +char(13)+
           '  NULL AS OMFORDELTTID, ' +char(13)+
           '  NULL AS FRAVAERSTIMER, ' +char(13)+
           '  NULL AS FRAVAERSDAGE, ' +char(13)+
           '  NULL AS DELVIST_SYG, ' +char(13)+
           '  NULL AS SYGDOMSPERIOD, ' +char(13)+
           '  NULL AS FRAVAERTYPEID, ' +char(13)+
           '  TJENESTE AS TJENESTETYPERID, ' +char(13)+
           '  TJENESTETYPE AS TJENESTEGROUPID, ' +char(13)+
           '  KMDID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Ikke_Paa_Arbejde_Minus_Fridag ' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+
           '  STARTTIDSPUNKT AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID,' +char(13)+
           '  STARTTIDSPUNKT AS IKRAFTDATO, ' +char(13)+
           '  SLUT AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  NULL AS GENNEMSNITTIMER, ' +char(13)+
           '  VAGTMINUTTER AS PLANLAGTTIMER, ' +char(13)+
           '  NULL AS OMFORDELTTID, ' +char(13)+
           '  NULL AS FRAVAERSTIMER, ' +char(13)+
           '  NULL AS FRAVAERSDAGE, ' +char(13)+
           '  NULL AS DELVIST_SYG, ' +char(13)+
           '  NULL AS SYGDOMSPERIOD, ' +char(13)+
           '  NULL AS FRAVAERTYPEID, ' +char(13)+
           '  TJENESTE AS TJENESTETYPERID, ' +char(13)+
           '  TJENESTETYPE AS TJENESTEGROUPID, ' +char(13)+
           '  KMDID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Ekstra_Paa_Arbejde '           

if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Samlet_Tid2'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Samlet_Tid2'
exec (@cmd)

--fravær sammenlignes med samlede foreløbig vagttid og laves negativ
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fravaer'' AND type = ''U'') DROP TABLE Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fravaer'
exec (@cmd)

set @cmd = 'SELECT DISTINCT ' +char(13)+
           '  ST.PK_DATE, ' +char(13)+
           '  FRA.MEDARBEJDER, ' +char(13)+
           '  NULL AS OMKOST_GRUPPE, ' +char(13)+
           '  FRA.MEDARB_GRUPPE, ' +char(13)+
           '  FRA.DELVIST_SYG, ' +char(13)+
           '  FRA.FRAVAERSDAGE, '+char(13)+
           '  FRA.SYGDOMSPERIOD, '+char(13)+
           '  ST.STATUSNAVN,' +char(13)+
           '  ST.STILLINGNAVN,' +char(13)+
           '  ST.STILLINGID,' +char(13)+
           '  FRA.STARTTIDSPUNKT, ' +char(13)+
           '  FRA.SLUT, ' +char(13)+ 
           '  CASE WHEN ST.KMDID IN (''NT'',''RB'',''RV'',''DB'',''DV'',''PP'',''VT'',''VU'',''FX'',''BV'',''OA'',''OP'',''TK'',''EX'',''ET'',''OF'',''OM'',''PO'',''TO'',''MV'') THEN '  +char(13)+
           '    COALESCE(' +char(13)+ 
           '    CASE WHEN DATEDIFF(HH,FRA.STARTTIDSPUNKT,FRA.SLUT)>DATEDIFF(HH,ST.IKRAFTDATO,ST.SLUTDATO) THEN' +char(13)+
           '      DATEDIFF(MI,ST.IKRAFTDATO,ST.SLUTDATO)*-1' +char(13)+
           '    ELSE ' +char(13)+
           '      DATEDIFF(MI,FRA.STARTTIDSPUNKT,FRA.SLUT)*-1' +char(13)+
           '    END,0) ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS VAGTMINUTTER, ' +char(13)+
           '  CASE WHEN ST.KMDID IN (''NT'',''RB'',''RV'',''DB'',''DV'',''PP'',''VT'',''VU'',''FX'',''BV'',''OA'',''OP'',''TK'',''EX'',''ET'',''OF'',''OM'',''PO'',''TO'',''MV'') THEN '  +char(13)+           
           '    COALESCE(' +char(13)+ 
           '    CASE WHEN DATEDIFF(HH,FRA.STARTTIDSPUNKT,FRA.SLUT)>DATEDIFF(HH,ST.IKRAFTDATO,ST.SLUTDATO) THEN' +char(13)+
           '      DATEDIFF(MI,ST.IKRAFTDATO,ST.SLUTDATO)' +char(13)+
           '    ELSE ' +char(13)+
           '      DATEDIFF(MI,FRA.STARTTIDSPUNKT,FRA.SLUT)' +char(13)+
           '    END,0) ' +char(13)+
           '  ELSE 0 ' +char(13)+
           '  END AS FRAVAERMINUTTER, ' +char(13)+
           '  FRA.FRAVAER AS FRAVAERTYPEID, ' +char(13)+ --SKAL MED
           '  FRA.KMDID ' +char(13)+  
           'INTO Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fravaer' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Fravaer FRA '+char(13)+
           'JOIN Tmp_Vagtplan_FactTimerPlan_Samlet_Tid1 ST ON FRA.MEDARBEJDER=ST.MEDID AND '+char(13)+
           '  (FRA.STARTTIDSPUNKT<ST.SLUTDATO) AND (FRA.SLUT>ST.IKRAFTDATO)'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)


--delresultater samles til temp Fact
set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''FactTimerPlan_1'' AND type = ''U'') DROP TABLE DBO.FactTimerPlan_1'
exec (@cmd)

set @cmd = 'SELECT '  +char(13)+ --almindelig tjeneste fratrukket afspadsering, firdage osv.
           '  CAST(PK_DATE AS date) AS PK_DATE, ' +char(13)+
           '  MEDID,' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  CAST(NULL AS NUMERIC(18,2))/60 AS GENNEMSNITTIMER, ' +char(13)+
           '  CAST(PLANLAGTTIMER AS NUMERIC(18,2))/60 AS PLANLAGTTIMER, ' +char(13)+
           '  CAST(OMFORDELTTID  AS NUMERIC(18,2))/60 AS OMFORDELTTID, ' +char(13)+
           '  CAST(FRAVAERSTIMER AS NUMERIC(18,2))/60 AS FRAVAERSTIMER, ' +char(13)+
           '  NULL AS FRAVAERSDAGE, ' +char(13)+
           '  NULL AS DELVIST_SYG, ' +char(13)+
           '  NULL AS SYGDOMSPERIOD, ' +char(13)+
           '  NULL AS FRAVAERTYPEID, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID ' +char(13)+
           'INTO FactTimerPlan_1  ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Samlet_Tid1 ' +char(13)+
           'UNION ALL ' +char(13)+
           'SELECT '  +char(13)+  --ovenstående fratrukket fravær eks. sygdom, kursus
           '  CAST(PK_DATE AS date) AS PK_DATE, ' +char(13)+
           '  MEDARBEJDER AS MEDID,' +char(13)+
           '  STARTTIDSPUNKT AS IKRAFTDATO, ' +char(13)+
           '  SLUT AS SLUTDATO, ' +char(13)+
           '  NULL AS VAGTER, ' +char(13)+
           '  MEDARB_GRUPPE AS UAFDELINGID, ' +char(13)+
           '  STATUSNAVN,' +char(13)+
           '  STILLINGNAVN,' +char(13)+
           '  STILLINGID,' +char(13)+
           '  CAST(NULL AS NUMERIC(18,2))/60 AS GENNEMSNITTIMER, ' +char(13)+
           '  CAST(VAGTMINUTTER AS NUMERIC(18,2))/60 AS PLANLAGTTIMER, ' +char(13)+
           '  CAST(NULL AS NUMERIC(18,2))/60 AS OMFORDELTTID, ' +char(13)+
           '  CAST(FRAVAERMINUTTER AS NUMERIC(18,2))/60 AS FRAVAERSTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  NULL AS TJENESTETYPERID, ' +char(13)+
           '  NULL AS TJENESTEGROUPID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Normalt_Paa_Arbejde_Minus_Fravaer '+char(13)+           
           'UNION ALL ' +char(13)+ 
           'SELECT '  +char(13)+
           '  PK_DATE, ' +char(13)+
           '  MEDID,' +char(13)+
           '  IKRAFTDATO, ' +char(13)+
           '  SLUTDATO, ' +char(13)+
           '  VAGTER, ' +char(13)+
           '  UAFDELINGID, ' +char(13)+
           '  STATUSNAVN, ' +char(13)+
           '  STILLINGNAVN, ' +char(13)+
           '  STILLINGID, ' +char(13)+
           '  CAST(GENNEMSNITTIMER AS NUMERIC(18,2))/60 AS GENNEMSNITTIMER, ' +char(13)+
           '  CAST(PLANLAGTTIMER AS NUMERIC(18,2))/60 AS PLANLAGTTIMER, ' +char(13)+
           '  CAST(NULL AS NUMERIC(18,2))/60 AS OMFORDELTTID, ' +char(13)+
           '  CAST(FRAVAERSTIMER AS NUMERIC(18,2))/60 AS FRAVAERSTIMER, ' +char(13)+
           '  FRAVAERSDAGE, ' +char(13)+
           '  DELVIST_SYG, ' +char(13)+
           '  SYGDOMSPERIOD, ' +char(13)+
           '  FRAVAERTYPEID, ' +char(13)+
           '  TJENESTETYPERID, ' +char(13)+
           '  TJENESTEGROUPID ' +char(13)+
           'FROM Tmp_Vagtplan_FactTimerPlan_Step1 ' +char(13)
           
           
if @debug = 1 print @cmd
exec (@cmd)
  
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''FactTimerPlan'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.DBO.FactTimerPlan'
exec (@cmd) 

--facts overføres til DW hvis medarbejder stadig findes i system

set @cmd = 'SELECT '+char(13)+ 
           '  A.*'+char(13)+ 
           'INTO '+@DestinationDB+'.DBO.FactTimerPlan'+char(13)+ 
           'FROM FactTimerPlan_1 A'+char(13)+ 
           'WHERE EXISTS(SELECT MEDARBEJDERID FROM MEDHISTORIK WHERE MEDHISTORIK.MEDARBEJDERID=A.MEDID)'+char(13)
           
if @debug = 1 print @cmd
exec (@cmd)  

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=62)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (62,GETDATE())           
end