#!/usr/bin/env perl

use strict;
use Bio::SeqIO;

my $input_file = shift;

my $seq_in  = Bio::SeqIO->new( -format => 'qual',
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
