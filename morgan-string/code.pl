#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
# Complete the morganAndString function below.
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

our @a;
our @b;

sub cmp_chars {

    my $i = shift;
    my $j = shift;

    return 1 if $i gt $j;

    return -1 if $i lt $j;

    return -1 unless @a; # a considered is less then b if there is no following elements in @a

    return 1 unless @b; # a considered is greater then b if there is no following elements in @b
    
    my @aa = @a;
    my @bb = @b;
    
    #return 0;
    
    while (1){
       my $a = shift @aa;
       my $b = shift @bb;
       return -1 if $a lt $b;
       return 1  if $a gt $b;
       return -1 unless @aa;
       return 1 unless @bb;
    }
    
    return 0;
    
}


# Complete the morganAndString function below.
sub morganAndString {

    my $a = shift;
    my $b = shift;
    
    logme("a",$a);
    logme("b",$b);
    
    @a = split //,$a;
    @b = split //,$b;
    
    my $res;
    
    dumparray("a",@a);

    dumparray("b",@b);
 
    my $i = shift @a; my $j = shift @b;   
    
    #my $shift_a = 0; my $shift_b = 0;
    
    while (1){
       
      logme("a top",$i);
      logme("b top",$j);
        
      if (cmp_chars($i,$j) < 1) {
          $res.=$i;
          logme("push from a","[$i] [$res]");
          if (scalar @a){
              $i = shift @a;
          } else {
             if (scalar @b) {
                  for my $c ($j, @b){
                    $res.=$c;  
                    logme("push last chunk from b","[$c] [$res]");   
                  }
                  last              
             } else {
                 last
             }
          }
      } else {
          $res.=$j;
          logme("push from b","[$j] [$res]");
          if (scalar @b){
              $j = shift @b;
          } else {
             if (scalar @a) {
                  for my $c ($i, @a){
                    $res.=$c; 
                    logme("push last chunk from a","[$c] [$res]");   
                  }
                  last              
             } else {
                 last
             }
          }
      }          
    }


    return $res; 
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
