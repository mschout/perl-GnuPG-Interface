#  Key.pm
#    - providing an object-oriented approach to GnuPG keys
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
#  $Id: Key.pm,v 1.3 2000/06/18 07:33:16 ftobin Exp $
#

package GnuPG::Key;

use strict;

use Class::MethodMaker
  get_set       => [ qw( length      algo_num     hex_id    hex_data
			 creation_date_string     expiration_date_string
		       ) ],
  object        => [ qw( GnuPG::Fingerprint  fingerprint ) ],
  new_hash_init => 'new',
  new_hash_init => 'hash_init';


sub short_hex_id
{
    my ( $self ) = @_;
    return substr $self->hex_id(), -8;
}


sub rigorously_compare
{
    my ( $self, $other ) = @_;
    
    my @comparison_pairs = 
      ( $self->length(),                 $other->length(),
        $self->algo_num(),               $other->algo_num(),
        $self->hex_id(),                 $other->hex_id(),
	$self->creation_date_string(),   $other->creation_date_string(),
        $self->expiration_date_string(), $other->expiration_date_string(),
      );
    
    for ( my $i = 0; $i < @comparison_pairs; $i += 2 )
    {
	return 0
	  unless defined $comparison_pairs[$i]
	    and defined $comparison_pairs[$i];
	return 0 if $comparison_pairs[$i] ne $comparison_pairs[$i+1];
    }
    
    return 1;
}


sub deeply_compare
{
    my ( $self, $other ) = @_;
    
    return
      $self->rigorously_compare( $other )
	and $self->fingerprint->deeply_compare( $other->fingerprint() );
}


1;


__END__

=head1 NAME

GnuPG::Key - GnuPG Key Object

=head1 SYNOPSIS

  # assumes a GnuPG::Interface object in $gnupg
  my @keys = $gnupg->get_public_keys( 'ftobin' );

  # now GnuPG::PublicKey objects are in @keys

=head1 DESCRIPTION

GnuPG::Key objects are generally not instantiated on their
own, but rather used as a superclass of GnuPG::PublicKey,
GnuPG::SecretKey, or GnuPG::SubKey objects.

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

=item short_hex_id

This returns the commonly-used short, 8 character short hex id
of the key.

=back

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
or L<Class::MethodMaker/"object">.
Please read there for more information.

=over 4

=item length

Number of bits in the key.

=item algo_num

They algorithm number that the Key is used for.

=item hex_data

The data of the key.

=item hex_id

The long hex id of the key.  This is not the fingerprint nor
the short hex id, which is 8 hex characters.

=item creation_date_string
=item expiration_date_string

Formatted date of the key's creation and expiration.

=item fingerprint

A GnuPG::Fingerprint object.

=back

=head1 SEE ALSO

See also L<GnuPG::Fingerprint> and L<Class::MethodMaker>.

=cut
