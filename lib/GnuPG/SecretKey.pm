#  SecretKey.pm
#    - providing an object-oriented approach to GnuPG secret keys
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
#  $Id: SecretKey.pm,v 1.2 2000/04/20 14:30:28 ftobin Exp $
#

package GnuPG::SecretKey;

use strict;
use GnuPG::Key;

use vars qw( @ISA );
push @ISA, 'GnuPG::Key';

use Class::MethodMaker
  list          => [ qw( user_ids   subkeys ) ],
  get_set       => [ qw( local_id   owner_trust ) ];


sub deeply_compare
{
    my ( $self, $other ) = @_;
    
    return 0 unless $self->rigorously_compare( $other );
    
    my @self_subkeys  = $self->subkeys();
    my @other_subkeys = $other->subkeys();
    
    return 0 unless @self_subkeys == @other_subkeys;
    
    my $num_subkeys = @self_subkeys;
    
    for ( my $i = 0; $i < $num_subkeys; $i++ )
    {
	return 0
	  unless $self_subkeys[$i]->deeply_compare( $other_subkeys[$i] );
    }
    

    my @self_user_ids  = $self->user_ids();
    my @other_user_ids = $other->user_ids();
    
    return 0 unless @self_user_ids == @other_user_ids;
    
    my $num_user_ids = @self_user_ids;
    
    for ( my $i = 0; $i < $num_user_ids; $i++ )
    {
	return 0
	  unless $self_user_ids[$i]->deeply_compare( $other_user_ids[$i] );
    }
    
    return $self->SUPER::deeply_compare( $other );
}


1;

__END__

=head1 NAME

GnuPG::SecretKey - GnuPG Secret Key Objects

=head1 SYNOPSIS

  # assumes a GnuPG::Interface object in $gnupg
  my @keys = $gnupg->get_public_keys( 'ftobin' );

  # now GnuPG::PublicKey objects are in @keys

=head1 DESCRIPTION

GnuPG::SecretKey objects are generally instantiated
through various methods of GnuPG::Interface.
They embody various aspects of a GnuPG secret key.

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

See also L<GnuPG::Key>, L<GnuPG::UserId>, L<GnuPG::SubKey>,
and L<Class::MethodMaker>.

=cut
