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
#  $Id: ComparablePublicKey.pm,v 1.2 2001/04/30 00:09:26 ftobin Exp $
#

package GnuPG::ComparablePublicKey;

use strict;
use vars qw( @ISA );
use GnuPG::PublicKey;
use GnuPG::ComparablePrimaryKey;

push @ISA, 'GnuPG::PublicKey', 'GnuPG::ComparablePrimaryKey';

1;
