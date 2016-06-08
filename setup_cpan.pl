#!/bin/bash
BINARY=~/work/git/regentmarkets
  PERL=$BINARY/perl
  CPAN=$BINARY/localcpan
  for v in v5.14.4-v2 v5.14.4-v3 v5.22.2-v2 v5.22.2-v3 v.24.0-v2 v5.24.0-v3
  do
  "(cd $PERL && git checkout chylli/$v)"
  "(cd $CPAN && git checkout chylli/$v)"
  for d in `ls`
  do
  if [ -d $d ] && [ -f $d/test.pl ]
  then
  echo "perl $d/test.pl $v > $d/$v.txt"
  perl $d/test.pl $v > $d/$v.txt
  fi
  done
  done
