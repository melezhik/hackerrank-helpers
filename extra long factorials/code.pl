#!/usr/bin/perl

use strict;
use warnings;
use bigint;

use Data::Dumper;

our $LOGME = 0;

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

# Complete the extraLongFactorials function below.
sub extraLongFactorials {
    my $n = shift;
    logme("n", $n);
    my $f = 1;
    for my $i (1 .. $n){
        $f = $f * $i;
        logme("f[$i]",$f);
    }
    print "$f\n";
}

my $n = <>;
$n =~ s/\s+$//;

extraLongFactorials $n;
