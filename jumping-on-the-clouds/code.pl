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
# Complete the 'jumpingOnClouds' function below.
#
# The function is expected to return an INTEGER.
# The function accepts INTEGER_ARRAY c as parameter.
#

sub jumpingOnClouds {
    # Write your code here
    my $a  = shift;
    my @a = @$a;

    dumparray("a",@a);

    my $i = 0;

    my $hops;

    while (1) {
      
      if ( defined($a[$i+1]) and defined($a[$i+2]) ) {
        if ($a[$i+1] == 0 and $a[$i+2] == 0) {
          $hops++;
          logme("double hop over 0","i=$i");
          $i = $i + 2;
        } elsif ($a[$i+2] == 0) {
          logme("double hop over 1","i=$i");
          $i = $i + 2;
          $hops++;
        } elsif ($a[$i+1] == 0) {
          logme("single hop","i=$i");
          $i = $i + 1;
          $hops++;
        }
      } elsif (defined($a[$i+1])) {
          if ($a[$i+1] == 0) {
            logme("last single hop","i=$i");
            $i = $i + 1;
            $hops++;
          }
      } else {
        last
      }
    }

    logme("hops",$hops);

    print $hops;

}

#open(my $fptr, '>', $ENV{'OUTPUT_PATH'});

my $n = ltrim(rtrim(my $n_temp = <STDIN>));

my $c = rtrim(my $c_temp = <STDIN>);

my @c = split /\s+/, $c;

my $result = jumpingOnClouds \@c;

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

