#  ComparableSignature.pm
#    - comparable GnuPG::Signature
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
#  $Id: ComparableSignature.pm,v 1.1 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::ComparableSignature;

use strict;
use vars qw( @ISA );
use GnuPG::Signature;

push @ISA, 'GnuPG::Signature';

sub compare
{
    my ( $self, $other ) = @_;
    
    my @comparison_pairs =
      ( $self->algo_num(),               $other->algo_num(),
        $self->hex_id(),                 $other->hex_id(),
        $self->date_string(),            $other->date_string(),
      );
    
    for ( my $i = 0; $i < @comparison_pairs; $i+=2 )
    {
	return 0 if $comparison_pairs[$i] ne $comparison_pairs[$i+1];
    }
    
    return 1;
}

1;
