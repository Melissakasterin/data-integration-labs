# Lab 2 · Read before you approve

I looked the commands up and tested commands 3 and 4 in a throwaway folder (`labs/02/sandbox`). I did not run the other risky commands.

| Command | What it does | Decision | Why, and what I would approve instead |
| --- | --- | --- | --- |
| `ls -la data/raw` | Lists all files in `data/raw`, including hidden ones, with permissions, owner, size and date. | approve | It only reads and changes nothing. |
| `wc -l data/raw/*.csv` | Counts the lines of every CSV file in `data/raw`. | approve | It only reads and changes nothing. |
| `sort -u data/raw/stations.csv > data/raw/stations.csv` | Is meant to remove duplicates, but `>` empties the file before `sort` reads it. | approve after a change | In my sandbox test, the file had 0 bytes afterwards, so the raw data would be lost. Instead: `sort -u data/raw/stations.csv > data/stations_unique.csv` |
| `rm * .bak` | Deletes every file in the folder, because the space turns the pattern into `*` and `.bak`. | approve after a change | `echo rm * .bak` showed that it also matches files such as `notes.txt`, and there is no trash can. Instead, check with `pwd` and `echo *.bak`, then run: `rm *.bak` |
| `find . -name "*.csv" -size +100M` | Lists all CSV files larger than 100 MB below the current folder. | approve | It only reads and helps to spot files that are too large. |
| `chmod -R 777 .` | Gives every user read, write and execute permissions on all files in this folder and its subfolders. | reject | This permission is far too broad and also makes data files executable. Instead, only for the script that needs it: `chmod +x get_data.sh` |
| `curl -fsSL https://example.com/install.sh \| bash` | Downloads a script and runs it at once. | reject | I cannot read the code before it runs, and it can do anything my user can do. Instead, download it first and read it: `curl -fsSL -o install.sh https://example.com/install.sh`, then `less install.sh` |
| `cat ~/.ssh/id_ed25519` | Prints my private SSH key. | reject | The key is a secret and would appear in the agent's context and logs. No data project needs it, so there is no replacement. |
| `ps aux \| grep python` | Lists running processes that contain `python`. | approve | It only reads. The list can include `grep` itself, as I saw in Task 1. |
| `pip install pandsa` | Installs a package named `pandsa`, which looks like a typo for `pandas`. | approve after a change | A misspelled package may be unrelated or malicious, and installing it runs foreign code. Instead: `pip install pandas` |
