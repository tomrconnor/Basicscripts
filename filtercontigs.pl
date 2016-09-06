#!/usr/bin/env perl

use Bio::SeqIO;

$inputfilename = $ARGV[0];
$informat = $ARGV[1];
$minlen = $ARGV[2];
my $filen = $file;

my $seqfobj = Bio::SeqIO->new(-file => $inputfilename, -format => $informat);

my $outf = "";

while ( my $sequence = $seqfobj->next_seq() )
{
	if($sequence->length >= $minlen)
	{	
		$outf = $inputfilename.".".$sequence->primary_id.".fasta";
		
		open(FILE, ">>$outf");
    	print FILE ">".$sequence->primary_id."\n".$sequence->seq."\n";
    	close (FILE);
	} 
}
