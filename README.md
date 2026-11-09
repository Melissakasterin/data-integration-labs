# Data Integration Labs

My repository for the Lab assignments in Data Integration.

Melissa Kasterin ([Melissakasterin](https://github.com/Melissakasterin)) · [Course repository](https://github.com/breuert/data-integration)

## Labs

| Lab | Description |
|---|---|
| [Lab 01](labs/01/) | Open Source Software and Open Data |
| [Lab 02](labs/02/) | Command Line Interface |

### Lab 01 Files

- [Markdown Cheatsheet](labs/01/cheatsheet.md)

## Gruppenprojekt: GDELT als Datenquelle

Stand: 09.11.2026

### Worum es geht

Im Gruppenprojekt (DIS 3.3) untersuchen wir den Zusammenhang zwischen Online-Aufmerksamkeit, Medienberichterstattung und der relativen Preisentwicklung von Kulturangeboten in Deutschland. Das gemeinsame Repository ist [Esmaa21/Data-Integration-3.3](https://github.com/Esmaa21/Data-Integration-3.3).

Bisherige Forschungsfrage:

> Gehen Veränderungen der Online-Aufmerksamkeit (Aufrufe deutschsprachiger Wikipedia-Artikel ausgewählter Künstler) und der Medienberichterstattung (Anzahl GDELT-Nachrichtenartikel zu diesen Künstlern) mit Veränderungen des relativen Preisindex für den Besuch von Kino, Theater, Konzert und Zirkus (Destatis CC13-09421 geteilt durch den VPI-Gesamtindex) in Deutschland von 2017 bis 2025 einher?

Untersuchungszeitraum: 01/2017 bis 12/2025, monatlich.

### Meine Datenquelle

Ich bearbeite den **GDELT 2.0 Global Knowledge Graph (GKG)**. Er liefert die Medienberichterstattung, also wie oft ein Künstler in Nachrichtenartikeln vorkommt. Das ausführliche Datensatzprofil steht in [labs/01/dataset.md](labs/01/dataset.md).

### Was ich bisher gemacht habe

| Schritt | Datum | Ergebnis | Datei |
|---|---|---|---|
| Datensatzprofil, FAIR-Prüfung, Kombinationsplan (Lab 1) | 03.11.2026 | Profil von GDELT anhand einer 15-Minuten-Datei vom 02.11.2026 | [labs/01/dataset.md](labs/01/dataset.md) |
| Testabruf per Skript (Lab 2) | 04.11.2026 | Eine GKG-Datei und ein Pageviews-Test für Taylor Swift heruntergeladen und geprüft | [labs/02/get_data.sh](labs/02/get_data.sh), [labs/02/get_data.txt](labs/02/get_data.txt) |
| Kandidatensuche in BigQuery | 09.11.2026 | Liste von 100 Personen aus Musik-Artikeln, Stichprobe 2017–2025 | [data/gdelt_kandidaten_stichprobe_2017-2025.csv](data/gdelt_kandidaten_stichprobe_2017-2025.csv), [data/gdelt_kandidaten_stichprobe_2017-2025.sql](data/gdelt_kandidaten_stichprobe_2017-2025.sql) |

Die heruntergeladenen Rohdaten (`data/raw/`) liegen nur lokal und sind nicht im Repository.

### Kandidatensuche: wie sie funktioniert

Ziel: Künstler finden, die über den ganzen Zeitraum tatsächlich in GDELT vorkommen, statt sie nach Bekanntheit auszuwählen.

- **Werkzeug:** Google BigQuery (Sandbox), Tabelle `gdelt-bq.gdeltv2.gkg_partitioned`. Die Abfrage hat 25,22 GB verarbeitet.
- **Stichprobe:** jeweils der 15. jedes Monats von 01/2017 bis 12/2025, also 108 Tage.
- **Filter:** nur Artikel mit dem GDELT-Thema `TAX_FNCACT_MUSICIAN`. Gezählt werden die Namen im Feld `Persons`.
- **Ergebnis:** 100 Personen mit Trefferzahl, Anzahl der Monate mit Treffer (höchstens 108), erstem und letztem Treffer und einer Beispiel-URL.

**Was die Stichprobe aussagt:** welche Namen in Musik-Artikeln regelmäßig über den ganzen Zeitraum vorkommen. Taylor Swift ist z. B. in 97 von 108 Stichtagen vertreten.

**Was sie nicht abdeckt:**

- Es sind **keine vollständigen Monatswerte**, sondern Zählungen an einem Tag pro Monat.
- Die Liste enthält auch **Nicht-Musiker**, weil das Thema den Artikel markiert und nicht die Person: Orte wie `los angeles` und `las vegas`, Politiker und andere Prominente.
- Die `beispiel_url` ist ein beliebiger Artikel und **kein Beleg**, dass der Artikel vom Künstler handelt.
- **Bands** fehlen, weil sie nicht im Feld `Persons` stehen (z. B. Oasis).
- Die Treffer stammen aus weltweiten Nachrichten in allen Sprachen, nicht nur aus Deutschland.

### Vorschlag zur Abstimmung (nicht beschlossen)

Aus der Stichprobe habe ich fünf lebende, aktive Musiker mit hoher Abdeckung vorgeschlagen. **Die Gruppe hat darüber noch nicht entschieden.**

| Künstler | Treffer (Stichprobe) | Monate mit Treffer |
|---|---|---|
| Taylor Swift | 2.308 | 97 / 108 |
| Elton John | 1.263 | 100 / 108 |
| Lady Gaga | 1.072 | 88 / 108 |
| Ed Sheeran | 1.041 | 92 / 108 |
| Bruce Springsteen | 651 | 92 / 108 |

Alternativen: Bob Dylan (1.170 / 104), Justin Bieber (963 / 92), Paul McCartney (821 / 100).

### Offene Punkte

- [ ] **Künstlerauswahl:** finale Auswahl der fünf Künstler durch die Gruppe. Klären, ob eine Band wie Oasis dabei sein soll, denn dafür braucht es eine eigene Abfrage über `Organizations`.
- [ ] **Fehlzuordnungen prüfen:** für jeden gewählten Künstler eine Stichprobe von Artikeln öffnen und prüfen, ob sie wirklich vom Künstler handeln.
- [ ] **Geografische und sprachliche Einschränkung:** entscheiden, ob alle Nachrichten weltweit zählen oder nur deutsche Quellen bzw. deutschsprachige Artikel. Das soll zur deutschsprachigen Wikipedia in der Forschungsfrage passen. `dataset.md` (Stand Lab 1) plant noch mit englischen Artikeln und `en.wikipedia`.
- [ ] **Lücke Juni 2025:** GDELT hatte von etwa 15.06. bis 01.07.2025 einen Ausfall. Dieser Monat muss markiert oder ausgeschlossen werden.
- [ ] **Normierung:** Trefferzahlen durch die Gesamtzahl der GKG-Artikel im Monat teilen, weil die Nachrichtenmenge schwankt.
- [ ] **Vollständige Datenerhebung:** nach der Abstimmung die Artikel pro Künstler und Monat für 01/2017 bis 12/2025 vollständig zählen, ohne Stichprobe. Vorher einen Dry Run machen, um die Datenmenge zu prüfen.
- [ ] **Doppelte Artikel:** mögliche Duplikate markieren, z. B. denselben Artikel auf mehreren Websites, wie in `dataset.md` beschrieben.

### Quelle

[GDELT 2.0 Global Knowledge Graph](https://www.gdeltproject.org/data.html) von [The GDELT Project](https://www.gdeltproject.org/), genutzt gemäß den [GDELT Terms of Use](https://www.gdeltproject.org/about.html#termsofuse). Für unser Projekt gezählt und zusammengefasst.

## License

Code in this repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details. Data from other sources keeps its own licence.

## Profile

[My GitHub profile](https://github.com/Melissakasterin)
