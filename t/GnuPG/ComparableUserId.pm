#  ComparableUserId.pm
#    - providing an object-oriented approach to GnuPG user ids
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
#  $Id: ComparableUserId.pm,v 1.1 2001/04/28 04:01:04 ftobin Exp $
#

package GnuPG::ComparableUserId;

use strict;
use vars qw( @ISA );
use GnuPG::UserId;

push @ISA, 'GnuPG::UserId';

sub compare
{
    my ( $self, $other, $deep ) = @_;
    
    return 0 unless $self->user_id_string() eq $other->user_id_string();
    return 0 unless $self->_deeply_compare( $other );
    return 1;
}


sub _deeply_compare
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
	  unless $self_signatures[$i]->compare( $other_signatures[$i], 1 );
    }
    
    return 1;
}


1;
