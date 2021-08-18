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
# Complete the 'equalizeArray' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY arr as parameter.
#

sub equalizeArray {
    # Write your code here
    my $ar = shift;

    my @ar = @$ar;

    dumparray("a",@ar);

    my %seen;
    my $rm_cnt = 0;

    for my $i (@ar) {
      $seen{$i} = (scalar @ar);
    }

    dumpme("seen", \%seen);

    for my $i (@ar) {
      #logme("i",$i);
      $seen{$i}--;
    }

    dumpme("seen", \%seen);

    dumparray("seen keys",keys %seen);

    my @a_sorted = sort { $seen{$a} <=> $seen{$b} } keys %seen;

    dumparray("a_sorted",@a_sorted);

    my $rm_cnt_k = $a_sorted[0];

    logme("rm_cnt",$seen{$rm_cnt_k});

    return $seen{$rm_cnt_k};
}

#open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = ltrim(rtrim(my $n_temp = <STDIN>));

my $arr = rtrim(my $arr_temp = <STDIN>);

my @arr = split /\s+/, $arr;

my $result = equalizeArray \@arr;

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

