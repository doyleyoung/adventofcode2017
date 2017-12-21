use v6;

my $sum = 0;
my $div_sum = 0;
#for '../../resources/2/example.txt'.IO.lines -> $line {
for '../../resources/2/spreadsheet.txt'.IO.lines -> $line {
    my @vals = split /\s+/, $line;

    # must cast to Int or string comparison is used, no bueno
    $sum += @vals.max({$_.Int}) - @vals.min({$_.Int});

    for @vals.combinations(2) {
        if $_[0] % $_[1] == 0 {
            $div_sum += ($_[0] / $_[1]);
        } elsif $_[1] % $_[0] == 0 {
            $div_sum += ($_[1] / $_[0]);
        }
    }
}

say $sum;
say $div_sum;