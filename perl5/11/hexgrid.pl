#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{sum};

use Data::Dumper;

my $inpath = "../../resources/11/input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";
my $line = <$fh>;
close $fh;
chomp $line;

#my $line = "se,sw,se,sw,sw";

# part 1
my %full_input = ();
map {$full_input{$_}++} split /,/, $line;
simplify(\%full_input);

say sum values %full_input;


# part 2 - has a bug, incorrect :(
my $max = 0;
my @every = split /,/, $line;

for(my $i = 0; $i < scalar(@every); $i++) {
    my %so_far = ();
    map {$so_far{$_}++} @every[0 .. $i];

    simplify(\%so_far);
    my $distance = sum values %so_far;
    say $distance;

    $max = $max > $distance ? $max : $distance;
}

say $max;

sub simplify {
    my ($moves) = @_;
    my $simplified = 1;
    while ($simplified) {
        $simplified = 0;

        if ((exists $moves->{'s'} && $moves->{'s'} != 0)
            && (exists $moves->{'n'} && $moves->{'n'} != 0)) {
            $simplified = 1;
            if ($moves->{'s'} >= $moves->{'n'}) {
                $moves->{'s'} = $moves->{'s'} - $moves->{'n'};
                $moves->{'n'} = 0;
            }
            else {
                $moves->{'n'} = $moves->{'n'} - $moves->{'s'};
                $moves->{'s'} = 0;
            }
        }

        if ((exists $moves->{'ne'} && $moves->{'ne'} != 0)
            && (exists $moves->{'sw'} && $moves->{'sw'} != 0)) {
            $simplified = 1;
            if ($moves->{'ne'} >= $moves->{'sw'}) {
                $moves->{'ne'} = $moves->{'ne'} - $moves->{'sw'};
                $moves->{'sw'} = 0;
            }
            else {
                $moves->{'sw'} = $moves->{'sw'} - $moves->{'ne'};
                $moves->{'ne'} = 0;
            }
        }

        if ((exists $moves->{'nw'} && $moves->{'nw'} != 0)
            && (exists $moves->{'se'} && $moves->{'se'} != 0)) {
            $simplified = 1;
            if ($moves->{'nw'} >= $moves->{'se'}) {
                $moves->{'nw'} = $moves->{'nw'} - $moves->{'se'};
                $moves->{'se'} = 0;
            }
            else {
                $moves->{'se'} = $moves->{'se'} - $moves->{'nw'};
                $moves->{'nw'} = 0;
            }
        }

        if ((exists $moves->{'nw'} && $moves->{'nw'} != 0)
            && (exists $moves->{'ne'} && $moves->{'ne'} != 0)) {
            $simplified = 1;
            my $count = 0;
            if ($moves->{'nw'} >= $moves->{'ne'}) {
                $count = $moves->{'ne'};
                $moves->{'nw'} -= $count;
                $moves->{'ne'} = 0;
            }
            else {
                $count = $moves->{'nw'};
                $moves->{'ne'} -= $count;
                $moves->{'nw'} = 0;
            }

            $moves->{'n'} += $count;
        }

        if ((exists $moves->{'sw'} && $moves->{'sw'} != 0)
            && (exists $moves->{'se'} && $moves->{'se'} != 0)) {
            $simplified = 1;
            my $diff = 0;
            if ($moves->{'sw'} >= $moves->{'se'}) {
                $diff = $moves->{'se'};
                $moves->{'sw'} -= $diff;
                $moves->{'se'} = 0;
            }
            else {
                $diff = $moves->{'sw'};
                $moves->{'se'} -= $diff;
                $moves->{'sw'} = 0;
            }

            $moves->{'s'} += $diff;
        }
    }
}
