#!/usr/bin/perl -w

use strict;
use English;

use lib './t';
use MyTest;
use MyTestSpecific;

my ( $key, $genkey );

TEST
{
    reset_handles();
    
    my @returned_keys = $gnupg->get_secret_keys( '0xF950DA9C' );
    
    return 0 unless @returned_keys == 1;
    
    $key = shift @returned_keys;
    
    $genkey = GnuPG::SecretKey->new
      ( length                 => 1024,
	algo_num               => 17,
	hex_id                 => '53AE596EF950DA9C',
	creation_date_string   => '2000-02-06',
	expiration_date_string => '2002-02-05',
	owner_trust            => 'f',
      );
    
    $genkey->fingerprint->hex_data
      ( '93AFC4B1B0288A104996B44253AE596EF950DA9C' );
    
    my $user_id1 = GnuPG::UserId->new
      ( validity           => 'u',
	user_id_string     => 'GnuPG test key (for testing purposes only)',
      );
    
    my $user_id2 = GnuPG::UserId->new
      ( validity         => 'u',
	user_id_string   => 'Foo Bar (1)',
      );
    
    my $subkey = GnuPG::SubKey->new
      ( validity                 => 'u',
	length                   => 768,
	algo_num                 => 16,
	hex_id                   => 'ADB99D9C2E854A6B',
	creation_date_string     => '2000-02-06',
	expiration_date_string   => '2002-02-05',
      );
    
    $subkey->fingerprint->hex_data
      ( '7466B7E98C4CCB64C2CE738BADB99D9C2E854A6B' );
    
    $genkey->push_user_ids( $user_id1, $user_id2 );
    $genkey->push_subkeys( $subkey );

    $key->rigorously_compare( $genkey );
};


TEST
{
    $key->fingerprint->deeply_compare( $genkey->fingerprint );
};
    

TEST
{
    my $equal = ( $key->subkeys )[0]->rigorously_compare( ( $genkey->subkeys )[0] );
    warn 'subkeys fail comparison; this is a known issue with recent development versions of GnuPG' unless $equal;
    return $equal;
};


TEST
{
    $key->deeply_compare( $genkey );
};
