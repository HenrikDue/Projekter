USE AvaleoAnalytics_Sta

SELECT *
  FROM [dbo].[FireBirdDBDataDefinition]
  where tablename='BOLIG_TILBUD'
  
 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIGVISITATION'  
 /*
 ID
SAGSID
VISIDATO
IKRAFTDATO
SLUTDATO
NAESTEVIS
INDFLYTNING
BOLIGERANVIST
DRIFTFORM
PLADSTYPE
RESUME
BOLIG_ONSKE1
BOLIG_ONSKE2
BOLIG_ONSKE3
BOLIG_ONSKE4
REVISITERET
PRIORITET
SAMBOENDE
BOLIG_ANSOG
FRITVALGSVENTELISTE
REVISITATIONSDATO
GS_SAG_ID
FRITVALGSVENTELISTE_DATO
BOLIG_ONSKE5
BOLIG_ONSKE6
BOLIG_ONSKE7
BOLIG_ONSKE8
*/
  
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','ID','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','SAGSID','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','VISIDATO','Datetime','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','IKRAFTDATO','Date','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','SLUTDATO','Date','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','INDFLYTNING','Date','Null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','BOLIGERANVIST','INTEGER','Null',0)  
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','DRIFTFORM','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','PLADSTYPE','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','BOLIG_ANSOG','Date','Null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','FRITVALGSVENTELISTE','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','FRITVALGSVENTELISTE_DATO','Date','Null',0)
--INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','INDFLYTNING','nvarchar(40)','Not null',0)
--INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGVISITATION','BOLIGERANVIST','INTEGER','Not null',0)  

/*
ID
BOLIGID
BORGERID
TILBUD_DATO
UDLOB_DATO
AFVIST_DATO
FRA_GARANTI_LISTE
BOLIGVISI_ID
*/
 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIG_TILBUD'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','ID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','BOLIGID','INTEGER','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','BORGERID','INTEGER','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','TILBUD_DATO','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','UDLOB_DATO','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','AFVIST_DATO','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','FRA_GARANTI_LISTE','INTEGER','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_TILBUD','BOLIGVISI_ID','INTEGER','Null',0)
  

 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIGER'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','ID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','DRIFTFORM','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','PLADSTYPE','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','UDLEJETDATO','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','HJEMSTED','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','KENDENAVN','nvarchar(40)','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','ADRESSE','nvarchar(40)','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','STATUS','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','BOLIGGRP','INTEGER','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','TILDELTPR','Date','Null',0) 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGER','LEDIGPR','Date','Null',0) 
 
 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIG_DFPT'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_DFPT','ID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_DFPT','KODE','nvarchar(20)','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIG_DFPT','DF_PT','INTEGER','Not null',0)

 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIGGRUPPER'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGGRUPPER','GRUPPEID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGGRUPPER','BOLIGGRUPPE','nvarchar(50)','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGGRUPPER','SKJULT','INTEGER','Not null',0)
 
 DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='BOLIGSAGHIST'
 
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','ID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','BOLIGID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','SAGSID','INTEGER','Not null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','INDFLYTNING','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','FRAFLYTNING','Date','Null',0)
 INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('BOLIGSAGHIST','KLAR_DATO','Date','Null',0)
