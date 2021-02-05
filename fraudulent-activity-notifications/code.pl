#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

our $LOGME = 1;
our @heap;
our $heapSize;
our @dd_sorted;
our $fd_index = 0;
our $fd;

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

sub add {
    my $value = shift;
    
    push @heap, $value;
    my $hs = scalar @heap;
    my $i = $hs - 1;
    
    my $parent = int(($i - 1) / 2);

    while ($i > 0 && $heap[$parent] < $heap[$i])
    {
        my $temp = $heap[$i];

        $heap[$i] = $heap[$parent];
        
        $heap[$parent] = $temp;

        $i = $parent;
        
        $parent = int(($i - 1) / 2);
        
    }
}

sub heapify {
    
    my $i = shift;
    my $track_fd =  shift || 0;
    
    #logme("run heapify for i",$i);

    my $hs = scalar @heap;
    
    my $leftChild;
    my $rightChild;
    my $largestChild;
    
    while(1){
        
        $leftChild = 2 * $i + 1;
        $rightChild = 2 * $i + 2;
        $largestChild = $i;
              
        if ($leftChild < $hs) {
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
        $fd_index = $i if $track_fd && $fd == $temp; # track first day index in heap
        $heap[$i] = $heap[$largestChild];
        $fd_index = $largestChild if $track_fd && $fd == $heap[$largestChild]; # track first day index in heap
        $heap[$largestChild] = $temp;
        $i = $largestChild;
            
    }

    if ($track_fd){
        $fd_index = $i if $fd == $heap[$largestChild]; # track first day index in heap
    }

}

sub getMax {
    my $result = $heap[0];
    $heap[0] = pop @heap;
    return $result;
}

sub heapSort {

    my @r;

    my @tmp =  @heap;

    for (my $i = (scalar @heap) - 1; $i >= 0; $i--)
    {
        $r[$i] = getMax();
        heapify(0);
    }
    
    @heap = @tmp;

    return @r;
} 

sub build_heap {

    my $hs = scalar @heap;

    for (my $i = int($hs / 2); $i >= 0; $i--)
    {
        heapify($i,1);
    }

}

sub mediana {

    my $m;
    my $i = int($heapSize/2);
    my $j =  $i - 1;
    
    if ($heapSize % 2 ==  1){
        $m = $dd_sorted[$i];
        logme("heapSize is not even, middle index", $i);
        logme("heapSize is not even, m", $m);
    } else {
        $m = ($dd_sorted[$i] + $dd_sorted[$j]) / 2;
        logme("heapSize is even, middle indexes", "$j:$i ($dd_sorted[$i]:$dd_sorted[$j])");
        logme("heapSize is even, m", $m);
    }

    return $m;

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
 
    dumparray("initial heap",@heap);

    $fd = $heap[0]; # remember first day

    # create binary heap from first $d elements of @$days
    build_heap();

    dumparray("heap",@heap);

    logme("initial state", "(fd=$fd, index_in_heap:$fd_index)");

    @dd_sorted = heapSort();

    dumparray("last $d sorted days",@dd_sorted);

    my $m = mediana();

    my $k = 0;
   
    for my $i (@$days){

       $k++;

       next unless $k > $d; # start counting frauds after $d days

       #print "process $k ...\n";

       logme(">>>","=================");

       logme("[$k] process day:", "$i (fd=$fd, index_in_heap:$fd_index) (m=$m)"); 

       if ($i >= 2*$m){
            $ntf++;
            logme("bump notification counter, suspisiously high expenses for this day",$ntf);
        }

       if ($i == $fd) {

           logme("current day: $d equal the first day: $fd", "don't recalculate heap, sorted days and mediana");

           # do noting if the current day expense as the first day expense
           # because this does not change mediana

            #dumparray("[k] heap",@heap);
            #dumparray("[k] last $d sorted days",@dd_sorted);

       } else {

            # subsitute the first day in the heap by the current day
            # then restore heaps properties
            # and recalculate mediana
            
            logme("rebuild heap", "replace [$fd] by [$i]");

            #for my $j (0 .. (scalar @heap)-1){
            #    if ($heap[$j] == $fd){
                    $heap[$fd_index] = $i;
                    heapify($fd_index,1);
                    @dd_sorted = heapSort(); 
                    #dumparray("[u] heap",@heap);
                    #dumparray("[u] last $d sorted days",@dd_sorted);
                    $m = mediana();
                    $fd = $i;
                    #last;
            #    }
            #}

       } 
 
 
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
