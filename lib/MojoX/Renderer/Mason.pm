package MojoX::Renderer::Mason;

use strict;
use warnings;

require HTML::Mason;
require HTML::Mason::Interp;
require HTML::Mason::Request;

our $VERSION = '0.10';

sub build {
  shift;    # ignore
  my %args = @_;

  my @allow_globals = ('$ctx', @{$args{allow_globals} || []});
  $args{allow_globals} = \@allow_globals;

  my $interp = HTML::Mason::Interp->new(%args);

  return sub {
    my ($mojo, $ctx, $output) = @_;
    my $stash    = $ctx->stash;
    my $template = $stash->{template};

    $template =~ s,^/*,/,;    # must start with /

    $interp->set_global('ctx' => $ctx);

    HTML::Mason::Request->new(
      interp     => $interp,
      args       => [%$stash],
      out_method => $output,
      comp       => $template,
    )->exec;

    return 1;
  };
}

1;

__END__

=encoding utf-8

=head1 NAME

MojoX::Renderer::Mason - HTML::Mason renderer for Mojo

=head1 SYNOPSIS

  use MojoX::Renderer::Mason;

  sub startup {
    my $self = shift;

    $self->types->type(html => 'text/html');

    my $render = MojoX::Renderer::Mason->build(
      comp_root => $self->home->rel_dir('mason'),
    );

    $self->renderer->add_handler(html => $render);
  }

=head1 DESCRIPTION

Once added this renderer will be called by L<MojoX::Renderer> for any given template
where the suffix of the specified template matches the suffix used in the C<add_handler>
method.

When the renderer is invoked, the contents of the stash will be passed to the template
in C<%ARGS>. Templates also have access to the context as C<$ctx>

=head1 METHODS

=head2 build

This method returns a handler for the Mojo renderer.

Supported parameters are any parameter documented as valid to L<HTML::Mason::Interp>, see L<HTML::Mason::Params>

L<comp_root|HTML::Mason::Params/comp_root> is a required parameter.

=head1 AUTHOR

Graham Barr <gbarr@cpan.org>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mojox-renderer-mason at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MojoX-Renderer-Mason>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head1 SEE ALSO

L<HTML::Mason>, L<HTML::Mason::Params>, L<MojoX::Renderer>

=head1 COPYRIGHT & LICENSE

Copyright (C) 2008 Graham Barr

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
