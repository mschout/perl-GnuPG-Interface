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
    
    $gnupg->list_secret_keys( handles => $handles );
    close $stdin;
    
    my $outfile = 'test/secret-keys/1.out';
    my $out = IO::File->new( "> $outfile" )
      or die "cannot open $outfile for writing: $ERRNO";
    $out->print( <$stdout> );
    close $stdout;
    $out->close();
    wait;
    
    my @files_to_test = ( 'test/secret-keys/1.0.test' );
    my $found_match = 0;
    
    foreach my $file ( @files_to_test )
    {
	if ( compare( $file, $outfile ) == 0 )
	{
	    $found_match = 1;
	    last;
	}
    }
    
    return ( $CHILD_ERROR == 0 and $found_match );
};


TEST
{
    reset_handles();
    
    $gnupg->list_secret_keys( handles              => $handles,
			      gnupg_command_args => '0xF950DA9C' );
    close $stdin;
    
    my $outfile = 'test/secret-keys/2.out';
    my $out = IO::File->new( "> $outfile" )
      or die "cannot open $outfile for writing: $ERRNO";
    $out->print( <$stdout> );
    close $stdout;
    $out->close();
    wait;
    
    my @files_to_test = ( 'test/secret-keys/2.0.test' );
    my $found_match = 0;
    
    foreach my $file ( @files_to_test )
    {
	if ( compare( $file, $outfile ) == 0 )
	{
	    $found_match = 1;
	    last;
	}
    }
    
    return ( $CHILD_ERROR == 0 and $found_match );
};
