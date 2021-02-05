#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

our $LOGME = 1;
our $fd;
our %stat;

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

# Complete the activityNotifications function below.


sub mediana {

    my $m;
    
    my $cnt = 0;

    my @exp = grep {$stat{$_}} sort { $a <=> $b } keys %stat;

    my @arr;

    for my $c (@exp) {
      for my $i (1 .. $stat{$c}){
          push @arr, $c;
      }
    }

    dumparray("mediana, sorted array",@arr);

    my $d = scalar @arr;

    my $i = int($d/2);
    my $j = $i - 1;

    if ($d % 2 ==  1){
        $m = $arr[$i];
        logme("d is not even, middle index", $i);
        logme("d is not even, value", $m);
    } else {
        
        $m = ($arr[$i] + $arr[$j])/2;
        logme("d is even, middle indexes", "$j:$i");
        logme("d is even, middle values", "$arr[$j]:$arr[$i]");
        logme("d is even, value", $m);

    }

    return $m;

}

sub init_stat {

    my $d = shift;
    for my $s (0..200){
        $stat{$s} = 0;
    }

    for my $d (@$d) {
        $stat{$d}++;
    }
}

sub activityNotifications {

   my $ntf = 0;
   
   my $days = shift;
   
   dumparray("days",@$days);

   my $d = shift;
   
   logme("d",$d);
   
   if (scalar @$days <= $d){
       
       logme("not enough stat, d",$d);
       return 0;
       
   }
   
    my @stat = @$days[0..$d-1];
 
    init_stat(\@stat);

    dumparray("initial days",@stat);
    #dumpme("initial stat",\%stat);

    $fd = $stat[0]; # remember first day

    logme("initial state", "fd=$fd");

    my $m = mediana();

    my $k = 0;
    my $l = 0;

    for my $i (@$days){

       $k++;

       next unless $k > $d; # start counting frauds after $d days

       #print "process $k ...\n";

       logme(">>>","=================");

       logme("[$k] process day:", "(day=$i) (fd=$fd) (m=$m)"); 

       if ($i >= 2*$m){
            $ntf++;
            logme("bump notification counter, suspisiously high expenses for this day",$ntf);
        }

        $stat{$fd}--;
        $stat{$i}++;
        $l++;
        $fd = $days->[$l]; 
        $m = mediana();
 
    }
    
    logme("total notifications to be send:", $ntf);

    return $ntf;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $nd = <>;
$nd =~ s/\s+$//;
my @nd = split /\s+/, $nd;

my $n = $nd[0];
$n =~ s/\s+$//;

my $d = $nd[1];
$d =~ s/\s+$//;

my $expenditure = <>;
$expenditure =~ s/\s+$//;
my @expenditure = split /\s+/, $expenditure;

my $result = activityNotifications \@expenditure, $d;

print $fptr "$result\n";

close $fptr;
