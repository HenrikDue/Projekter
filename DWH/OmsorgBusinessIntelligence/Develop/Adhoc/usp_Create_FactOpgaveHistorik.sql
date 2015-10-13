DECLARE @cmd as varchar(max)
DECLARE @debug as bit
DECLARE @targetDB as varchar(max)

set @debug = 1
set @targetDB='Adhoc_DW'

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep1'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep1'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+  --find alle opgaver
           '  OPGAVE, '+char(13)+
           '  TID AS STARTDATO, '+char(13)+
           '  CAST(NULL AS DATETIME) AS SLUTDATO, '+char(13)+
           '  HANDLING, '+char(13)+
           '  CAST(''Ej tildelt'' AS VARCHAR(20)) AS ANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikStep1 '+char(13)+
           'FROM Sta_OpgaveHistorik '+char(13)+
           'WHERE HANDLING LIKE ''Ny opgave%'' '+char(13)+
           'ORDER BY OPGAVE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep2'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep2'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --find 1. række der er sat ansvarlig på
           '  OPGAVE, '+char(13)+
           '  MIN(TID) AS STARTDATO '+char(13)+
           'INTO tmpOpgaveHistorikStep2 '+char(13)+
           'FROM Sta_OpgaveHistorik '+char(13)+
           'WHERE SUBSTRING(HANDLING,1,(charindex(''->'',HANDLING))) LIKE ''Ansvarlig: Ej tildelt%'' '+char(13)+
           'GROUP BY OPGAVE   '+char(13)+
           'ORDER BY OPGAVE   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE tmpOpgaveHistorikStep1 '+char(13)+
           'SET SLUTDATO=(SELECT STARTDATO FROM tmpOpgaveHistorikStep2 B WHERE tmpOpgaveHistorikStep1.OPGAVE=B.OPGAVE) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep3'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep3'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --find 1. række med flyttet ansvar
           '  OPGAVE '+char(13)+
           'INTO tmpOpgaveHistorikStep3 '+char(13)+
           'FROM Sta_OpgaveHistorik '+char(13)+
           'WHERE HANDLING LIKE ''Ansvarlig:%->%'' '+char(13)+
           'GROUP BY OPGAVE   '+char(13)+
           'ORDER BY OPGAVE   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep4'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep4'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --find slutdato og ansvarlig hvor der ikke er en handling med flyttet ansvar
           '  ID AS OPGAVE, '+char(13)+
           '  COALESCE(SLUTDATO, GETDATE()) AS SLUTDATO, '+char(13)+
           '  ANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikStep4 '+char(13)+
           'FROM Sta_Opgave '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmpOpgaveHistorikStep3 A WHERE A.OPGAVE=Sta_Opgave.ID) '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE tmpOpgaveHistorikStep1 '+char(13)+
           'SET SLUTDATO=(SELECT SLUTDATO FROM tmpOpgaveHistorikStep4 B WHERE tmpOpgaveHistorikStep1.OPGAVE=B.OPGAVE), '+char(13)+
           '  ANSVARLIG=COALESCE((SELECT ANSVARLIG FROM tmpOpgaveHistorikStep4 B WHERE tmpOpgaveHistorikStep1.OPGAVE=B.OPGAVE),''Ej tildelt'') '+char(13)+
           'WHERE SLUTDATO IS NULL   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep5'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep5'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --find 1. række med flyttet ansvar ikke er Ej tildelt - (Ej tildelt bruges IKKE altid)
           '  OPGAVE, '+char(13)+
           '  MIN(TID) AS SLUTDATO, '+char(13)+
           '  CAST(NULL AS VARCHAR(20)) AS ANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikStep5 '+char(13)+
           'FROM Sta_OpgaveHistorik '+char(13)+
           'WHERE HANDLING LIKE ''Ansvarlig:%'' AND '+char(13)+
           '  SUBSTRING(HANDLING,12,(CHARINDEX(''->'',HANDLING))-12) NOT LIKE ''Ej tildelt'' '+char(13)+
           'GROUP BY OPGAVE   '+char(13)+
           'ORDER BY OPGAVE   '+char(13)
          
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep6'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep6'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --sæt ansvarlig på
           '  A.OPGAVE, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  SUBSTRING(HANDLING,12,(CHARINDEX(''->'',HANDLING))-12) AS ANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikStep6 '+char(13)+
           'FROM tmpOpgaveHistorikStep5 A'+char(13)+
           'JOIN Sta_OpgaveHistorik B ON A.OPGAVE=B.OPGAVE AND A.SLUTDATO=B.TID AND B.HANDLING LIKE ''Ansvarlig%'' '+char(13)          
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'UPDATE tmpOpgaveHistorikStep1 '+char(13)+
           'SET SLUTDATO=(SELECT SLUTDATO FROM tmpOpgaveHistorikStep6 B WHERE tmpOpgaveHistorikStep1.OPGAVE=B.OPGAVE), '+char(13)+
           '  ANSVARLIG=(SELECT ANSVARLIG FROM tmpOpgaveHistorikStep6 B WHERE tmpOpgaveHistorikStep1.OPGAVE=B.OPGAVE) '+char(13)+
           'WHERE SLUTDATO IS NULL   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikNyOpgave'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikNyOpgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+  --lav første ansvarlig
           '  COALESCE(B.SLUTDATO, GETDATE()) AS PK_DATE,'+char(13)+
           '  A.OPGAVE, '+char(13)+
           '  A.STARTDATO, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  A.HANDLING, '+char(13)+
           '  A.ANSVARLIG, '+char(13)+
           '  B.REKVIRENT AS KUNDEID, '+char(13)+
           '  CAST(B.AFSLUTTET AS INTEGER) AS STATUS, '+char(13)+
           '  DATEDIFF(DD,A.STARTDATO,A.SLUTDATO) AS BEHANDLINGSDAGE, '+char(13)+
           '  CASE WHEN (B.SLUTDATO=A.SLUTDATO AND A.ANSVARLIG=''Ej tildelt'') THEN 1 '+char(13)+
           '  ELSE 0 '+char(13)+
           '  END AS TILDELTUDENANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikNyOpgave '+char(13)+
           'FROM tmpOpgaveHistorikStep1 A '+char(13)+
           'JOIN Sta_Opgave B ON A.OPGAVE=B.ID'+char(13)+
           'ORDER BY OPGAVE'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep7'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep7'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+ --sæt ansvarlig på
           '  OPGAVE, '+char(13)+
           '  TID AS DATO, '+char(13)+
           '  SUBSTRING(HANDLING,(CHARINDEX(''->'',HANDLING))+3,(LEN(HANDLING))) AS TILANSVARLIG, '+char(13)+
           '  SUBSTRING(HANDLING,12,(CHARINDEX(''->'',HANDLING))-12) AS FRAANSVARLIG '+char(13)+
           'INTO tmpOpgaveHistorikStep7 '+char(13)+
           'FROM Sta_OpgaveHistorik'+char(13)+
           'WHERE HANDLING LIKE ''Ansvarlig%'' '+char(13)          
