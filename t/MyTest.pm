#  MyTest.pm
#    - module for use with test scripts
#
#  Copyright (C) 2000 Frank J. Tobin <ftobin@uiuc.edu>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, visit the following URL:
#  http://www.gnu.org
#
#  $Id: MyTest.pm,v 1.1.1.1 2000/04/19 21:06:33 ftobin Exp $
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
