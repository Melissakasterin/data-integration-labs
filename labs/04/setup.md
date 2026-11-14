# Lab 4 · Task 1: Agent einrichten und seine Bremsen finden

Getestet am 14.11.2026 auf einem MacBook Air M1 (macOS, Terminal mit zsh) in einem Wegwerf-Repository `agent-test`.

| Frage | Antwort |
| --- | --- |
| Tool und Version | Claude Code 2.1.325, installiert mit dem nativen Installer (`https://claude.ai/install.sh`). Das Skript habe ich vorher heruntergeladen und gelesen: Es lädt nur von `downloads.claude.ai`, prüft die SHA-256-Prüfsumme und braucht kein `sudo`. Den Ordner `~/.local/bin` musste ich selbst in `~/.zshrc` eintragen, sonst wurde `claude` nicht gefunden. |
| Modell | Opus 5.5, angemeldet mit meinem Claude-Pro-Konto. |
| Start-Modus und Umstellen | Claude Code startete im **auto mode**. Umgestellt mit Shift+Tab bis `manual mode on` (Reihenfolge: accept edits → plan mode → auto mode → manual mode). Später direkt mit `claude --permission-mode manual` gestartet. |
| Was ohne Nachfrage? | Lesen und Ordner auflisten (`Listed 1 directory`) ohne Nachfrage. Vor dem Schreiben von `hello.txt` (`Write`) und vor `git log` (`Bash`, „This command requires approval“) hat es gefragt. Bei der Nachfrage bot es auch „don't ask again for: git *“ und „switch to auto mode“ an, beides habe ich nicht gewählt. |
| Änderungen sehen und rückgängig machen | Sehen: `git status` in einem zweiten Terminal-Tab (laut Hinweis auch `/diff`). Rückgängig: `/rewind` („Restore the code and/or conversation to the point before…“). Ich habe das Menü geöffnet, die Datei dann aber mit `rm hello.txt` gelöscht. Danach zeigte `git status` wieder `working tree clean`. |
| Neue Session, Kontext und Quota | Neue Session: `/clear` (oder `claude` neu starten; `claude --resume …` setzt eine alte fort). Kontext: `/context`, nach den Tests ca. 4 % belegt, 92,4 % von 1M Tokens frei; meine Nachrichten nur 1,3 %, die Werkzeugbeschreibungen 2,3 %. Quota: `/usage`, aktuelle Sitzung 13 %, Woche 6 %. Das Kontingent teile ich mit meiner sonstigen Claude-Nutzung, der Anteil dieser Aufgabe ist deshalb nicht genau ablesbar. |
| Anleitungsdateien | Laut `/memory`: `~/.claude/CLAUDE.md` (für alle Projekte) und `./CLAUDE.md` (Projekt). `AGENTS.md` liest Claude Code laut Hinweis nur, wenn es keine `CLAUDE.md` gibt. Auto-memory ist eingeschaltet, Claude kann sich also auch nach `/clear` Notizen merken. |
| Training mit meinen Daten | Einstellung auf claude.ai → Einstellungen → Datenschutz → „Zur Verbesserung unserer KI-Modelle beitragen“. Sie war eingeschaltet, ich habe sie am 14.11.2026 ausgeschaltet. |

## Beobachtungen

- Im Plan-Modus war beim Bestätigen „Yes, and use auto mode“ vorausgewählt. Ich habe den Plan mit Esc abgelehnt, danach war `git status` sauber.
- Nachdem ich `hello.txt` gelöscht hatte, behauptete Claude bei `git log` trotzdem, die Datei sei noch da, und der Plan zählte sie mit. Claude hat sich auf das Gespräch verlassen, statt im Ordner nachzusehen.

## Warum dieses Tool?

Ich habe Claude Code gewählt, weil ich bereits Claude Pro nutze und mich mit Claude schon etwas auskenne. In meiner Projektgruppe verwenden wir ebenfalls Claude, weshalb es sinnvoll ist, dass wir zunächst dasselbe Tool nutzen. Beim Datenschutz habe ich darauf geachtet, keine persönlichen oder sensiblen Daten einzugeben und die Nutzung meiner Chats und Coding-Sitzungen für das Training in den Einstellungen auszuschalten. Ein Nachteil ist, dass Claude Code nicht Open Source ist und die Nutzungslimits mit meinem normalen Claude-Chat geteilt werden. Deshalb muss ich auch darauf achten, mein Kontingent sinnvoll zu nutzen und die Änderungen des Agents selbst zu überprüfen.