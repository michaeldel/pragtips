#!/usr/bin/env bash
pdftk "$practicalvimpdf" dump_data_utf8 | grep 'BookmarkTitle: Tip' | sed -E 's/BookmarkTitle: Tip ([0-9]+)\. /Tip \1\t/' > out/practivalvim.txt
pdftk "$modernvimpdf" dump_data_utf8 | grep 'BookmarkTitle: Tip' | sed -E 's/BookmarkTitle: Tip ([0-9]+)\. /Tip \1\t/' > out/modernvim.txt

pdftotext -layout "$pragmaticthinkingpdf" - | python <<< EOF

import sys

current = ""
label = None
last_label = None

tips = {}

for line in map(str.strip, sys.stdin):
    if line.startswith("Tip"):
        label = " ".join(line.split()[:2])
        rest = " ".join(line.split()[2:])

        if current:
            current = " ".join((current, rest))

        continue

    current = " ".join((current, line)).strip()

    if line == "":
        if (label != last_label):
            tips[label] = current
            last_label = label
        current = ""

for label, text in tips.items():
    print(label, text, sep='\t')

EOF > out/pragmaticthinking.txt

