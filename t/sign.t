#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->sign( handles => $handles );
    
    print $stdin @plaintext;
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};
