#!/usr/bin/perl

use SVG;

# basic script to produce SVG for loading into Illustrator from an SVG composed ofcolumns for loci and rows for strains


my $file = $ARGV[0];
if($ARGV[1] == 1)
{
$colval = 5.1	
}
else
{
	$colval = 510;
}

open (INFO, $file);
my @lines = <INFO>;
close (INFO);

my @genearray;
my $maxlen = 0;
my $samps = $#lines;
for($i = 0 ; $i <= $samps ; $i++)
{
	@tmp = split(/,/,$lines[$i]);
	if($maxlen < $#tmp)
	{
		$maxlen = $#tmp;	
	}	
	push @genearray, [ @tmp ]; 
}

my $rwidth = 300/$maxlen;
my $rheight = 200/$samps;


    # create an SVG object
my $svg= SVG->new(width=>350,height=>210);
my $xv = 0;
my $yv = 10;
my $count = 0;
my $colour = "";
my $colourv = "";
for($i = 1 ; $i <= $samps ; $i++)
{  
	#print "\n";
	for($j = 1 ; $j <= $maxlen ; $j++)
	{
		#print $genearray[$i][$j]."_";
		$colourv = $colval*$genearray[$i][$j];
		$colour = get_colour($colourv);

		$id = "rect".$count;
		$count++;
		$svg->rectangle(
       	 x     => $xv, y => $yv,
       	 width => $rwidth, height => $rheight,
       	 id    => $id,
       	 fill  => $colour
    	);
    	$xv = $xv+$rwidth; 	
	}
	$xv = 0;
	$yv = $yv+$rheight;
	
}

# add in rectangles for the key

$xv = 320;
$yv = 90;
$rwidth = 20;
$rheight = 10;
for($j = 1 ; $j <= 10 ; $j++)
{
		#print $genearray[$i][$j]."_";
		$colourv = 5.1*$j*10;
		$colour = get_colour($colourv);

		$id = "rect".$count;
		$count++;
		$svg->rectangle(
       	 x     => $xv, y => $yv,
       	 width => $rwidth, height => $rheight,
       	 id    => $id,
       	 fill  => $colour
    	);
    	$yv = $yv+10; 	
}

	





    # now render the SVG object, implicitly use svg namespace
    print $svg->xmlify;

sub get_colour 
{
	my ($colourv);
	($colourv) = @_;
	my $colour = "";
	
		if($colourv > 510)
		{
		$colour = "0000FF";	
		}
		elsif($colourv > 255)
		{
			$cvred = uc(sprintf("%x", 255-($colourv-255)));
			
			$cvblue = uc(sprintf("%x", 255-($colourv-255)));
			$cvblue = "FF";
			if(length($cvred) == 1)
			{
				$cvred = "0".$cvred;
			}
			if(length($cvblue) == 1)
			{
				$cvblue = "0".$cvblue;
			}			
		#print $cvred."_".$cvblue."\t";
		$colour = $cvred."00".$cvblue;	
		}
		else
		{
			$colourv = 255-$colourv;
			$cvred = uc(sprintf("%x", 255-$colourv));
			$cvblue = uc(sprintf("%x", (255-$colourv)));
			$cvred = "FF";

			if(length($cvred) == 1)
			{
				$cvred = "0".$cvred;
			}
			if(length($cvblue) == 1)
			{
				$cvblue = "0".$cvblue;
			}	
			#print $cvred."_".$cvblue."\t";
		$colour = $cvred."00".$cvblue;	
		#print $colour."_";
		}
		#print "\n";
		$colour = '#'.$colour;


return $colour;
}
