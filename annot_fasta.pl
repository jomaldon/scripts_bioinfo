#!/usr/bin/perl
use strict;

my $fasta_file = $ARGV[0];
my $annot_file = $ARGV[1];
my $flag_pre_post = $ARGV[2];


open FASTA, $fasta_file or die "no pude abrir $fasta_file";
open ANNOT, $annot_file or die "no pude abrir $annot_file";

#cargar anotaciones en memoria
my %annots;
while(<ANNOT>){
  chomp;
  s/^ +//;
  my @parts = split(/\t/);
  my $seq_name = $parts[0];
  shift @parts;
  my $seq_annot = join(" ",@parts);
  $annots{$seq_name}=$seq_annot;
  #print "$seq_name=$seq_annot\n";
}


while(<FASTA>){
  if(/>/){
    chomp;
    s/>//;
    s/^ +//;
    my @parts = split(/ /);
    my $seq_name = $parts[0];
    shift @parts;
    my $seq_annot_prev = join(" ",@parts);

    if(length($annots{$seq_name}) < 1){
      print STDERR "no existe anotacion de $seq_name\n";
      next;
    }
    if($flag_pre_post eq "pre"){
      print ">$seq_name ".$annots{$seq_name}."; ".$seq_annot_prev."\n";
    }elsif($flag_pre_post eq "post"){
      print ">$seq_name ".$seq_annot_prev."; ".$annots{$seq_name}."\n";
    }else{
      print ">$seq_name ".$annots{$seq_name}."\n";
    }
    next; 
  }
  print $_;

}

close FASTA;
close ANNOT;



