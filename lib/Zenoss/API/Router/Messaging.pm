package Zenoss::API::Router::Messaging;
use strict;

use Moose::Role;
requires '_router_request', '_check_args';

#**************************************************************************
# Attributes
#**************************************************************************
has 'MESSAGING_LOCATION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'zport/dmd/messaging_router',
    init_arg    => undef,
);

has 'MESSAGING_ACTION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'MessagingRouter',
    init_arg    => undef,
);

#**************************************************************************
# Public Functions
#**************************************************************************
#======================================================================
# messaging_getUserMessages
#======================================================================
sub messaging_getUserMessages {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {};

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->MESSAGING_LOCATION,
            action      => $self->MESSAGING_ACTION,
            method      => 'getUserMessages',
            data        => [$args],
        }
    );
} # END messaging_getUserMessages

#**************************************************************************
# Package end
#**************************************************************************
no Moose;

1;

__END__

=head1 NAME

Zenoss::API::Router::Messaging - A JSON/ExtDirect interface to operations on messages

=head1 SYNOPSIS

    use Zenoss::API;
    my $api = Zenoss::API->connect(
        {
            username    => 'zenoss username',
            password    => 'zenoss password',
            url         => 'http://zenossinstance:8080',
        }
    );

    # Replace SOMEMETHOD() with one of the available methods provided by this package
    my $response = $api->zenoss->messaging_SOMEMETHOD({parameter1 => 'value', parameter2 => 'value'});

=head1 DESCRIPTION

This class is NOT instantiated directly.  To call methods from this package create an
instance of Zenoss::API.  This document serves as a resource of available Zenoss API
calls available for use with Zenoss::API.

=head1 METHODS

The following is a list of available methods available for interaction with the Zenoss API.
Please take note of the arguement requirements, defaults and return content.

=head2 $obj->messaging_getUserMessages()

Get the queued messages for the logged in user.

=over

=item PARAMETERS

NONE

=back

=over

=item REQUIRED PARAMETERS

N/A

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

messages: ([string]) A list of queued messages.

=back

=head1 SEE ALSO

=over

=item *

L<Zenoss::API>

=item *

L<Zenoss::API::Response>

=back

=head1 AUTHOR

Patrick Baker E<lt>patricksbaker@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Patrick Baker E<lt>patricksbaker@gmail.comE<gt>

This module is free software: you can redistribute it and/or modify
it under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

You can obtain the Artistic License 2.0 by either viewing the
LICENSE file provided with this distribution or by navigating
to L<http://opensource.org/licenses/artistic-license-2.0.php>.

=cut