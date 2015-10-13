use Adhoc_STA

SELECT opgave, 
 COUNT(opgave) AS NumOccurrences
FROM tmpOpgaveHistorikStep1
GROUP BY opgave
HAVING ( COUNT(opgave) > 1 )