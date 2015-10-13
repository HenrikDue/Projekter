USE [PGEDW_AVA]
GO

/****** Object:  View [dbo].[vFactGrundplan]    Script Date: 10/25/2010 14:48:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





--Afgang alle der har afgang < 2008-12-31 skal der ses bort fra

ALTER  VIEW [dbo].[vFactGrundplan]
AS
SELECT      A.sagspID, --Tilgang (dropper innerjoinet på den første, laver case så hvis før 2009-01-01 så 2009-01-01)
			A.SagspdetID, 
			A.SAGSID, 
			A.MEDID,  
            A.doegninddeling,
            A.STARTMINEFTERMIDNAT, 
            A.jobid, 
            CASE A.STILLINGSID WHEN NULL THEN '9999' ELSE A.STILLINGSID END AS STILLINGSID, 
            A.medarb_org, 
            A.VISITYPE, 
            A.VISIID, 
            CASE A.MEDARBEJDERID WHEN NULL THEN '9999' ELSE A.MEDARBEJDERID END AS MEDARBEJDERID, 
            CASE A.MEDARBEJDER_STATUS WHEN NULL THEN '9999' ELSE A.MEDARBEJDER_STATUS END AS MEDARBEJDER_STATUS, 
            CASE A.MEDARBEJDER_STATUSID WHEN NULL THEN '9999' ELSE A.MEDARBEJDER_STATUSID END AS MEDARBEJDER_STATUSID, 
            A.frekvens, 
            A.FREKTYPE, 
            A.frekvalgtedage, 
            A.Planlagt_uge, 
            A.borgerorg, 
            A.start, 
            A.slut, 
            A.date, 
            2 AS specifikation, 
            pgsta.dbo.Dim_Time.PK_Date
FROM         dbo.FactSagsplan A INNER JOIN
                      pgsta.dbo.Dim_Time ON A.start = pgsta.dbo.Dim_Time.PK_Date AND 
                      A.slut >= pgsta.dbo.Dim_Time.PK_Date
WHERE     (A.specifikation = 2)
UNION ALL
SELECT     B.sagspID, --Afgang
		   B.SagspdetID, 
		   B.SAGSID, 
		   B.MEDID, 
		   B.doegninddeling, 
		   B.STARTMINEFTERMIDNAT,
           B.jobid, 
           CASE B.STILLINGSID WHEN NULL THEN '9999' ELSE B.STILLINGSID END AS Expr2, 
           B.medarb_org, 
           B.VISITYPE, 
           B.VISIID, 
           CASE B.MEDARBEJDERID WHEN NULL THEN '9999' ELSE B.MEDARBEJDERID END AS Expr3, 
           CASE B.MEDARBEJDER_STATUS WHEN NULL THEN '9999' ELSE B.MEDARBEJDER_STATUS END AS Expr4, 
           CASE B.MEDARBEJDER_STATUSID WHEN NULL THEN '9999' ELSE B.MEDARBEJDER_STATUSID END AS Expr5, 
           B.frekvens, 
           B.FREKTYPE, 
           B.frekvalgtedage, 
           B.Planlagt_uge * - 1 AS Expr1, 
           B.borgerorg, 
           B.start, 
           B.slut, 
           B.date, 
           3 AS specifikation, 
           Dim_Time_2.PK_Date
FROM         dbo.FactSagsplan AS B INNER JOIN
                      pgsta.dbo.Dim_Time AS Dim_Time_2 ON B.slut = Dim_Time_2.PK_Date AND 
                      B.slut >= Dim_Time_2.PK_Date
WHERE     (B.specifikation = 2)
UNION ALL
SELECT      C.sagspID, --Udfylder alt hvad der er indimellem start og slut. Hver mandag som ligger mellem 2 tidspunkter er primo lig med planlagte uge
			C.SagspdetID, 
			C.SAGSID, 
			C.MEDID, 
			C.doegninddeling, 
			C.STARTMINEFTERMIDNAT,
            C.jobid, 
            CASE C.STILLINGSID WHEN NULL THEN '9999' ELSE C.STILLINGSID END AS Expr2, 
            C.medarb_org, 
            C.VISITYPE, 
            C.VISIID, 
            CASE C.MEDARBEJDERID WHEN NULL THEN '9999' ELSE C.MEDARBEJDERID END AS Expr3, 
            CASE C.MEDARBEJDER_STATUS WHEN NULL THEN '9999' ELSE C.MEDARBEJDER_STATUS END AS Expr4, 
            CASE C.MEDARBEJDER_STATUSID WHEN NULL THEN '9999' ELSE C.MEDARBEJDER_STATUSID END AS Expr5, 
            C.frekvens, 
            C.FREKTYPE, 
            C.frekvalgtedage, 
            C.Planlagt_uge, 
            C.borgerorg, 
            C.start, 
            C.slut, 
            C.date, 
            1 AS specifikation, 
            Dim_Time_1.PK_Date
FROM         dbo.FactSagsplan AS C INNER JOIN
                      pgsta.dbo.Dim_Time AS Dim_Time_1 ON C.start < Dim_Time_1.PK_Date AND 
                      C.slut >= Dim_Time_1.PK_Date
WHERE     (C.specifikation = 2) AND (Dim_Time_1.Day_Of_Week = 1) --Lægger ind hver mandag det som er planlagt primo. 





GO


