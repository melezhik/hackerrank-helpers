# hackerrunk-helpers

HackerRank helpers


```perl
use Data::Dumper;

sub dumpme {
    print Dumper(@_);
}

sub logme {
    return;
    print join " ", @_;
    print "\n";
}
```
