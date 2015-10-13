use AvaleoAnalytics_STA

declare @morgen as integer
declare @formiddag as integer

DECLARE cur_doegninddeling CURSOR FAST_FORWARD FOR
select top 1 morgen,formiddag from DOGN_INDDELING order by ID desc

OPEN cur_doegninddeling
FETCH NEXT FROM cur_doegninddeling
INTO @morgen,@formiddag
CLOSE cur_doegninddeling
DEALLOCATE cur_doegninddeling

select top 1000 vt.STARTTIDSPUNKT,vt.SLUT, 
(DATEPART(HH,vt.STARTTIDSPUNKT)*60)+(DATEPART(MI,vt.STARTTIDSPUNKT)) as startminframidnat,
(DATEPART(HH,vt.SLUT)*60)+(DATEPART(MI,vt.SLUT)) as slutminframidnat,
Case 
  when ((DATEPART(HH,vt.SLUT)*60)+(DATEPART(MI,vt.SLUT))>@formiddag) then @formiddag-((DATEPART(HH,vt.STARTTIDSPUNKT)*60)+(DATEPART(MI,vt.STARTTIDSPUNKT)))
ELSE -6 -- ((DATEPART(HH,vt.SLUT)*60)+(DATEPART(MI,vt.SLUT))-(DATEPART(HH,vt.STARTTIDSPUNKT)*60)+(DATEPART(MI,vt.STARTTIDSPUNKT)))
END AS VAGTMINUTTER,
1 AS DOGNINDDELING 

from VPL_TJENESTER vt
join VPL_TJENESTETYPER vtt on vt.TJENESTE=vtt.ID
where vtt.KMDID='NT' AND (DATEPART(HH,vt.STARTTIDSPUNKT)*60)+(DATEPART(MI,vt.STARTTIDSPUNKT)) between 421 and @formiddag

-- dateadd(day, -datediff(day, 0, @datetime), @datetime)
