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
  my $a = "hello world " x 10 . "hello world2 " x 10 ;
  $a =~ /(hello world ){5}hello (world2)/;
  my $b = $1;
  $a =~ s/world/World/g;
}

$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
