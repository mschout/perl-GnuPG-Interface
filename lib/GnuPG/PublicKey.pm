#  PublicKey.pm
#    - providing an object-oriented approach to GnuPG public keys
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
#  $Id: PublicKey.pm,v 1.6 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::PublicKey;

use strict;
use GnuPG::Key;

use vars qw( @ISA );
push @ISA, 'GnuPG::Key';

use Class::MethodMaker
  list          => [ qw( user_ids   subkeys  ) ],
  get_set       => [ qw( local_id   owner_trust ) ];

1;

__END__

=head1 NAME

GnuPG::PublicKey - GnuPG Public Key Objects

=head1 SYNOPSIS

  # assumes a GnuPG::Interface object in $gnupg
  my @keys = $gnupg->get_public_keys( 'ftobin' );

  # now GnuPG::PublicKey objects are in @keys

=head1 DESCRIPTION

GnuPG::PublicKey objects are generally instantiated
through various methods of GnuPG::Interface.
They embody various aspects of a GnuPG primary key.

This package inherits data members and object methods
from GnuPG::Key, which are not described here, but rather
in L<GnuPG::Key>.

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
L<Class::MethodMaker/"object">, or L<Class::MethodMaker/"list">.
Please read there for more information.

=over 4

=item user_ids

A list of GnuPG::UserId objects associated with this key.

=item subkeys

A list of GnuPG::SubKey objects associated with this key.

=item local_id

GnuPG's local id for the key.

=item owner_trust

The scalar value GnuPG reports as the ownertrust for this key.
See GnuPG's DETAILS file for details.

=back

=head1 SEE ALSO

L<GnuPG::Key>,
L<GnuPG::UserId>,
L<GnuPG::SubKey>,
L<Class::MethodMaker>

=cut
