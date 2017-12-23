#!/usr/bin/env perl

use Modern::Perl;

my $inpath = "../../resources/5/input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my @jumps = ();
while (my $line = <$fh>) {
    chomp $line;
    push @jumps, $line;
}

my $count = 0;
my $index = 0;
my @first_jumps = @jumps;
while($index >= 0 && $index < scalar @first_jumps) {
    my $movement = $first_jumps[$index];
    $first_jumps[$index]++;
    $index += $movement;
    $count++;
}

say $count;


$count = 0;
$index = 0;
my @second_jumps = @jumps;
while($index >= 0 && $index < scalar @second_jumps) {
    my $movement = $second_jumps[$index];

    if ($movement >= 3) {
        $second_jumps[$index]--;
    } else {
        $second_jumps[$index]++;
    }

    $index += $movement;
    $count++;
}

say $count;