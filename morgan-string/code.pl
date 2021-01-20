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

# Complete the morganAndString function below.
sub morganAndString {

    my $a = shift;
    my $b = shift;
    
    logme("a",$a);
    logme("b",$b);
    
    my @a = split //,$a;
    my @b = split //,$b;
    
    my @result;
    
    dumparray("a",@a);

    dumparray("b",@b);
 
    my $i = shift @a; my $j = shift @b;   
    
    my $shift_a = 0; my $shift_b = 0;
    
    while (1){
        
      if (scalar @a){
          $i = shift @a if $shift_a;       
      } else {
          
          $i = "ZZ"
      }
      
      if (scalar @b){
          $j = shift @b if $shift_b;      
      } else {
          $j = "ZZ"
      }
      
      
      if ($i le $j) {
          push @result, $i;
          $shift_a = 1;
          $shift_b = 0;
      } else {
          push @result, $j;
          $shift_a = 0;
          $shift_b = 1;
      }       
    }

    last if $i eq "ZZ" && $j eq "ZZ";

    return join "", @result; 
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $t = <>;
$t =~ s/\s+$//;

for (my $t_itr = 0; $t_itr < $t; $t_itr++) {
    my $a = <>;
    chomp($a);

    my $b = <>;
    chomp($b);

    my $result = morganAndString $a, $b;

    print $fptr "$result\n";
}

close $fptr;
