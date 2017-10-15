#!/usr/bin/perl

use strict;
use warnings;

use CGI qw(:standard);				# Include standard HTML and CGI functions
use CGI::Carp qw(fatalsToBrowser);      	# Send error messages to browser

	&printheader;
	if (param()) {
		&display;
	}
	&printform;
	&printtail;


sub printheader {

  print header(),
  	start_html(-title=>"Display user's running processes", -bgcolor=>"#cdb15f"),
  	h1("Display user's running processes"),
	hr;
}


sub printtail {

	print ("mkowalc1 | ASU | 2017"),
  end_html();
}


sub printform {

  print h3(""),

	start_form(),
	p,
	"Choose user: ",
   	scrolling_list(-name=>'username',
                       -values=>[getusers()],
                       -size=>7,
		       -multiple=>'false'),

	p,
	submit("Get processes"),
	end_form();
}


sub display {
	my @values;
	my $key;
	foreach $key (param) {
		push @values, param($key);
	}
	print h4("processes of $values[0]...");
	print "<pre>";
	 system("ps -U $values[0]");
	print "</pre>";
	hr;
}

sub getusers {
	my @unames;
	my $key;
	open PASSWD, "/etc/passwd";
		while(<PASSWD>) {
    			my @f = split /:/;
			push @unames, $f[0];
		}
	return @unames;
}
