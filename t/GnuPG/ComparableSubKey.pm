#  ComparableSubKey.pm
#    - comparable GnuPG::SubKey
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
#  $Id: ComparableSubKey.pm,v 1.1 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::ComparableSubKey;

use strict;
use vars qw( @ISA );
use GnuPG::SubKey;
use GnuPG::ComparableKey;
use GnuPG::ComparableSignature;
use GnuPG::ComparableFingerprint;

push @ISA, 'GnuPG::SubKey', 'GnuPG::ComparableKey';

sub compare
{
    my ( $self, $other, $deep ) = @_;
    
    if ( $deep )
    {
	bless $self->signature, 'GnuPG::ComparableSignature';
	bless $self->fingerprint, 'GnuPG::ComparableFingerprint';
	
	return 0 unless
	  ( $self->signature->compare( $other->signature )
	    and $self->fingerprint->compare( $other->fingerprint() )
	  );
    }
    
    return $self->SUPER::compare( $other, $deep )
}

1;
