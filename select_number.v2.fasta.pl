#!/usr/bin/perl

use strict;
use Bio::SeqIO;

if ($#ARGV != 3) {
    usage();
    exit;
}

sub usage {
    print "Description\n";
    print "Usage: script.pl <fasta file> start end id\n";
    print "Jonathan Maldonado\n";
    print "January 13, 2020\n\n";
    print "Updated Jan 20, 2020:\n";
}

my $input_file = shift;
my $start= shift;
my $end= shift;
my $id= shift;
#my $count=$start;
my $count=1;
my $count2=0;

#if($end eq ""){
#	$end=$start-1;
#        $start=0;
#}


my $seq_in  = Bio::SeqIO->new( -format => 'fasta',
                                   -file => $input_file);

my $seq;
while($seq = $seq_in->next_seq() and $count<=$end){
	if($start<=$count) {
		print ">".$id."\n";
		print $seq->seq()."\n";
		$count2++;
	}
	$count++;
}
#$count2;

print STDERR "done subfile of ".$input_file." from ".$start." to ".$end." count ".$count2."\n";
