USE [AvaleoAnalytics_STAa]
GO
/****** Object:  StoredProcedure [dbo].[usp_Create_Dim_Boliger]    Script Date: 07/11/2011 05:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[usp_Create_Dim_Boliger] 
                @DestinationDB as varchar(200) = 'AvaleoAnalytics_DW',
                @Debug  as bit = 1 
AS
DECLARE @cmd as varchar(max)
BEGIN
set @cmd = 'IF EXISTS(SELECT name FROM '+@DestinationDB+'.DBO.sysobjects WHERE name =  ''DimBoliger'' AND type = ''U'') DROP TABLE '+@DestinationDB+'.dbo.DimBoliger'
if @debug = 1 print @cmd
exec (@cmd)

set @cmd = 'SELECT '+char(13)+
           '  (SELECT KODE FROM BOLIG_DFPT WHERE ID=B.DRIFTFORM) AS DRIFTSFORM,'+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           '  KENDENAVN'+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           ''+char(13)+
           'INTO '+@DestinationDB+'.dbo.DimBoliger'+char(13)+           
           'FROM BOLIGER B'+char(13)
        
if @debug = 1 print @cmd
exec (@cmd)
             
--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=40)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (40,GETDATE())           
--end

END
