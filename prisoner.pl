#!/usr/bin/env perl

sub makeBoxes($) {
    my $total = shift;
    my @arr = (1 .. $total);
    my %boxes = ();

    foreach my $val (1 .. $total) {
        my $index = int(rand(scalar @arr));
        $boxes{$val} = $arr[$index];
        splice @arr, $index, 1;
    }
    return %boxes;
}

sub findLongestLoop {
    my (%boxes) = @_;
    my $size = scalar(keys %boxes);
    my $max = 0;
    my %found = ();

    foreach my $val (1 .. $size) {
        if (!(exists $found{$val})) { 
            my $count = 1;
            my $index = $val;
            while ($boxes{$index} != $val) {
                $found{$index} = 1;
                $count++;
                $index = $boxes{$index};
            }
            $max = $count if ($count > $max);
        }
    }
    return $max;
}

my $boxes = 1e3;
my $trials = 1e3;
my $wins = 0;

foreach my $t (1 .. $trials) {
    $result = &findLongestLoop(&makeBoxes($boxes));
    $wins++ if ($result <= $boxes/2)
}

print "$wins / $trials = " . ($wins / $trials * 100) . "%\n"; 
