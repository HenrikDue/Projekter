/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *-- distinct TableName 
FROM [AvaleoAnalytics_Staging_Clean].[dbo].[FireBirdDBDataDefinition]
where ColType='ntext'
delete
  FROM [AvaleoAnalytics_Staging_Clean].[dbo].[FireBirdDBDataDefinition]
  where ColType='ntext'
  where TableName not in (
  
  
  'ADRESSER',
'AFDELINGER',
'BESOGSTATUS',
'DOGN_INDDELING',
'HJPLEVERANDOR',
'HJVISIJOB',
'HJVISITATION',
'JOBTYPER',
'MADVISIJOB',
'MADVISITATION',
'MEDARBEJDERE',
'MEDHISTORIK',
'MEDSTATUS',
'ORGANISATIONER',
'PARAGRAF_GRUPPERING',
'PARATYPER',
'REFUSIONSKOMMUNE',
'SAGER',
'SAGSHISTORIK',
'SAGSPDET',
'SAGSPLAN',
'SAGSPLANRET',
'SAGSPRETDET',
'SAGSSTATUS',
'SPVISIJOB',
'SPVISITATION',
'STILLINGBET',
'TPVISIJOB',
'TPVISITATION',
'UAFDELINGER',
'VPL_FRAVAER',
'VPL_FRAVAERSTYPER')
