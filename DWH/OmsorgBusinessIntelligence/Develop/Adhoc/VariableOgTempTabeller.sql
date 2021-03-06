/****** Script for SelectTopNRows command from SSMS  ******/
use Adhoc_STA

--EXEC sp_rename 'test_tbl', 'test_tbl1'

--drop table [Adhoc_STA].[dbo].test_tbl
SELECT TOP 1000 KUNDEID=IDENTITY(int,212,1),[KUNDE]
into test_tbl
  FROM [Adhoc_STA].[dbo].[DimKunderStep1]


DECLARE @cmd as varchar(max) 

DECLARE @table as varchar(max)
DECLARE @table1 as varchar(max)
DECLARE @debug as bit
DECLARE @targetDB as varchar(max)

set @debug = 1
select @targetDB='Adhoc_sta'

--SELECT @table=(SELECT name FROM Adhoc_sta.DBO.sysobjects WHERE name =  'test_tbl' AND type = 'U')
--print @table
--set @cmd = 'SELECT '+@table+'=(SELECT name FROM Adhoc_sta.DBO.sysobjects WHERE name =  ''test_tbl'' AND type = ''U'') '
--SELECT @table=('SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''test_tbl'' AND type = ''U''')  
----print @cmd
----EXEC SELECT @table=('SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''test_tbl'' AND type = ''U''')
--exec (@table)

--print @cmd

CREATE TABLE #tmpData (tablename varchar(max))
SELECT @cmd=('SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''test_tbl'' AND type = ''U''')  
INSERT #tmpData exec (@cmd)
SELECT @table = tablename from #tmpData
DROP TABLE #tmpData
print @table


--print @table

set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  ''test_tbl1'' AND type = ''U'') DROP TABLE '+@targetDB+'.dbo.test_tbl1'
if @debug = 1 print @cmd
EXEC (@cmd)

 
set @cmd = 'IF EXISTS(SELECT name FROM '+@targetDB+'.DBO.sysobjects WHERE name =  '''+@table+''' AND type = ''U'') EXEC sp_rename '''+@table+''', '''+@table+'1'' '
print @cmd
--set @cmd = 'EXEC sp_rename '''+@table+''', '''+@table+'1'' '
print @cmd
exec (@cmd)