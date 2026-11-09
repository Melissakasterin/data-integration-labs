-- gdelt_pruefungen_deutschland_2017-2025.sql
-- Prüfabfragen, mit denen am 09.11.2026 der Deutschland-Filter und die
-- Suchmethode für das Gruppenprojekt (DIS 3.3) festgelegt wurden.
-- Ausgeführt in Google BigQuery (Sandbox), Projekt dis33-gdelt.
-- Jede Abfrage einzeln ausführen. Ergebnisdateien jeweils darunter angegeben.
--
-- Quelle: GDELT 2.0 Global Knowledge Graph (https://www.gdeltproject.org/data.html)
-- von The GDELT Project (https://www.gdeltproject.org/), genutzt gemäß den
-- GDELT Terms of Use (https://www.gdeltproject.org/about.html#termsofuse).


-- ===========================================================================
-- PRÜFLAUF 1: Sprachcode und Domain-Endungen an einem Tag (15.12.2025)
-- Ergebnis: pruefung_1_quellsprache_endung_2025-12-15.csv
-- Befund: Sprachcode für Deutsch ist "deu". Deutschsprachige Artikel:
--   .de 15.302 (76 %), .at 2.428 (12 %), andere 1.375 (7 %), .ch 953 (5 %).
--   Musik-Thema kommt auch in deutschen Artikeln vor (158 bei .de).
-- ===========================================================================
SELECT
  REGEXP_EXTRACT(TranslationInfo, r'srclc:([a-z]+)') AS quellsprache,
  CASE
    WHEN ENDS_WITH(LOWER(SourceCommonName), '.de') THEN '.de'
    WHEN ENDS_WITH(LOWER(SourceCommonName), '.at') THEN '.at'
    WHEN ENDS_WITH(LOWER(SourceCommonName), '.ch') THEN '.ch'
    ELSE 'andere'
  END AS endung,
  COUNT(*) AS artikel,
  COUNTIF(Themes LIKE '%TAX_FNCACT_MUSICIAN%') AS musik_artikel
FROM `gdelt-bq.gdeltv2.gkg_partitioned`
WHERE DATE(_PARTITIONTIME) = '2025-12-15'
GROUP BY quellsprache, endung
ORDER BY artikel DESC
LIMIT 40;


-- ===========================================================================
-- PRÜFLAUF 2: Deutschsprachige Quellen ohne .de/.at/.ch
-- 18 Stichtage (15. Januar und 15. Juli, 2017 bis 2025)
-- Ergebnis: pruefung_2_quellen_deutschsprachig_ohne_de.csv
-- Befund: Die 45 größten Quellen (90 % der Artikel) wurden von Hand zugeordnet.
--   Als deutsche Medien aufgenommen: faz.net, handelsblatt.com, dw.com,
--   finanzen.net, topagrar.com, agrarheute.com (Zuordnung nach Kenntnis,
--   Impressen nicht einzeln geöffnet). Ausgeschlossen: österreichische,
--   Südtiroler, luxemburgische, belgische, liechtensteinische u. a. Medien,
--   ausländische Staatsmedien, Aggregatoren (msn.com, yahoo.com),
--   Presseschauen und Pressemitteilungsportale, nicht zuordenbare Quellen.
-- ===========================================================================
SELECT
  LOWER(SourceCommonName) AS quelle,
  COUNT(*) AS artikel,
  COUNT(DISTINCT EXTRACT(YEAR FROM _PARTITIONTIME)) AS jahre_mit_artikeln
FROM `gdelt-bq.gdeltv2.gkg_partitioned`
WHERE DATE(_PARTITIONTIME) IN UNNEST(
        GENERATE_DATE_ARRAY('2017-01-15', '2025-07-15', INTERVAL 6 MONTH))
  AND REGEXP_EXTRACT(TranslationInfo, r'srclc:([a-z]+)') = 'deu'
  AND NOT ENDS_WITH(LOWER(SourceCommonName), '.de')
  AND NOT ENDS_WITH(LOWER(SourceCommonName), '.at')
  AND NOT ENDS_WITH(LOWER(SourceCommonName), '.ch')
GROUP BY quelle
ORDER BY artikel DESC
LIMIT 200;


-- ===========================================================================
-- VERWORFEN: Kandidatensuche Deutschland über das Feld Persons
-- 108 Stichtage, Deutschland-Filter, Musik-Thema, Namen aus Persons
-- Ergebnis: gdelt_kandidaten_stichprobe_deutschland_persons_2017-2025.csv
-- Befund: Namen werden bei der maschinellen Übersetzung verfälscht
--   (z. B. "pietro lombard", "jrgen andrews", "helene fischler").
--   Deshalb nicht für die Auswahl verwendet.
-- ===========================================================================
SELECT
  person,
  COUNT(DISTINCT DocumentIdentifier) AS artikel,
  COUNT(DISTINCT FORMAT_DATE('%Y-%m', DATE(_PARTITIONTIME))) AS monate_mit_treffer,
  MIN(DATE(_PARTITIONTIME)) AS erster_treffer,
  MAX(DATE(_PARTITIONTIME)) AS letzter_treffer,
  COUNT(DISTINCT LOWER(SourceCommonName)) AS anzahl_quellen,
  ANY_VALUE(DocumentIdentifier) AS beispiel_url
FROM `gdelt-bq.gdeltv2.gkg_partitioned`,
  UNNEST(SPLIT(Persons, ';')) AS person
WHERE DATE(_PARTITIONTIME) IN UNNEST(
        GENERATE_DATE_ARRAY('2017-01-15', '2025-12-15', INTERVAL 1 MONTH))
  AND REGEXP_EXTRACT(TranslationInfo, r'srclc:([a-z]+)') = 'deu'
  AND (
    ENDS_WITH(LOWER(SourceCommonName), '.de')
    OR LOWER(SourceCommonName) IN ('faz.net', 'handelsblatt.com', 'dw.com',
                                   'finanzen.net', 'topagrar.com', 'agrarheute.com')
  )
  AND Themes LIKE '%TAX_FNCACT_MUSICIAN%'
  AND person != ''
GROUP BY person
ORDER BY monate_mit_treffer DESC, artikel DESC
LIMIT 200;


-- ===========================================================================
-- METHODENTEST: Persons vs. URL vs. Seitentitel für 7 Testkünstler
-- 108 Stichtage, Deutschland-Filter, ohne Musik-Thema
-- Ergebnis: pruefung_3_methodentest_namenssuche.csv
-- Befund: Persons findet nur einen Bruchteil (z. B. Taylor Swift 103 vs.
--   954 über URL oder Titel, Pietro Lombardi 0 vs. 493). Seitentitel liegen
--   im deutschen Original vor. Gewählte Methode: URL ODER Titel.
-- ===========================================================================
WITH basis AS (
  SELECT
    DocumentIdentifier AS url,
    LOWER(DocumentIdentifier) AS url_klein,
    LOWER(IFNULL(REGEXP_EXTRACT(Extras, r'<PAGE_TITLE>(.*?)</PAGE_TITLE>'), '')) AS titel,
    SPLIT(Persons, ';') AS personen
  FROM `gdelt-bq.gdeltv2.gkg_partitioned`
  WHERE DATE(_PARTITIONTIME) IN UNNEST(
          GENERATE_DATE_ARRAY('2017-01-15', '2025-12-15', INTERVAL 1 MONTH))
    AND REGEXP_EXTRACT(TranslationInfo, r'srclc:([a-z]+)') = 'deu'
    AND (
      ENDS_WITH(LOWER(SourceCommonName), '.de')
      OR LOWER(SourceCommonName) IN ('faz.net', 'handelsblatt.com', 'dw.com',
                                     'finanzen.net', 'topagrar.com', 'agrarheute.com')
    )
),
kuenstler AS (
  SELECT * FROM UNNEST([
    STRUCT('Taylor Swift' AS artist, 'taylor swift' AS name, 'taylor-swift' AS slug),
    ('Elton John', 'elton john', 'elton-john'),
    ('Lady Gaga', 'lady gaga', 'lady-gaga'),
    ('Ed Sheeran', 'ed sheeran', 'ed-sheeran'),
    ('Bruce Springsteen', 'bruce springsteen', 'bruce-springsteen'),
    ('Helene Fischer', 'helene fischer', 'helene-fischer'),
    ('Pietro Lombardi', 'pietro lombardi', 'pietro-lombardi')
  ])
)
SELECT
  k.artist,
  COUNT(DISTINCT IF(k.name IN UNNEST(b.personen), b.url, NULL)) AS treffer_persons,
  COUNT(DISTINCT IF(STRPOS(b.url_klein, k.slug) > 0, b.url, NULL)) AS treffer_url,
  COUNT(DISTINCT IF(STRPOS(b.titel, k.name) > 0, b.url, NULL)) AS treffer_titel,
  COUNT(DISTINCT IF(STRPOS(b.url_klein, k.slug) > 0
                    OR STRPOS(b.titel, k.name) > 0, b.url, NULL)) AS treffer_url_oder_titel,
  ANY_VALUE(IF(STRPOS(b.titel, k.name) > 0, b.titel, NULL)) AS beispiel_titel
FROM basis b
CROSS JOIN kuenstler k
GROUP BY k.artist
ORDER BY k.artist;
