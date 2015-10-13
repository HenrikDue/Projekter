SET NAMES WIN1252;

CONNECT 'LOCALHOST:C:\AvaleoProj\TEST_01.FDB' USER 'SYSDBA' PASSWORD 'masterkey';

 execute ibeblock
 as
 begin
ExportOptions = 'OmitCaptions;
                 ExportTextBlobs;
                 DateTimeFormat="dd-mm-yyy hh:nn:ss";
                 DateFormat="dd-mmm-yyyy";
                      TimeFormat="hh:nn:ss";
                      CurrencyFormat="£0.00";
                      IntegerFormat="0";
                      FloatFormat="0.0000";
                      Delimiter=";"';
--select first 1 'BESOGID','STATUS','STAT_TYPE','STAT_GYLDIG','STATUSNAVN' from besogstatus
select
    besogid,
    status,
    stat_type,
    stat_gyldig,
    statusnavn
from besogstatus

as dataset MyDataset;
ibec_ds_Export(MyDataset,__etCSV,'c:\AvaleoProj\DimBesogStatus.csv',ExportOptions);
--ibec_ds_Export(MyDataset,__etCSV,'c:\AvaleoProj\DimBesogStatus.txt',ExportOptions);
close dataset MyDataset;
end
