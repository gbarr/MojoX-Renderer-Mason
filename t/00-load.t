#!perl -T

use Test::More tests => 1;

BEGIN {
        use_ok( 'MojoX::Renderer::Mason' );
}

diag( "Testing MojoX::Renderer::Mason $MojoX::Renderer::Mason::VERSION, Perl $], $^X" );
