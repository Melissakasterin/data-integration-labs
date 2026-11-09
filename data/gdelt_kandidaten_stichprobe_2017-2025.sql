-- gdelt_kandidaten_stichprobe_2017-2025.sql
-- Zweck: Kandidaten für die Künstlerauswahl finden (DIS 3.3, Gruppenprojekt).
-- Ergebnis: gdelt_kandidaten_stichprobe_2017-2025.csv (100 Zeilen)
--
-- Ausgeführt: 09.11.2026 in Google BigQuery (Sandbox), Projekt dis33-gdelt
-- Verarbeitete Datenmenge laut BigQuery: 25,22 GB
--
-- Stichprobe: jeweils der 15. jedes Monats von 01/2017 bis 12/2025
-- (108 Tage). Gezählt werden Personen (Feld Persons) in Artikeln mit dem
-- GDELT-Thema TAX_FNCACT_MUSICIAN. Die Zahlen sind Stichprobenwerte,
-- keine Gesamtzahlen pro Monat.
--
-- Hinweise:
-- - Das Thema markiert den Artikel, nicht die Person. Die Liste enthält
--   deshalb auch Nicht-Musiker (z. B. Politiker, Orte wie "los angeles").
-- - beispiel_url ist ein beliebiger Artikel (ANY_VALUE), kein Beleg dafür,
--   dass der Artikel vom Künstler handelt.
-- - Bands (z. B. Oasis) stehen nicht im Feld Persons.
--
-- Quelle: GDELT 2.0 Global Knowledge Graph (https://www.gdeltproject.org/data.html)
-- von The GDELT Project (https://www.gdeltproject.org/), genutzt gemäß den
-- GDELT Terms of Use (https://www.gdeltproject.org/about.html#termsofuse).

SELECT
  person,
  COUNT(*) AS artikel,
  COUNT(DISTINCT SUBSTR(CAST(DATE AS STRING), 1, 6)) AS monate_mit_treffer,
  MIN(DATE) AS erster_treffer,
  MAX(DATE) AS letzter_treffer,
  ANY_VALUE(DocumentIdentifier) AS beispiel_url
FROM `gdelt-bq.gdeltv2.gkg_partitioned`,
  UNNEST(SPLIT(Persons, ';')) AS person
WHERE DATE(_PARTITIONTIME) IN UNNEST(
        GENERATE_DATE_ARRAY('2017-01-15', '2025-12-15', INTERVAL 1 MONTH))
  AND Themes LIKE '%TAX_FNCACT_MUSICIAN%'
  AND person != ''
GROUP BY person
ORDER BY monate_mit_treffer DESC, artikel DESC
LIMIT 100
