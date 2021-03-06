USE [Adhoc_DW]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Time_Dimension]    Script Date: 03/17/2011 08:57:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create a stored procedure that will cause an 
-- object resolution error.
ALTER PROCEDURE [dbo].[usp_Create_Time_Dimension]
					  @DestinationDB as  varchar(200),
				      @start_date as datetime,
					  @end_date as datetime
					
AS

set nocount on
set datefirst 1
declare 
 --@start_date datetime
 --,@end_date datetime
 @loop_day datetime
 ,@diff int
 --,@loop int
,@weekNo int
declare @date datetime
declare @ISOweek integer
declare @cmd as varchar(max)
declare @debug as bit

declare @PK_Date as datetime
declare @Date_Name as nvarchar(50)
declare @Year as datetime
declare @Year_Name as nvarchar(50)
declare @Quarter as datetime
declare @Quarter_Name as nvarchar(50)
declare @Month as datetime
declare @Month_Name as nvarchar(50)
declare @Week as datetime
declare @Week_Name as nvarchar(50)
declare @Day_Of_Year as int
declare @Day_Of_Year_Name as nvarchar(50)
declare @Day_Of_Quarter as int
declare @Day_Of_Quarter_Name as nvarchar(50)
declare @Day_Of_Month as int
declare @Day_Of_Month_Name as nvarchar(50)
declare @Day_Of_Week as int
declare @Day_Of_Week_Name as nvarchar(50)
declare @Week_Of_Year as int
declare @Week_Of_Year_Name nvarchar(50)
declare @Month_Of_Year as int
declare @Month_Of_Year_Name as nvarchar(50)
declare @Month_Of_Quarter as int
declare @Month_Of_Quarter_Name as nvarchar(50)
declare @Quarter_Of_Year as int
declare @Quarter_Of_Year_Name as nvarchar(50)
declare @tmpint as int
declare @loop as int
set @debug = 1

set @loop = 0
 

set @cmd = 'IF EXISTS(SELECT name FROM  sysobjects WHERE name =  ''Dim_Time'' AND type = ''U'') DROP TABLE Dim_Time'
if @debug = 1 print @cmd
exec (@cmd) 

CREATE TABLE Dim_Time(
	[PK_Date] [datetime] NOT NULL,
	[Date_Name] [nvarchar](50) NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](50) NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](50) NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](50) NULL,
	[Week] [datetime] NULL,
	[Week_Name] [nvarchar](50) NULL,
	[Day_Of_Year] [int] NULL,
	[Day_Of_Year_Name] [nvarchar](50) NULL,
	[Day_Of_Quarter] [int] NULL,
	[Day_Of_Quarter_Name] [nvarchar](50) NULL,
	[Day_Of_Month] [int] NULL,
	[Day_Of_Month_Name] [nvarchar](50) NULL,
	[Day_Of_Week] [int] NULL,
	[Day_Of_Week_Name] [nvarchar](50) NULL,
	[Week_Of_Year] [int] NULL,
	[Week_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Year] [int] NULL,
	[Month_Of_Year_Name] [nvarchar](50) NULL,
	[Month_Of_Quarter] [int] NULL,
	[Month_Of_Quarter_Name] [nvarchar](50) NULL,
	[Quarter_Of_Year] [int] NULL,
	[Quarter_Of_Year_Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Time] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

