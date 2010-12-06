package Zenoss::API::Router::Process;
use strict;

use Moose::Role;
with 'Zenoss::API::Router::Tree', 'Zenoss::API::MetaHelper';
requires '_router_request', '_check_args';
__PACKAGE__->_INSTALL_META_METHODS;

#**************************************************************************
# Attributes
#**************************************************************************
has 'PROCESS_LOCATION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'zport/dmd/process_router',
    init_arg    => undef,
);

has 'PROCESS_ACTION' => (
    is          => 'ro',
    isa         => 'Str',
    default     => 'ProcessRouter',
    init_arg    => undef,
);

#**************************************************************************
# Public Functions
#**************************************************************************
#======================================================================
# process_getTree
#======================================================================
sub process_getTree {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        required    => ['id'],
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'getTree',
            data        => [$args],
        }
    );
} # END process_getTree

#======================================================================
# process_moveProcess
#======================================================================
sub process_moveProcess {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        required    => ['uid', 'targetUid'],
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'moveProcess',
            data        => [$args],
        }
    );
} # END process_moveProcess

#======================================================================
# process_getInfo
#======================================================================
sub process_getInfo {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        required    => ['uid'],
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'getInfo',
            data        => [$args],
        }
    );
} # END process_getInfo

#======================================================================
# process_setInfo
#======================================================================
sub process_setInfo {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        required    => ['uid'],
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'setInfo',
            data        => [$args],
        }
    );
} # END process_getInfo

#======================================================================
# process_getInstances
#======================================================================
sub process_getInstances {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        defaults    => {
            start   => 0,
            limit   => 50,
            sort    => 'name',
            dir     => 'ASC',
        },
        required    => ['uid'],
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'getInstances',
            data        => [$args],
        }
    );
} # END process_getInstances

#======================================================================
# process_getSequence
#======================================================================
sub process_getSequence {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {};

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'getSequence',
            data        => [$args],
        }
    );
} # END process_getSequence

#======================================================================
# process_setSequence
#======================================================================
sub process_setSequence {
    my ($self, $args) = @_;
    $args = {} if !$args;

    # Argument definition
    my $definition = {
        required    => ['uids']
    };

    # Check the args
    $self->_check_args($args, $definition);

    # Route the request
    $self->_router_request(
        {
            location    => $self->PROCESS_LOCATION,
            action      => $self->PROCESS_ACTION,
            method      => 'setSequence',
            data        => [$args],
        }
    );
} # END process_setSequence

#**************************************************************************
# Package end
#**************************************************************************
no Moose;

1;

__END__

=head1 NAME

Zenoss::API::Router::Process - A JSON/ExtDirect interface to operations on processes

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
    my $response = $api->zenoss->process_SOMEMETHOD({parameter1 => 'value', parameter2 => 'value'});

=head1 DESCRIPTION

This class is NOT instantiated directly.  To call methods from this package create an
instance of Zenoss::API.  This document serves as a resource of available Zenoss API
calls available for use with Zenoss::API.

=head2 $obj->process_getTree()

Returns the tree structure of an organizer hierarchy where the root node is the organizer identified by the id parameter.

=over

=item PARAMETERS

id (string) - Id of the root node of the tree to be returned

=back

=over

=item REQUIRED PARAMETERS

id

target

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

Object representing the tree

=back

=head2 $obj->process_moveProcess()

Move a process or organizer from one organizer to another.

=over

=item PARAMETERS

uid (string) - UID of the process or organizer to move

targetUid (string) - UID of the organizer to move to

=back

=over

=item REQUIRED PARAMETERS

uid

targetUid

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

uid: (dictionary) The new uid for moved process or organizer

=back

=head2 $obj->process_getInfo()

Get the properties of a process.

=over

=item PARAMETERS

uid (string) - Unique identifier of a process

keys (list) - List of keys to include in the returned dictionary. If None then all keys will be returned

=back

=over

=item REQUIRED PARAMETERS

uid

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

data: (dictionary) Object representing a process's properties

=back

=head2 $obj->process_setInfo()

Set attributes on a process. This method accepts any keyword argument for the property that you wish to set. The only required property is "uid".

=over

=item PARAMETERS

uid (string) - Unique identifier of a process

=back

=over

=item REQUIRED PARAMETERS

uid

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

data: (dictionary) Object representing a process's new properties

=back

=head2 $obj->process_getInstances()

Get a list of instances for a process UID.

=over

=item PARAMETERS

uid (string) - Process UID to get instances of

start (integer) - Offset to return the results from; used in pagination

params (dictionary) - Key-value pair of filters for this search.

limit (integer) - Number of items to return; used in pagination

sort (string) - Key on which to sort the return results

dir (string) - Sort order; can be either 'ASC' or 'DESC'

=back

=over

=item REQUIRED PARAMETERS

uid

=back

=over

=item DEFAULT PARAMETERS

{start => 0, limit => 50, sort => 'name', dir => 'ASC'}

=back

=over

=item RETURNS

data: ([dictionary]) List of objects representing process instances

total: (integer) Total number of instances

=back

=head2 $obj->process_getSequence()

Get the current processes sequence.

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

data: ([dictionary]) List of objects representing processes in sequence order

=back

=head2 $obj->process_setSequence()

Set the current processes sequence.

=over

=item PARAMETERS

uids ([string]) - The set of process uid's in the desired sequence

=back

=over

=item REQUIRED PARAMETERS

uids

=back

=over

=item DEFAULT PARAMETERS

N/A

=back

=over

=item RETURNS

Success message

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