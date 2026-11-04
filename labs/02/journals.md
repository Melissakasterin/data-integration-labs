# Lab 2 · Journal articles

All commands were run in `labs/02/shell-lesson`.

## 1. Shape

```zsh
head -n 1 2014-01_JA.tsv | tr "\t" "\n" | cat -n
```

```text
     1	File
     2	Creator
     3	Issue
     4	Volume
     5	Journal
     6	ISSN
     7	ID
     8	Citation
     9	Title
    10	Place Labe
    11	Language
    12	Publisher
    13	Date
```

```zsh
for f in *.tsv; do head -n 1 "$f"; done | sort | uniq -c
```

```text
   4 File	Creator	Issue	Volume	Journal	ISSN	ID	Citation	Title	Place Labe	Language	Publisher	Date
```

```zsh
wc -l *.tsv
```

```text
  507732 2014-01_JA.tsv
   13712 2014-01-31_JA-africa.tsv
   27392 2014-01-31_JA-america.tsv
    5375 2014-02-02_JA-britain.tsv
  554211 total
```

Column 10, `Place Labe`, is cut off and was probably meant to be `Place Label`. All four files have the same header, and without the header line they contain 507,731, 13,711, 27,391 and 5,374 articles.

## 2. Missing values

```zsh
cut -f 11 2014-01_JA.tsv | tail -n +2 | sort | uniq -c | sort -rn
```

```text
403284 eng
40155 fre
36100 
28192 ger
```

36,100 articles have no language (the line without a value). The languages are English (`eng`, 403,284), French (`fre`, 40,155) and German (`ger`, 28,192).

## 3. Years

```zsh
cut -f 13 2014-01_JA.tsv | tail -n +2 | sort | uniq -c | sort -rn | head -n 5
```

```text
30813 1997
28215 1998
27968 1996
27916 2002
27335 2001
```

```zsh
cut -f 13 2014-01_JA.tsv | tail -n +2 | sort -n | uniq -c | tail -n 5
```

```text
24912 2010
24788 2011
21804 2012
8430 2013
  20 2077
```

```zsh
cut -f 5,13 2014-01_JA.tsv | grep "2077$" | sort | uniq -c
cut -f 5,8,13 2014-01_JA.tsv | grep "2077$" | head -n 5
```

```text
  20 FRANCAIS DANS LE MONDE	2077
FRANCAIS DANS LE MONDE	FRANCAIS DANS LE MONDE 353(SUPP), 2-2. (2077)	2077
FRANCAIS DANS LE MONDE	FRANCAIS DANS LE MONDE 353(SUPP), 4-5. (2077)	2077
FRANCAIS DANS LE MONDE	FRANCAIS DANS LE MONDE 353(SUPP), 6-7. (2077)	2077
FRANCAIS DANS LE MONDE	FRANCAIS DANS LE MONDE 353(SUPP), 8-9. (2077)	2077
FRANCAIS DANS LE MONDE	FRANCAIS DANS LE MONDE 353(SUPP), 10-11. (2077)	2077
```

```zsh
cut -f 4,5,13 2014-01_JA.tsv | grep "FRANCAIS DANS LE MONDE" | grep -E "^35[1-5]" | sort | uniq -c
```

```text
  20 351	FRANCAIS DANS LE MONDE	2007
  20 353	FRANCAIS DANS LE MONDE	2077
```

1997 has the most articles (30,813). The year 2077 cannot be right: 20 articles from *FRANCAIS DANS LE MONDE*, volume 353, carry it, and because volume 351 is from 2007, the intended year was probably 2007.

## 4. Lines are not fields

```zsh
grep -i -c africa 2014-01_JA.tsv
cut -f 9 2014-01_JA.tsv | grep -i -c africa
cut -f 5 2014-01_JA.tsv | grep -i africa | sort | uniq -c | sort -rn | head -n 5
```

```text
33577
13711
3887 WEST AFRICA
2828 BULLETIN- SCHOOL OF ORIENTAL AND AFRICAN STUDIES UNIVERSITY OF LONDON
2562 INTERNATIONAL JOURNAL OF AFRICAN HISTORICAL STUDIES
1823 JOURNAL OF AFRICAN HISTORY
1458 JOURNAL OF MODERN AFRICAN STUDIES
```

33,577 lines but only 13,711 titles contain *africa*. The numbers differ because `grep` searches the whole line, so it also matches other columns, such as journal names like *WEST AFRICA*.

## 5. Where does a file come from?

```zsh
cut -f 9 2014-01_JA.tsv | grep -i africa | sort > t_all_africa.txt
tail -n +2 2014-01-31_JA-africa.tsv | cut -f 9 | sort > t_file_africa.txt
diff t_all_africa.txt t_file_africa.txt | wc -l
```

```text
       0
```

```zsh
cut -f 9 2014-01_JA.tsv | grep -i america | sort > t_all_america.txt
tail -n +2 2014-01-31_JA-america.tsv | cut -f 9 | sort > t_file_america.txt
diff t_all_america.txt t_file_america.txt
```

```text
5084c5084
< British Trade with Spanish America, 1763Ã¯Â¿Â½1808 - by Pearce, A. J.
---
> British Trade with Spanish America, 1763ï¿½1808 - by Pearce, A. J.
```

The claim holds exactly for the Africa file: both sorted lists contain 13,711 titles and `diff` finds no difference. It holds for the America file, too, as both lists contain 27,391 titles, but one title is stored with a different broken character encoding.

## 6. Spreadsheet damage

```zsh
cut -f 3 2014-01_JA.tsv | tail -n +2 | sort | uniq -c | sort -rn | head -n 20
```

```text
99743 1
96514 2
75421 3
58325 4
30668 
9650 5
5325 6
4219 01-Feb
3157 03-Apr
2736 7
2077 8
2035 10
2009 12
1965 11
1829 9
1731 02-Mar
 793 SUM
 781 AUT
 732 WIN
 707 SPR
```

```zsh
cut -f 3,8 2014-01_JA.tsv | grep "^01-Feb" | head -n 3
cut -f 3,8 2014-01_JA.tsv | grep "^03-Apr" | head -n 3
```

```text
01-Feb	WASHINGTON MONTHLY 28(1/2), 4-9. (1996)
01-Feb	WASHINGTON MONTHLY 28(1/2), 9-16. (1996)
01-Feb	WASHINGTON MONTHLY 28(1/2), 17-25. (1996)
03-Apr	INTERNATIONALES ASIENFORUM 26(3/4), 233-248. (1995)
03-Apr	INTERNATIONALES ASIENFORUM 26(3/4), 249-285. (1995)
03-Apr	INTERNATIONALES ASIENFORUM 26(3/4), 285-302. (1995)
```

```zsh
tail -n +2 2014-01_JA.tsv | cut -f 3 | grep -E '^[0-9]{2}-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)$' | wc -l
```

```text
   11632
```

`01-Feb`, `03-Apr` and `02-Mar` are not issue numbers: the `Citation` column shows that double issues such as `1/2` and `3/4` were turned into dates, most likely by a spreadsheet program. In total, 11,632 rows are affected; values such as `SUM`, `WIN` or `Oct` are real issue labels (`4(Oct)` in the citation) and are not counted.
