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
