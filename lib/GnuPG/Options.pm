#  Options.pm
#    - providing an object-oriented approach to GnuPG's options
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
#  $Id: Options.pm,v 1.3 2000/04/25 20:23:38 ftobin Exp $
#

package GnuPG::Options;

use strict;
use Class::MethodMaker
  get_set       => [ qw( homedir
			 armor
			 default_key
			 no_greeting
			 verbose         no_verbose      quiet
			 batch
			 always_trust
			 comment         no_comment
			 status_fd       logger_fd       passphrase_fd
			 compress_algo
			 force_v3_sigs
			 rfc1991         openpgp
			 options         no_options
			 
			 meta_pgp_5_compatible
			 meta_pgp_2_compatible
			 meta_interactive
			 meta_signing_key
		       ) ],
  list          => [ qw( encrypt_to
			 recipients
			 meta_recipients_keys
			 extra_args
		       ) ],
  new_with_init => 'new',
  new_hash_init => 'hash_init';


sub init
{
    my ( $self, %args ) = @_;
    
    $self->hash_init( meta_interactive => 1 );
    $self->hash_init( %args );
}



sub copy
{
    my ( $self ) = @_;
    return __PACKAGE__->new( %{ $self } );
}



sub get_args
{
    my ( $self ) = @_;
    
    return ( $self->get_meta_args(),
	     $self->get_option_args(),
	     $self->extra_args() );
}



sub get_option_args
{
    my ( $self ) = @_;

    my @args = ();
    
    push @args, '--homedir',       $self->homedir()         if $self->homedir();
    push @args, '--options',       $self->options()         if $self->options();
    push @args, '--no-options'                              if $self->no_options();
    push @args, '--armor'                                   if $self->armor();
    push @args, '--default-key',   $self->default_key()     if $self->default_key();
    push @args, '--no-greeting'                             if $self->no_greeting();
    push @args, '--verbose'                                 if $self->verbose();
    push @args, '--no-verbose'                              if $self->no_verbose();
    push @args, '--quiet'                                   if $self->quiet();
    push @args, '--batch'                                   if $self->batch();
    push @args, '--always-trust'                            if $self->always_trust();
    push @args, '--comment',       $self->comment()         if $self->comment();
    push @args, '--no-comment'                              if $self->no_comment();
    push @args, '--status-fd',     $self->status_fd()       if defined $self->status_fd();
    push @args, '--logger-fd',     $self->logger_fd()       if defined $self->logger_fd();
    push @args, '--passphrase-fd', $self->passphrase_fd()   if defined $self->passphrase_fd();
    push @args, '--compress-algo', $self->compress_algo()   if defined $self->compress_algo();
    push @args, '--force-v3-sigs'                           if $self->force_v3_sigs();
    push @args, '--rfc1991'                                 if $self->rfc1991;
    push @args, '--openpgp'                                 if $self->openpgp();
    
    push @args, map { ( '--recipient', $_ ) } $self->recipients();
    push @args, map { ( '--encrypt-to', $_ ) } $self->encrypt_to();
    
    return @args;
}



sub get_meta_args
{
    my ( $self ) = @_;
    
    my @args = ();
    
    push @args, '--compress-algo', 1, '--force-v3-sigs'     if $self->meta_pgp_5_compatible();
    push @args, '--rfc1991'                                 if $self->meta_pgp_2_compatible();
    push @args, '--batch', '--no-tty'                       if not $self->meta_interactive();
    push @args, '--default-key', $self->meta_signing_key()  if $self->meta_signing_key();
    
    push @args, map { ( '--recipient', $_->hex_id() ) } $self->meta_recipients_keys();
    
    return @args;
}


1;


__END__

=head1 NAME

GnuPG::Options - GnuPG options embodiment

=head1 SYNOPSIS

  # assuming $gnupg is a GnuPG::Interface object
  $gnupg->options->armor( 1 );
  $gnupg->options->push_recipients( 'ftobin', '0xABCD1234' );

=head1 DESCRIPTION

GnuPG::Options objects are generally not instantiated on their
own, but rather as part of a GnuPG::Interface object.

=head1 OBJECT METHODS

=over 4

=item new( I<%initialization_args> )

This methods creates a new object.  The optional arguments are
initialization of data members; the initialization is done
in a manner according to the method created as described
in L<Class::MethodMaker/"new_hash_init">.

=item hash_init( I<%args> ).

This method works as described in L<Class::MethodMaker/"new_hash_init">.

=item copy

Returns a copy of this object.  Useful for 'saving' options.

=item get_args

Returns a list of arguments to be passed to GnuPG based
on data members which are 'meta_' options, regular options,
and then I<extra_args>, in that order.

=back

=head1 OBJECT DATA MEMBERS

Note that these data members are interacted with via object methods
created using the methods described in L<Class::MethodMaker/"get_set">,
L<Class::MethodMaker/"object">, and L<Class::MethodMaker/"list">.
Please read there for more information.

=over 4

=item homedir

=item armor

=item default_key

=item no_greeting

=item verbose

=item no_verbose

=item quiet

=item batch

=item always_trust

=item comment

=item no_comment

=item status_fd

=item logger_fd

=item passphrase_fd

=item compress_algo

=item force_v3_sigs

=item rfc1991

=item openpgp

=item options

=item no_options

=item encrypt_to

=item recipients

These options correlate directly to many GnuPG options.  For those that
are boolean to GnuPG, simply that argument is passed.  For those
that are associated with a scalar, that scalar is passed passed
as an argument appropriate.  For those that can be specified more
than once, such as B<recipients>, those are considered lists
and passed accordingly.  Each are undefined to begin.

=head2 Meta Options

Meta options are those which do not correlate directly to any
option in GnuPG, but rather are generally a bundle of options
used to accomplish a specific goal, such as obtaining
compatibility with PGP 5.  The actual arguments each of these
reflects may change with time.  Each defaults to false unless
otherwise specified.

=item meta_pgp_5_compatible

If true, arguments are generated to try to be compatible with PGP 5.

=item meta_pgp_2_compatible

If true, arguments are generated to try to be compatible with PGP 5.

=item meta_interactive

If false, arguments are generated to try to help the using program
use GnuPG in a non-interactive environment, such as CGI scripts.
Default is true.

=item meta_signing_key

This scalar reflects the key used to sign messages.
Currently this is synonymous with the B<default_key> data member.

=item meta_recipients_keys

This list of keys, of the type GnuPG::Key, are used to generate the
appropriate arguments having these keys as recipients.

=back

=head2 Other Data Members

=over 4

=item extra_args

This is a list of any other arguments used to pass to GnupG.
Useful to pass an argument not yet covered in this package.

=back

=head1 SEE ALSO

See also L<GnuPG::Interface and L<Class::MethodMaker>.

=cut
