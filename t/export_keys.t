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
    
    $gnupg->export_keys( handles            => $handles,
			 gnupg_command_args => '0xF950DA9C' );
    close $stdin;
    
    my $result = compare( 'test/key.1.asc', $stdout );
    close $stdout;
    wait;
    
    return $CHILD_ERROR == 0 and $result;
};
