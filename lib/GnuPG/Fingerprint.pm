#  Fingerprint.pm
#    - providing an object-oriented approach to GnuPG key fingerprints
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
#  $Id: Fingerprint.pm,v 1.3 2000/07/12 07:43:46 ftobin Exp $
#

package GnuPG::Fingerprint;

use strict;

use Class::MethodMaker
  get_set       => [ qw( hex_data ) ],
  new_hash_init => 'new';

sub rigorously_compare
{
    my ( $self, $other ) = @_;
    
    return $self->hex_data() eq $other->hex_data();
}

sub deeply_compare
{
    my ( $self, $other ) = @_;
    
    return $self->rigorously_compare( $other );
}


1;


__END__

=head1 NAME

GnuPG::Fingerprint - GnuPG Fingerprint Objects

=head1 SYNOPSIS

  # assumes a GnuPG::Key in $key
  my $fingerprint = $key->fingerprint->hex_data();

=head1 DESCRIPTION

GnuPG::Fingerprint objects are generally part of GnuPG::Key
objects, and are not created on their own.

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

=item hex_data

This is the hex value of the fingerprint that the object embodies.

=back

=head1 SEE ALSO

L<GnuPG::Key>,
L<Class::MethodMaker>

=cut
