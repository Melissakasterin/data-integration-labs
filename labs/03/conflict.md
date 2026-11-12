# Task 5 · Konflikt

## Datei nach dem Merge

```text
<<<<<<< HEAD
name,iso3,iso2,numeric
Czech Republic,CZE,CZ,203
Germany,DEU,DE,276
Macedonia,MKD,MK,807
Swaziland,SWZ,SZ,748
Turkey,TUR,TR,792
=======
name,iso3,iso2
Czechia,CZE,CZ
Germany,DEU,DE
North Macedonia,MKD,MK
Eswatini,SWZ,SZ
Türkiye,TUR,TR
>>>>>>> feature/new-names
```

## Was ein Programm sehen würde

```bash
cut -d, -f1 countries.csv
```
```text
<<<<<<< HEAD
name
Czech Republic
Germany
Macedonia
Swaziland
Turkey
=======
name
Czechia
Germany
North Macedonia
Eswatini
Türkiye
>>>>>>> feature/new-names
```

Ein Programm, das die CSV liest, würde 13 statt 5 Länder sehen: jedes Land zweimal (mit altem und neuem Namen), zwei Kopfzeilen und die Konfliktmarker `<<<<<<< HEAD`, `=======` und `>>>>>>> feature/new-names` als Ländernamen. Eine Auswertung wäre damit falsch, ohne dass ein Fehler gemeldet wird.

## Lösung

Ich habe beide Versionen Zeile für Zeile kombiniert: die neuen Namen aus `feature/new-names` und die Spalte `numeric` aus `main`. Danach gab `grep -c -E "^(<<<<<<<|=======|>>>>>>>)" countries.csv` den Wert `0` aus, und `cut -d, -f4 countries.csv` zeigte in jeder Zeile einen Code.

```bash
git log --oneline --graph -8
```
```text
*   3445a1d (HEAD -> main) Merge branch 'feature/new-names'
|\
| * e9689ad Use current country names
* | 25ba1bb Add ISO numeric country codes
|/
* 9b8ac00 Add ISO2 country codes
* d25de3a Add country mapping table with ISO3 codes
* 64d3645 (origin/main, origin/HEAD) Document the four rescues of Task 4 in git.md
* 5686327 Revert "Switch GDELT file to 2016"
* 8296de0 Switch GDELT file to 2016
```

## Fragen

**Die beiden Branches haben verschiedene Spalten geändert. Warum meldet Git trotzdem einen Konflikt?**
Git vergleicht Dateien zeilenweise, nicht spaltenweise. In einer CSV-Datei ist jede Zeile ein ganzer Datensatz. `main` hat an jede Zeile `,numeric` bzw. einen Code angehängt, `feature/new-names` hat in vier Zeilen den Namen geändert. Damit haben beide Branches dieselben Zeilen verändert, und Git kann nicht selbst entscheiden, welche Version richtig ist.

**Warum gehören *Germany* und die Kopfzeile zum Konflikt, obwohl nur ein Branch sie geändert hat?**
Die Kopfzeile und *Germany* hat nur `main` geändert (neue Spalte), `feature/new-names` nicht. Sie liegen aber direkt zwischen Zeilen, die beide Branches geändert haben. Git fasst nebeneinanderliegende Änderungen zu einem Block zusammen. Weil der Block insgesamt in beiden Branches anders ist, zeigt Git ihn als einen einzigen Konflikt.

**Wie könnte unser Team solche Konflikte in einer gemeinsamen Datendatei vermeiden?**
- Vor der Arbeit `git pull` machen und Branches kurz halten, also schnell mergen
- Absprechen, wer gerade an welcher Datei arbeitet, z. B. über ein Issue
- Spalten nicht gleichzeitig in verschiedenen Branches hinzufügen, sondern nacheinander
- Die Datei nicht von Hand bearbeiten, sondern mit einem Skript erzeugen. Dann ändert man nur das Skript, und die Datei wird neu erzeugt.