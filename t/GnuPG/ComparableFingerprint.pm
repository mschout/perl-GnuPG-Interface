#  ComparableFingerprint.pm
#    - comparable GnuPG::Fingerprint
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
#  $Id: ComparableFingerprint.pm,v 1.2 2001/04/30 00:09:26 ftobin Exp $
#

package GnuPG::ComparableFingerprint;

use strict;
use vars qw( @ISA );
use GnuPG::Fingerprint;

push @ISA, 'GnuPG::Fingerprint';

sub compare
{
    my ( $self, $other ) = @_;
    
    return $self->as_hex_string() eq $other->as_hex_string();
}

1;
