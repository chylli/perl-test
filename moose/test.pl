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
use Moose; # automatically turns on strict and warnings
 
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

sub test {
  my $p1 = Point3D->new(x => 1,y => 2, z => 3);
  $p1->x(3);
  $p1->y(2);
  $p1->z(1);
  $p1->clear;
  return $p1;
}

$out = timethis(-20, sub{test()});


select($stdout);
print Dumper $out;
