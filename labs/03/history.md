# Task 6 · Die Geschichte eines Datensatzes

Repository: [datasets/co2-ppm](https://github.com/datasets/co2-ppm), Datei `data/co2-mm-mlo.csv` (monatliche CO₂-Werte, Mauna Loa, Daten von NOAA). Geklont am 12.11.2026 nach `~/co2-ppm`, neben meinem Lab-Repository.

## 1. Versionen

```bash
git log --oneline -- data/co2-mm-mlo.csv | wc -l
git log --format="%an" -- data/co2-mm-mlo.csv | sort | uniq -c
git log --format="%ad" --date=format:%Y -- data/co2-mm-mlo.csv | sort | uniq -c
```
```text
      48
  30 github-actions
   1 Joel
   1 Luccas Gomes
  15 Soren Jones
   1 subhankar
  10 2015
   4 2016
   2 2017
  10 2024
  11 2025
  11 2026
```

48 Commits haben die Datei geändert: 30 der Bot `github-actions`, 15 Soren Jones, je einer Joel, Luccas Gomes und subhankar. Von 2018 bis 2023 hat niemand die Datei aktualisiert. Zwischen `af2c0a6` (13.03.2017) und `ed48c9c` (13.02.2024) liegen fast sieben Jahre:

```text
ed48c9c 2024-02-13 Joel [data,github][s]: Add automatic updates of data - fixes #12.
af2c0a6 2017-03-13 subhankar [s] update date format from yyyy-mm to yyyy-mm-dd ref - #8
```

In dieser Zeit war der neueste Monat in der Datei Dezember 2016:

```bash
git show af2c0a6:data/co2-mm-mlo.csv | tail -1
```
```text
2016-12-01,2016.958,404.48,404.48,405.25,29
```

## 2. Der Tag, an dem die Daten verschwanden

```text
0c74626 2026-03-01 github-actions Commit from GitHub Actions (Update Data from NOAA)
 data/co2-mm-mlo.csv | 814 ----------------------------------------------------
```

```bash
git show 0c74626:data/co2-mm-mlo.csv | wc -l
git show 0c74626:data/co2-mm-mlo.csv
```
```text
       1
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
```

Das Update des Bots vom 01.03.2026 hat 814 Zeilen gelöscht, übrig blieb nur die Kopfzeile. Mein `get_data.sh` hätte an diesem Tag eine leere Tabelle heruntergeladen, ohne Fehlermeldung, weil die Datei selbst ja existierte.

Repariert hat es Luccas Gomes zwei Tage später, am 03.03.2026:

```text
4ae30e8 2026-03-03 Luccas Gomes fix: harden NOAA fetch and restore co2-mm-mlo output
```

```bash
git show 4ae30e8 -- scripts/process.sh
```
```diff
-  curl ftp://aftp.cmdl.noaa.gov/products/trends/co2/$file > tmp/$file
+  curl --fail --silent --show-error --location ftp://aftp.cmdl.noaa.gov/products/trends/co2/$file -o tmp/$file
+  if [ ! -s "tmp/$file" ]; then
+    echo "Download failed or empty file: $file" >&2
+    exit 1
+  fi
```

Das ist die Lektion aus Lab 2: Ein Skript soll bei einem fehlgeschlagenen Download abbrechen, statt mit leeren Daten weiterzumachen. Vorher hat `curl … >` auch bei einem Fehler eine Datei geschrieben. Jetzt sorgt `--fail` dafür, dass `curl` bei einem Fehler aufhört, und `[ ! -s … ]` prüft, ob die Datei leer ist, und beendet dann das Skript mit `exit 1`. In meinem `get_data.sh` mache ich das mit `curl -f … || exit 1`.

## 3. Alte Zahlen ändern sich

```bash
git show --stat 8c40972 | tail -6
```
```text
 data/co2-annmean-gl.csv |  40 +--
 data/co2-gr-gl.csv      |  48 +--
 data/co2-gr-mlo.csv     |   2 +-
 data/co2-mm-gl.csv      | 863 ++++++++++++++++++++++++------------------------
 data/co2-mm-mlo.csv     | 103 +++---
 5 files changed, 529 insertions(+), 527 deletions(-)
```

```bash
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep -c "^+[0-9]"
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep -c "^-[0-9]"
git diff 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep "^-[0-9]" | head -1
```
```text
52
51
-1982-12,1982.9583,340.78,341.70,26,0.30,0.11
```

Das Update vom 01.10.2026 hat 52 Datenzeilen hinzugefügt und 51 entfernt. Eine geänderte Zeile erscheint als eine entfernte und eine hinzugefügte. Es kam also 1 neuer Monat dazu (August 2026), und 51 bestehende Monate wurden geändert. Der älteste geänderte Monat ist Dezember 1982.

```bash
git diff --word-diff --word-diff-regex='[^,]+' 8c40972~1 8c40972 -- data/co2-mm-mlo.csv | grep "\[-" | head -3
```
```text
1982-12,1982.9583,340.78,[-341.70-]{+341.71+},26,0.30,0.11
1993-10,1993.7917,354.23,[-357.60-]{+357.61+},28,0.29,0.11
1995-07,1995.5417,361.78,[-361.10-]{+361.11+},28,0.36,0.13
```

Geändert hat sich jeweils nur der vierte Wert (der saisonbereinigte Wert), meistens um 0,01. Wer im September Mittelwerte oder Korrelationen berechnet hat, bekommt mit dem Oktober-Download leicht andere Ergebnisse, auch für Jahrzehnte alte Monate. Ohne die genaue Version kann niemand das Ergebnis nachrechnen.

## 4. Eine Kopfzeile, die nicht mehr passt

```bash
git show 8c40972:data/co2-mm-mlo.csv | head -2
git show af2c0a6:data/co2-mm-mlo.csv | head -2
```
```text
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
1958-03,1958.2027,315.71,314.44,-01,-9.99,-0.99
Date,Decimal Date,Average,Interpolated,Trend,Number of Days
1958-03-01,1958.208,315.71,315.71,314.62,-1
```

```bash
git show 8c40972:data/co2-mm-mlo.csv | head -1 | tr ',' '\n' | wc -l
git show 8c40972:data/co2-mm-mlo.csv | sed -n 2p | tr ',' '\n' | wc -l
git show ed48c9c~1:data/co2-mm-mlo.csv | sed -n 2p | tr ',' '\n' | wc -l
git show ed48c9c:data/co2-mm-mlo.csv | sed -n 2p | tr ',' '\n' | wc -l
```
```text
       6
       7
       6
       7
```

Die Kopfzeile hat 6 Namen, eine Datenzeile 7 Werte. 2017 passten noch 6 Namen zu 6 Werten. Seit dem Commit `ed48c9c` vom 13.02.2024 („Add automatic updates of data“) hat jede Zeile einen Wert mehr. Ein Programm ordnet die Werte dann falsch zu: Unter „Trend“ steht z. B. `-01`, und die siebte Spalte hat keinen Namen.

Auf GitHub ist das Problem bekannt: [Issue #18](https://github.com/datasets/co2-ppm/issues/18) „co2-mm-gl.csv and co2-mm-mlo.csv have incorrect number of header names vs columns“, eröffnet am 4. Mai 2026. Es ist noch offen. Es gibt einen verknüpften Pull Request, der aber noch nicht gemergt ist. Das Problem ist also noch nicht behoben.

## 5. Die eigene Version festhalten

```bash
git rev-parse 8c40972
```
```text
8c4097238570147adf6fa97ad357315528dac4c5
```

Diese URL liefert immer die Datei vom 01.10.2026:

```text
https://raw.githubusercontent.com/datasets/co2-ppm/8c4097238570147adf6fa97ad357315528dac4c5/data/co2-mm-mlo.csv
```

```bash
curl -fsSL https://raw.githubusercontent.com/datasets/co2-ppm/8c4097238570147adf6fa97ad357315528dac4c5/data/co2-mm-mlo.csv | tail -n 1
```
```text
2026-08,2026.6250,427.55,429.51,17,0.36,0.17
```

Mit `main` statt dem Hash würde die URL immer die neueste Version liefern, also nach jedem Update etwas anderes.

```bash
git checkout 0c74626
wc -l data/co2-mm-mlo.csv
git status | head -1
git switch main
```
```text
You are in 'detached HEAD' state. …
HEAD is now at 0c74626 Commit from GitHub Actions (Update Data from NOAA)
       1 data/co2-mm-mlo.csv
HEAD detached at 0c74626
Switched to branch 'main'
```

Am Tag des Datenverlusts hatte die Datei nur 1 Zeile. Git nennt den Zustand dazwischen **detached HEAD**: HEAD zeigt direkt auf einen Commit statt auf einen Branch.

## Fazit

In unserer Projekt-README notieren wir für jeden Datensatz das Abrufdatum und, wenn die Quelle in Git liegt, den vollen Commit-Hash bzw. eine URL mit diesem Hash statt `main`. Bei einem Portal ohne Git, wie in Lab 1 (z. B. GDELT oder Destatis), schreiben wir das Abrufdatum, die genaue Abfrage oder URL und eine Prüfsumme der heruntergeladenen Datei auf, so wie in meinem `get_data.sh`. Am sichersten ist es, die genaue Version, mit der wir gerechnet haben, selbst mit DOI zu veröffentlichen (z. B. auf Zenodo), damit sie sich nicht mehr ändern kann.