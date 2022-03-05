#!/usr/bin/env python3
#
# Quick helper to export my CSV to the transcription Markdown format. You might
# have to fix the Windows line endings prior, and this will print an extra
# newline at the end.
#
# I use `_Speaker:_` instead of `_Speaker_:`. Both have been used, mixed before.

import sys, csv

def export_to_md(csv_reader):
    for row in csv_reader:
        print("_{speaker}:_ {transcript}"
                .format
                    ( speaker    = row[0]
                    , transcript = row[1] ))
        print()

with open(sys.argv[1]) as csv_file:
    export_to_md(csv.reader(csv_file))
