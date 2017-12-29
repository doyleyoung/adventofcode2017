#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{reduce};

# part one
my $inpath = "../../resources/10/input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";
my $line = <$fh>;
close $fh;

chomp $line;
my @twists_one = split /,/, $line;

my @list_one = 0..255;
sparse_hash(\@list_one, \@twists_one, 1);

say $list_one[0] * $list_one[1];

#part two
my @ascii = map {ord($_)} split //, $line;
push(@ascii, map {int($_)} qw(17 31 73 47 23));

my @list_two = 0..255;
sparse_hash(\@list_two, \@ascii, 64);

my @dense = ();
for(my $i = 0; $i < 16; $i++) {
    $dense[$i] = reduce {$a ^ $b} @list_two[($i*16) .. ($i*16+15)];
}

my $output = "";
map {$output .= sprintf("%02x", $_)} @dense;
say $output;

sub sparse_hash {
    my ($list, $twists, $rounds) = @_;

    my $list_size = scalar(@$list);
    my $pos = 0;
    my $skip = 0;

    for(my $i = 0; $i < $rounds; $i++) {
        for my $twist (@$twists) {
            #    say "$pos $skip $twist";

            if (($pos + $twist) < $list_size) {
                splice(@$list, $pos, $twist, reverse(@$list[$pos .. ($pos + $twist - 1)]));
                $pos += ($twist + $skip);
            }
            else {
                $twist = $twist % $list_size if $twist > $list_size;

                my @change = @$list[$pos .. ($list_size - 1)];
                my $end_size = scalar(@change);
                push(@change, @$list[0 .. ($twist - $end_size - 1)]);
                my $begin_size = scalar(@change) - $end_size;

                my @reversed = reverse(@change);
                # get end first
                splice(@$list, $pos, $end_size, @reversed[0 .. ($end_size - 1)]);
                # then beginning
                splice(@$list, 0, $begin_size, @reversed[$end_size .. (scalar(@reversed) - 1)]);

                $pos += ($twist + $skip);
            }

            while($pos > $list_size) {
                $pos = $pos % $list_size;
            }

            $skip++;

            #    say "$pos $skip";
            #    say join ",", @list;
            #    say scalar @list;
        }
    }
}