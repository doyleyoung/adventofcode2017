#!/usr/bin/env perl

use Modern::Perl;
use Clone qw(clone);
use enum qw(Position Direction Range);

my $inpath = "../../resources/13/input.txt";
#my $inpath = "../../resources/13/test_input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my %initial_firewall;
my $max_depth;
while(my $line = <$fh>) {
    chomp $line;
    my ($depth, $range) = (split /: /, $line);
    $initial_firewall{$depth} = [0, 1, $range];
    $max_depth = $depth;
}

use Data::Dumper;
my %firewall = %{ clone(\%initial_firewall) };
# part one
my $severity = 0;
for my $i (0..$max_depth) {
    if(exists $firewall{$i} && $firewall{$i}[Position] == 0) {
        $severity += $i * $firewall{$i}[Range];
    }

    move_scanner(\%firewall);
}
say $severity;

# part two
my $delay = 1;
my $caught = 1;
my $caught_on = 0;
my %delayed_firewall = %{ clone(\%initial_firewall) };
while ($caught) {
    say $delay if $delay % 100000 == 0;
    $caught = 0;
    move_scanner(\%delayed_firewall);

    my %firewall = %{ clone(\%delayed_firewall) };

    for my $i (0..$max_depth) {
        if(exists $firewall{$i} && $firewall{$i}[Position] == 0) {
            if($i > $caught_on) {
                $caught_on = $i;
                say "caught on: $caught_on";
            }
            $caught = 1;
            last;
        }

        move_scanner(\%firewall);
    }

    if($caught) {
        $delay++;
    }
}
say $delay;

sub move_scanner {
    my $fw = shift;
    foreach my $scanner (keys %$fw) {
        $fw->{$scanner}[Position] += $fw->{$scanner}[Direction];

        if($fw->{$scanner}[Position] == 0 || $fw->{$scanner}[Position] == ($fw->{$scanner}[Range] - 1)) {
            $fw->{$scanner}[Direction] *= -1;
        }
    }
}