USE [AvaleoAnalytics_STAa]
GO
/****** Object:  UserDefinedFunction [dbo].[SERIES_OCCURS_ON_DAY]    Script Date: 12/29/2011 13:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER FUNCTION [dbo].[SERIES_OCCURS_ON_DAY] 
(
	@DATO as datetime,
    @FREKVENS as smallint,
    @FREKTYPE smallint,
    @FREKVALGTEDAGE smallint,
    @STARTDATO datetime
)
RETURNS int
AS
BEGIN
  declare @RESULT as int
  declare @BIN_UGEDAG smallint
  declare @UGEDAG smallint
  set @RESULT = 0
  
  IF @FREKTYPE=0 
  BEGIN
      /* Ugentlige besøg */
    IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%7=0 
    BEGIN
      /* Kun hver x. uge */
      IF @FREKVENS>0 
      BEGIN
        IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* Ikke hver x. uge */
      BEGIN
        IF (((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)+1)%@FREKVENS<>0
        BEGIN      
          SET @RESULT = 1
        END
      END
    END
  END
  ELSE IF @FREKTYPE=1
  BEGIN
    /* Daglige besøg, hver x. dag */
    IF @FREKVENS>0 
    BEGIN
      IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
      BEGIN
        SET @RESULT = 1
      END
    END
    ELSE /* Daglige besøg, ikke hver x. dag */
    BEGIN
     IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
     BEGIN
        SET @RESULT = 1
     END
    END
  END
  ELSE IF (@FREKTYPE=2) 
  BEGIN
    /* Alle hverdag */
    IF DATEPART(DW,@DATO) IN (2,3,4,5,6)
    BEGIN
       /* hver x. dag */
      IF (@FREKVENS>0)
      BEGIN
        IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END
  ELSE IF (@FREKTYPE=3)
  BEGIN
    /* Weekender */
    IF DATEPART(DW,@DATO) IN (7,1)
    BEGIN
      /* hver x. dag */
      IF (@FREKVENS > 0)
      BEGIN
        IF (CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))+1)%@FREKVENS<>0 
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END
  ELSE IF (@FREKTYPE=4)
  BEGIN
    /* Kun udvalgte dage */
    set @UGEDAG = DATEPART(DW,@DATO)-1
    IF (@UGEDAG=0)
    BEGIN
      set @UGEDAG=7;
    END

    /* Find det binære nummer for dagen i uge */
    set @BIN_UGEDAG = 1;
    WHILE (@UGEDAG>1) 
    BEGIN
      set @BIN_UGEDAG = @BIN_UGEDAG * 2;
      set @UGEDAG = @UGEDAG - 1;
    END

    /* Returner linien hvis dagen er valgt */
    IF (@FREKVALGTEDAGE&@BIN_UGEDAG)>0 
    BEGIN

        /* hver x. dag */
      IF (@FREKVENS > 0)
      BEGIN
        IF ((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)%@FREKVENS=0
        BEGIN
          SET @RESULT = 1
        END
      END
      ELSE /* ikke hver x. dag */
      BEGIN
       IF (((CAST(@DATO AS INT)-CAST(@STARTDATO AS INT))/7)+1)%@FREKVENS<>0
       BEGIN
          SET @RESULT = 1
       END
      END
    END
  END        

  RETURN @RESULT
END

--declare @version as int
--set @version = (SELECT VERSION FROM AvaleoAnalytics_STA.dbo.VERSION WHERE VERSION=61)
--if @version is null
--begin
--INSERT INTO AvaleoAnalytics_STA.[dbo].[VERSION] ([VERSION],[OPDATERINGSDATO])
--VALUES (61,GETDATE())           
--end