#!/usr/bin/env perl

use Modern::Perl;
use Algorithm::Permute;

my $input = 368078;

say manhattanDistance(rotateAroundOrigin($input), [0,0]);
say sumAroundOrigin($input);

sub manhattanDistance {
    my ($p, $q) = @_;

    return abs(@$p[0] - @$q[0]) + abs(@$p[1] - @$q[1]);
}

sub rotateAroundOrigin {
    my $num = shift;
    my $x_max = 1;
    my $y_max = 1;
    my $x_direction = 1;
    my $y_direction = -1;

    my $location = [ 0, 0 ];

#    say $num;
    for (my $i = 1; $i < $num; $i++) {
        if ((@$location[0] == 0 && @$location[1] == 0)
            || ($x_max > @$location[0]
                && (-1 * ($y_max - 1)) == @$location[1]
                && $x_direction > 0
                && $y_direction < 0)) {
#            say "right";
            @$location[0] += 1;

            if ($x_max == @$location[0]) {
                $y_direction = 1;
            }
        } elsif ($x_max == @$location[0]
                && $y_max > @$location[1]
                && $x_direction > 0
                && $y_direction > 0) {
#            say "up";
            @$location[1] += 1;

            if ($y_max == @$location[1]) {
                $x_direction = -1;
            }
        } elsif((-1 * $x_max) < @$location[0]
                && $y_max == @$location[1]
                && $x_direction < 0
                && $y_direction > 0) {
#            say "left";
            @$location[0] -= 1;

            if((-1 * $x_max) == @$location[0]) {
                $x_max += 1;
                $y_direction = -1;
            }
        } elsif((-1 * $x_max) == (@$location[0] - 1)
                && (-1 * $y_max) < @$location[1]
                && $x_direction < 0
                && $y_direction < 0) {
#            say "down";
            @$location[1] -= 1;

            if ((-1 * $y_max) == @$location[1]) {
                $y_max += 1;
                $x_direction = 1;
            }
        }
    }

    return $location;
}

sub sumAroundOrigin {
    my $testVal = shift;
    my %grid_values = ();
    my $x_max = 1;
    my $y_max = 1;
    my $x_direction = 1;
    my $y_direction = -1;

    my $location = [ 0, 0 ];

    for (my $i = 1; $i < $testVal; $i++) {
        if ((@$location[0] == 0 && @$location[1] == 0)
          || ($x_max > @$location[0]
          && (-1 * ($y_max - 1)) == @$location[1]
          && $x_direction > 0
          && $y_direction < 0)) {
            my $locationValue = setGridValue($location, \%grid_values);
            if($locationValue > $testVal) {
                return $locationValue;
            }
            #            say "right";
            @$location[0] += 1;

            if ($x_max == @$location[0]) {
                $y_direction = 1;
            }
        } elsif ($x_max == @$location[0]
          && $y_max > @$location[1]
          && $x_direction > 0
          && $y_direction > 0) {
            my $locationValue = setGridValue($location, \%grid_values);
            if($locationValue > $testVal) {
                return $locationValue;
            }
            #            say "up";
            @$location[1] += 1;

            if ($y_max == @$location[1]) {
                $x_direction = -1;
            }
        } elsif((-1 * $x_max) < @$location[0]
          && $y_max == @$location[1]
          && $x_direction < 0
          && $y_direction > 0) {
            my $locationValue = setGridValue($location, \%grid_values);
            if($locationValue > $testVal) {
                return $locationValue;
            }
            #            say "left";
            @$location[0] -= 1;

            if((-1 * $x_max) == @$location[0]) {
                $x_max += 1;
                $y_direction = -1;
            }
        } elsif((-1 * $x_max) == (@$location[0] - 1)
          && (-1 * $y_max) < @$location[1]
          && $x_direction < 0
          && $y_direction < 0) {
            my $locationValue = setGridValue($location, \%grid_values);
            if($locationValue > $testVal) {
                return $locationValue;
            }
            #            say "down";
            @$location[1] -= 1;

            if ((-1 * $y_max) == @$location[1]) {
                $y_max += 1;
                $x_direction = 1;
            }
        }


    }

    return $location;
}

sub setGridValue {
    my ($location, $gridValues) = @_;
    my $permutations = Algorithm::Permute->new([-1, 0, 1], 2);
    my $value = 0;

#    say "" . (join ",", @$location);

    while(my @combo = $permutations->next()) {
#        say "checking: " . (@$location[0] + $combo[0]) . " " . (@$location[1] + $combo[1]);
        if(exists($gridValues->{@$location[0] + $combo[0]}{@$location[1] + $combo[1]})) {
            $value += $gridValues->{@$location[0] + $combo[0]}{@$location[1] + $combo[1]};
        }
    }

    # have to do 1,1 and -1,-1, too ^ algorithm only makes exclusive pairs
    if(exists($gridValues->{@$location[0] + 1}{@$location[1] + 1})) {
        $value += $gridValues->{@$location[0] + 1}{@$location[1] + 1};
    }

    if(exists($gridValues->{@$location[0] - 1}{@$location[1] - 1})) {
        $value += $gridValues->{@$location[0] - 1}{@$location[1] - 1};
    }

    $value ||= 1;

    $gridValues->{@$location[0]}{@$location[1]} = $value;
#    say "" . (join ",", @$location) . " " . $value;

    return $value;
}