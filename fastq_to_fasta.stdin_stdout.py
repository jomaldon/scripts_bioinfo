## Need Biopython

# pigz -c -d file.fastq.gz | python3 fastq_to_fasta.stdin_stdout.py - | sed 's/ .*//' > file.fasta

from Bio import SeqIO

import sys

records = SeqIO.parse(sys.stdin, "fastq")
SeqIO.write(records, sys.stdout, "fasta")
#SeqIO.write(records, sys.stdout, "qual")

