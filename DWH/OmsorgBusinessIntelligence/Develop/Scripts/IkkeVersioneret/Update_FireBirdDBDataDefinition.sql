/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [AvaleoAnalytics_Staging_Clean].[dbo].[FireBirdDBDataDefinition]
  where tablename='vpl_fravaer'
  
  
 update [AvaleoAnalytics_Staging_Clean].[dbo].[FireBirdDBDataDefinition]
 set ColType='Datetime' where TableName='vpl_fravaer' and ColName='starttidspunkt'
 update [AvaleoAnalytics_Staging_Clean].[dbo].[FireBirdDBDataDefinition]
 set ColType='Datetime' where TableName='vpl_fravaer' and ColName='slut'