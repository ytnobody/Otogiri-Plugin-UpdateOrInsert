requires 'perl', '5.008001';
requires 'Otogiri', '0.09';
requires 'Otogiri::Plugin', '0.02';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'DBD::SQLite', '0';
    requires 'File::Spec', '0';
    requires 'File::Temp', '0';
};

