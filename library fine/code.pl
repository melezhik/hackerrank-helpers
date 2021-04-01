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


sub libraryFine {

    my $d1 = shift;
    my $m1 = shift;
    my $y1 = shift;

    my $d2 = shift;
    my $m2 = shift;
    my $y2 = shift;

    my $fine = 0;

    logme("d1", $d1);
    logme("m1", $m1);
    logme("y1", $y1);

    logme("========",".");

    logme("d2", $d2);
    logme("m2", $m2);
    logme("y2", $y2);

    logme("========",".");

    if ($y1 > $y2) {
        logme("late return","y");
        $fine = 10000;
    } elsif ($m1 > $m2 && $y1 == $y2) {
        logme("late return","m");
        $fine = 500*($m1-$m2);
    } elsif ($d1 > $d2 && $m1 == $m2 && $y1 == $y2 ) {
        logme("late return","d");
        $fine = 15*($d1-$d2);
    } else {
        logme("normal return", "no fine");
    }

    logme("fine",$fine);

    logme("========",".");

    return $fine;

}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $d1M1Y1 = <>;
$d1M1Y1 =~ s/\s+$//;
my @d1M1Y1 = split /\s+/, $d1M1Y1;

my $d1 = $d1M1Y1[0];
$d1 =~ s/\s+$//;

my $m1 = $d1M1Y1[1];
$m1 =~ s/\s+$//;

my $y1 = $d1M1Y1[2];
$y1 =~ s/\s+$//;

my $d2M2Y2 = <>;
$d2M2Y2 =~ s/\s+$//;
my @d2M2Y2 = split /\s+/, $d2M2Y2;

my $d2 = $d2M2Y2[0];
$d2 =~ s/\s+$//;

my $m2 = $d2M2Y2[1];
$m2 =~ s/\s+$//;

my $y2 = $d2M2Y2[2];
$y2 =~ s/\s+$//;

my $result = libraryFine $d1, $m1, $y1, $d2, $m2, $y2;

print $fptr "$result\n";

close $fptr;
