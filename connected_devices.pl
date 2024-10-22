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

#Here we send post request with credentials and then get the page which is contain list of connected and not connected devices to Xfinity router
#Successful response always return code 302 Found.
my $response = $ua->post($url, \%form_data);
my $response_list = $ua->get('http://10.0.0.1/at_a_glance.jst');
 
if ($response_list->is_success) {
    my @list_of_connected_devices;
    $response_list->decoded_content =~ m/(<h2 id="conndev">Connected Devices.*?\n)([^\n]*)/gm;
    my $connected_devices_html = $2;
    while ($connected_devices_html =~ m/(readonlyLabel">)(.*?)(<\/span><\/div>)/gm) {
        push(@list_of_connected_devices, $2);
    }
    print join(", ", @list_of_connected_devices);
}
else {
    die $response_list->status_line;
}