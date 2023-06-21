#!/usr/bin/perl -w
if ($#ARGV == -1) {
    usage();
    exit;
}
$fasta_file = $ARGV[0];
unless ( open(IN, "$fasta_file") ) {    
    print "Got a bad fasta file: $fasta_file\n\n";
    exit;
}

my $seq = "";
my @posit;
my @negat;
my $cuenta1=0;
my $cuenta2=0;

while (<IN>) {
    chomp;
    if (/^>/) {
	#finish up previous line.
	if (length($seq) > 0) {
	    &process_it;
#		print "$cuenta1\t$cuenta2\n";
	}
	#start new line.
	s/>//;
	$id = $_;
	$id =~ s/^>(.+?)\s.+$/$1/g;
#	print "$id\t";
    }
    else {
	$seq = $seq . $_;
    }
}

#finish up last line.
&process_it;

for(my $key=0; $key<$cuenta1; $key++){
	print $posit[$key]."\n";
}

for(my $key=0; $key<$cuenta2; $key++){
        print $negat[$key]."\n";
}

close(IN);

sub usage {
    print "Get GC Content\n";
    print "Usage: get_gc_content.pl <fasta file>\n";
    print "This program takes a fasta file as it's first (and only) parameter.\n\n";
    print "It returns a tab delimited file (gc_out.txt): column 1 = header ID (everything between \">\"\n";
    print "and the first space in the header), and column 2 = gc content for the fasta entry.\n\n";
    print "Jennifer Meneghin\n";
    print "July 23, 2009\n\n";
    print "Updated September 20, 2010:\n";
    print "This script now works properly with sequences that contain spaces.\n\n";
    print "Updated September 21, 2010:\n";
    print "This script now also returns the total nucleotide count, along with the number of of A's, G's, C's and T's for each fasta record.\n\n";
}

sub process_it {
    @letters = split(//, $seq);
    $gccount = 0;
    $totalcount = 0;
    $gcount = 0;
    $ccount = 0;
    $gcskew = 0;
    foreach $i (@letters) {
	if (lc($i) =~ /[a-z]/) {
	    $totalcount++;
	}
	if (lc($i) eq "g" || lc($i) eq "c") {
	    $gccount++;
		if (lc($i) eq "g") {
			 $gcount++;
		}
		else{
			$ccount++;
		}

	}
    }
    if ($totalcount > 0) {
	$gccontent = (100 * $gccount) / $totalcount;
	if ($gccount > 0) {
		$gcskew = (($gcount - $ccount) / $gccount);
	}
	else{ # when $gccount == 0 
                $gcskew = 0;
        }
    }
    else {
	$gccontent = 0;
    }
#    print "$gcskew\n";

	if($gcskew>=0){
		$posit[$cuenta1]=$id; $cuenta1++;
	}
	else{
		$negat[$cuenta2]=$id; $cuenta2++;

	}

    $seq = "";
}


