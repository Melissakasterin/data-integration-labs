#!/bin/bash
# get_data.sh: download one GDELT GKG file and one Wikimedia Pageviews
# request into data/raw/ and print a first look at the data.
# Usage: ./get_data.sh
#
# Sources and licences:
# GDELT 2.0 Global Knowledge Graph (https://www.gdeltproject.org/data.html)
# von The GDELT Project (https://www.gdeltproject.org/), genutzt gemäß den
# GDELT Terms of Use (https://www.gdeltproject.org/about.html#termsofuse).
# Pageviews (https://archive.sunet.se/mirror/wikimedia.org/other/pageview_complete/readme.html)
# von der Wikimedia Foundation, CC0 1.0
# (https://creativecommons.org/publicdomain/zero/1.0/).

gdelt_url="https://data.gdeltproject.org/gdeltv2/20261102181500.gkg.csv.zip"
gdelt_target="data/raw/20261102181500.gkg.csv.zip"
pageviews_url="https://wikimedia.org/api/rest_v1/metrics/pageviews/per-article/en.wikipedia/all-access/user/Taylor_Swift/monthly/2026070100/2026103100"
pageviews_target="data/raw/pageviews_taylor_swift.json"
gdelt_csv="data/raw/20261102181500.gkg.csv"

mkdir -p data/raw

# Download both files. Each entry holds a URL and its target file.
for pair in "$gdelt_url $gdelt_target" "$pageviews_url $pageviews_target"; do
  url=${pair% *}
  target=${pair#* }
  curl -fL -sS -o "$target" "$url" || exit 1
  # >> appends a line; > would replace the whole file.
  echo "$(date '+%Y-%m-%d %H:%M:%S') $url $target" >> data/raw/SOURCES.txt
done

# The GDELT file comes as a ZIP. -o replaces an older copy without asking.
unzip -o -q "$gdelt_target" -d data/raw || exit 1

echo "== Size"
ls -lh "$gdelt_csv" "$pageviews_target"
echo "== Bytes of the GDELT file"
wc -c < "$gdelt_csv"
echo "== Type"
file "$gdelt_csv" "$pageviews_target"
echo "== Lines of the GDELT file"
wc -l < "$gdelt_csv"
echo "== Columns of the GDELT file"
head -n 1 "$gdelt_csv" | awk -F'\t' '{print NF}'
echo "== First lines of the GDELT file (columns 1 to 4 only)"
# dataset.md promises to publish no raw rows, names or quotes, and this
# output goes into a public repository. Columns 1 to 4 hold only the record
# ID, the date, the source type and the source name.
head -n 3 "$gdelt_csv" | cut -f 1-4
echo "== Pageviews, first 300 characters"
head -c 300 "$pageviews_target"
echo

# Comparison with dataset.md (04.11.2026): bytes (21037577), lines (1599)
# and columns (27) match. `file` reports ASCII, while dataset.md says UTF-8.
# iconv accepts the file as valid UTF-8 and it has 321 non-ASCII bytes, so
# dataset.md is right; `file` probably only checked the start of the file.
# In SOURCES.txt, >> appends a line per file, while > would replace it.
