#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use bigint;

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
# Complete the 'nonDivisibleSubset' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER k
#  2. INTEGER_ARRAY s
#

sub nonDivisibleSubset {
    # Write your code here

    my $k = shift;
    logme("k:",$k);

    my $arr = shift;
    my @f;

    dumparray("a",@$arr);

    for my $i ( 0 .. $k - 1 ) {
      $f[$i] = 0;
    }

    my @a = @$arr;
    
    for my $i (@a) {
      #logme("i:",$i);
      $f[$i % $k]++;
    }

    dumparray("f",@f);

    if ($k % 2 == 0) {
      my $m = $k / 2;
      $f[$m] = 1 if $f[$m] > 1;
    }

    dumparray("f_n",@f);

    my $res = $f[0] > 1 ? 1 : $f[0];

    logme("res0:",$res); 

    for my $i (1 .. int($k / 2)) {
      logme(
        "compare:", 
        "$i => ".($k - $i)." || ".$f[$i]." vs ".($f[$k - $i])
      );
      $res += $f[$i] > $f[$k - $i] ? $f[$i] : $f[$k - $i];
    }
    logme("res:",$res);
    return $res;
}

#open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my @first_multiple_input = split /\s+/, rtrim(my $first_multiple_input_temp = <STDIN>);

my $n = $first_multiple_input[0];

my $k = $first_multiple_input[1];

my $s = rtrim(my $s_temp = <STDIN>);

my @s = split /\s+/, $s;

my $result = nonDivisibleSubset $k, \@s;

#print $fptr "$result\n";

#close $fptr;

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

