# Task 2–4 · Git im Lab-Repository

## Setup

### Anzahl und Ort der Commits

```bash
git log --oneline | wc -l
```
```text
62
```

Mein Repository hat 62 Commits. Alle habe ich im Browser auf GitHub gemacht (Dateien hochgeladen oder dort bearbeitet), keinen vom Terminal aus. Das zeigt auch der Committer: Bei allen 62 Commits steht `GitHub`.

```bash
git log --format="%cn" | sort | uniq -c
```
```text
   62 GitHub
```

### Commit-Messages von GitHub

Viele Messages hat GitHub automatisch erzeugt, z. B. `Update shell.md`, `Update cheatsheet.md`, `Update open-source.md` und mehrere `Rename … to data/…`. Sie sagen nur, welche Datei betroffen war, aber nicht, was und warum.

| Commit | Alte Message | Neue Message |
| --- | --- | --- |
| `3187815` | `Update shell.md` | `Fix bashcrawl command explanation and document unread scrolls` |
| `dfd9348` | `Update gdelt_kandidaten_stichprobe_deutschland_persons_2017-2025.csv` | `Move persons candidate CSV into data/ to keep all GDELT files together` |

Beim zweiten Commit klingt die alte Message, als hätte sich der Inhalt geändert. Tatsächlich wurde die Datei nur nach `data/` verschoben und am Dateiende ein fehlender Zeilenumbruch ergänzt (`\ No newline at end of file` im Diff). Die Geschichte habe ich nicht verändert.

### E-Mail-Adresse

```bash
git log --format="%h %ae %s" | head -5
```
```text
8f14ed1 melissa.kasterin@smail.th-koeln.de Rename pruefung_3_methodentest_namenssuche.csv to data/pruefung_3_methodentest_namenssuche.csv
2600dee melissa.kasterin@smail.th-koeln.de Rename pruefung_2_quellen_deutschsprachig_ohne_de.csv to data/pruefung_2_quellen_deutschsprachig_ohne_de.csv
61cc405 melissa.kasterin@smail.th-koeln.de Rename pruefung_1_quellsprache_endung_2025-12-15.csv to data/pruefung_1_quellsprache_endung_2025-12-15.csv
3fc91d1 melissa.kasterin@smail.th-koeln.de Rename gdelt_pruefungen_deutschland_2017-2025.sql to data/gdelt_pruefungen_deutschland_2017-2025.sql
dfd9348 melissa.kasterin@smail.th-koeln.de Update gdelt_kandidaten_stichprobe_deutschland_persons_2017-2025.csv
```

Alle 62 Commits tragen meine Uni-Adresse. Sie ist damit öffentlich, in jedem Klon meines Repositorys. Mit **Keep my email addresses private** und der `noreply`-Adresse in `git config` bekommen ab jetzt alle neuen Commits die Adresse `346924907+Melissakasterin@users.noreply.github.com`. Die alten Commits kann das nicht ändern: Dafür müsste ich die Geschichte neu schreiben, und wer das Repository schon geklont hat, hat die Adresse ohnehin.

### Am häufigsten geänderte Dateien

```bash
git log --name-only --format="" | sort | uniq -c | sort -rn | head -5
```
```text
  13 labs/01/cheatsheet.md
   9 labs/01/open-source.md
   8 AI_USAGE.md
   7 README.md
   3 labs/02/shell.md
```

### Erster Commit vom Computer

```bash
git add labs/03/graph.md labs/03/git-graph.png
git commit -m "Add commit graph predictions and screenshot for Lab 3 Task 1"
git push
```
```text
To https://github.com/Melissakasterin/data-integration-labs.git
   8f14ed1..5657d76  main -> main
```

`git status` nach dem Push:
```text
On branch main
Your branch is up to date with 'origin/main'.
```

Den `git status` vor dem Push habe ich bei diesem Commit vergessen. Ich habe ihn beim nächsten Push nachgeholt (siehe unten).

Mein Avatar steht auf GitHub neben dem Commit `5657d76`, weil die `noreply`-Adresse mit meinem Profil verknüpft ist. Anders als meine früheren Browser-Commits hat er kein „Verified“: Die hat GitHub beim Erstellen im Browser signiert, auf meinem Computer habe ich keine Signatur eingerichtet.