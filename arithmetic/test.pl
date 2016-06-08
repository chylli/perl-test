use strict;
use warnings;

use Benchmark qw(timethis timeit :hireswallclock );
use File::Slurp;
use Data::Dumper;
use IO::Null;

my $out;
my $null = IO::Null->new;
my $stdout = select($null);

sub test {
  my $a = 5678.2;
  my $b = 1234.3;
  my $c = $a + $b;
  $c = $a - $b;
  $c = $a * $b;
  $c = $a / $b;
  $c = $a ** 0.5;
  $c = sin($a);
  use integer;
  $c = $a + $b;
  $c = $a - $b;
  $c = $a * $b;
  $c = $a / $b;
  $c = $a ** 0.5;
  $c = sin($a);
}

$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
