#!/usr/bin/env perl

use strict;
use Bio::SeqIO;

my $input_file = shift;
my $minimo= shift;

if($minimo eq ""){
	$minimo=200;
}


my $seq_in  = Bio::SeqIO->new( -format => 'fasta',
                                   -file => $input_file);

my $seq;
my $total=0;
my $total2=0;
my $n=0;
my $n2=0;
my $max="";
my $max2="";
my $max_annot="";
my $max2_annot="";
my $min="";
my $min2="";
my $min_annot="";
my $min2_annot="";

while( $seq = $seq_in->next_seq() ) {
  if($min=="") {$min=$max=$seq->length};

  $total+=$seq->length; $n++;
  if($seq->length<$min){
    $min_annot = $seq->id();
    $min=$seq->length;
  }
  if($seq->length>$max){
    $max_annot = $seq->id();
    $max= $seq->length;
  }

  if($seq->length>($minimo-1)){

    if($min2=="") {$min2=$max2=$seq->length};

    $total2+=$seq->length; $n2++;
     if($seq->length<$min2){
       $min2_annot = $seq->id();
       $min2=$seq->length;
     }
     if($seq->length>$max2){
       $max2_annot = $seq->id();
       $max2= $seq->length;
     }
  }

}

print "min length (".$min."): ".$min_annot."\n";
print "max length (".$max."): ".$max_annot."\n";
print "avg length (".($total/$n).") of ".$n." contigs \n";
print "total length (".($total/1000000).") Mb\n";
print "\n";

print "min$minimo length (".$min2."): ".$min2_annot."\n";
print "max$minimo length (".$max2."): ".$max2_annot."\n";
print "avg200 length (".($total2/$n2).") of ".$n2." contigs \n";
print "total200 length (".($total2/1000000).") Mb\n";
print "\n";


