package Zenoss::API;
use strict;

use Moose;
use Zenoss::API::Connector;
use Zenoss::API::Router;

our $VERSION = '1.02';

#**************************************************************************
# Public methods
#**************************************************************************
#======================================================================
# connect
#======================================================================
sub connect {
    my ($self, $args) = @_;
    return $self->_connect($args);
}

#**************************************************************************
# Private methods
#**************************************************************************
#======================================================================
# _connect
#======================================================================
sub _connect {
    my ($self, $args) = @_;
    Zenoss::API::Router->new(
        {
            connector => Zenoss::API::Connector->new($args),
        }
    );
} # END connect

#**************************************************************************
# Package end
#**************************************************************************
__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Zenoss::API - Perl interface to the Zenoss JSON API

=head1 SYNOPSIS

    use Zenoss::API;
    use Data::Dumper;
    
    # Create a Zenoss::API object
    my $api = Zenoss::API->connect(
        {
            username    => 'admin',
            password    => 'zenoss',
            url         => 'http://zenossinstance:8080',
        }
    );
    
    # Issue a request to get all devices from Zenoss
    my $response = $api->device_getDevices();
    
    # $response is now an instance of Zenoss::API::Response
    # now we can do things like
    print $response->json();
    print $response->http_code();
    
    # get the response in hashref form
    my $response_hash = $response->hash();
    print Dumper $response_hash;
    
    # Query events, with history, and only return
    # events that have a severity of 0,1,2,3,4 or 5
    my $events = $api->events_query(
        {
            history => JSON::true,
            params  => {
                severity => [0,1,2,3,4,5],
            }
        }
    );

=head1 DESCRIPTION

This is an aggregate package that ties components together that are vital to
communicating with a Zenoss JSON API.  Zenoss::API is a full service implementation
that provides all documented API calls by Zenoss.  Essentially, anything that you can
accomplish via the Zenoss UI can be done via Zenoss::API.

To get an idea of what requests can be issued to the Zenoss JSON API, please review
the documentation for the following packages.

=over

=item *

L<Zenoss::API::Router::DetailNav>

=item *

L<Zenoss::API::Router::Device>

=item *

L<Zenoss::API::Router::Events>

=item *

L<Zenoss::API::Router::Messaging>

=item *

L<Zenoss::API::Router::Mib>

=item *

L<Zenoss::API::Router::Network>

=item *

L<Zenoss::API::Router::Process>

=item *

L<Zenoss::API::Router::Report>

=item *

L<Zenoss::API::Router::Service>

=item *

L<Zenoss::API::Router::Template>

=item *

L<Zenoss::API::Router::Tree>

=item *

L<Zenoss::API::Router::ZenPack>

=back

The documentation for these packages were mostly taken from the Zenoss JSON API docs.  Keep in mind
that their programming is based around python, so descriptions such as dictionaries will be represented
as hashes in PERL.

=head1 METHODS

Available methods provided by this package.

=head2 $obj->connect({})

This method instantiates the Zenoss::API package.  Currently it accepts the following
attributes.  Note, these attributes can be described in detail at L<Zenoss::API::Connector>.

=over

=item *

username

=item *

password

=item *

url

=item *

timeout

=back

=head1 NOTES

Here are some notes regarding this interface.

=head2 Zenoss JSON API Attributes

=head3 Attributes in methods

When calling the various router methods available, note that any attribute you submit will be
converted to JSON and transmitted to the API.

For example:
    $api->device_getDevices({foo => 'bar'});

The above code will transmit an attribute, in JSON, of foo with a value of bar to the API.

Its also interesting to point out that each router method has an attribute definition.  If you
attempt to call a method that requires a specific attribute, and its omitted, it will croak.

=head3 JSON true, false, null

In the event that you need to use a true, false or null, the value can be submitted with:

=over

=item *

JSON::true

=item *

JSON::false

=item *

JSON::null

=back

For sake of clarity, say we need to add a device, but we want to also want to model the device
after the add.  Reading L<Zenoss::API::Router::Device> states that $obj->device_addDevice()
has a parameter of 'model', which is a boolean.  With that said we can do the following:

    my $response = $api->device_addDevice(
        {
            deviceName  => 'testdevice',
            deviceClass => '/Server/Linux',
            model       => JSON::true,
        }
    );

=head2 Error handling

Some methods Carp, so its always good to always try and trap exceptions.  This is mostly limited to
when attempting to establish connections to the API, API timeouts, and attribute checking.  Error 
handling of Zenoss API responses can be handled with the available methods in L<Zenoss::API::Response>.

=head1 DOCUMENTATION

Please let me know if there is trouble with the documentation.  I attempted to put a vast amount of
information together all at once, so there may be some mistakes.  If you have a question
about implementing something described in the documentation, let me know so I can clarify.  However,
please do not take advantage of this and only ask a question if you're really stuck!

=head1 SEE ALSO

=over

=item *

L<Zenoss::API::Response>

=back

=head1 BUGS

Please open bug tickets at L<https://rt.cpan.org>

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