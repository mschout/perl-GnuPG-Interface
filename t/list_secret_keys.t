#!/usr/bin/perl -w

use strict;
use English;
use File::Compare;

use lib './t';
use MyTest;
use MyTestSpecific;

my $outfile;

TEST
{
    reset_handles();
    
    $gnupg->list_secret_keys( handles => $handles );
    close $stdin;
    
    $outfile = 'test/secret-keys/1.out';
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
    my @files_to_test = ( 'test/secret-keys/1.0.test' );

    return file_match( $outfile, @files_to_test );
};


TEST
{
    reset_handles();
    
    $gnupg->list_secret_keys( handles              => $handles,
			      gnupg_command_args => '0xF950DA9C' );
    close $stdin;
    
    $outfile = 'test/secret-keys/2.out';
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
    my @files_to_test = ( 'test/secret-keys/2.0.test' );
    
    return file_match( $outfile, @files_to_test );
};



TEST
{
    reset_handles();
    
    $handles->stdout( $texts{temp}->fh() );
    $handles->options( 'stdout' )->{direct} = 1;
    
    $gnupg->list_secret_keys( handles            => $handles,
			      gnupg_command_args => '0xF950DA9C' );
    
    wait;
    
    $outfile = $texts{temp}->fn();
    
    return $CHILD_ERROR == 0;
};
 

TEST
{
    my @files_to_test = ( 'test/secret-keys/2.0.test' );
    
    return file_match( $outfile, @files_to_test );
};
