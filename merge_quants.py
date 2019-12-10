#! /usr/bin/env python

## Original
# invoke with column nr to extract as first parameter followed by
# filenames. The files should all have the same number of rows

## JM
# github: jomaldon
#
# invoke with
#       merge_quants.py *.sf
#
# On this version column number has been fixed to "5" that is the "counts" column in salmon quant.sf files
#
# QUANT FILES MUST HAVE DIFFERENT NAMES ACCORDING TO SAMPLES NAME (ie SRR1811524.quant.sf)
# If quants are inside samples folders, you can try the following bash script to rename and copy quant.sf files to current path
#
#	for fn in */*.sf;
#	do
#		echo "Input=${fn} | Output=${fn%_quant/quant.sf}.quant.sf"
#		cp ${fn} ${fn%\_quant/quant.sf}.quant.sf
#	done
#

import sys
import re

#col = int(sys.argv[1])
col = 5; # in salmon quant.sf output "counts" are in column 5
res = {}
first = 1;

file_name = sys.argv[1]
for line_nr, line in enumerate(open(file_name)): # this cycle is to retain the IDs (using file1 as template)
    res.setdefault(line_nr, []).append(line.strip().split('\t')[0])

for file_name in sys.argv[1:]: # this cycle is to obtain "counts" columns for each file
    for line_nr, line in enumerate(open(file_name)):
        if first:
#            res.setdefault(line_nr, []).append(file_name.replace(r'.*',''))
            res.setdefault(line_nr, []).append(re.sub(r"\..*", "", file_name))
            first = 0;
        else:
            res.setdefault(line_nr, []).append(str(int(float(line.strip().split('\t')[col-1])))) # if "count" is not "int", it must be transformed
    first = 1;

for line_nr in sorted(res):
    print ('\t'.join(res[line_nr]));
