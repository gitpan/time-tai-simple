#!/bin/env perl

use strict;
use warnings;
use Test::Most;
use Time::HiRes;

use lib "./lib";
use Time::TAI::Simple;

my $success = 0;
my $tai_or = undef;
# eval { $tai_or = Time::TAI::Simple->new();  $success = 1; };
$tai_or = Time::TAI::Simple->new();  $success = 1;
ok $success, 'new: no parameters';
die("no further tests possible\n") unless ($success);

my $tai35 = tai35();
my $del35 = Time::HiRes::time() - $tai35;
my $tai10 = tai10();
my $del10 = Time::HiRes::time() - $tai10;
my $tai00 = tai();
my $del00 = Time::HiRes::time() - $tai00;
# print "System clock is $tm0\n";
ok abs($del35) <  1.0, "tai35 is $tai35 = system clock - $del35";
ok abs($del10) < 26.0, "tai10 is $tai10 = system clock - $del10";
ok abs($del00) < 36.0, "tai   is $tai00 = system clock - $del00";

printf("tai35 error is less than %0.010f seconds\n", abs($del35));
printf("tai10 error is less than %0.010f seconds\n", abs($del10 - 25.0));
printf("tai   error is less than %0.010f seconds\n", abs($del00 - 35.0));

done_testing();
exit(0);
