#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw{any all sum0};

my $inpath = "../../resources/12/input.txt";
#my $inpath = "../../resources/12/test_input.txt";
open(my $fh, "<", $inpath) or die "Unable to open input file: '$inpath'";

my %tree = ();
my $last_parent = 0;
while(my $line = <$fh>) {
    my ($parent, $children) = ($line =~ /^(\d+)\s+<->\s+(.*)$/);
    $last_parent = $parent;
    map {push(@{$tree{$parent}}, int($_))}  split /, /, $children;
}

# part 1
my %seen;
my $group_size = 1; # initialize with zero
for my $i (1..$last_parent) {
    %seen = ();
    $seen{0} = 1;
    $group_size += search_tree($tree{$i});
}
say $group_size;

#part 2
my @seen;
my $groups = 0;
for my $i (0..$last_parent) {
    my $count = traverse($i);
    $groups++ if($count > 0);
}
say $groups;

sub search_tree {
    my ($base) = @_;

    if (any {$_ == 0} @{$base}) {
        return 1;
    } elsif (all {exists($seen{$_})} @{$base}) {
        return 0;
    } else {
        return sum0
          map {
              if (!exists($seen{$_})) {
                  $seen{$_} = 1;
                  search_tree($tree{$_});
              }
          } @{$base};
    }
}

sub traverse {
    my $root = shift;
    my $all = 0;
    foreach my $child (@{$tree{$root}}) {
        next if(grep {$child == $_} @seen);
        push @seen, $child;
        $all++;
        $all += traverse($child);
        delete $tree{$child};
    }
    return $all;
}