use strict;
use warnings;

use Benchmark qw(timethis timeit :hireswallclock );
use File::Slurp;
use Data::Dumper;
use IO::Null;

my $out;
my $null = IO::Null->new;
my $stdout = select($null);

my $s = "";

sub test {
  $s .= "x";
  $s = "" if length $s > 1_000_000;
  my $r = $s;
  return $s;
}

$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
