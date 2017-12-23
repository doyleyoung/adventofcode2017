#!/usr/bin/env perl

use Modern::Perl;
use Algorithm::Permute;
use List::MoreUtils qw{all notall};

my $inpath = "../../resources/4/input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

# part one: no dupes
my $count = 0;
while (my $line = <$fh>) {
    my %blah = ();
    map {$blah{$_}++} split /\s+/, $line;
    $count++ if all {$_ == 1} values %blah;
}
say $count;
close $fh;

# part two anagrams
open($fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

$count = 0;
while (my $line = <$fh>) {
    # matching strings are anagrams, filter those first
    my %blah = ();
    my @words = split /\s+/, $line;
    map {$blah{$_}++} @words;
    if(notall {$_ == 1} values %blah) {
        next;
    }

    my $match = 0;
    WORD: foreach my $word (@words) {
        my @without_word = grep !/$word/, @words;

        my @letters = split //, $word;
        my $permutations = Algorithm::Permute->new(\@letters, length($word));

        while (my @combo = $permutations->next()) {
            my $potential = join "", @combo;
            if(grep /^$potential$/, @without_word) {
                $match = 1;
                last WORD;
            }
        }
    }

    $count++ if !$match;
}

say $count;
close $fh;