#!/usr/bin/perl -w

use strict;
use English;
use File::Compare;

use lib './t';
use MyTest;
use MyTestSpecific;


TEST
{
    reset_handles();
    
    $gnupg->list_sigs( handles => $handles );
    close $stdin;
    
    my $diff = compare( 'test/public-keys-sigs.1.txt', $stdout );
    close $stdout;
    wait;
    
    return ( $CHILD_ERROR == 0 and not $diff );
};


TEST
{
    reset_handles();
    
    $gnupg->list_sigs( handles              => $handles,
		       gnupg_command_args => '0xF950DA9C' );
    close $stdin;
    
    my $diff = compare( 'test/public-keys-sigs.2.txt', $stdout );
    close $stdout;
    wait;
    
    return ( $CHILD_ERROR == 0 and not $diff );
};
