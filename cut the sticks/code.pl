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


sub cutTheSticks {

    my $aa = shift;
  
    my @a = map { $_ + 0 } @$aa;


    #dumparray("an",@a);

    @a = sort { $a <=> $b } @a;

    #dumparray("as",@a);

    logme("=====",".");

    my @sticks;


    for my $i (0 .. scalar @a - 1) {
        if ($i == 0){
            push @sticks, scalar @a;
        } else {
            if ( $a[$i] != $a[$i-1]) {
                push @sticks, (scalar @a - $i);
            } 
        }
    }
    
    logme("sticks",@sticks);

    return @sticks;

}

open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = <>;
$n =~ s/\s+$//;

my $arr = <>;
$arr =~ s/\s+$//;
my @arr = split /\s+/, $arr;

my @result = cutTheSticks \@arr;

print $fptr join "\n", @result;
print $fptr "\n";

close $fptr;
