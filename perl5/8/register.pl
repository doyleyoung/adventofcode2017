#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{max};
no warnings 'experimental::smartmatch';

use Data::Dumper;

my $inpath = "../../resources/8/input.txt";
#my $inpath = "../../resources/8/test_input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my %registers = ();
my $ever_max = 0;
while (my $line = <$fh>) {
    my ($name, $op, $op_val, $test_name, $test_op, $test_val) = ($line =~ /^(\w+) (\w+) (-?\d+) if (\w+) ([!<>=]+) (-?\d+)$/);

#    print $line;
#    say "$name, $op, $op_val, $test_name, $test_op, $test_val";

    if(!exists($registers{$name})) {
        $registers{$name} = 0;
    }

    if(!exists($registers{$test_name})) {
        $registers{$test_name} = 0;
    }

    my $test = 0;
    for ($test_op) {
        when("==") {$test = $registers{$test_name} == scalar($test_val)};
        when("<") {$test = $registers{$test_name} < scalar($test_val)};
        when("<=") {$test = $registers{$test_name} <= scalar($test_val)};
        when(">") {$test = $registers{$test_name} > scalar($test_val)};
        when(">=") {$test = $registers{$test_name} >= scalar($test_val)};
        when("!=") {$test = $registers{$test_name} != scalar($test_val)};
        default {say "Don't know test operation -> '$test_op'"};
    }

    if($test) {
        for ($op) {
            when ("inc") {$registers{$name} += scalar($op_val)};
            when ("dec") {$registers{$name} -= scalar($op_val)};
            default {say "Don't know operation -> '$op'"};
        }
    }

    $ever_max = max(values %registers) > $ever_max ? max(values %registers) : $ever_max;
#    print Dumper(\%registers);
}


say max(values %registers);
say $ever_max;