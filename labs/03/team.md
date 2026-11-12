# Task 7 · Roadmap über Pull Requests

Gruppenrepository: [Esmaa21/Data-Integration-3.3](https://github.com/Esmaa21/Data-Integration-3.3)

## Links

| Was | Link |
| --- | --- |
| Mein Issue | [#1 Zeitraum in der README vereinheitlichen und F3 klären](https://github.com/Esmaa21/Data-Integration-3.3/issues/1) |
| Mein Pull Request (Zeitraum) | [#2](https://github.com/Esmaa21/Data-Integration-3.3/pull/2) |
| Mein Pull Request (F3) | [#NUMMER](https://github.com/Esmaa21/Data-Integration-3.3/pull/NUMMER) |
| Pull Request, den ich reviewt habe | OFFEN |

## Commit-Graph

Stand am 12.11.2026, 21:17 Uhr, nach `git switch main` und `git pull`:

```bash
git log --oneline --graph -15
```
```text
* e26357d (HEAD -> main, origin/main, origin/HEAD) Add entry for highest-grossing concert tours
* 7069073 Update README.md
*   cf18fe5 Merge pull request #8 from Esmaa21/feature/4-lizenzen
|\
| * aff378f Revise milestone status and licensing information
| * 5d52d51 (origin/feature/4-lizenzen) Revise licensing details and data source acknowledgments
* |   04ae132 Merge pull request #3 from Esmaa21/feature/1-zeitraum
|\ \
| |/
|/|
| * aa92c7b (origin/feature/1-zeitraum) Platzhalter F3 aus der README entfernen, zwei Forschungsfragen reichen für Meilenstein 1
* | 9362b18 Merge pull request #2 from Esmaa21/feature/1-zeitraum
|\|
| * ccc3e58 Zeitraum in der README auf 2017–2025 vereinheitlichen, wie in der Gruppe beschlossen
|/
* beaf10d Revise Destatis licenses in README
* 0535bde New entry for AI Usage
* 165c7ea Update HICP entry with additional author information
* 5906bb5 Update README.md
* f12e19b Update AI_USAGE.md
* 56ec732 Update AI_USAGE.md
```

Meine beiden Commits `ccc3e58` und `aa92c7b` liegen auf dem Branch `feature/1-zeitraum` und kamen über die Merge-Commits von PR #2 und PR #3 nach `main`. Die beiden obersten Commits wurden direkt auf `main` gemacht, nicht über einen Pull Request.

## Reflexion

**Mein Review-Kommentar:** Bei Tanjas PR #8 habe ich an Zeile 155 kommentiert, dass Prof. Breuer GDELT und CC BY 4.0 zwar erlaubt, aber verlangt, dass die Lizenz keine Rechte Dritter oder an den Nachrichtenartikeln überträgt. Außerdem habe ich angemerkt, dass in der PR-Beschreibung „Roadmap-Häkchen angepasst“ stand, die Häkchen aber nicht geändert waren. Ich habe „Request changes“ gewählt. Tanja hat beides korrigiert, danach habe ich approved.

**Konflikt:** In unserem Gruppenrepository hatte ich keinen Merge-Konflikt, weil die PRs nacheinander gemergt wurden und verschiedene Abschnitte der README geändert haben. Es gab aber einen ähnlichen Fall: Idman hat PR #2 gemergt, kurz bevor mein zweiter Commit ankam. Dadurch fehlte er in `main`, und ich habe ihn über PR #3 nachgereicht. Einen echten Konflikt habe ich in Task 5 mit `countries.csv` gelöst.

**Teamregel für den Rest des Semesters:** Niemand committet direkt auf `main`. Jede Änderung kommt über einen Branch und einen Pull Request mit mindestens einem Review, und gemergt wird von der Person, die den PR erstellt hat, erst nach dem Approve. Vor dem Arbeiten machen alle `git pull`.