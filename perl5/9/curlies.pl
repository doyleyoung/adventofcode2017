#!/usr/bin/env perl

use Modern::Perl;

my $inpath = "../../resources/9/input.txt";
#my $inpath = "../../resources/9/test_input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

use constant STANDARD => 1;
use constant GARBAGE => 2;
use constant ESCAPE => 3;

my $line = <$fh>;
chomp $line;
my @chars = split //, $line;

my $status = STANDARD;
my $escape_status = STANDARD;
my $depth = 0;
my $curly_sum = 0;
my $garbage_count = 0;
for my $char (@chars) {
    if($status == ESCAPE) {
        $status = $escape_status;

    } elsif($char eq '!') {
        $escape_status = $status;
        $status = ESCAPE;

    } elsif($char eq '<') {
        if($status != GARBAGE) {
            $status = GARBAGE;
        } else {
            $garbage_count++;
        }

    } elsif($char eq '>' && $status == GARBAGE) {
        $status = STANDARD;

    } elsif($char eq '{' && $status == STANDARD) {
        $depth += 1;

    } elsif($char eq '}' && $status == STANDARD) {
        $curly_sum += $depth;
        $depth -=1;

    } elsif($status == GARBAGE) {
        $garbage_count++;
    }
}

say $curly_sum;
say $garbage_count;