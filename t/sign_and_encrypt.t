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
    
    print $stdin @{ $texts{plain}->data() };
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    $handles->stdin( $texts{plain}->fh() );
    $handles->options( 'stdin' )->{direct} = 1;
    $gnupg->sign_and_encrypt( handles => $handles );
    
    wait;
    
    return $CHILD_ERROR == 0;
};
