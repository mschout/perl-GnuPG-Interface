#!/usr/bin/perl -w

use strict;
use English;
use Symbol;

use lib './t';
use MyTest;
use MyTestSpecific;

TEST
{
    reset_handles();
    return $gnupg->test_default_key_passphrase()
};


TEST
{
    reset_handles();
    
    my $passphrase_handle = gensym;
    $handles->passphrase( $passphrase_handle );
    
    my $pid = $gnupg->sign( handles => $handles );
    
    print $passphrase_handle 'test';
    print $stdin @plaintext;
    
    close $passphrase_handle;
    close $stdin;
    
    waitpid $pid, 0;
    return $CHILD_ERROR == 0;
};
