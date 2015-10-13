USE [AvaleoAnalytics_STA]
GO

/****** Object:  UserDefinedFunction [dbo].[Udf_Helligdag]    Script Date: 10/07/2015 21:28:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Udf_Helligdag] 
(
	@INDDATO as Date
)
RETURNS int
AS
BEGIN
declare @RESULT as int
declare @TEMP smallint
declare @TEMP_A smallint
declare @TEMP_B smallint
declare @TEMP_C smallint
declare @DAG smallint
declare @MAANED smallint
declare @AAR smallint
declare @PAASKEDAG date
set @RESULT = 0
set @AAR = datepart(year,@INDDATO)
set @MAANED = 3
set @TEMP_A = 225 - 11 * (@AAR%19)
set @TEMP_B = ((@TEMP_A - 21)%30) + 21

IF (@TEMP_B>48) BEGIN SET @TEMP_B=@TEMP_B-1 END 

set @TEMP_C = ((@AAR + (@AAR/4) + @TEMP_B + 1)%7)
set @DAG = @TEMP_B + 7 - @TEMP_C

IF (@DAG>31) BEGIN SET @DAG=@DAG-31 SET @MAANED=4 END

set @PAASKEDAG=CAST(CAST(@AAR AS CHAR)+'-'+CAST(@MAANED AS CHAR)+'-'+CAST(@DAG AS CHAR) AS DATE)

  if datepart(DAYOFYEAR,@INDDATO)=datepart(DAYOFYEAR,(dateadd(DD,-3,@PAASKEDAG))) begin SET @RESULT=1 end             /*skærtorsdag*/
  else if datepart(DAYOFYEAR,@INDDATO)=datepart(DAYOFYEAR,(dateadd(DD,-2,@PAASKEDAG)))  begin SET @RESULT=1 end       /*langfredag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(@PAASKEDAG)))) begin SET @RESULT=1 end                 /*påskedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,1,@PAASKEDAG))))) begin SET @RESULT=1 end   /*2. påskedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,26,@PAASKEDAG))))) begin SET @RESULT=1 end  /*st bededag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,39,@PAASKEDAG))))) begin SET @RESULT=1 end  /*kr himmelfart*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,49,@PAASKEDAG))))) begin SET @RESULT=1 end  /*pinsedag*/
  else if ((datepart(DAYOFYEAR,@INDDATO))=(datepart(DAYOFYEAR,(dateadd(DD,50,@PAASKEDAG))))) begin SET @RESULT=1 end  /*2. pinsedag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-01-01') AS DATE))) begin SET @RESULT=1 end                /*nytårsdag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-06-05') AS DATE))) begin SET @RESULT=1 end                /*grundlovsdag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-12-25') AS DATE))) begin SET @RESULT=1 end                /*juledag*/
  else if (@INDDATO=(CAST((CAST(@AAR AS CHAR)+'-12-26') AS DATE))) begin SET @RESULT=1 end                /*2. juledag*/

RETURN @RESULT

END

GO

