USE [AvaleoAnalytics_STA]
GO

/****** Object:  UserDefinedFunction [dbo].[CheckLeverandoer]    Script Date: 10/07/2015 21:27:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[CheckLeverandoer](@levId int) 
RETURNS  int

AS
BEGIN
declare @returnLevId as int

  if @levId is null
	return null
  if @levId = ''
	return null
	select @returnLevId = coalesce((select ID from dbo.HJPLEVERANDOR where ID=@levId),9999)

  RETURN @returnLevId;
END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=26)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (26,GETDATE())           
--end

GO

