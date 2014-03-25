use strict;
use Test::More;

use Otogiri;
use Otogiri::Plugin;
use File::Temp qw( tempdir );
use File::Spec;

my $tmpdir = tempdir(CLEANUP => 1);
my $dbfile = File::Spec->catfile($tmpdir, 'testdb.sqlite3');

Otogiri->load_plugin('UpdateOrInsert');

my $db = Otogiri->new(connect_info => [ "dbi:SQLite:dbname=$dbfile", "", "" ]);

my $fixture = <<SQL;
CREATE TABLE member (
    id    INTEGER PRIMARY KEY AUTOINCREMENT,
    name  TEXT,
    age   INTEGER
);
SQL

can_ok( $db, qw(update_or_insert insert_or_update upsert) );
ok( $db->do($fixture) );

subtest 'insert' => sub {
    my $row = $db->update_or_insert('member', {age => 22}, {name => 'moznion'});
    is_deeply( $row, {id => 1, age => 22, name => 'moznion'} );
};

subtest 'update' => sub {
    my $row = $db->update_or_insert('member', {age => 23}, {name => 'moznion'});
    is_deeply( $row, {id => 1, age => 23, name => 'moznion'} );
};

subtest 'other_row' => sub {
    my $row = $db->upsert('member', {age => 33}, {name => 'ytnobody'});
    is_deeply( $row, {id => 2, age => 33, name => 'ytnobody'} );
};

done_testing;
