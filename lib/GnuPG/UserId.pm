#  UserId.pm
#    - providing an object-oriented approach to GnuPG user ids
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
#  $Id: UserId.pm,v 1.2 2000/04/20 14:30:28 ftobin Exp $
#

package GnuPG::UserId;

use strict;

use Class::MethodMaker
  get_set       => [ qw( validity user_id_string ) ],
  list          => [ qw( signatures ) ],
  new_hash_init => 'new';

sub rigorously_compare
{
    my ( $self, $other ) = @_;

    return $self->user_id_string() eq $other->user_id_string();
}


sub deeply_compare
{
    my ( $self, $other ) = @_;
    
    return 0 unless
      $self->rigorously_compare( $other );

    my @self_signatures  = $self->signatures();
    my @other_signatures = $other->signatures();
    
    return 0 unless @self_signatures == @other_signatures;
    
    my $num_sigs = @self_signatures;
    
    for ( my $i = 0; $i < $num_sigs; $i++ )
    {
	
	return 0
	  unless $self_signatures[$i]->deeply_compare( $other_signatures[$i] );
    }

    return 1;
}


1;


__END__

=head1 NAME

GnuPG::UserId - GnuPG User ID Objects

=head1 SYNOPSIS

  # assumes a GnuPG::PublicKey object in $publickey
  my $first_userid_string = $publickey->user_ids_ref->[0]->user_id_string;

=head1 DESCRIPTION

GnuPG::UserId objects are generally not instantiated on their
own, but rather as part of GnuPG::PublicKey or GnuPG::SecretKey
objects.

=head1 OBJECT METHODS

=over 4

=item new( I<%initialization_args> )

This methods creates a new object.  The optional arguments are
initialization of data members; the initialization is done
in a manner according to the method created as described
in L<Class::MethodMaker/"new_hash_init">.

=back

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
L<Class::MethodMaker/"object">, or L<Class::MethodMaker/"list">.
Please read there for more information.

=over 4

=item user_id_string

A string of the user id.

=item validity

A scalar holding the value GnuPG reports for the trust of authenticity
(a.k.a.) validity of a key.
See GnuPG's DETAILS file for details.

=item signatures

A list of GnuPG::Signature objects embodying the signatures
on this user id.

=back

=head1 SEE ALSO

See also L<GnuPG::Signature> and L<Class::MethodMaker>.

=cut
