# Task 1 · Commit-Graph

## Runde 1 · Eine gerade Linie

**Vorhersage:**

**Was passiert ist:**

**Antworten:**
- Hat `git merge clean` einen neuen Commit erzeugt?
- Was hat das Tool geantwortet?
- Wohin zeigen `master` und `clean` jetzt?s

## Runde 2 · Zwei Linien treffen sich

**Vorhersage:**

**Was passiert ist:**

**Antworten:**
- Welcher Commit hat zwei Parents? (beide per Message benennen)
- Warum war dieser Merge kein Fast-Forward?
- Was würde ein Tag wie `v1.0` in unserem Projekt markieren?

## Runde 3 · Zwei Wege zurück

**Vorhersage:**

**Was passiert ist:**

**Antworten:**
- Was hat `git revert HEAD` zum Graphen hinzugefügt?
- Was hat `git reset HEAD~2` verändert?
- Die gestrichelten Commits: Sind sie weg?
- Welchen der beiden Befehle darf man bei Commits benutzen, die schon gepusht sind, und warum?

## Runde 4 · Verloren und wiedergefunden

**Vorhersage:**

**Was passiert ist:**

**Antworten:**
- Was steht über dem Graphen nach `git checkout v1.0~1`?
- Was passiert mit „Try a log scale“, wenn ich zurück auf `master` wechsle?
- Hash aus `git reflog` und Rettung mit `git branch logscale <hash>`