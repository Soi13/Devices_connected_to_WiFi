#!/usr/bin/perl
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Cookies;

my $ua = LWP::UserAgent->new;
$ua->timeout(10);

my $cookie_jar = HTTP::Cookies->new;
$ua->cookie_jar($cookie_jar);

my $url = 'http://10.0.0.1/check.jst';

my %form_data = (
    username => '',
    password => '',
    locale => 'false',
);

my $response = $ua->post($url, \%form_data);

if ($response->is_success) {
    print $response->decoded_content;
} else {
    die $response->status_line;
}


my $response1 = $ua->get('http://10.0.0.1/at_a_glance.jst');
 
if ($response1->is_success) {
    print $response1->decoded_content;
}
else {
    die $response1->status_line;
}