#!/usr/bin/env bash
pdftk "$practicalvimpdf" dump_data_utf8 | grep 'BookmarkTitle: Tip' | sed -E 's/BookmarkTitle: Tip ([0-9]+)\. /Tip \1\t/' > out/practivalvim.txt
pdftk "$modernvimpdf" dump_data_utf8 | grep 'BookmarkTitle: Tip' | sed -E 's/BookmarkTitle: Tip ([0-9]+)\. /Tip \1\t/' > out/modernvim.txt

