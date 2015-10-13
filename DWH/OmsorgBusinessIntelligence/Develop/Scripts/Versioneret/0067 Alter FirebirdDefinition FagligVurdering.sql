USE AvaleoAnalytics_Staa

DELETE FROM [dbo].[FireBirdDBDataDefinition] where TableName='AKTIVITETER'  
 /*
ID
AKTIVITET
BESKRIVELSE
STATUS
GOD_SAGSBEHANDLING
HV_LIV_AKTIVITET_ID
FALLES_SPROG_ART
AKTIVNIVEAU1
AKTIVNIVEAU2
*/
  
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('AKTIVITETER','ID','INTEGER','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('AKTIVITETER','AKTIVITET','varchar(50)','Not null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('AKTIVITETER','AKTIVNIVEAU1','integer','Null',0)
INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('AKTIVITETER','FALLES_SPROG_ART','integer','Null',0)


declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_Sta.dbo.VERSION WHERE VERSION=67)
if @version is null
begin
INSERT INTO AvaleoAnalytics_Staa.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (67,GETDATE())           
end