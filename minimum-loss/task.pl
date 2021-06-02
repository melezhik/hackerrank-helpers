#!perl

#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

our $LOGME = 1;

sub dumparray {
    return unless $LOGME;
    my $label = shift;
    print "$label: ", "[", join ", ", @_;
    print "]\n";
}

sub dumpme {
    return unless $LOGME;
    my $label = shift;
    print "$label:",Dumper(@_);
}

sub logme {
    return unless $LOGME;
    print join " ", @_;
    print "\n";
}


#
# Complete the 'minimumLoss' function below.
#
# The function is expected to return an INTEGER.
# The function accepts LONG_INTEGER_ARRAY price as parameter.
#

sub minimumLoss {
    # Write your code here

    my $prices = shift;
    dumparray("prices",@$prices);
    my @prices_sorted = sort { $a <=> $b } @$prices;
    my $min_loss = 100000000;

    my %prices_to_index;

    my $j = 0;

    for my $i (@$prices) {
      $prices_to_index{$i} = $j; # map price to array index
      $j++;
    };

    dumpme("prices to index",\%prices_to_index);

    dumparray("prices_sorted",@prices_sorted);

    for my $i (1 .. scalar (@prices_sorted) - 1) {
      logme("i",$i);
      logme("price a",$prices_sorted[$i-1]);
      logme("price b",$prices_sorted[$i]);
      logme("index a",$prices_to_index{$prices_sorted[$i-1]});
      logme("index b",$prices_to_index{$prices_sorted[$i]});
      if (
        ($prices_sorted[$i] - $prices_sorted[$i-1]) < $min_loss
          &&
        ($prices_to_index{$prices_sorted[$i]} < $prices_to_index{$prices_sorted[$i-1]})
      ) {
        $min_loss = $prices_sorted[$i] - $prices_sorted[$i-1];
        logme("set min loss",$min_loss);
      }
      #print "$i\n";
    }

    logme("min loss",$min_loss);
    return $min_loss;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = ltrim(rtrim(my $n_temp = <STDIN>));

my $price = rtrim(my $price_temp = <STDIN>);

my @price = split /\s+/, $price;

my $result = minimumLoss \@price;

print $fptr "$result\n";

close $fptr;

sub ltrim {
    my $str = shift;

    $str =~ s/^\s+//;

    return $str;
}

sub rtrim {
    my $str = shift;

    $str =~ s/\s+$//;

    return $str;
}
