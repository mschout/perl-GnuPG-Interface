#!/usr/bin/perl -w

use strict;
use English;
use IO::File;

use lib './t';
use MyTest;
use MyTestSpecific;

my $outfile;

TEST
{
    reset_handles();
    
    $gnupg->list_public_keys( handles => $handles );
    close $stdin;
    
    $outfile = 'test/public-keys/1.out';
    my $out = IO::File->new( "> $outfile" )
      or die "cannot open $outfile for writing: $ERRNO";
    $out->print( <$stdout> );
    close $stdout;
    $out->close();
    wait;
    
    return $CHILD_ERROR == 0;
};


TEST
{
    reset_handles();
    
    $gnupg->list_public_keys( handles            => $handles,
			      gnupg_command_args => '0xF950DA9C' );
    close $stdin;
    
    $outfile = 'test/public-keys/2.out';
    my $out = IO::File->new( "> $outfile" )
      or die "cannot open $outfile for writing: $ERRNO";
    $out->print( <$stdout> );
    close $stdout;
    $out->close();
    wait;
    
    return $CHILD_ERROR == 0;
};



TEST
{
    reset_handles();
    
    $handles->stdout( $texts{temp}->fh() );
    $handles->options( 'stdout' )->{direct} = 1;
    
    $gnupg->list_public_keys( handles            => $handles,
			      gnupg_command_args => '0xF950DA9C' );
    
    wait;
    
    $outfile = $texts{temp}->fn();
    
    return $CHILD_ERROR == 0;
};

