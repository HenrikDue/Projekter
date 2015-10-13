USE AvaleoAnalytics_Sta


INSERT INTO [dbo].[FireBirdDBDataDefinition] (TableName,ColName,ColType,ColNull,Sortorder) VALUES ('HJPLEVERANDOR','CVRNR','INTEGER','Null',17)

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_Sta.dbo.VERSION WHERE VERSION=65)
if @version is null
begin
INSERT INTO AvaleoAnalytics_Sta.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (65,GETDATE())           
end