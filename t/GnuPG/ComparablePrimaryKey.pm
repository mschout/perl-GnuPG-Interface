#  ComparablePrimaryKey.pm
#      - Comparable GnuPG::PrimaryKey
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
#  $Id: ComparablePrimaryKey.pm,v 1.1 2001/05/01 02:36:28 ftobin Exp $
#

package GnuPG::ComparablePrimaryKey;

use strict;
use GnuPG::PrimaryKey;
use GnuPG::ComparableKey;
use GnuPG::ComparableSubKey;
use vars qw( @ISA );

push @ISA, 'GnuPG::PrimaryKey', 'GnuPG::ComparableKey';

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
    
    $self->SUPER::_deeply_compare( $other );
    
    return 1;
}

1;
