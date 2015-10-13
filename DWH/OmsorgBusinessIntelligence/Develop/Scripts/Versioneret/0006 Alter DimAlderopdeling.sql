USE [AvaleoAnalytics_DW]
GO

/****** Object:  Table [dbo].[DimAldersopdeling]    Script Date: 11/26/2010 09:37:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DimAldersopdeling]') AND type in (N'U'))
DROP TABLE [dbo].[DimAldersopdeling]
GO

USE [AvaleoAnalytics_DW]
GO

/****** Object:  Table [dbo].[DimAldersopdeling]    Script Date: 11/26/2010 09:37:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DimAldersopdeling](
	[AlderAar] [int] NULL,
	[AldersGruppe] [float] NULL,
	[AldersGruppeStart] [float] NULL,
	[AldersGruppeSlut] [float] NULL,
	[AldersGruppeNavn] [nvarchar](61) NULL,
	[Pensionist] [varchar](4) NOT NULL,
	[Yngre∆ldre67] [varchar](4) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

declare @version as int
set @version = (SELECT VERSION FROM AvaleoAnalytics_DW.dbo.VERSION WHERE VERSION=6)
if @version is null
begin
INSERT INTO AvaleoAnalytics_DW.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
VALUES (6,GETDATE())           
end



