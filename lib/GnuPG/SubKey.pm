#  SubKey.pm
#    - providing an object-oriented approach to GnuPG sub keys
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
#  $Id: SubKey.pm,v 1.3 2000/07/12 07:43:46 ftobin Exp $
#

package GnuPG::SubKey;

use strict;
use GnuPG::Key;

use vars qw( @ISA );
push @ISA, 'GnuPG::Key';

use Class::MethodMaker
  get_set       => [ qw( validity   owner_trust  local_id ) ],
  object        => [ qw( GnuPG::Signature  signature ) ];


sub deeply_compare
{
    my ( $self, $other ) = @_;

    return
      $self->rigorously_compare( $other )
	and $self->signature->deeply_compare( $other->signature )
	  and $self->fingerprint->deeply_compare( $other->fingerprint() )
	    and $self->SUPER::deeply_compare( $other );
}

1;

__END__

=head1 NAME

GnuPG::SubKey - GnuPG Sub Key objects

=head1 SYNOPSIS

  # assumes a GnuPG::PublicKey object in $key
  my @subkeys = $key->subkeys();

  # now GnuPG::SubKey objects are in @subkeys

=head1 DESCRIPTION

GnuPG::SubKey objects are generally instantiated
through various methods of GnuPG::Interface.
They embody various aspects of a GnuPG sub key.

This package inherits data members and object methods
from GnuPG::Key, which are not described here, but rather
in L<GnuPG::Key>.

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
L<Class::MethodMaker/"object">, or L<Class::MethodMaker/"list">.
Please read there for more information.

=over 4

=item validity

A scalar holding the value GnuPG reports for the trust of authenticity
(a.k.a.) validity of a key.
See GnuPG's DETAILS file for details.

=item local_id

GnuPG's local id for the key.

=item owner_trust

The scalar value GnuPG reports as the ownertrust for this key.
See GnuPG's DETAILS file for details.

=item signature

A GnuPG::Signature object holding the representation of the
signature on this key.

=back

=head1 SEE ALSO

L<GnuPG::Key>,
L<GnuPG::Signature>,
L<Class::MethodMaker>

=cut
