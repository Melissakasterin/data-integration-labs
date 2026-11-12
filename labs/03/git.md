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

### `git status` vor und nach dem Push

Nachgeholt beim Commit `ce206b8` (diese Datei).

Vor dem Push:
```text
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)
```

```text
To https://github.com/Melissakasterin/data-integration-labs.git
   5657d76..ce206b8  main -> main
```

Nach dem Push:
```text
On branch main
Your branch is up to date with 'origin/main'.
```

Vor dem Push ist mein lokales `main` einen Commit weiter als `origin/main` auf GitHub. Nach dem Push sind beide auf demselben Stand.


## Step by step

Ich habe mein Download-Skript aus Lab 2 nach `labs/03` kopiert und Schritt für Schritt unter Versionskontrolle gestellt. Jeder Commit enthält genau eine Änderung:

```bash
git log --oneline -- .
```
```text
45b7be7 (HEAD -> main) Add Lab 3 README explaining how to restore the raw data
593a2b3 Print a checksum of the downloaded GDELT file to detect changes at the source
418308c Explain in the header where to run the script and where files are saved
d78fa19 Ignore data/raw/ so downloaded raw data stays out of the repository
24e3a3c Copy the download script from lab 2
9628a89 (origin/main, origin/HEAD) Fill in predictions and answers for all four rounds in graph.md
8f25c3d Add git status before and after push to git.md
ce206b8 Document Git setup, commit history and e-mail check for Lab 3 Task 2
5657d76 Add commit graph predictions and screenshot for Lab 3 Task 1
```

Nach dem ersten Lauf von `./get_data.sh` hat `git status` den Ordner `data/` als „Untracked“ angezeigt. Mit `data/raw/` in der `.gitignore` ist er verschwunden. Git ignoriert ihn jetzt:

```bash
git status --ignored
```
```text
Ignored files:
  (use "git add -f <file>..." to include in what will be committed)
	data/
```

`git check-ignore -v data/raw/*` zeigt, welche Regel jede Datei ignoriert:

```text
labs/03/.gitignore:1:data/raw/	data/raw/20261102181500.gkg.csv
labs/03/.gitignore:1:data/raw/	data/raw/20261102181500.gkg.csv.zip
labs/03/.gitignore:1:data/raw/	data/raw/pageviews_taylor_swift.json
labs/03/.gitignore:1:data/raw/	data/raw/SOURCES.txt
```

Den Kommentar im Kopf des Skripts und die Prüfsumme am Ende habe ich gleichzeitig geändert, aber mit `git add -p` getrennt committet: beim ersten Abschnitt `y`, beim zweiten `n`. Vor dem ersten Commit hat `git diff --staged` nur die Kommentarzeile gezeigt.


## Rescue

### 1. Änderung in der Datei verwerfen (`git restore`)

Ich habe in `get_data.sh` die Zeile `head -c 300 "$pageviews_target"` gelöscht und gespeichert. `git diff` zeigte sie rot mit `-`. Mit `git restore get_data.sh` kam die Datei aus dem letzten Commit zurück, danach war `git diff` leer.

### 2. Änderung aus dem Staging-Bereich holen (`git restore --staged`)

```bash
echo "# test" >> get_data.sh
git add get_data.sh
git status          # Changes to be committed: modified: get_data.sh
git restore --staged get_data.sh
git status          # Changes not staged for commit: modified: get_data.sh
git restore get_data.sh
git status          # nur noch team.md als untracked
```

`restore --staged` holt die Änderung nur aus dem Staging-Bereich, die Datei bleibt geändert. Erst `restore` ohne `--staged` verwirft die Änderung in der Datei.

### 3. Tippfehler in der Commit-Message (`git commit --amend`)

```text
6961115 (HEAD -> main) Explian what a changed chekcsum means
b960f30 (origin/main, origin/HEAD) Document Task 3 step by step in git.md
```

Nach `git commit --amend -m "Explain what a changed checksum means"`:

```text
a740d77 (HEAD -> main) Explain what a changed checksum means
b960f30 (origin/main, origin/HEAD) Document Task 3 step by step in git.md
```

Der Hash hat sich von `6961115` zu `a740d77` geändert, weil `--amend` einen neuen Commit erzeugt. Das ist nur in Ordnung, solange der Commit noch nicht gepusht ist: `origin/main` stand noch bei `b960f30`.

### 4. Gepushten Fehler rückgängig machen (`git revert`)

Ich habe in der GDELT-URL das Jahr von 2026 auf 2016 geändert, committet und gepusht (`8296de0`). Ich hatte erwartet, dass das Skript abbricht. Das ist nicht passiert: GDELT 2.0 gibt es seit Februar 2015, die Datei von 2016 existiert also. Das Skript hat sie aber unter dem alten Namen gespeichert und danach weiter die alte 2026-CSV ausgewertet. Die Zahlen sahen deshalb richtig aus. Nur die Prüfsumme hat den Fehler gezeigt:

```text
== Checksum
137ff7e50ab53f9d21f9a7d851d503222e9eb97b
```

statt `0c95a6d68f0d0cbddb6f1cf7c731374bda28ad11`. Ein Fehler ohne Abbruch ist gefährlicher als einer mit Abbruch, weil man ihn sonst nicht bemerkt.

Weil der Commit schon auf GitHub war, habe ich ihn mit `git revert` rückgängig gemacht und nicht mit `reset`:

```bash
git revert --no-edit HEAD
git push
```
```text
5686327 (HEAD -> main, origin/main, origin/HEAD) Revert "Switch GDELT file to 2016"
8296de0 Switch GDELT file to 2016
a740d77 Explain what a changed checksum means
b960f30 Document Task 3 step by step in git.md
```

Danach war die Prüfsumme wieder `0c95a6d68f0d0cbddb6f1cf7c731374bda28ad11`. Der fehlerhafte Commit bleibt in der Geschichte sichtbar, der Revert-Commit macht ihn rückgängig.