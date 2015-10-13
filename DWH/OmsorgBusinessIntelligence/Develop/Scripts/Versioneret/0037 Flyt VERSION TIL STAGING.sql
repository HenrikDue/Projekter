--use AvaleoAnalytics_STA  
use AvaleoAnalytics_STA_blank 


DECLARE @cmd as varchar(max)
declare @Debug  as bit = 1
declare @tabelexists as varchar(100)

set @tabelexists=(SELECT name FROM .DBO.sysobjects WHERE name =  'VERSION' AND type = 'U')
print @tabelexists

set @cmd = 'IF EXISTS(SELECT name FROM .DBO.sysobjects WHERE name =  ''VERSION'' AND type = ''U'') DROP TABLE dbo.VERSION'
if @debug = 1 print @cmd
if @tabelexists is null exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           ' * '+char(13)+
           'INTO VERSION '+char(13)+
           'FROM AvaleoAnalytics_DW.dbo.VERSION '
if @debug = 1 print @cmd
if @tabelexists is null exec (@cmd)

--set @cmd = 'IF EXISTS(SELECT name FROM AvaleoAnalytics_DW.DBO.sysobjects WHERE name =  ''VERSION'' AND type = ''U'') DROP TABLE dbo.VERSION'
--if @debug = 1 print @cmd
--if @tabelexists is null exec (@cmd)

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA_blank.dbo.VERSION WHERE VERSION=37)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA_blank.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (37,GETDATE())           
end
