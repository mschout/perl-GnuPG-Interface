#  MyTest.pm
#    - module for use with test scripts
#
#  Copyright (C) 2000 Frank J. Tobin <ftobin@uiuc.edu>
#
#  This module is free software; you can redistribute it and/or modify it
#  under the same terms as Perl itself.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
#  $Id: MyTest.pm,v 1.2 2000/11/21 18:03:39 ftobin Exp $
#

package MyTest;

use strict;
use English;
use Exporter;
use IO::File;
use vars qw( @ISA @EXPORT );

@ISA    = qw( Exporter );
@EXPORT = qw( TEST );

$OUTPUT_AUTOFLUSH = 1;

print "1..", COUNT_TESTS(), "\n";

my $counter = 0;

sub TEST ( & )
{
    my ( $code ) = @_;
    
    $counter++;
    
    &$code or print "not ";
    print "ok $counter\n";
}


sub COUNT_TESTS
{
    my ( $file ) = @_;
    $file ||= $PROGRAM_NAME;
    
    my $tests = 0;
    
    my $in = IO::File->new( $file );
    
    while ( $_ = $in->getline() )
    {
	$tests++
	  if /^\s*TEST\s*/;
    }
    
    return $tests;
}


1;
