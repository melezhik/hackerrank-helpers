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
# Complete the 'repeatedString' function below.
#
# The function is expected to return a LONG_INTEGER.
# The function accepts following parameters:
#  1. STRING s
#  2. LONG_INTEGER n
#

sub repeatedString {
    # Write your code here

    my $s = shift;
    logme("s",$s);
    my $n = shift;
    logme("n",$n);
  
    my @chars = (split "", $s);

    my $chunk_len = scalar @chars;

    logme("chunk_len",$chunk_len);
    
    my @a = grep {$_ eq "a"} (split "", $s);

    my $a_in_chunk = scalar @a;

    logme("a_in_chunk",$a_in_chunk);

    my $units = int($n/$chunk_len);

    my $cnt = 0;
    my $rem = $n % $chunk_len;

    logme("rem",$rem);

    if ( $rem == 0){
      $cnt = $units * $a_in_chunk
    } else {
      $cnt = $units * $a_in_chunk;
      my @aa = grep {$_ eq "a"} (split "", $s)[0 .. $rem - 1];
      logme("a rem", scalar @aa);
      $cnt += scalar @aa;
    }

    logme("a's cnt", $cnt);
    
    return $cnt;
}

#open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $s = <STDIN>;
chomp($s);

my $n = ltrim(rtrim(my $n_temp = <STDIN>));

my $result = repeatedString $s, $n;

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

