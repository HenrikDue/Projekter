use AvaleoAnalytics_Sta
/*opdater kopi db*/
use AvaleoAnalytics_STA_Blank

delete from FireBirdDBDataDefinition where TableName='FAGLIGVURDERINGHIST' or TableName='VURDERINGSNIV' or TableName='FAGLIGVURDERING' or 
    (TableName='HJVISITATION' and ColName='GS_SAG_ID') or TableName='GS_SAGER' 

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('VURDERINGSNIV','ID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('VURDERINGSNIV','NIVEAUNAVN','nvarchar (50)','Not null',2)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('VURDERINGSNIV','NIVEAU','Integer','Null',3)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('VURDERINGSNIV','FALLES_SPROG_ART','Integer','Null',4)


insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','ID','Integer','Not null',1)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','AKTIVITET_ID','Integer','Not null',5)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','BRUGER_ID','Integer','Not null',6)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','RELEVANT','Integer','Not null',7)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','VURDNIV_ID','Integer','Not null',8)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','VISI_TYPE','Integer','Null',9)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('FAGLIGVURDERING','VISI_ID','Integer','Null',10)

insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('HJVISITATION','GS_SAG_ID','Integer','Null',10)


insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('GS_SAGER','SAG_ID','Integer','Null',9)
insert into FireBirdDBDataDefinition (TableName,ColName,ColType,ColNull,Sortorder) values ('GS_SAGER','SAMLET_FUNKTIONSNIVEAU_ID','Integer','Null',10)




--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=21)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (21,GETDATE())           
--end