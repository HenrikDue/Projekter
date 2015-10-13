use AvaleoAnalytics_STAa

update [AvaleoAnalytics_DW].[dbo].DimTimeExtended 
  set Week_Of_Year=dbo.udf_GetISOWeekNumberFromDate(pk_date), Week_Of_Year_Name='Uge '+cast(dbo.udf_GetISOWeekNumberFromDate(pk_date) as varchar(5))  
  
  update [AvaleoAnalytics_DW].[dbo].[DimTimeExtended] set Week_Name='Uge 1,'+cast(DATEPART(yy,pk_date)+1 as varchar(4))
  where week_of_year=1 and DATEPART(mm,pk_date)=12
  
    update [AvaleoAnalytics_DW].[dbo].[DimTimeExtended] set Week_Name='Uge 52,'+cast(DATEPART(yy,pk_date)-1 as varchar(4))
   where week_of_year=52 and DATEPART(mm,pk_date)=1
   
    update [AvaleoAnalytics_DW].[dbo].[DimTimeExtended] set Week_Name='Uge 53,'+cast(DATEPART(yy,pk_date)-1 as varchar(4))
   where week_of_year=53 and DATEPART(mm,pk_date)=1   
   
  --select DATEPART(yy,pk_date)+1 as aar, day_of_week, cast(PK_Date as date) pk_date,cast([Week] as DATE) [week], Week_Name,Week_Of_Year,Week_Of_Year_Name,[Year] from [AvaleoAnalytics_DW].[dbo].[DimTimeExtended]
  --where week_of_year=1 and DATEPART(mm,pk_date)=12   /*Week_Name like '%uge 52,2010%' */ --(Week_Of_Year=1 or Week_Of_Year=53 or Week_Of_Year=52) and PK_Date>'2009-01-01'
  --order by PK_Date
  --select DATEPART(yy,pk_date)-1 as aar, day_of_week, cast(PK_Date as date) pk_date,cast([Week] as DATE) [week], Week_Name,Week_Of_Year,Week_Of_Year_Name,[Year] from [AvaleoAnalytics_DW].[dbo].[DimTimeExtended]
  --where week_of_year=52 and DATEPART(mm,pk_date)=1   /*Week_Name like '%uge 52,2010%' */ --(Week_Of_Year=1 or Week_Of_Year=53 or Week_Of_Year=52) and PK_Date>'2009-01-01'
  --order by PK_Date
  --select DATEPART(yy,pk_date)-1 as aar, day_of_week, cast(PK_Date as date) pk_date,cast([Week] as DATE) [week], Week_Name,Week_Of_Year,Week_Of_Year_Name,[Year] from [AvaleoAnalytics_DW].[dbo].[DimTimeExtended]
  --where week_of_year=53 and DATEPART(mm,pk_date)=1   /*Week_Name like '%uge 52,2010%' */ --(Week_Of_Year=1 or Week_Of_Year=53 or Week_Of_Year=52) and PK_Date>'2009-01-01'
  --order by PK_Date       
 
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=47)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (47,GETDATE())           
--end