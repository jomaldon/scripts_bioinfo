#!/usr/bin/perl

use strict;

my $input_file = shift;
open FILE, $input_file or die "no pude abrir $input_file";

my $last_id; # guarda el nombre completo
my $last_id2; # cuarda el nombre corto
my $last_length;
my $current_id;
my $current_length;

#my %files;
while(<FILE>){
  chomp;
  s/^ +//;
  my @parts = split(/\t/);
  my $seq_name = $parts[0];
  shift @parts;
  my $current_length = join(" ",@parts);

#  print "$seq_name | $current_length\n";
 
  my $fin1 = rindex $seq_name, "_";
  $current_id= substr $seq_name, 0 , $fin1;

    my $fin2 = rindex $last_id, "_";
    $last_id2 = substr $last_id, 0 , $fin2;

# print "$current_id | $last_id2 | $seq_name\n";

  if($current_id eq $last_id2){
	if($current_length>$last_length){
		$last_id=$seq_name;
		$last_length=$current_length;
	}
  }
  else{
	print "$last_id\t$last_length\n";
 	$last_length=$current_length;
	$last_id=$seq_name;
	
  }
}
print "$last_id\t$last_length\n";
close FILE;

