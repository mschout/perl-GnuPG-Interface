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
    close $stdout;
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    $handles->stdout( $texts{temp}->fh() );
    $handles->options( 'stdout' )->{direct} = 1;
    
    $gnupg->export_keys( handles            => $handles,
			 gnupg_command_args => '0xF950DA9C' );
    wait;
    return $CHILD_ERROR == 0;
};
