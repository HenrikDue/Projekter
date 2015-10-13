use AvaleoAnalytics_STAa

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'DimWeekendHelligdag' AND type = 'U') DROP TABLE DimWeekendHelligdag

SELECT PK_Date,DBO.Udf_Helligdag(PK_DATE) as helligdag, CASE WHEN datepart(dw, PK_DATE) in (1,7) then 1 else 0 end as weekend,
CASE WHEN MONTH(PK_DATE) IN (1, 3, 5, 7, 8, 10, 12) THEN 31
            WHEN MONTH(PK_DATE) IN (4, 6, 9, 11) THEN 30
            ELSE DATEDIFF(dd, CAST(YEAR(PK_DATE) AS varchar(4)) + '-02-01', CAST(YEAR(PK_DATE) AS varchar(4)) + '-03-01')
       END AS DAYSINMONTH

into DimWeekendHelligdag
 FROM [AvaleoAnalytics_Sta].[dbo].[Dim_Time_Special]
 
declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=50)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (50,GETDATE())           
end 
