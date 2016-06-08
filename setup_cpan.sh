#!/bin/bash
BINARY=~/work/git/regentmarkets
PERL=$BINARY/perl
CPAN=$BINARY/localcpan
for v in v5.14.4-v3 v5.22.2-v2 v5.22.2-v3 v5.24.0-v2 v5.24.0-v3
do
    (cd $PERL && git checkout chylli/$v)
    perl -v
    (cd $CPAN && git checkout master && git checkout chylli/$v && git checkout chylli/v5.14.4-v2 cpanfile && carton install && git add -A . && git commit -m 'install modules')
done
