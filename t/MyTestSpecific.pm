#  MyTestSpecific.pm
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
#  $Id: MyTestSpecific.pm,v 1.4 2000/07/23 01:46:04 ftobin Exp $
#

use strict;
use English;
use Symbol;
use Fatal qw/ open close /;
use IO::File;
use IO::Seekable;
use File::Compare;
use Exporter;
use Class::Struct;

use GnuPG::Interface;
use GnuPG::Handles;

use vars qw( @ISA           @EXPORT
	     $stdin         $stdout           $stderr
	     $gpg_program   $handles          $gnupg
	     %texts
	   );

@ISA    = qw( Exporter );
@EXPORT = qw( stdin                  stdout          stderr
	      gnupg_program handles  reset_handles
	      texts                  file_match
	    );


$gpg_program = 'gpg';

$gnupg = GnuPG::Interface->new( gnupg_call  => $gpg_program,
				passphrase  => 'test',
			      );

$gnupg->options->hash_init( homedir              => 'test',
			    armor                => 1,
			    meta_interactive     => 0,
			    meta_signing_key_id  => '0xF950DA9C',
			    always_trust         => 1,
			  );

struct( Text => { fn => "\$", fh => "\$", data => "\$" } );

$texts{plain} = Text->new();
$texts{plain}->fn( 'test/plain.1.txt' );

$texts{encrypted} = Text->new();
$texts{encrypted}->fn( 'test/encrypted.1.gpg' );

$texts{signed} = Text->new();
$texts{signed}->fn( 'test/signed.1.asc' );

$texts{key} = Text->new();
$texts{key}->fn( 'test/key.1.asc' );

$texts{temp} = Text->new();
$texts{temp}->fn( 'test/temp' );


foreach my $name ( qw( plain encrypted signed key ) )
{
    my $entry = $texts{$name};
    my $filename = $entry->fn();
    my $fh = IO::File->new( $filename )
      or die "cannot open $filename: $ERRNO";
    $entry->data( [ $fh->getlines() ] );
}

sub reset_handles
{
    foreach ( $stdin, $stdout, $stderr )
    {
	$_ = gensym;
    }
    
    $handles = GnuPG::Handles->new
      ( stdin   => $stdin,
	stdout  => $stdout,
	stderr  => $stderr
      );
    
    foreach my $name ( qw( plain encrypted signed key ) )
    {
	my $entry = $texts{$name};
	my $filename = $entry->fn();
	my $fh = IO::File->new( $filename )
	  or die "cannot open $filename: $ERRNO";
	$entry->fh( $fh );
    }
    
    {
	my $entry = $texts{temp};
	my $filename = $entry->fn();
	my $fh = IO::File->new( $filename, 'w' )
	  or die "cannot open $filename: $ERRNO";
	$entry->fh( $fh );
    }
}



sub file_match
{
    my ( $orig, @compares ) = @_;
    
    my $found_match = 0;
    
    foreach my $file ( @compares )
    {
	return 1
	  if compare( $file, $orig ) == 0;
    }
    
    return 0;
}



1;
