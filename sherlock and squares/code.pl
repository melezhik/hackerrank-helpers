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

sub find_int_sqrt {

    my $N = shift;

    #logme("find qn",$N);
    
    my $sqrt = sprintf "%f", sqrt($N);
    
    #logme("sn",$sn);
    my $nearest_sqrt = sprintf "%d", $sqrt;
    return $nearest_sqrt == $sqrt ? $nearest_sqrt : $nearest_sqrt+1;
}

sub squares {

    my $a = shift;
    my $b = shift;
    
    logme("a", $a);
    logme("b", $b);
    logme("=======",".");
    my $aa = find_int_sqrt($a);
    my $bb = int(sqrt($b));
    my $cnt = $bb - $aa + 1;
    logme("aa",$aa);
    logme("bb",$bb);
    logme("cnt",$cnt);
    logme("=======",".");
    return $cnt;
}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $q = <>;
$q =~ s/\s+$//;

for (my $q_itr = 0; $q_itr < $q; $q_itr++) {
    my $ab = <>;
    $ab =~ s/\s+$//;
    my @ab = split /\s+/, $ab;

    my $a = $ab[0];
    $a =~ s/\s+$//;

    my $b = $ab[1];
    $b =~ s/\s+$//;

    my $result = squares $a, $b;

    print $fptr "$result\n";
}

close $fptr;
