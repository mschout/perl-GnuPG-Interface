#  Handles.pm
#    - interface to the handles used by GnuPG::Interface
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
#  $Id: Handles.pm,v 1.2 2000/04/20 14:30:28 ftobin Exp $
#


package GnuPG::Handles;

use strict;
use Class::MethodMaker
  get_set       => [ qw( stdin stdout stderr status logger passphrase ) ],
  new_hash_init => [ qw( new hash_init ) ];

1;


=head1 NAME

GnuPG::Handles - GnuPG handles bundle

=head1 SYNOPSIS

  use IO::Handle;
  my ( $stdin, $stdout, $stderr,
       $status_fh, $logger_fh, $passphrase_fh )
    = ( IO::Handle->new(), IO::Handle->new(), IO::Handle->new(),
        IO::Handle->new(), IO::Handle->new(), IO::Handle->new() );
 
  my $handles = GnuPG::Handle->new
    ( stdin      => $stdin,
      stdout     => $stdout,
      stderr     => $stderr,
      status     => $status_fh,
      logger     => $logger_fh,
      passphrase => $passphrase_fh );

=head1 DESCRIPTION

GnuPG::Handles objects are generally instantiated
to be used in conjunction with methods of objects
of the class GnuPG::Interface.  GnuPG::Handles objects
represent a collection of handles that are used to
communicate with GnuPG.

=head1 OBJECT METHODS

=head2 Initialization Methods

=over 4

=item new( I<%initialization_args> )

This methods creates a new object.  The optional arguments are
initialization of data members; the initialization is done
in a manner according to the method created as described
in L<Class::MethodMaker/"new_hash_init">.

=item hash_init( I<%args> ).

This method works as described in L<Class::MethodMaker/"new_hash_init">.

=back

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
or L<Class::MethodMaker/"object">.
Please read there for more information.

=over 4

=item stdin

This handle is generally connected to the standard input of
a GnuPG process.

=item stdout

This handle is generally connected to the standard output of
a GnuPG process.

=item stderr

This handle is generally connected to the standard error of
a GnuPG process.

=item status

This handle is generally connected to the status output handle of
a GnuPG process.

=item logger

This handle is generally connected to the logger output handle of
a GnuPG process.

=item passphrase

This handle is generally connected to the passphrase input handle of
a GnuPG process.

=back

=head1 SEE ALSO

See also L<GnuPG::Interface> and L<Class::MethodMaker>.

=cut
