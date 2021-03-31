#!/usr/bin/perl
#$ENV{'OUTPUT_PATH'} = "in.txt";

use strict;
use warnings;
use bigint;

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

# Complete the extraLongFactorials function below.
sub appendAndDelete {

    my $s = shift;
    my $t = shift;
    my $k = shift;

    logme("k", $k);
    return "Yes" if $s eq $t;

    my @s = split //, $s;
    my @t = split //, $t;

    dumparray("s", @s);
    dumparray("t", @t);

    my $steps = 0;
    my $s_left = 0;
    my $t_left = 0;

    for my $i (0 .. scalar @s - 1){
        if ($s[$i] eq $t[$i]){
            logme("s and t has the same element",$s[$i]);
            $s_left = (scalar @s - $i);
            $t_left = (scalar @t - $i);
            next
        } else {
            logme("exit","loop");
            $s_left = (scalar @s - $i);
            $t_left = (scalar @t - $i);
            last
        }

    }


    logme("s_left",$s_left);
    logme("t_left",$t_left);

    if ($s_left + $t_left > $k){
        logme("result","No");    
        return "No"
    }

    if ($s_left + $t_left == $k){
        logme("result","Yes (equal)");    
        return "Yes"
    }

    if (($k - ($s_left + $t_left)) % 2 == 0){
        logme("result","Yes (even reminder)");    
        return "Yes"
    }

    if ($t_left == 0 && ( $k - $s_left) % 2 != 0 ){

        logme("result","Yes (not even)");    
        return "Yes";

    }

    if ($s_left == scalar @s){

        logme("result","Yes (zero s)");    
        return "Yes";

    }

    logme("result","No (not even reminder)");    
    return "No";

}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $s = <>;
chomp($s);

my $t = <>;
chomp($t);

my $k = <>;
$k =~ s/\s+$//;

my $result = appendAndDelete $s, $t, $k;

print $fptr "$result\n";

close $fptr;

