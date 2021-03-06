/****** Script for SelectTopNRows command from SSMS  ******/
IF EXISTS(SELECT name FROM [AdHoc].DBO.sysobjects WHERE name =  'tmp_start' AND type = 'U') DROP TABLE [AdHoc].DBO.tmp_start
SELECT distinct A.[Opgave]

      ,A.[Tid] as start
      ,A.[Handling]
      ,LTRIM(rtrim(SUBSTRING(A.handling,(charindex('->',A.HANDLING)+3),(LEN(A.handling))))) as Startansvarlig
      ,LTRIM(rtrim(SUBSTRING(A.handling,(charindex('Ansvarlig:',A.HANDLING)+11),(charindex('->',A.HANDLING))-(charindex('Ansvarlig:',A.HANDLING)+11)  ))) as Slutansvarlig
  into [AdHoc].[dbo].tmp_start
  FROM [AdHoc].[dbo].[OpgaveHistorik] A
  join [AdHoc].[dbo].[OpgaveHistorik] B on a.Opgave=b.Opgave
  where /*A.opgave=6039 and*/ A.HANDLING like 'Ansvarlig:%->%'
  order by A.opgave
  
IF EXISTS(SELECT name FROM [AdHoc].DBO.sysobjects WHERE name =  'tmp_slut' AND type = 'U') DROP TABLE [AdHoc].DBO.tmp_slut
SELECT distinct A.[Opgave]

      ,A.[Tid] as start
      ,A.[Handling]
      ,LTRIM(rtrim(SUBSTRING(A.handling,(charindex('->',A.HANDLING)+3),(LEN(A.handling))))) as Startansvarlig
      ,LTRIM(rtrim(SUBSTRING(A.handling,(charindex('Ansvarlig:',A.HANDLING)+11),(charindex('->',A.HANDLING))-(charindex('Ansvarlig:',A.HANDLING)+11)  ))) as Slutansvarlig
  into [AdHoc].[dbo].tmp_slut
  FROM [AdHoc].[dbo].[OpgaveHistorik] A
  join [AdHoc].[dbo].[OpgaveHistorik] B on a.Opgave=b.Opgave
  where /*A.opgave=6039 and*/ A.HANDLING like 'Ansvarlig:%->%'
  order by A.opgave  
  
 IF EXISTS(SELECT name FROM [AdHoc].DBO.sysobjects WHERE name =  'tmp_join' AND type = 'U') DROP TABLE [AdHoc].DBO.tmp_join 
  
  select a.opgave,a.start as start,b.start as slut,a.Startansvarlig,b.Slutansvarlig into [AdHoc].DBO.tmp_join  from [AdHoc].[dbo].tmp_start A
  join [AdHoc].[dbo].tmp_slut B on a.Opgave=b.Opgave and a.Startansvarlig=b.Slutansvarlig and a.start<=b.start 
  order by opgave,start
  
  --select * from [AdHoc].DBO.tmp_join
 

IF EXISTS(SELECT name FROM [AdHoc].DBO.sysobjects WHERE name =  'tmp_join_opgave' AND type = 'U') DROP TABLE [AdHoc].DBO.tmp_join_opgave 

declare @opgave int 
declare @old_opgave int 
declare @start as datetime
declare @slut as datetime
declare @old_slut as datetime
declare @ansvarlig as varchar(100)

SELECT top 1 opgave,start,slut,startansvarlig as ansvarlig, null as forbrugte_dage
INTO [AdHoc].DBO.tmp_join_opgave
FROM [AdHoc].DBO.tmp_join  

delete from [AdHoc].DBO.tmp_join_opgave
  
  DECLARE findopgave CURSOR FAST_FORWARD FOR
SELECT opgave,start,slut,startansvarlig
FROM [AdHoc].DBO.tmp_join  

set @old_opgave=0

OPEN findopgave
FETCH NEXT FROM findopgave
INTO @opgave,@start,@slut,@ansvarlig

WHILE @@fetch_status = 0
BEGIN 
  IF @opgave<>@old_opgave 
  BEGIN
    INSERT INTO [AdHoc].DBO.tmp_join_opgave
    SELECT opgave,start,slut,Startansvarlig,DATEDIFF(DD,start,slut) AS FORBRUGTE_DAGE
    FROM [AdHoc].DBO.tmp_join
    where opgave=@opgave and start=@start and slut=@slut and Startansvarlig=@ansvarlig
    set @old_slut=@slut
  END
  else if @start=@old_slut
  begin
    INSERT INTO [AdHoc].DBO.tmp_join_opgave
    SELECT opgave,start,slut,Startansvarlig,DATEDIFF(DD,start,slut) AS FORBRUGTE_DAGE
    FROM [AdHoc].DBO.tmp_join
    where opgave=@opgave and start=@start and slut=@slut and Startansvarlig=@ansvarlig  
    set @old_slut=@slut
  end
  
   
print @old_slut --print @start

 -- set @old_slut=@slut
  set @old_opgave=@opgave
  
  FETCH NEXT FROM findopgave
INTO @opgave,@start,@slut,@ansvarlig

END
 
CLOSE findopgave
DEALLOCATE findopgave

IF EXISTS(SELECT name FROM Adhoc_DW.DBO.sysobjects WHERE name =  'FactOpgave' AND type = 'U') DROP TABLE Adhoc_DW.dbo.FactOpgave

select a.Opgave as opgaveid,CAST(b.Slutdato AS DATE) AS PK_DATE,a.ansvarlig,b.Status,b.PabegyndtDato,b.Slutdato,a.forbrugte_dage 
INTO adhoc_dw.dbo.FactOpgave
from [AdHoc].DBO.tmp_join_opgave a
join [AdHoc].[dbo].opgave B on a.Opgave=b.id and b.Afsluttet=1
  
  --select *,status from [AdHoc].[dbo].opgave where id=6039
  
 --select distinct HANDLING FROM [AdHoc].[dbo].[OpgaveHistorik]order by handling
 
 