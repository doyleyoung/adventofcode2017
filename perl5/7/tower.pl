#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{reduce max};

my $inpath = "../../resources/7/input.txt";
#my $inpath = "../../resources/7/test_input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my @lines = ();
my %parents = ();
my %tower = ();
while (my $line = <$fh>) {
    chomp $line;
    push @lines, $line;

    if($line =~ /(\w+)\s+\((\d+)\)\s+->\s+(.*)/) {
        map {push @{$parents{$1}}, $_} split /, /, $3;
        $tower{$1} = {weight => $2, children => $parents{$1}};
    } else {
        my ($name, $weight) = ($line =~ /(\w+)\s+\((\d+)\)/);
        $tower{$name} = {weight => $weight};
    }
}
close $fh;

my $root = "";
for my $parent (keys %parents) {
    $root = $parent;

    my $found = 0;
    foreach my $p (grep !/^$parent$/, keys %parents) {
        if(grep /^$parent$/, @{$parents{$p}}) {
            $found = 1;
            last;
        }
    }

    last if !$found;
}

say "part one " . $root;

tower_sum($root, \%tower);
say "part two" . find_unbalanced_difference($root, \%tower);

sub tower_sum {
    my ($name, $tower) = @_;

    my @children_sums = ();
    if(exists $tower->{$name}{"children"}) {
        for my $child (@{$tower->{$name}{"children"}}) {
            push @children_sums, tower_sum($child, $tower);
        }

        $tower->{$name}{"sum"} = (reduce {$a + $b} @children_sums) + $tower->{$name}{"weight"};
        return $tower->{$name}{"sum"};
    } else {
        return $tower->{$name}{"weight"};
    }
}

sub find_unbalanced_difference {
    my ($name, $tower) = @_;

    my %disk_weights = ();
    map {$disk_weights{exists $tower->{$_}{"sum"} ? $tower->{$_}{"sum"} : $tower->{$_}{"weight"}}++} @{$tower->{$name}{"children"}};

    my %count_of_weights = reverse %disk_weights;
    my $primary_weight = $count_of_weights{max(values %disk_weights)};

    if(exists $count_of_weights{"1"}) {
        my $oddball_weight = $count_of_weights{"1"};
        my ($oddball_name) = grep {$tower->{$_}{"sum"} == $oddball_weight ? $_ : ""} @{$tower->{$name}{"children"}};

        my $child_unbalanced = find_unbalanced_difference($oddball_name, $tower);
        if ($child_unbalanced) {
            return $child_unbalanced;
        } else {
            return $tower->{$oddball_name}{"weight"} + ($primary_weight - $oddball_weight);
        }
    } else {
        return 0;
    }
}