if @debug = 1 print @cmd
exec (@cmd)

--###

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikStep8'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikStep8'
if @debug = 1 print @cmd
exec (@cmd)

declare @opgave int 
declare @old_opgave int 
declare @dato as datetime
declare @old_dato as datetime
declare @ansvarlig as varchar(100)
declare @old_ansvarlig as varchar(100)

SELECT top 1 opgave,dato as startdato,CAST(NULL AS DATETIME) AS SLUTDATO,TILansvarlig as ansvarlig
INTO tmpOpgaveHistorikStep8
FROM tmpOpgaveHistorikStep7 

delete from tmpOpgaveHistorikStep8
  
DECLARE findopgave CURSOR FAST_FORWARD FOR
SELECT opgave,dato,tilansvarlig as ansvarlig
FROM tmpOpgaveHistorikStep7 ORDER BY OPGAVE,DATO

set @old_opgave=0

OPEN findopgave
FETCH NEXT FROM findopgave
INTO @opgave,@dato,@ansvarlig

set @old_ansvarlig=@ansvarlig

WHILE @@fetch_status = 0
BEGIN 
  IF @opgave<>@old_opgave 
  BEGIN
    INSERT INTO tmpOpgaveHistorikStep8
    SELECT opgave,dato,null,tilansvarlig
    FROM tmpOpgaveHistorikStep7
    where opgave=@opgave and dato=@dato and tilansvarlig=@ansvarlig
  END
  ELSE IF @ansvarlig<>@old_ansvarlig
  BEGIN
    UPDATE tmpOpgaveHistorikStep8 SET SLUTDATO=@dato WHERE OPGAVE=@opgave AND UPPER(ansvarlig)=UPPER(@old_ansvarlig)
    INSERT INTO tmpOpgaveHistorikStep8
    SELECT opgave,dato,null,tilansvarlig
    FROM tmpOpgaveHistorikStep7
    where opgave=@opgave and dato=@dato and tilansvarlig=@ansvarlig    
  END
  
  set @old_opgave=@opgave 
  set @old_ansvarlig=@ansvarlig
  
  FETCH NEXT FROM findopgave
  INTO @opgave,@dato,@ansvarlig

