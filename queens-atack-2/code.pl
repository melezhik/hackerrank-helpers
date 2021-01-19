#!/usr/bin/perl

use strict;
use warnings;


use Data::Dumper;

our $LOGME = 0;

our %obst;

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


sub find_obst {
    
    my $x = shift;
    my $y = shift;
    return $obst{"$x:$y"};
    return 1;
}


# Complete the queensAttack function below.
sub queensAttack {

    #dumpme("input",\@_);
    my $board_size = shift;
    my $obst_cnt = shift;
    
    logme("board_size",$board_size);
    logme("obst_cnt",$obst_cnt);
    
    my $q_y = shift;
    my $q_x = shift;

    logme("q_y",$q_y);
    logme("q_x",$q_x);
    
    my $obst = shift;

    for my $i (@$obst){ 
       my $x = $i->[1];
       my $y = $i->[0];
       $obst{"$x:$y"} = "X";       
    }    

    dumpme("obst",$obst);
    dumpme("obst_hash",\%obst);

    my $x = $q_x;
    my $y = $q_y;
    
    my $free_cells = 0;
    my $free_cells_before = $free_cells;
    
    # find obst to the right
    while (1){
       last if $q_x == $board_size; 
       if (find_obst($x,$y)){
           $free_cells = $free_cells + ( $x - $q_x - 1);
           last;
       }
       $x++;
       if ($x > $board_size) {
         $free_cells = $free_cells + ( $board_size - $q_x);
         last;    
       } 
    }

    logme("east(right) increase", $free_cells - $free_cells_before);

    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
  
    # find obst to the left
    while (1){
       last if $q_x == 1; 
       if (find_obst($x,$y)){
           $free_cells = $free_cells + ( $q_x - $x - 1);
           last;
       }
       $x--;
       if ($x < 1) {
         $free_cells = $free_cells + $q_x - 1;
         last;    
       } 
    }

    logme("west(left) increase", $free_cells - $free_cells_before);
 
    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
 
    # find obst to the north (up)
    while (1){
       last if $q_y == $board_size; 
       if (find_obst($x,$y)){
           $free_cells = $free_cells + ( $y - $q_y - 1);
           last;
       }
       $y++;
       if ($y > $board_size) {
         $free_cells = $free_cells + ( $board_size -  $q_y );
         last;    
       } 
    }
    
    logme("north(up) increase", $free_cells - $free_cells_before);
    
    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
 
    # find obst to the south (down)
    while (1){
       last if $q_y == 1; 
       if (find_obst($x,$y)){
           $free_cells = $free_cells + ( $q_y - $y - 1);
           last;
       }
       $y--;
       if ($y < 1) {
         $free_cells = $free_cells + ( $q_y -  1 );
         last;    
       } 
    }

    logme("south(down) increase", $free_cells - $free_cells_before);

    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;

    my $j = 0;
    
    # find obst to the south-west (left and down)
    while (1){
       last if $q_x == 1 or $q_y == 1;
  
       if (find_obst($x,$y)){
           unless ($x == $q_x && $y == $q_y){
               $free_cells = $free_cells + $j - 1;           
           }
           last;
       }
  
       $x--; $y--;
       $j++;
  
       if ($y < 1 or $x < 1) {
         $free_cells = $free_cells + $j - 1;
         last;    
       } 
  
    }
    
    logme("south-west(left and down) increase", $free_cells - $free_cells_before);

    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
    $j = 0;
 
    # find obst to the north-west (left and up)
    while (1){
        
       last if $q_x == 1 or $q_y == $board_size;
  
       if (find_obst($x,$y)){
           unless ($x == $q_x && $y == $q_y){
               $free_cells = $free_cells + $j - 1;           
           }
           last;
       }
  
       $x--; $y++;
       $j++;
  
       if ($y > $board_size or $x < 1) {
         $free_cells = $free_cells + $j - 1;
         last;    
       } 
  
    }

    logme("north-west(left and up) increase", $free_cells - $free_cells_before );
    
    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
    $j = 0;
 
    # find obst to the north-east (right and up)
    while (1){
        
       last if $q_x == $board_size or $q_y == $board_size;
  
       if (find_obst($x,$y)){
           unless ($x == $q_x && $y == $q_y){
               $free_cells = $free_cells + $j - 1;           
           }
           last;
       }
  
       $x++; $y++;
       $j++;
  
       if ($y > $board_size or $x > $board_size) {
         $free_cells = $free_cells + $j - 1;
         last;    
       } 
  
    }

    logme("north-east(right and up) increase", $free_cells - $free_cells_before);

    $x = $q_x;
    $y = $q_y;
    $free_cells_before = $free_cells;
    $j = 0;
 
    # find obst to the south-east (right and down)
    while (1){
        
       last if $q_x == $board_size or $q_y == 1;
  
       if (find_obst($x,$y)){
           unless ($x == $q_x && $y == $q_y){
               $free_cells = $free_cells + $j - 1;           
           }
           last;
       }
  
       $x++; $y--;
       $j++;
  
       if ($y < 1 or $x > $board_size) {
         $free_cells = $free_cells + $j - 1;
         last;    
       } 
  
    }
 
    logme("south-east(right and down) increase", $free_cells - $free_cells_before);
      
    return $free_cells;
}


open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $nk = <>;
$nk =~ s/\s+$//;
my @nk = split /\s+/, $nk;

my $n = $nk[0];
$n =~ s/\s+$//;

my $k = $nk[1];
$k =~ s/\s+$//;

my $r_qC_q = <>;
$r_qC_q =~ s/\s+$//;
my @r_qC_q = split /\s+/, $r_qC_q;

my $r_q = $r_qC_q[0];
$r_q =~ s/\s+$//;

my $c_q = $r_qC_q[1];
$c_q =~ s/\s+$//;

my @obstacles = ();

for (1..$k) {
    my $obstacles_item = <>;
    $obstacles_item =~ s/\s+$//;
    my @obstacles_item = split /\s+/, $obstacles_item;

    push @obstacles, \@obstacles_item;
}

my $result = queensAttack $n, $k, $r_q, $c_q, \@obstacles;

print $fptr "$result\n";

close $fptr;
