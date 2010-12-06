package Zenoss::API::Router::Mib;
use strict;

use Moose::Role;
requires '_router_request', '_check_args';

#**************************************************************************
# Attributes
#**************************************************************************
has 'MIB_LOCATION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'zport/dmd/mib_router',
    init_arg    => undef,
);

has 'MIB_ACTION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'MibRouter',
    init_arg    => undef,
);

#**************************************************************************
# Public Functions
#**************************************************************************
#======================================================================
# mib_getTree
#======================================================================
sub mib_getTree {
    my ($self, $args) = @_;
    $self->_croak('The MibRouter API is not yet implemented on Zenoss');
} # END mib_getTree

#======================================================================
# mib_getOrganizerTree
#======================================================================
sub mib_getOrganizerTree {
    my ($self, $args) = @_;
    $self->_croak('The MibRouter API is not yet implemented on Zenoss');
} # END mib_getOrganizerTree

#**************************************************************************
# Package end
#**************************************************************************
no Moose;

1;

__END__

=head1 NAME

Zenoss::API::Router::Mib - A JSON/ExtDirect interface to operations on MIBs

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
    my $response = $api->zenoss->mib_SOMEMETHOD({parameter1 => 'value', parameter2 => 'value'});

=head1 DESCRIPTION

This class is NOT instantiated directly.  To call methods from this package create an
instance of Zenoss::API.  This document serves as a resource of available Zenoss API
calls available for use with Zenoss::API.

=head1 METHODS

The following is a list of available methods available for interaction with the Zenoss API.
Please take note of the arguement requirements, defaults and return content.

B<Mib is currently broken as Zenoss hasnt implemented the JSON interface>

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