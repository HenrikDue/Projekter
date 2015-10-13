SET NAMES WIN1252;

CONNECT 'LOCALHOST:C:\AvaleoProj\OMSORG.FDB' USER 'SYSDBA' PASSWORD 'masterkey';

 execute ibeblock
 as
 begin
ExportOptions = 'OmitCaptions;
                 ExportTextBlobs;
                 DateTimeFormat="dd-mm-yyy hh:nn:ss";
                 DateFormat="dd-mmm-yyyy";
                      TimeFormat="hh:nn:ss";
                      CurrencyFormat="Â£0.00";
                      IntegerFormat="0";
                      FloatFormat="0.0000";
                      Delimiter=";"';

select
    sager.sagsid,
    sager.sagstype,
    sager.cprnr,
    sager.fornavn ||' '||sager.efternavn as navn,
    sager.adresse,
    sager.postnr,
    case when substr(cprnr,10,10) in (0,2,4,6,8) then 'K' else 'M' end as kon,
    coalesce(refusionskommune.kommunekode,999999) refusionskommune,
    coalesce(refusionskommune.navn ,'EXKØBING') as refusionskommunenavn,
    coalesce(plejekategori.beskrivelse,'UKENDT') as plejekategori,
    'laegenavntelefon'
from sager
left join refusionskommune on sager.refusionskommune=refusionskommune.id
left join plejekategori on sager.plejekategori=plejekategori.id
where sagstype=1

as dataset MyDataset;
ibec_ds_Export(MyDataset,__etCSV,'c:\AvaleoProj\DimSager.csv',ExportOptions);
close dataset MyDataset;
end
