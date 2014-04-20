#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;

use DateTime;
use Web::Query;
use WWW::Mechanize;
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

        # 書籍
        'https://www.kadokawa.com.tw/p1-products.php?Class2=d77fOJmJ3T8QyBH_DlwPjLc0SsMRALOEAuJJ6H82&intM=2',
    );

    my $feed = XML::Feed->new('Atom');

    $feed->title('台灣角川新書列表 (Unofficial)');
    $feed->link('https://www.kadokawa.com.tw/');
    $feed->language('zh-TW');

    my $ua = WWW::Mechanize->new;

    foreach my $url (@urls) {
        my $res = $ua->get($url);

        my $body = Web::Query->new($res->decoded_content);
        $body->find('.pro_set')->each(
            sub {
                my ($i, $book) = @_;

                my $link = 'https://www.kadokawa.com.tw/' . $book->find('a')->first->attr('href');

                my $bookname = $book->find('.pro_bookname')->text;
                $bookname =~ s/(^\s+|\s+$)//g;

                my $author = $book->find('.pro_people')->text;
                $author =~ s/(^\s+|\s+$)//g;

                my $price = $book->find('.pro_price')->text;
                $price =~ s/(^\s+|\s+$)//g;

                my $date = undef;
                if ($price =~ m{(\d{4})/(\d\d)/(\d\d)}) {
                    $date = DateTime->new(
                        year => $1,
                        month => $2,
                        day => $3,
                        time_zone => 'Asia/Taipei',
                    );
                } else {
                    return;
                }

                my $entry = XML::Feed::Entry->new;

                $entry->id($link);
                $entry->link($link);
                $entry->title($bookname);
                $entry->author($author);
                $entry->content($price);
                $entry->issued($date);

                $feed->add_entry($entry);
            }
        );
    }

    print $feed->as_xml;
}

__END__
