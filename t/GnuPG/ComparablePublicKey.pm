#  ComparablePublicKey.pm
#      - Comparable GnuPG::PublicKeys
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
#  $Id: ComparablePublicKey.pm,v 1.1 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::ComparablePublicKey;

use strict;
use vars qw( @ISA );
use GnuPG::PublicKey;
use GnuPG::ComparableKey;

push @ISA, 'GnuPG::PublicKey', 'GnuPG::ComparableKey';

sub _deeply_compare
{
    my ( $self, $other ) = @_;
    
    my @self_subkeys  = $self->subkeys();
    my @other_subkeys = $other->subkeys();
    
    return 0 unless @self_subkeys == @other_subkeys;
    
    my $num_subkeys = @self_subkeys;
    
    for ( my $i = 0; $i < $num_subkeys; $i++ )
    {
	my $subkey1 = $self_subkeys[$i];
	my $subkey2 = $other_subkeys[$i];
	
	bless $subkey1, 'GnuPG::ComparableSubKey';
	
	return 0 unless $subkey1->compare( $subkey2, 1 );
    }
    
    
    # don't compare user id's because their ordering
    # is not necessarily deterministic
    
    return 1;
}


1;
