#!/usr/bin/perl

# TODO:
# combine ignores into a single line

use strict;
use Irssi;

use vars qw($VERSION %IRSSI);

$VERSION = "0.1.1";
%IRSSI = (
	authors		=> 'apic',
	contact		=> 'apic@IRCnet',
	name		=> 'ignorsula',
	description	=> 'script to show ignored message in censored form',
	license		=> 'public domina', # no typo # O.o
	url		=> 'http://irssi.apic.name/ignorsula.pl',
);

Irssi::theme_register(['censor', "%_Irssi:%_ \02\02Censored a message from \$0\02\02"]);
# I had to register the msg level as `nicks` as I am using a script to hide & show those.
# It would make more sense to change this to `crap`
sub handle_msg {
	my ($srv, $msg, $nick, $addr, $dst) = @_;
	if($srv->ignore_check($nick, $addr, $dst, $msg, MSGLEVEL_NICKS)) {
	        $srv->printformat($dst, MSGLEVEL_NICKS, "censor", $nick);
			# Irssi::print('-----', MSGLEVEL_NEVER)
        }
}

Irssi::signal_add_first("message public", "handle_msg");
Irssi::signal_add_first("message private", "handle_msg");
Irssi::signal_add_first("ctcp action", "handle_msg");
