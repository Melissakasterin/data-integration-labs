-- gdelt_kandidaten_stichprobe_deutschland_2017-2025.sql
-- Zweck: Kandidaten für die Künstlerauswahl, nur deutsche Nachrichtenquellen
-- (DIS 3.3, Gruppenprojekt). Dient nur der Auswahl, keine vollständigen Monatswerte.
-- Ergebnis: gdelt_kandidaten_stichprobe_deutschland_2017-2025.csv (22 Zeilen)
--
-- Ausgeführt: 09.11.2026 in Google BigQuery (Sandbox), Projekt dis33-gdelt
--
-- STICHPROBE: jeweils der 15. jedes Monats, 01/2017 bis 12/2025 (108 Tage).
-- monate_mit_treffer ist daher höchstens 108.
--
-- DEUTSCHLAND-FILTER (identisch in allen Deutschland-Abfragen):
--   Originalsprache Deutsch (TranslationInfo srclc:deu)
--   UND Quelle endet auf .de ODER ist eines von 6 geprüften deutschen Medien
--   ohne .de (faz.net, handelsblatt.com, dw.com, finanzen.net, topagrar.com,
--   agrarheute.com). Abgeleitet aus zwei Prüfläufen am 09.11.2026:
--   - 15.12.2025: deutschsprachige Artikel nach Endung (.de 76 %, .at 12 %,
--     andere 7 %, .ch 5 %)
--   - 18 Stichtage (Jan./Juli 2017-2025): deutschsprachige Quellen ohne
--     .de/.at/.ch, die 45 größten von Hand zugeordnet. Österreichische,
--     Südtiroler, luxemburgische u. a. Medien, Aggregatoren (msn.com,
--     yahoo.com) und Presseschauen ausgeschlossen.
--
-- SUCHMETHODE: Name im deutschen Original, d. h. in der URL (mit Bindestrich)
-- ODER im Seitentitel (Extras, PAGE_TITLE; Umlaute in ae/oe/ue/ss umgewandelt).
-- Gezählt werden verschiedene URLs.
-- Nicht über das Feld Persons: Ein Methodentest am 09.11.2026 zeigte, dass
-- Persons in deutschen Artikeln einen Großteil der Treffer übersieht, weil
-- Namen bei der maschinellen Übersetzung verfälscht werden (z. B. Taylor Swift
-- 103 statt 954 Treffer, Pietro Lombardi 0 statt 493).
--
-- KANDIDATEN (Spalte herkunft):
--   W = aus der weltweiten Stichprobe (lebende, aktive Musiker)
--   D = aus der deutschen Persons-Stichprobe (Namen korrigiert)
--   G = Vorschlag aus der Gruppe
--
-- EINSCHRÄNKUNGEN:
-- - Artikel, die den Namen nur im Fließtext nennen, werden nicht gezählt.
-- - Themen- oder Übersichtsseiten mit dem Namen in der URL können mitzählen.
-- - Mehrdeutige Namen (z. B. "Oasis") können Fehltreffer liefern.
-- - Deutsche Medien ohne .de, die nicht auf der Liste stehen, fehlen.
--
-- Quelle: GDELT 2.0 Global Knowledge Graph (https://www.gdeltproject.org/data.html)
-- von The GDELT Project (https://www.gdeltproject.org/), genutzt gemäß den
-- GDELT Terms of Use (https://www.gdeltproject.org/about.html#termsofuse).

WITH basis AS (
  SELECT
    DocumentIdentifier AS url,
    LOWER(DocumentIdentifier) AS url_klein,
    DATE(_PARTITIONTIME) AS tag,
    LOWER(SourceCommonName) AS quelle,
    REPLACE(REPLACE(REPLACE(REPLACE(
      LOWER(IFNULL(REGEXP_EXTRACT(Extras, r'<PAGE_TITLE>(.*?)</PAGE_TITLE>'), '')),
      '&#xe4;', 'ae'), '&#xf6;', 'oe'), '&#xfc;', 'ue'), '&#xdf;', 'ss') AS titel
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
    STRUCT('Taylor Swift' AS artist, 'taylor swift' AS name, 'taylor-swift' AS slug, 'W' AS herkunft),
    ('Elton John', 'elton john', 'elton-john', 'W'),
    ('Lady Gaga', 'lady gaga', 'lady-gaga', 'W'),
    ('Ed Sheeran', 'ed sheeran', 'ed-sheeran', 'W'),
    ('Bruce Springsteen', 'bruce springsteen', 'bruce-springsteen', 'W'),
    ('Bob Dylan', 'bob dylan', 'bob-dylan', 'W'),
    ('Justin Bieber', 'justin bieber', 'justin-bieber', 'W'),
    ('Paul McCartney', 'paul mccartney', 'paul-mccartney', 'W'),
    ('Ariana Grande', 'ariana grande', 'ariana-grande', 'W'),
    ('Billie Eilish', 'billie eilish', 'billie-eilish', 'W'),
    ('Harry Styles', 'harry styles', 'harry-styles', 'W'),
    ('Dua Lipa', 'dua lipa', 'dua-lipa', 'W'),
    ('Helene Fischer', 'helene fischer', 'helene-fischer', 'D'),
    ('Pietro Lombardi', 'pietro lombardi', 'pietro-lombardi', 'D'),
    ('Giovanni Zarrella', 'giovanni zarrella', 'giovanni-zarrella', 'D'),
    ('Juergen Drews', 'juergen drews', 'juergen-drews', 'D'),
    ('Stefanie Hertel', 'stefanie hertel', 'stefanie-hertel', 'D'),
    ('Lena Meyer-Landrut', 'lena meyer-landrut', 'lena-meyer-landrut', 'D'),
    ('Herbert Groenemeyer', 'herbert groenemeyer', 'groenemeyer', 'D'),
    ('Andreas Gabalier', 'andreas gabalier', 'andreas-gabalier', 'D'),
    ('Florian Silbereisen', 'florian silbereisen', 'florian-silbereisen', 'D'),
    ('Oasis', 'oasis', 'oasis', 'G')
  ])
)
SELECT
  k.artist,
  k.herkunft,
  COUNT(DISTINCT b.url) AS artikel,
  COUNT(DISTINCT FORMAT_DATE('%Y-%m', b.tag)) AS monate_mit_treffer,
  MIN(b.tag) AS erster_treffer,
  MAX(b.tag) AS letzter_treffer,
  COUNT(DISTINCT b.quelle) AS anzahl_quellen,
  ANY_VALUE(b.url) AS beispiel_url,
  ANY_VALUE(b.titel) AS beispiel_titel
FROM basis b
JOIN kuenstler k
  ON STRPOS(b.url_klein, k.slug) > 0 OR STRPOS(b.titel, k.name) > 0
GROUP BY k.artist, k.herkunft
ORDER BY monate_mit_treffer DESC, artikel DESC
