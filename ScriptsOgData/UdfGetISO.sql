USE [AvaleoAnalytics_STA]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_GetISOWeekNumberFromDate]    Script Date: 10/07/2015 21:29:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_GetISOWeekNumberFromDate](@dtDate as DATETIME) RETURNS INT WITH RETURNS NULL ON NULL INPUT
/*
** Return the ISO week of the year regardless of the DATEFIRST session setting.
*/
AS
BEGIN

DECLARE @intISOWeekdayNumber INT
DECLARE @dtThisThursday DATETIME
DECLARE @dtFirstOfThisThursdaysYear DATETIME
DECLARE @intISOWeekdayNumberOfFirstOfThisThursdaysYear INT
DECLARE @dtFirstThursdayOfYear DATETIME
DECLARE @intISOWeekNumber INT

   -- Get the ISO week day number (Monday = 1) for our date.
   SET @intISOWeekdayNumber = (((DATEPART(dw, @dtDate) - 1) + (@@DATEFIRST - 1)) % 7) + 1

   -- Get the date of the Thursday in this ISO week.
   SET @dtThisThursday = DATEADD(d,(4 - @intISOWeekdayNumber),@dtDate)

   -- Get the date of the 1st January for 'this Thursdays' year.
   SET @dtFirstOfThisThursdaysYear = CAST(CAST(YEAR(@dtThisThursday) AS CHAR(4)) + '-01-01' AS DATETIME)

   SET @intISOWeekdayNumberOfFirstOfThisThursdaysYear = (((DATEPART(dw, @dtFirstOfThisThursdaysYear) - 1) + (@@DATEFIRST - 1)) % 7) + 1

   -- Get the date of the first Thursday in 'this Thursdays' year.
   -- The year of which the ISO week is a part is the year of this date.     
   IF (@intISOWeekdayNumberOfFirstOfThisThursdaysYear in (1,2,3,4))
      SET @dtFirstThursdayOfYear = DATEADD(d,(4 - @intISOWeekdayNumberOfFirstOfThisThursdaysYear),@dtFirstOfThisThursdaysYear)
   ELSE
      SET @dtFirstThursdayOfYear = DATEADD(d,(4 - @intISOWeekdayNumberOfFirstOfThisThursdaysYear + 7),@dtFirstOfThisThursdaysYear)

   -- Work out how many weeks from the first Thursday to this Thursday.
   SET @intISOWeekNumber = DATEDIFF(d,@dtFirstThursdayOfYear,@dtThisThursday)/7+1
   
   RETURN @intISOWeekNumber

END

GO

