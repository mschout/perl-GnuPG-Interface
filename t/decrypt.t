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
    
    $gnupg->decrypt( handles => $handles );
    
    print $stdin @encrypted_text;
    close $stdin;
    
    my $diff = compare( 'test/plain.1.txt', $stdout );
    close $stdout;
    wait;
    
    return ( $CHILD_ERROR == 0 and not $diff );
};
