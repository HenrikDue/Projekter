USE [AvaleoAnalytics_STA]
GO
/****** Object:  StoredProcedure [dbo].[usp_Customer_Specific]    Script Date: 12/30/2011 11:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Description:	Runs customer specific procedures
-- =============================================
ALTER PROCEDURE [dbo].[usp_Customer_Specific]
		@DestinationDB as varchar(200)='AvaleoAnalytics_DW'
AS
DECLARE @cmd as varchar(max)
BEGIN


-----------------------------------------------------------------------------------------------------
--1. execute procedure for ETL on KMD vagtplandata
-----------------------------------------------------------------------------------------------------
  --print '--------------------------------------------------------------------------------------------'   
  --print '1. executes procedure for ETL on KMD vagtplandata' 
  --print ''
  --set @cmd = 'exec usp_Create_Vagtplan_KMD ''' + @DestinationDB + ''',0,''0''' 
  --exec (@cmd)
  	

END

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=63)
if @version is null
begin
INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (63,GETDATE())           
end
