#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{max};
use List::MoreUtils qw{firstidx};

my $inpath = "../../resources/6/input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my $line = <$fh>;
close $fh;
chomp $line;

#my $line = "0 2 7 0";

my @memory_bank = split /\s+/, $line;

#part one
my $count;
my %seen = ();
while(!exists $seen{join "", @memory_bank}) {
    $seen{join "", @memory_bank} = 1;

    my $max = max @memory_bank;
    my $index = firstidx {$_ == $max} @memory_bank;

    $memory_bank[$index] = 0;
    for(my $i = $max; $i > 0; $i--) {
        if($index + 1 == scalar @memory_bank) {
            $index = 0;
        } else {
            $index++;
        }

        $memory_bank[$index]++;
    }

    $count++;
}

say $count;

#part two
@memory_bank = split /\s+/, $line;
$count = 0;
my $loop_string = "";
my %seen2 = ();
while(1) {
    my $current = join "", @memory_bank;
    if(exists $seen2{$current}) {
        if($loop_string) {
            if($current eq $loop_string) {
                last;
            }
        } else {
            $loop_string = join "", @memory_bank;
        }
    } else {
        $seen2{$current} = 1;
    }

    my $max = max @memory_bank;
    my $index = firstidx {$_ == $max} @memory_bank;

    $memory_bank[$index] = 0;
    for(my $i = $max; $i > 0; $i--) {
        if($index + 1 == scalar @memory_bank) {
            $index = 0;
        } else {
            $index++;
        }

        $memory_bank[$index]++;
    }

    $count++ if $loop_string;
}

say $count;