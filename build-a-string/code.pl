#!/usr/bin/perl

use strict;
use warnings;

#
# Complete the buildString function below.
#

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

sub min_copy_len {

    my $price_insert = shift;
    my $price_copy = shift;
    my $min_copy_len = 0;

    $min_copy_len = int($price_copy / $price_insert)+1;

    return $min_copy_len
}

sub buildString {
    #
    # Write your code here.
    #
    
    my $cost = 0;
    
    my $price_insert = shift;
    my $price_copy = shift;
    my $s = shift;
    
    logme("price_insert",$price_insert);
    logme("price_copy",$price_copy);
    logme("s",$s);

    my $a = substr($s,0,1);
    my $s_built.=$a;
    $s = substr($s,1,length($s));
    my $cnt = $price_insert * 1;

    while (1) {


        logme(">","==================================");

        logme("current","$s_built >> $s");

        my $min_copy_len = min_copy_len($price_insert, $price_insert);
        logme("minimal copy len:", $min_copy_len);

        my $depth = length($s_built) < length($s) ? length($s_built) : length($s);

        logme("max copy depth:", $depth);

        last unless $s;

        if ($depth < $min_copy_len){
            $a = substr($s,0,1);
            $s_built.=$a;
            $s = substr($s,1,length($s));
            logme("insert",$a);
            $cnt += $price_insert;
        } else {
            logme("start copy","...");
            my $copy_ok = 0;
            # itterate over right string    
            COPY: for my $d ( reverse(1 .. $depth)) {
                logme("look up","[1 .. $d] : ".(substr($s,0, $d)));
                if (index($s_built, substr($s,0, $d) ) != -1) {
                    $a = substr($s,0,$d);
                    $s_built.=$a;
                    $s = substr($s,$d,length($s));
                    logme("copy",$a);
                    $copy_ok = 1;
                    $cnt+=$price_copy;
                    last COPY;
                }

            }
            if (!$copy_ok){
                logme("copy search was not successful","fall back to insert");
                $a = substr($s,0,1);
                $s_built.=$a;
                $s = substr($s,1,length($s));
                logme("insert",$a);
                $cnt+=$price_insert;
            }       

        }

    }

    print $cost, "\n";
    return $cnt;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $t = <>;
$t =~ s/\s+$//;

for (my $t_itr = 0; $t_itr < $t; $t_itr++) {
    my $nab = <>;
    $nab =~ s/\s+$//;
    my @nab = split /\s+/, $nab;

    my $n = $nab[0];
    $n =~ s/\s+$//;

    my $a = $nab[1];
    $a =~ s/\s+$//;

    my $b = $nab[2];
    $b =~ s/\s+$//;

    my $s = <>;
    chomp($s);

    my $result = buildString $a, $b, $s;

    print $fptr $result, "\n";

}

close $fptr;
