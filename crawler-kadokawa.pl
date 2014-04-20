#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

use XML::Feed;

INIT {
    my $feed = XML::Feed->new('Atom');

    print $feed->as_xml;
}

__END__
