#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->verify( handles => $handles );
    
    print $stdin @signed_text;
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};
