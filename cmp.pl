use strict;
use warnings;
use File::Slurp;

use Benchmark qw(cmpthese);

my $dir = shift;
my @files = glob "$dir/v*.txt";
my %results;
my $VAR1;
for my $f (@files){
  my $string = read_file($f);
  #print $string;
  my $k = $f;
  $k =~ s{.*/}{};
  $results{$k} = eval $string;
}

cmpthese(\%results);
#use Data::Dumper;
#print Dumper \%results;
