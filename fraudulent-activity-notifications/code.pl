#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

our $LOGME = 1;
our @heap;
our $heapSize;

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

sub heapify {
    
    my $i = shift;
    
    logme("run heapify for i",$i);
    my $hs = scalar @heap;
    
    my $leftChild;
    my $rightChild;
    my $largestChild;
    
    while(1){
        
        $leftChild = 2 * $i + 1;
        $rightChild = 2 * $i + 2;
        $largestChild = $i;
      
        
        if ($leftChild < $hs) {
            #logme('$leftChild < $heapSize',"$leftChild|$heapSize");
            #logme('$leftChild',$leftChild);
            #logme('$heap[$leftChild]',$heap[$leftChild]);
            #logme('$leftChild',$leftChild);
            #logme('$heap[$leftChild]',$heap[$leftChild]);
            #logme('heapSize',$heapSize); 
            if ($heap[$leftChild] > $heap[$largestChild]) 
            {
                $largestChild = $leftChild;
            }
        }
        if ($rightChild < $hs ) {
            if ( $heap[$rightChild] > $heap[$largestChild])
            {
            $largestChild = $rightChild;
            }
        }
        if ($largestChild == $i) 
        {
            last;
        }

        my $temp = $heap[$i];
        $heap[$i] = $heap[$largestChild];
        $heap[$largestChild] = $temp;
        $i = $largestChild;
            
    }
    
}

sub getMax {
    my $result = $heap[0];
    $heap[0] = pop @heap;
    return $result;
}

sub heapSort {

    my @r;

    for (my $i = (scalar @heap) - 1; $i >= 0; $i--)
    {
        $r[$i] = getMax();
        heapify(0);
    }
        
    return @r;
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
   
   our $heapSize = $d + 0;

   our @heap = @$days[0..$heapSize-1];
 
    dumparray("unsorted heap",@heap);
    
    
    # create binary heap from first $d elements of @$days
    for (my $i = int($heapSize / 2); $i >= 0; $i--)
    {
        heapify($i);
    }
 
   dumparray("semi sorted heap",@heap);
   
   my @dd_sorted = heapSort();

   dumparray("last $d sorted days",@dd_sorted);
    
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
