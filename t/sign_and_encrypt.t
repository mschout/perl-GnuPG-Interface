#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->options->push_recipients( '0x2E854A6B' );
    $gnupg->sign_and_encrypt( handles => $handles );
    
    print $stdin @plaintext;
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};
