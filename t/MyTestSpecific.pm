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
#  $Id: MyTestSpecific.pm,v 1.2 2000/05/25 01:22:29 ftobin Exp $
#

use strict;
use English;
use Symbol;
use Fatal qw/ open close /;
use IO::File;
use Exporter;
use GnuPG::Interface;
use GnuPG::Handles;

use vars qw( @ISA           @EXPORT
	     $stdin         $stdout           $stderr
	     @plaintext     @encrypted_text   @signed_text
	     $gpg_program   $handles          $gnupg
	     @importable_key
	   );

@ISA    = qw( Exporter );
@EXPORT = qw( stdin                  stdout          stderr
	      plaintext              encrypted_text  signed_text
	      gnupg_program handles  mp              reset_handles
	      compare_array_refs     importable_key
	    );


$gpg_program = 'gpg';

$gnupg = GnuPG::Interface->new( gnupg_call  => $gpg_program,
				passphrase  => 'test' );

$gnupg->options->hash_init( homedir              => 'test',
			    armor                => 1,
			    meta_interactive     => 0,
			    meta_signing_key_id  => '0xF950DA9C',
			  );


my $filename = 'test/plain.1.txt';
my $file = IO::File->new( $filename )
  or die "cannot open $filename: $ERRNO";
@plaintext = $file->getlines();
$file->close();


$filename = 'test/encrypted.1.gpg';
$file = IO::File->new( $filename )
  or die "cannot open $filename: $ERRNO";
@encrypted_text = $file->getlines();
$file->close();


$filename = 'test/signed.1.asc';
$file = IO::File->new( $filename )
  or die "cannot open $filename: $ERRNO";
@signed_text = $file->getlines();
$file->close();

$filename = 'test/key.1.asc';
$file = IO::File->new( $filename )
  or die "cannot open $filename: $ERRNO";
@importable_key = $file->getlines();
$file->close();


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
}


1;
