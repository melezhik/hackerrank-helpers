# hackerrank-helpers

HackerRank helpers


```perl
use Data::Dumper;

sub dumparray {
    # return
    my $label = shift;
    print "$label: ", "[", join ", ", @_;
    print "]\n";
}

sub dumpme {
    # return
    my $label = shift;
    print "$label:",Dumper(@_);
}

sub logme {
    #return;
    print join " ", @_;
    print "\n";
}
```
