/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 
CASE DATEPART(mm,PK_Date)
  WHEN 1 then 'Januar, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 2 then 'Februar, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 3 then 'Marts, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 4 then 'April, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 5 then 'Maj, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 6 then 'Juni, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 7 then 'Juli, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 8 then 'August, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 9 then 'September, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 10 then 'Oktober, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 11 then 'November, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
  WHEN 12 then 'December, '+CAST(DATEPART(YYYY,PK_Date) as varchar(4))
END as Maaned_Navn,*
  FROM [AvaleoAnalytics_DW].[dbo].[DimTimeExtended]