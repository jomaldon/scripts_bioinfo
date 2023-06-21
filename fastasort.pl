#!/usr/bin/env perl

use strict;
use Bio::Index::Fasta;

sub print_uso{
print "Uso: 
        fastasort.pl archivo_fuente lista_identificadores\n";
}

# file names
#
if($#ARGV != (1)){
        print_uso();
        exit;
}

#my $In_Fasta_File_Name = $ARGV[0];
#my $List_File_Name     = $ARGV[1];
#print "$In_Fasta_File_Name\t$List_File_Name";

#
# make index
#
my $Index_File_Name = "tmp.idx";
my $idx             = Bio::Index::Fasta->new(
 '-filename'   => $Index_File_Name,
 '-write_flag' => 1
);
$idx->make_index($ARGV[0]);

#
# open the list
#
open( my $list, $ARGV[1] ) or die "Could not open $ARGV[1] !";

#
# write to stdout using list and index
#
my $out = Bio::SeqIO->new( '-format' => 'Fasta', '-fh' => \*STDOUT );
while ( my $id = <$list> ) {
 chomp $id;
 my $seq = $idx->fetch($id); 
 $out->write_seq($seq);
}

exec "rm tmp.idx";
