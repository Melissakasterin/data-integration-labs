# Lab 3 · Version Control Software

## Inhalt

| Datei | Task |
| --- | --- |
| [graph.md](graph.md), [git-graph.png](git-graph.png) | Task 1 · Commit-Graph |
| [git.md](git.md) | Task 2–4 · Git im Lab-Repository |
| [get_data.sh](get_data.sh) | Task 3 · Download-Skript aus Lab 2 |
| [team.md](team.md) | Task 7 · Roadmap über Pull Requests |

## Rohdaten wiederherstellen

Die Rohdaten liegen nicht im Repository. `data/raw/` steht in der [.gitignore](.gitignore), weil man die Dateien jederzeit neu herunterladen kann. So bekommt man sie zurück:

```bash
cd labs/03
./get_data.sh
```

Danach liegen in `labs/03/data/raw/`:

| Datei | Inhalt |
| --- | --- |
| `20261102181500.gkg.csv.zip` | GDELT-GKG-Datei, wie heruntergeladen |
| `20261102181500.gkg.csv` | entpackte GDELT-Datei (1.599 Zeilen, 27 Spalten, 21.037.577 Bytes) |
| `pageviews_taylor_swift.json` | Wikimedia Pageviews für Taylor Swift, Juli bis Oktober 2026 |
| `SOURCES.txt` | Zeitpunkt, URL und Zieldatei jedes Downloads |

Am Ende gibt das Skript eine Prüfsumme der GDELT-ZIP-Datei aus. Am 12.11.2026 war sie:

```text
0c95a6d68f0d0cbddb6f1cf7c731374bda28ad11
```

Steht dort eine andere Zahl, hat sich die Datei bei GDELT seitdem verändert.

## Quellen und Lizenzen

- [GDELT 2.0 Global Knowledge Graph](https://www.gdeltproject.org/data.html) von [The GDELT Project](https://www.gdeltproject.org/), genutzt gemäß den [GDELT Terms of Use](https://www.gdeltproject.org/about.html#termsofuse)
- [Pageviews](https://wikimedia.org/api/rest_v1/) von der Wikimedia Foundation, [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)