#!/usr/bin/perl
use strict;
use warnings;
use lib ".";
use Devices;

my $login = "";
my $passw = "";
my $locale = "false";

my $list_obj = Devices->new($login, $passw, $locale);
my @list = $list_obj->getList();
print @list;
