package Otogiri::Plugin::UpdateOrInsert;
use 5.008005;
use strict;
use warnings;
use Otogiri;
use Otogiri::Plugin;

our $VERSION = "0.01";
our @EXPORT = qw( update_or_insert insert_or_update upsert );

sub update_or_insert {
    my ($self, $table, $set, $cond) = @_;
    my $row = $self->update($table, $set, $cond) > 0 ? $self->single($table, $cond) : $self->insert($table, {%$set, %$cond});
    $row;
}

{
    no strict;
    for my $method (qw( insert_or_update upsert )) {
        *{__PACKAGE__."\::$method"} = *{__PACKAGE__."\::update_or_insert"};
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Otogiri::Plugin::UpdateOrInsert - update_or_insert plugin for Otogiri

=head1 SYNOPSIS

    use Otogiri;
    use Otogiri::Plugin;
    Otogiri->load_plugin('UpdateOrInsert');
    
    my $db = Otogiri->new(connect_info => [...]);
    
    my $table      = 'member';
    my $set_vars   = {age => 33};
    my $conditions = {name => 'ytnobody'};
    
    my $row = $db->update_or_insert($table, $set_vars, $conditions);
    
    ### Or, use synonym
    $row = $db->insert_or_update($table, $set_vars, $conditions);
    $row = $db->upsert($table, $set_vars, $conditions);


=head1 DESCRIPTION

Otogiri::Plugin::UpdateOrInsert appends the update_or_insert and its synonym methods into Otogiri.

=head1 METHODS

=head2 update_or_insert

    my $row = $db->update_or_insert($table, $set_vars, $conditions);

First, It tries to update with "$set_vars" to row that found by $conditions.

If affected record is, fetch it and return. Else, it insert $set_vars and $conditions as row data.

=head2 insert_or_update, upsert

Synonym for update_or_insert

=head1 LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=cut

