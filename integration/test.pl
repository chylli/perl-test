use strict;
use warnings;

use Moose;
use Benchmark qw(timethis timeit :hireswallclock );
use File::Slurp;
use Data::Dumper;
use IO::Null;

my $out;
my $null = IO::Null->new;
my $stdout = select($null);


package Point;
use Moose;                      # automatically turns on strict and warnings
 
has 'x' => (is => 'rw', isa => 'Int');
has 'y' => (is => 'rw', isa => 'Int');
 
sub clear {
  my $self = shift;
  $self->x(0);
  $self->y(0);
}
 
package Point3D;
use Moose;
 
extends 'Point';
 
has 'z' => (is => 'rw', isa => 'Int');
 
after 'clear' => sub {
  my $self = shift;
  $self->z(0);
};

package main;

sub test{
  test_moose();
  test_arithmetic();
  test_memory_allocation();
  test_memory_move();
  test_regexp();

}

sub test_moose {
  my $p1 = Point3D->new(x => 1,y => 2, z => 3);
  $p1->x(3);
  $p1->y(2);
  $p1->z(1);
  $p1->clear;
  return $p1;
}

sub test_arithmetic {
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

my $s = "";

sub test_memory_allocation {
  $s .= "x";
  $s = "" if length $s > 1_000_000;
  my $r = $s;
  return $s;
}

my @a = (0) x 1000;
sub test_memory_move {
  my @b = ([@a]);
  for my $i (1..10) {
    $b[$i] = [@a];
    $b[$i-1] = [];
  }
}


sub test_regexp {
  my $a = "hello world " x 10 . "hello world2 " x 10 ;
  $a =~ /(hello world ){5}hello (world2)/;
  my $b = $1;
  $a =~ s/world/World/g;
}


$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
