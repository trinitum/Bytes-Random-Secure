## no critic (RCS,VERSION,encapsulation,Module)

use strict;
use warnings;
use Test::More;

use 5.006000;

use Bytes::Random::Secure;

# For testing purposes only.....
# A callback for Crypt::Random::Source::new().  Accepts number of bytes desired,
# and returns a string of that length which is unpacked as our seed.
# This enables us to test _seed() without draining the entropy pool.
my $source = sub { return join( '', 'a' x shift ); };

my $rv = Bytes::Random::Secure->config_seed( Source => $source, Count => 4 );
ok( $rv, 'Seed configuration succeeded.' );

my $bytes = random_bytes(4);
is( length $bytes, 4, 'Asked for four, got four.' );

$rv = Bytes::Random::Secure->config_seed( Source => sub{}, Count => 16 );
ok( ! $rv, 'Seed configuration unchanged after RNG initialized.' );

done_testing();
