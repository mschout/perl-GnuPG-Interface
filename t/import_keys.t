#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->import_keys( handles => $handles );
    
    print $stdin @importable_key;
    close $stdin;
    my @output = <$stdout>;
    wait;
    
    return $CHILD_ERROR == 0;
};