select  @diff = datediff(dd,@start_date,@end_date)
while @loop <= @diff
	begin
	 select @loop_day = dateadd(dd,@loop,@start_date)
		set @isoweek = DATEPART( wk,dateadd(dd,@loop,@start_date)) 
			if datepart(dw,@loop_day) = 1  begin
				set @isoweek = DATEPART( wk,dateadd(dd,@loop,@start_date)) 
				if DATEPART( wk,dateadd(dd,@loop,@start_date)) = 1 begin		
					set @date = dateadd(dd,@loop,@start_date)		
					select @ISOweek= datepart(wk,@date)+1-datepart(wk,'Jan 4,'+CAST(datepart(yy,@date) as CHAR(4)))			
					if (@ISOweek=0) begin
						select @ISOweek=datepart(wk, 'Dec '+ CAST(24+datepart(day,@date) as
						CHAR(2))+','+CAST(datepart(yy,@date)-1 as CHAR(4)))+1 
				end	
			end
	 end	
 
 set @PK_Date = dateadd(dd,@loop,@start_date)
 set @Date_Name = datepart(dw,@loop_day)
	if  @Date_Name = '1' 
		set @Date_Name = 'Mandag'
	if  @Date_Name = '2' 
		set @Date_Name = 'Tirsdag'
	if  @Date_Name = '3' 
		set @Date_Name = 'Onsdag'
	if  @Date_Name = '4' 
		set @Date_Name = 'Torsdag'
	if  @Date_Name = '5' 
		set @Date_Name = 'Fredag'
	if  @Date_Name = '6' 
		set @Date_Name = 'Lørdag'
	if  @Date_Name = '7' 
		set @Date_Name = 'Søndag'

 set @Year = cast(lower(year(@PK_Date))  as datetime)
 set @Year_Name = 'Kalender ' + lower( year(@PK_Date))
 set @Quarter_Name = lower(convert(varchar,datepart(qq,@loop_day)))
 
 if @Quarter_Name = '1'
	set @Quarter = cast( lower(year(@PK_Date)) + '-01-01'  as datetime)
  if @Quarter_Name = '2'
	set @Quarter = cast( lower(year(@PK_Date)) + '-04-01'  as datetime)
  if @Quarter_Name = '3'
	set @Quarter = cast( lower(year(@PK_Date)) + '-07-01'  as datetime)
  if @Quarter_Name = '4'
	set @Quarter = cast( lower(year(@PK_Date)) + '-10-01'  as datetime)
   
  set @Quarter_Name = convert(varchar,datepart(qq,@loop_day)) + '. Kvartal ' + lower(year(@PK_Date))
  
  set @tmpint = datepart(mm,@loop_day)  
  if @tmpint > 9  
     set @month = cast(lower(year(@PK_Date)) + '-' + lower(@tmpint) + '-01' as datetime)
  else
	 set @month =cast(lower(year(@PK_Date)) + '-0' + lower(@tmpint) + '-01'  as datetime)
  	
    if  @tmpint = 1 
		set @month_name = 'januar' --+ lower(year(@PK_Date))
	if  @tmpint = 2 
		set @month_name = 'februar'-- + lower(year(@PK_Date))
	if  @tmpint = 3 
		set @month_name = 'marts' --+ lower(year(@PK_Date))
	if  @tmpint = 4 
		set @month_name = 'april'-- + lower(year(@PK_Date))
	if  @tmpint = 5 
		set @month_name = 'maj' --+ lower(year(@PK_Date))
	if  @tmpint = 6 
		set @month_name = 'juni'-- + lower(year(@PK_Date))
	if  @tmpint = 7 
		set @month_name = 'juli' --+ lower(year(@PK_Date))
	if  @tmpint = 8 
		set @month_name = 'august' --+ lower(year(@PK_Date))
   if  @tmpint = 9 
		set @month_name = 'september' --+ lower(year(@PK_Date))
   if  @tmpint = 10 
		set @month_name = 'oktober' --+ lower(year(@PK_Date))
   if  @tmpint = 11 
		set @month_name = 'november' --+ lower(year(@PK_Date))
   if  @tmpint = 12 
		set @month_name = 'december' --+ lower(year(@PK_Date))
  set datefirst 1
  set @Date_Name = @Date_Name + ', '  + lower(day(@PK_Date)) + '. '  + @month_name + ' ' + lower(year(@PK_Date))
  set @month_name = @month_name + ' ' + lower(year(@PK_Date)) 
  set @Week = @PK_Date - (DATEPART(DW,  @PK_Date) - 1)
  declare @yearfix int
  if DAY(@PK_Date)<9 and dbo.udf_GetISOWeekNumberFromDate(@PK_Date)>50 
     set  @yearfix=-1
   else 
     set @yearfix=0 
  set @Week_Name = 'Uge '+ cast(dbo.udf_GetISOWeekNumberFromDate(@PK_Date) as nvarchar(2)) +',' + lower(year(@PK_Date)+@yearfix)
  set @Day_Of_Year =  DATEDIFF(dd, '01/01/'+ lower(year(@PK_Date)), @PK_Date) + 1 
  set @Day_Of_Year_Name = 'Dag ' + lower( @Day_Of_Year)
  set @Day_Of_Quarter = DATEDIFF(dd,@Quarter, @PK_Date) + 1 
  set @Day_Of_Quarter_Name = 'Dag ' + lower(DATEDIFF(dd,@Quarter, @PK_Date) + 1 )
  set @Day_Of_Month = day(@PK_Date)
  set @Day_Of_Month_Name = 'Dag ' + lower(day(@PK_Date))
  set @Day_Of_Week = datepart(dw,@loop_day)
  set @Day_Of_Week_Name = 'Dag ' + lower(@Day_Of_Week)
  set @Week_Of_Year = @isoweek
  set @Week_Of_Year_Name = 'Uge ' + lower(@isoweek)
  set @Month_Of_Year = datepart(mm,@loop_day)
  set @Month_Of_Year_Name = 'Måned ' + lower(@Month_Of_Year)
  set @Month_Of_Quarter =  DATEDIFF(mm,@Quarter, @PK_Date) + 1
  set @Month_Of_Quarter_Name = 'Måned ' + lower( @Month_Of_Quarter )
  set @Quarter_Of_Year =  convert(varchar,datepart(qq,@loop_day))
  set @Quarter_Of_Year_Name = 'Kvartal ' + lower(@Quarter_Of_Year)


