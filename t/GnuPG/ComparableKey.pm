#  ComparableKey.pm
#    - comparable GnuPG::Key
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
#  $Id: ComparableKey.pm,v 1.1 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::ComparableKey;

use strict;
use vars qw( @ISA );
use GnuPG::Key;

push @ISA, 'GnuPG::Key';

sub compare
{
    my ( $self, $other, $deep ) = @_;
    
    my @comparison_pairs = 
      ( $self->length(),                 $other->length(),
        $self->algo_num(),               $other->algo_num(),
        $self->hex_id(),                 $other->hex_id(),
	$self->creation_date_string(),   $other->creation_date_string(),
        # this is taken out because GnuPG for some reason has decided
	# to not make expiration date listings the same for subkeys
	# in public-key mode and private-key mode
	#$self->expiration_date_string(), $other->expiration_date_string(),
      );
    
    for ( my $i = 0; $i < @comparison_pairs; $i += 2 )
    {
	return 0 unless ( defined $comparison_pairs[$i]
			  and defined $comparison_pairs[$i]
			);
	return 0 if $comparison_pairs[$i] ne $comparison_pairs[$i+1];
    }
    
    return $self->_deeply_compare( $other ) if $deep;
    
    return 1;
}


sub _deeply_compare
{
    my ( $self, $other ) = @_;
    bless $self->fingerprint(), 'GnuPG::ComparableFingerprint';
    
    return ( $self->fingerprint->compare( $other->fingerprint() ) );
}


1;