END
 
CLOSE findopgave
DEALLOCATE findopgave
--###

set @cmd = 'UPDATE tmpOpgaveHistorikStep8 '+char(13)+
           'SET SLUTDATO=(SELECT COALESCE(SLUTDATO,GETDATE()) FROM Sta_Opgave B WHERE tmpOpgaveHistorikStep8.OPGAVE=B.ID) '+char(13)+
           'WHERE SLUTDATO IS NULL   '+char(13)
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  ''tmpOpgaveHistorikOpgave'' AND type = ''U'') DROP TABLE dbo.tmpOpgaveHistorikOpgave'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+  
           '  COALESCE(B.SLUTDATO, GETDATE()) AS PK_DATE,'+char(13)+
           '  A.OPGAVE, '+char(13)+
           '  A.STARTDATO, '+char(13)+
           '  A.SLUTDATO, '+char(13)+
           '  A.ANSVARLIG, '+char(13)+
           '  B.REKVIRENT AS KUNDEID, '+char(13)+
           '  CAST(B.AFSLUTTET AS INTEGER) AS STATUS, '+char(13)+
           '  DATEDIFF(DD,A.STARTDATO,A.SLUTDATO) AS BEHANDLINGSDAGE '+char(13)+
           'INTO tmpOpgaveHistorikOpgave '+char(13)+
           'FROM tmpOpgaveHistorikStep8 A '+char(13)+
           'JOIN Sta_Opgave B ON A.OPGAVE=B.ID '+char(13)+
           'WHERE NOT EXISTS(SELECT * FROM tmpOpgaveHistorikNyOpgave C WHERE C.OPGAVE=A.OPGAVE AND C.TILDELTUDENANSVARLIG=1) '+char(13)+
           'ORDER BY OPGAVE'
if @debug = 1 print @cmd
exec (@cmd)

--union
set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''FactBehandlingsTid'' AND type = ''U'') DROP TABLE '+@targetDB+'.dbo.FactBehandlingsTid'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+  
           '  CAST(PK_DATE AS DATE) AS PK_DATE,'+char(13)+
           '  OPGAVE AS OPGAVEID, '+char(13)+
           '  STARTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  ANSVARLIG, '+char(13)+
           '  KUNDEID, '+char(13)+
           '  STATUS, '+char(13)+
           '  BEHANDLINGSDAGE '+char(13)+
           'INTO '+@targetDB+'.dbo.FactBehandlingsTid '+char(13)+
           'FROM tmpOpgaveHistorikNyOpgave '+char(13)+
           'UNION ALL '+char(13)+
           'SELECT '+char(13)+  
           '  CAST(PK_DATE AS DATE) AS PK_DATE,'+char(13)+
           '  OPGAVE AS OPGAVEID, '+char(13)+
           '  STARTDATO, '+char(13)+
           '  SLUTDATO, '+char(13)+
           '  ANSVARLIG, '+char(13)+
           '  KUNDEID, '+char(13)+
           '  STATUS, '+char(13)+
           '  BEHANDLINGSDAGE '+char(13)+
           'FROM tmpOpgaveHistorikOpgave '+char(13)

if @debug = 1 print @cmd
exec (@cmd)


set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimAnsvarlig'' AND type = ''U'') EXEC sp_rename '+@targetDB+'.dbo.DimAnsvarlig, '+@targetDB+'.dbo.DimAnsvarlig1 '
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''DimAnsvarlig'' AND type = ''U'') DROP TABLE '+@targetDB+'.dbo.DimAnsvarlig'
if @debug = 1 print @cmd
exec (@cmd)

SET IDENTITY_INSERT Adhoc_DW.dbo.DimAnsvarlig ON

set @cmd = 'INSERT INTO '+@targetDB+'.dbo.DimAnsvarlig '+char(13)+
           'SELECT DISTINCT ANSVARLIG FROM '+@targetDB+'.dbo.FactBehandlingsTid '+char(13)+
           'WHERE NOT EXISTS(SELECT ANSVARLIG FROM '+@targetDB+'.dbo.DimAnsvarlig A WHERE A.ANSVARLIG='+@targetDB+'.dbo.FactBehandlingsTid.ANSVARLIG)'+char(13)
if @debug = 1 print @cmd
exec (@cmd)

SET IDENTITY_INSERT Adhoc_DW.dbo.DimAnsvarlig OFF