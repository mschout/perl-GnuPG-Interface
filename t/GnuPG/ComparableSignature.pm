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
#  $Id: ComparableSignature.pm,v 1.2 2001/04/30 00:09:26 ftobin Exp $
#

package GnuPG::ComparableSignature;

use strict;
use vars qw( @ISA );
use GnuPG::Signature;

push @ISA, 'GnuPG::Signature';

sub compare
{
    my ( $self, $other ) = @_;
    
    my @compared_fields = qw( algo_num hex_id date_string );
    
    foreach my $field ( @compared_fields )
    {
	my $f1 = $self->$field();
	my $f2 = $other->$field();
	
	# don't test for definedness because
	# all fields should be defined
	return 0 unless $self->$field() eq $other->$field();
    }
    
    return 1;
}

1;
