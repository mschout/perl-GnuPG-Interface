#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    
    $gnupg->options->clear_recipients();
    $gnupg->options->clear_meta_recipients_keys();
    $gnupg->options->push_recipients( '0x2E854A6B' );
    
    $gnupg->encrypt( handles => $handles );
    
    print $stdin @plaintext;
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    my @keys = $gnupg->get_public_keys( '0xF950DA9C' );
    $gnupg->options->clear_recipients();
    $gnupg->options->clear_meta_recipients_keys();
    $gnupg->options->push_meta_recipients_keys( @keys );
    
    $gnupg->encrypt( handles => $handles );
    
    print $stdin @plaintext;
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
}
