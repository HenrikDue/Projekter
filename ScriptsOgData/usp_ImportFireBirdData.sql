USE [AvaleoAnalytics_Sta]
GO

/****** Object:  StoredProcedure [dbo].[usp_ImportFireBirdData]    Script Date: 11/16/2010 08:22:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery7.sql|7|0|C:\Users\Avaleo\AppData\Local\Temp\4\~vsC66B.sql
/* MODDOC                                                                     
+----------------------------------------------------------------------------+
+-------------+--------------------------------------------------------------+
| DESCRIPTION |                                                       
| SUPPORT:    |                                                               
| VERSION:    |                                                    
| TEST:       |                                                               
+-------------+--------------------------------------------------------------+
| PURPOSE:  Importere en tabel fra den linkede firebird database over i dw.
                                                      
+---------+---------------+-----------+-------------+------------------------+
|HISTORY  |RuneG		  | 01MAJ2007 | Solitwork   | Initial coding.
+---------+---------------+-----------+-------------+------------------------+
                                                                              
MODULEDOCEND */

CREATE PROCEDURE [dbo].[usp_ImportFireBirdData]
                 @TableName VARCHAR(50)
				 
as
         

DECLARE @Cmd1 varchar(8000)
DECLARE @ColName varchar(50)
DECLARE @ColType varchar(50)
DECLARE @ColNull varchar(50)
DECLARE @Cmd varchar(MAX)
DECLARE @TableSchema VARCHAR(50)
DECLARE	@Database VARCHAR(50)
DECLARE	@TableType VARCHAR(50)
DECLARE @ColStr varchar(max)
declare @executionStart as datetime
declare @RowCount as int
declare @linkedserver as varchar(200)
declare @colstrRemoteTable as varchar(max)
declare @InsertCol as varchar(max)
declare @remoteDb as varchar(200)
set @remoteDb = ''


set @TableSchema = 'dbo'
set @tableType = @tablename
set @colstr = ''
set @InsertCol = ''
set @colstrRemoteTable = ''
set @linkedserver = 'OMSORG' 

 if lower(@TableName) = 'borgerjournal'
	return


SET @Cmd = 'IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(TABLE_NAME) = UPPER('+@Tablename+') AND TABLE_SCHEMA = '+@TableSchema+')' 

BEGIN
		  SET @Cmd1='drop table '+@TableSchema+'.'+@Tablename
		  print @cmd1
		  EXEC(@Cmd1)
END 
	
		SET @Cmd1='Create Table '+@TableSchema+'.'+@Tablename +char(13)+'('
		DECLARE CursorCreateTable CURSOR FOR 
		SELECT  ColName , ColType, ColNull from FireBirdDBDataDefinition
		where tablename =@TableType order by sortorder

		OPEN CursorCreateTable 
		FETCH NEXT FROM CursorCreateTable    into  @ColName,@ColType,@ColNull
		   WHILE (@@fetch_status <> -1)
		   BEGIN
			  if @coltype = 'datetime' 
				print @coltype
			  
			  SET @Cmd1=@Cmd1+@ColName+' '+@ColType+' '+@ColNull+char(13)+','
			  SEt @ColStr = @ColStr + @ColName + ','
			  set @colstrRemoteTable = @colstrRemoteTable + @ColName + ','
			  SEt @InsertCol = @InsertCol + @ColName + ','
			 -- print 'colstr ' + @colstr
			  FETCH NEXT FROM CursorCreateTable into  @ColName,@ColType,@ColNull
		   end
		CLOSE CursorCreateTable
		DEALLOCATE CursorCreateTable

if len(@colstr)  = 0  
 return
print @colstrRemoteTable 
SET @Cmd1 = substring(@Cmd1,1,len(@Cmd1)-1)
	SET @Cmd1=@Cmd1+')'
	PRINT @Cmd1
	exec(@Cmd1)

set @executionStart = CURRENT_TIMESTAMP
set @ColStr = substring(@colstr,1,len(@colstr) - 1)
set @colstrRemoteTable = substring(@colstrRemoteTable,1,len(@colstrRemoteTable) - 1)
set @InsertCol = substring(@InsertCol,1,len(@InsertCol) - 1)
set @cmd1 = 'insert into '+@TableSchema+'.' + @tablename + ' (' +  @InsertCol + ') ' +
			'SELECT ' + @ColStr + ' FROM ' +
			 ' OPENQUERY('+@linkedserver+', ''SELECT ' + @colstrRemoteTable + ' FROM ' +@tablename+''')'
print @cmd1
begin try
	exec(@Cmd1)
	set @rowcount = @@rowcount
end try
BEGIN CATCH
	update FireBirdDBDataDefinition set ErrorMessage = ERROR_MESSAGE(), ErrorNumber = ERROR_NUMBER(), errorcmd = @cmd1
	where tableName = @tableName
    SELECT 
        ERROR_NUMBER() as ErrorNumber,
        ERROR_MESSAGE() as ErrorMessage;
END CATCH;

update FireBirdDBDataDefinition set LastImported =CURRENT_TIMESTAMP, rowsimported = @rowcount, 
ExecutionTime = datediff(s,@executionStart, IsNull(CURRENT_TIMESTAMP, @executionStart ))									
where tablename = @Tablename

GO

