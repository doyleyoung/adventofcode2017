#!/usr/bin/env perl

use Modern::Perl;
use Algorithm::Permute;

#my $inpath = "../../resources/2example2.txt";
my $inpath = "../../resources/2/spreadsheet.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my @diffs;
my @divs;
while (my $line = <$fh>) {
    chomp $line;
    my @vals = split /\s+/, $line;

    my $min = $vals[0];
    my $max = $vals[0];
    map {if($_ < $min) { $min = $_ } if($_ > $max) { $max = $_ }} @vals;
    push(@diffs, $max - $min);

    my $permutations = Algorithm::Permute->new(\@vals, 2);
    while(my @combo = $permutations->next()) {
        if($combo[0] % $combo[1] == 0) {
            push(@divs, $combo[0] / $combo[1]);
        }
    }
}

# part 1
my $checksum = 0;
map {$checksum += $_} @diffs;
say $checksum;

# part 2
$checksum = 0;
map {$checksum += $_} @divs;
say $checksum;