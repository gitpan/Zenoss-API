package Zenoss::API::Response;
use strict;
use JSON qw{};

use Moose;
with 'Zenoss::API::Error';

#**************************************************************************
# Public Attributes
#**************************************************************************
# HTTP::Response from Zenoss::API::Router
has handler => (
    isa         => 'HTTP::Response',
    is          => 'ro',
    handles     => {
        # Proxy methods to HTTP::Response
        json                    => 'decoded_content',
        raw_response            => 'as_string',
        http_code               => 'code',
        http_code_description   => 'message',
        http_status             => 'status_line',
        is_success              => 'is_success',
        is_error                => 'is_error',
        error_as_HTML           => 'error_as_HTML',        
        header                  => 'header',
        request_time            => 'current_age',
    },
    required    => 1,
);

# Transaction ID that was sent to the Zenoss server
has transaction_id => (
    is          => 'ro',
    isa         => 'Num',
    required    => 1,
);

#**************************************************************************
# Public Methods
#**************************************************************************
#======================================================================
# hash
#======================================================================
sub hash  {
    my $self = shift;
    my $json_decoder = JSON->new->allow_nonref;
    return $json_decoder->decode($self->json);
} # END hash

#**************************************************************************
# Package end
#**************************************************************************
__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=head1 NAME

Zenoss::API::Response - Handles responses from Zenoss::API::Router

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

=head1 DESCRIPTION

This class is NOT instantiated directly.  When the Zenoss API issues a response
to a request initiated by Zenoss::API::Router, a Zenoss::API::Response instance is created.
To call methods from this package create an instance of Zenoss::API and issue an API
call.

Please review the SYNOPSIS for examples.

=head1 ATTRIBUTES

Attributes can be retrieved by calling $obj->attribute.

=head2 transaction_id

This attribute is set upon the creation of Zenoss::API::Response by Zenoss::API::Router.  Each
request issued to the Zenoss API is coded with a transaction_id (tid).  The response transaction_id
should match the transaction_id of the inital request.  This attribute is provided to allow
the ability to check if the request transaction id matches response transaction id.  This may
not be greatly important now, but will show its value once composite transactions are supported
by Zenoss::API (IE send multiple requests in one call).

=head1 METHODS

=head2 $obj->json()

Returns the response, from the Zenoss API request, in JSON format.

=head2 $obj->hash()

Returns the response, from the Zenoss API request, in a PERL hashref.

=head2 $obj->raw_response()

Returns a textual representation of the response.

=head2 $obj->http_code()

Returns a 3 digit number that encodes the overall outcome of a HTTP response.

For example 200, for OK.

=head2 $obj->http_code_description()

Returns a short human readable single line string that explains the response code.

For example, OK.

=head2 $obj->http_status()

Returns the string "<http_code> <http_code_description>". If the http_code_description
attribute is not set then the official name of <code> (see HTTP::Status) is substituted.

=head2 $obj->is_success()

Returns true if the response was successful.

See HTTP::Status for the meaning of these.

=head2 $obj->is_error()

Returns true if the response had an error.

See HTTP::Status for the meaning of these.

=head2 $obj->error_as_HTML()

Returns a string containing a complete HTML document indicating what error occurred.
This method should only be called when $obj->is_error is TRUE.

=head2 $obj->header()

This is used to get header values and it is inherited from HTTP::Headers via HTTP::Message.

=head2 $obj->request_time()

Calculates the "current age" of the response as specified by RFC 2616 section 13.2.3.
The age of a response is the time since it was sent by the origin server. The returned value
is a number representing the age in seconds.

=head2 $obj->transaction_id()

Returns the transaction_id (tid) of the request to the Zenoss API.  This can be compared to
the tid in $obj->json() or $obj->hash(); Zenoss should return the same tid that was sent in
the inital request.

=head1 SEE ALSO

=over

=item *

L<Zenoss::API>

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