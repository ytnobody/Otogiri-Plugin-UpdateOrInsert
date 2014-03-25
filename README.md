# NAME

Otogiri::Plugin::UpdateOrInsert - update\_or\_insert plugin for Otogiri

# SYNOPSIS

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



# DESCRIPTION

Otogiri::Plugin::UpdateOrInsert appends the update\_or\_insert and its synonym methods into Otogiri.

# METHODS

## update\_or\_insert

    my $row = $db->update_or_insert($table, $set_vars, $conditions);

First, It tries to update with "$set\_vars" to row that found by $conditions.

If affected record is, fetch it and return. Else, it insert $set\_vars and $conditions as row data.

## insert\_or\_update, upsert

Synonym for update\_or\_insert

# LICENSE

Copyright (C) ytnobody.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

ytnobody <ytnobody@gmail.com>
