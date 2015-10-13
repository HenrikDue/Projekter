  SELECT TOP 1000 [Opgave]
      ,[ID]
      ,[Navn]
      ,[Tid]
      ,[Handling]
  FROM [AdHoc_STA].[dbo].[sta_OpgaveHistorik]
  where HANDLING like '%Ny opgave%'
  and Tid>'2009-01-01'
  order by opgave
  
    SELECT TOP 1000 [Opgave]
      ,[ID]
      ,[Navn]
      ,[Tid]
      ,[Handling]
  FROM [AdHoc_STA].[dbo].[sta_OpgaveHistorik]
  where --HANDLING like '%Ny opgave%' and
   Tid>'2009-01-01'
   order by opgave
   
       SELECT Registreret,*
  FROM [AdHoc_STA].[dbo].[sta_Opgave]
    where Registreret>'2009-01-01'
  order by id