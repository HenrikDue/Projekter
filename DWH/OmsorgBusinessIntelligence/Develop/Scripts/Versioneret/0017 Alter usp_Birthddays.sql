USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Birthddays]    Script Date: 12/21/2010 12:43:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER PROCEDURE [dbo].[usp_Birthddays]
					   @TABLE as  varchar(200),
					   @Database as varchar(200),
					   @VisiColName as varchar(200)
AS
declare @count as int
declare @rownumber as int
declare @loop as int
declare @cmd as varchar(max)
DECLARE @c varchar(4000), @t varchar(128)
declare @Debug int
declare @tmpId int
declare @age as int
declare @maxDate as datetime
declare @tmpAge as int
declare @specifikation as int
declare @cprNr as nvarchar(12)
declare @birthday as datetime

set @debug = 1
set @c = ''
set @t= @TABLE 
set @tmpId = 0

if @debug = 1 print '1. Close Period                                       (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'



set @cmd = 'update '+@Database+'.DBO.'+@t+' set slut=CAST(DATEPART(YEAR,GETDATE()) + 1 AS varCHAR(4))+''-12-31'' where slut = ''9999-01-01 00:00:00.000'''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF EXISTS(SELECT name FROM '+@Database+'.DBO.sysobjects WHERE name =  ''_'+@t+''' AND type = ''U'') DROP TABLE '+@Database+'.dbo._'+@t+''
if @debug = 1 print @cmd
exec (@cmd)

