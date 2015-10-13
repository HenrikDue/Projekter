use AvaleoAnalytics_Staging_Clean

select distinct a.visiid as visiid1,b.visiid as visiid2,A.leverandoerid, B.leverandoerid from tmp_Visitations_BorgerMedFritvalgLev_Step2 A
full outer join tmp_Visitations_BorgerMedFritvalgLev_Step2 B on a.sagsid_plejetype=b.sagsid_plejetype and a.slutdato=b.ikraftdato