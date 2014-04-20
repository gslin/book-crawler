#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

use XML::Feed;

INIT {
    my @urls = (
        # 漫畫 & 畫集
        'https://www.kadokawa.com.tw/p1-products.php?Class2=4f17EfZ94jWuR_R9yR5Y-XZ4Y5-vJCIG2ZNSFpSr&intM=2',
        'https://www.kadokawa.com.tw/p1-products.php?Class2=4f17EfZ94jWuR_R9yR5Y-XZ4Y5-vJCIG2ZNSFpSr&intM=2&Page=2',

        # 輕小說
        'https://www.kadokawa.com.tw/p1-products.php?Class2=2d98q6mt1HfTQMGvNye2LYSyDyTMfoC1xNj1bwKE&page=1',
        'https://www.kadokawa.com.tw/p1-products.php?Class2=2d98q6mt1HfTQMGvNye2LYSyDyTMfoC1xNj1bwKE&page=2',
        'https://www.kadokawa.com.tw/p1-products.php?Class2=2d98q6mt1HfTQMGvNye2LYSyDyTMfoC1xNj1bwKE&page=3',
        'https://www.kadokawa.com.tw/p1-products.php?Class2=2d98q6mt1HfTQMGvNye2LYSyDyTMfoC1xNj1bwKE&page=4',
        'https://www.kadokawa.com.tw/p1-products.php?Class2=2d98q6mt1HfTQMGvNye2LYSyDyTMfoC1xNj1bwKE&page=5',
    );

    my $feed = XML::Feed->new('Atom');

    foreach my $url (@urls) {
    }

    print $feed->as_xml;
}

__END__
