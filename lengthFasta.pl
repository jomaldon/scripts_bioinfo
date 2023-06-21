#!/usr/bin/env perl
# lengthFasta.pl
# Jonathan Maldonado
# github: jomaldon
# ultima version: Junio 2019

# Calcula el largo de secuencias en un archivo formato FASTA usando Bioperl

# El archivo de entrada debe estar en formato DASTA
# El archivo de salida estará separado por "tab"

# Uso:
# lengthFasta.pl entrada.fasta > salida.txt

# entrada.fasta tiene secuencias en formato fasta / salida.txt tendrá dos columnas

use strict;
use Bio::SeqIO;

my $input_file = shift;

my $seq_in  = Bio::SeqIO->new( -format => 'fasta',
                                   -file => $input_file);

my $seq;
# my $total=0;
# my $n=0;

while( $seq = $seq_in->next_seq() ) {
#  $total+=$seq->length; $n++;
  print $seq->id();
  print "\t";
  print $seq->length;
  print "\n";
}

#print ($total/$n);
#print "\n";