insert into Dim_Time
 select @PK_Date, 
		@Date_Name, 
		@Year, 
		@Year_Name, 
		@Quarter, 
		@Quarter_Name, 
		@Month, 
		@Month_Name, 
		@Week, 
		@Week_Name, 
		@Day_Of_Year, 
		@Day_Of_Year_Name, 
		@Day_Of_Quarter,
		@Day_Of_Quarter_Name, 
		@Day_Of_Month, 
		@Day_Of_Month_Name, 
		@Day_Of_Week, 
		@Day_Of_Week_Name, 
		@Week_Of_Year, 
		@Week_Of_Year_Name, 
		@Month_Of_Year,                
		@Month_Of_Year_Name, 
		@Month_Of_Quarter, 
		@Month_Of_Quarter_Name, 
		@Quarter_Of_Year, 
		@Quarter_Of_Year_Name
	

 select @loop = @loop + 1  
end

set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimTime'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimTime'
if @debug = 1 print @cmd
exec (@cmd)



set @cmd = 'Select * into '+@DestinationDB+'.DBO.DimTime from dbo.Dim_Time'
if @debug = 1 print @cmd
exec (@cmd)

IF EXISTS(SELECT name FROM DBO.sysobjects WHERE name =  'link_time' AND type = 'U') DROP TABLE link_time

SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
into link_time
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 2) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 2)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, '0' + CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 1) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 2)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-0' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM        Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 2) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 1)
UNION ALL
SELECT     PK_Date, Date_Name, Year, Year_Name, Quarter, Quarter_Name, Month, Month_Name, Week, Week_Name, Day_Of_Year, Day_Of_Year_Name, 
                      Day_Of_Quarter, Day_Of_Quarter_Name, Day_Of_Month, Day_Of_Month_Name, Day_Of_Week, Day_Of_Week_Name, Week_Of_Year, 
                      Week_Of_Year_Name, Month_Of_Year, Month_Of_Year_Name, Month_Of_Quarter, Month_Of_Quarter_Name, Quarter_Of_Year, 
                      Quarter_Of_Year_Name, '0' + CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar) + '-0' + CAST(CAST(DATEPART(Month, PK_Date) AS float) 
                      AS nvarchar) AS JoinFactor
FROM         Dim_time
WHERE     (LEN(CAST(CAST(DATEPART(day, PK_Date) AS float) AS nvarchar)) = 1) AND (LEN(CAST(CAST(DATEPART(Month, PK_Date) AS float) AS nvarchar)) = 1)

