USE [AvaleoAnalytics_STA]
GO
/****** Object:  UserDefinedFunction [dbo].[Age]    Script Date: 10/07/2015 21:25:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[Age](@cprNr AS nvarchar(10), @dato as datetime) 
RETURNS  int

AS
BEGIN
  if @cprnr is null
	return null
  if @cprnr = ''
	return null
  DECLARE @CENT as varchar(2)
  DECLARE @DATEOFBIRTH as datetime
  declare @age as int
  select @CENT =(select CASE WHEN (substring(@cprNr, 7, 1)) < 4 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
			    WHEN (substring(@cprNr, 7, 1)) = 4 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
				WHEN (substring(@cprNr, 7, 1)) = 9 AND (substring(@cprNr, 5, 2)) > 36 THEN 19 
			    WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) < 37 THEN 20 
				WHEN (substring(@cprNr, 7, 1)) > 4 AND (substring(@cprNr, 7, 1)) < 8 AND (substring(@cprNr, 5, 2)) > 36 THEN 18 
				END AS år)  
  set @DATEOFBIRTH = CAST(LOWER(@CENT) + SUBSTRING(@cprNr, 5, 2)+ 
					 '-' + SUBSTRING(@cprNr, 3, 2) + 
					 '-' + LEFT(@cprNr, 2) AS datetime) 

  --set @age = FLOOR((CAST(@dato AS float) - CAST(@DATEOFBIRTH AS float)) / 365) 
	--set @age =  datediff(year,@DATEOFBIRTH,@dato)
	select @age = (select CASE
					WHEN dateadd(year, datediff (year, @DATEOFBIRTH, @dato), @DATEOFBIRTH) > @dato
					THEN datediff (year, @DATEOFBIRTH, @dato) - 1
					ELSE datediff (year, @DATEOFBIRTH, @dato)
					END as Age)

  RETURN @age;
END
