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
    
    print $stdin @{ $texts{key}->data() };
    close $stdin;
    my @output = <$stdout>;
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    $handles->stdin( $texts{key}->fh() );
    $handles->options( 'stdin' )->{direct} = 1;
    
    $gnupg->import_keys( handles => $handles );
    wait;
    
    return $CHILD_ERROR == 0;
};
