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
    
    print $stdin @{ $texts{signed}->data() };
    close $stdin;
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    $handles->stdin( $texts{signed}->fh() );
    $handles->options( 'stdin' )->{direct} = 1;
    
    $gnupg->verify( handles => $handles );
    
    wait;
    
    return $CHILD_ERROR == 0;
};
