USE AvaleoAnalytics_Staging_Clean

SELECT *
  FROM [dbo].[FireBirdDBDataDefinition]
  where tablename='vpl_fravaer'
  
  
 update [dbo].[FireBirdDBDataDefinition]
 set ColType='Datetime' where TableName='vpl_fravaer' and ColName='starttidspunkt'
 update [FireBirdDBDataDefinition]
 set ColType='Datetime' where TableName='vpl_fravaer' and ColName='slut'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('PARATYPER','PARAGRAF_GRUPPERING_ID','INTEGER','Null',6)