use AvaleoAnalytics_Staa
/*opdater kopi db*/
--use AvaleoAnalytics_STA_Blank

delete from FireBirdDBDataDefinition where TableName='BRUGER'  

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','BRUGERID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','MEDARBEJDER','Integer','Null',2)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','UAFDELINGID','Integer','Null',3)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','BRUGERNAVN','nvarchar (50)','Not null',5)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','ADBRUGERNAVN','nvarchar (255)','Null',6)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','KONTI_DISABLED','Integer','Null',7)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','FORNAVN','nvarchar (50)','Null',8)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','EFTERNAVN','nvarchar (50)','Null',9)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','KONTI_DISABLED_AARSAG','Integer','Not null',10)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','LASTPWCHANGE','datetime2','Null',11) 
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER','SYSTEMBRUGER','Integer','Null',12) 

delete from FireBirdDBDataDefinition where TableName='BRUGER_PASSW_HIST'  

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER_PASSW_HIST','BRUGERID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGER_PASSW_HIST','OPRETTET','datetime2','Not null',2)

delete from FireBirdDBDataDefinition where TableName='BRUGERPROFILREL'

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGERPROFILREL','PROFILID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGERPROFILREL','BRUGERID','Integer','Not null',2)

delete from FireBirdDBDataDefinition where TableName='BRUGERPROFIL'

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGERPROFIL','ID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('BRUGERPROFIL','NAVN','nvarchar (20)','Not null',1)



--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_Sta.dbo.VERSION WHERE VERSION=38)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_Sta.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (38,GETDATE())           
--end

--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA_Blank.dbo.VERSION WHERE VERSION=38)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA_Blank.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (38,GETDATE())           
--end