set @maxdate = (select max(pk_date) from dim_time)
print @maxdate
set @cmd = 'update ' + @Database+ '.dbo.'+@t+' set slut = '''+lower(@maxdate)+''' where slut > '''+lower(@maxdate) +''''
if @debug = 1 print @cmd
exec (@cmd)


/* 2. Use the age function to finde age of person på */

if @debug = 1 print '2. Find age                                           (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'Select Row_Number() OVER (order by a.sagsid asc) as RowNumber,  ' +char(13)+
		   'dbo.Age(b.CPRNR,a.start) as Alder,								' +char(13)+
		   'dbo.Age(b.CPRNR,a.slut) -										' +char(13)+
		   'dbo.Age(b.CPRNR,a.start) as birthdaysInPeriod,					' +char(13)+
		   'b.CPRNR,                                                        ' +char(13)+
		   'a.*																' +char(13)+
		   ' into ' + @Database+ '.dbo._'+@t+
		   ' from  ' + @Database+ '.dbo.'+@t+'  a' +char(13)+
		   ' inner join dimsager b on a.sagsid = b.sagsid '
if @debug = 1 print @cmd
exec (@cmd)

SET @t='_' + @t

/* 3. Find Columns */

if @debug = 1 print '3. Find columns in table and place then in @c         (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

IF OBJECT_ID (N'_tmpTableDef') IS NOT NULL
             DROP table _tmpTableDef;

set @cmd = 'select c.name + '', '' as col ' +char(13)+
			'into _tmpTableDef ' +char(13)+
			'from ' + @Database+ '.dbo.syscolumns c INNER JOIN ' + @Database+ '.dbo.sysobjects o '+char(13)+
			'on o.id = c.id WHERE o.name = ''' + @t +''''+char(13)+
			'order by colid' 
if @debug = 1 print @cmd
exec (@cmd)

SELECT @c = @c + c.col  
FROM _tmpTableDef as c




if @debug = 1 print ' '
if @debug = 1 print '4. Laver temp view                                    (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

IF OBJECT_ID (N'view_name') IS NOT NULL
    DROP view view_name;
set @cmd = 'CREATE VIEW view_name AS SELECT ' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ' from ' + @Database+ '.dbo.'+ @t
if @debug = 1 print @cmd
exec (@cmd)

IF OBJECT_ID (N'#tmp') IS NOT NULL
    DROP table #tmp;
CREATE TABLE #tmp
( 
    age INT, 
    rownumber int,
	birthday datetime
)



if @debug = 1 print ' '
if @debug = 1 print '5. Laver temp table over view                         (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'

set @cmd='DECLARE CursorLoop CURSOR FOR '+
         --' Select ' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ' ' +
                        ' Select rownumber,birthdaysInPeriod, Alder, cprnr ' +char(13)+
         ' from view_name ' +char(13)+
		' WHERE (birthdaysInPeriod > 0) '
if @debug = 1 print @cmd
exec(@cmd)
set @loop = 0
set nocount on
OPEN CursorLoop
FETCH NEXT FROM CursorLoop into @rownumber,@count, @age, @cprnr
  WHILE @@FETCH_STATUS = 0
           BEGIN
                      while @loop < @count begin
                                 if @count > 20
									set @loop = @count
                                 set @loop = @loop + 1                              
                                 set @tmpage = @age + @loop
  								 set @birthday = dateadd(year,@tmpage,dbo.getbirthday(@cprnr))
								 insert into #tmp values (@tmpage,@rownumber,@birthday)
							     insert into #tmp values (-@tmpage+1,@rownumber,@birthday)								
                      end
                      set @loop = 0
FETCH NEXT FROM CursorLoop into @rownumber,@count, @age,@cprnr
end
CLOSE CursorLoop
DEALLOCATE CursorLoop
set nocount off

IF OBJECT_ID (N'tmp') IS NOT NULL
  DROP table tmp;

select * into tmp from #tmp



if @debug = 1 print ' '
if @debug = 1 print '6. Tilføje nye post med afgang og tilgang på alder specifikation 6 & 7 '
if @debug = 1 print '----------------------------------------------------------------------'

print @VisiColName
print Substring(@c, 1, Datalength(@c) - 2)
set @cmd = 'insert into ' + @Database+ '.dbo.'+ @t + ' (' + (SELECT Substring(@c, 1, Datalength(@c) - 2)) + ') ' +char(13)+ 
		   ' select ' + replace(replace (replace (replace( replace( (SELECT Substring(@c, 1, Datalength(@c) - 2)), 'Alder', 'a.age'), 'dato', 'a.birthday as dato'), 'rownumber', 'a.rownumber'),'specifikation','6 as specifikation'), ''+@VisiColName+'', ''+@VisiColName+'' ) + ' ' +char(13)+
		   ' FROM  #tmp a INNER JOIN ' +char(13)+ 
           '' + @Database+ '.dbo.'+ @t + '  b ' +char(13)+ 
           ' on a.rownumber = b.RowNumber ' +char(13)+ 
		   ' where specifikation = 2 and age > 0 ' +char(13)+
			'union all ' +char(13)+ 
		   ' select ' + replace(replace(replace(replace(replace( replace( (SELECT Substring(@c, 1, Datalength(@c) - 2)), 
		    'Alder', 'a.age * -1'),
		    'dato', 'a.birthday as dato'),
		    'rownumber', 'a.rownumber'),
		    'specifikation','7 as specifikation'),
		    'pris','pris * -1 as PRIS'),
		     ''+@VisiColName+'', '-1*'+@VisiColName  ) +char(13)+
			' FROM  #tmp a INNER JOIN            ' +char(13)+ 
           '' + @Database+ '.dbo.'+ @t +  ' b      ' +char(13)+ 
           ' on a.rownumber = b.RowNumber        ' +char(13)+ 
		   ' where specifikation = 2 and age < 0 ' 

if @debug = 1 print @cmd
exec (@cmd)

--IF OBJECT_ID (N'#tmp') IS NOT NULL
  --DROP table #tmp;


if @debug = 1 print ' '
if @debug = 1 print '6. Tilrettet table og skifter den ud                  (usp_Birthddays)'
if @debug = 1 print '----------------------------------------------------------------------'


set @cmd = 'IF EXISTS(SELECT name FROM '+@Database+'.DBO.sysobjects WHERE name =  '''+@TABLE+''' AND type = ''U'') DROP TABLE '+@Database+'.dbo.'+@TABLE+''
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN birthdaysInPeriod'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN start'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN slut'
if @debug = 1 print @cmd
--exec (@cmd)

set @cmd = 'alter table ' + @Database+ '.dbo.'+ @t + ' drop COLUMN RowNumber'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'IF OBJECT_ID (N'''+@TABLE+''') IS NOT NULL DROP table ' + @TABLE+';'
if @debug = 1 print @cmd
exec (@cmd)


set @cmd = @Database+ '.dbo.sp_rename '''+@t+''','''+@TABLE+''''
if @debug = 1 print @cmd
exec (@cmd)

IF OBJECT_ID (N'tmp') IS NOT NULL
    DROP table tmp;
select * into tmp from #tmp

--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'tmp' AND type = 'U') DROP TABLE tmp
--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '_tmpTableDef' AND type = 'U') DROP TABLE _tmpTableDef
--IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  '__tmp_HJVISITATION_PB' AND type = 'U') DROP TABLE __tmp_HJVISITATION_PB

return

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=17)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (17,GETDATE())           
end