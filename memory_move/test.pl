use strict;
use warnings;

use Benchmark qw(timethis timeit :hireswallclock );
use File::Slurp;
use Data::Dumper;
use IO::Null;

my $out;
my $null = IO::Null->new;
my $stdout = select($null);

my @a = (0) x 1000;
sub test {
  my @b = ([@a]);
  for my $i (1..10){
    $b[$i] = [@a];
    $b[$i-1] = [];
  }
}

$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
