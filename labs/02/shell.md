# Lab 2 · Shell

## Task 1 · Get to know your shell

### 1. Which shell?

```zsh
echo $0
```

```text
-zsh
```

```zsh
zsh --version
```

```text
zsh 5.9 (arm64-apple-darwin25.0)
```

My terminal runs zsh version 5.9; the leading dash in `-zsh` shows that it was started as a login shell.

### 2. Where am I?

```zsh
cd ~
pwd
cd ~/Downloads
pwd
```

```text
/Users/melissa
/Users/melissa/Downloads
```

My home directory is `/Users/melissa`, and my downloads folder is `/Users/melissa/Downloads`.

### 3. Where do commands come from?

```zsh
echo $PATH | tr ":" "\n"
```

```text
/opt/anaconda3/bin
/opt/anaconda3/condabin
/usr/local/bin
/System/Cryptexes/App/usr/bin
/usr/bin
/bin
/usr/sbin
/sbin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin
/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin
/pkg/env/global/bin
```

```zsh
echo $PATH | tr ":" "\n" | wc -l
echo $PATH | tr ":" "\n" | head -n 1
which curl
which python3
which git
git --version
```

```text
      12
/opt/anaconda3/bin
/opt/anaconda3/bin/curl
/opt/anaconda3/bin/python3
/usr/bin/git
git version 2.50.1 (Apple Git-155)
```

My `PATH` contains 12 directories and `/opt/anaconda3/bin` is searched first, so `curl` and `python3` come from Anaconda, while `git` (version 2.50.1) is installed in `/usr/bin`.

### 4. How full is your disk?

```zsh
df -h ~
du -sh ~/Downloads
```

```text
Filesystem      Size    Used   Avail Capacity iused ifree %iused  Mounted on
/dev/disk3s5   228Gi   129Gi    69Gi    66%    1,2M  720M    0%   /System/Volumes/Data
3,5G	/Users/melissa/Downloads
```

My disk has 69 GiB of free space, and my downloads folder takes up 3.5 GB.

### 5. Stop a runaway process

First terminal window:

```zsh
sleep 600
```

Second terminal window:

```zsh
ps aux | grep sleep
```

```text
melissa          42712   0,0  0,0 435300096   1344 s001  S+   10:35     0:00.01 grep sleep
melissa          42698   0,0  0,0 435300240    496 s000  S+   10:35     0:00.00 sleep 600
```

```zsh
kill 42698
ps aux | grep sleep
```

```text
melissa          42724   0,0  0,0 435299968   1344 s001  S+   10:36     0:00.01 grep sleep
```

First terminal window after `kill`:

```text
zsh: terminated  sleep 600
```

The first window shows that `sleep 600` was terminated, and `ps aux | grep sleep` lists two processes because `grep sleep` runs at the same time as `ps` and matches its own command line.


## bashcrawl

### Inventory

```zsh
echo $I
```

```text
crown,coins,sword,amulet,
```

### Three new commands

- `alias ls='ls -F'` creates a shortcut, so that `ls` runs `ls -F` in this shell.
- `ln -s <target> <name>` creates a symbolic link, a shortcut to another file or directory.
- `export I=sword,$I` stores a value in the variable `I` and passes it on to the programs started from this shell.

### A monster and a scroll

In the room with the monster, with the alias `ls='ls -F'` active:

```zsh
ls -l
```

```text
total 8
drwxr-xr-x  4 melissa  staff   128 24 Mai  00:21 library/
-rwxr-xr-x  1 melissa  staff  3408 24 Mai  00:21 monster*
```

There was no scroll in this room. For comparison, `ls -l` in the chamber before it:

```text
-rw-r--r--  1 melissa  staff   282 24 Mai  00:21 scroll
```

A monster is executable: its permissions contain `x`, so it can be run as a program with `./monster`, while a scroll has no `x` and can only be read.

### Note on `bashcrawl.log`

I removed two entries (203 and 204) from the log because I had pasted chat text into the terminal by accident; they caused a parse error and did not run any command.

### Scrolls I did not read

I did not read every scroll. After the library, I listed the game's files with `find` and went straight to `.rift/arena/pit`, where I defeated the last enemy. I skipped the rooms below `chapel` and `vault`, among others, so I did not read their scrolls.
