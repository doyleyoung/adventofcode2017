#!/usr/bin/env perl

use Modern::Perl;

say manhattanDistance(rotateAroundOrigin(368078), [0,0]);

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

    #    say $num;
    for (my $i = 1; $i < $num; $i++) {
        if ((@$location[0] == 0 && @$location[1] == 0)
          || ($x_max > @$location[0]
          && (-1 * ($y_max - 1)) == @$location[1]
          && $x_direction > 0
          && $y_direction < 0)) {
            #            say "right";
            @$location[0] += 1;
            setGridValue($location, \$grid_values);

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

sub setGridValue {
    my ($location, $gridValues) = @_;


}