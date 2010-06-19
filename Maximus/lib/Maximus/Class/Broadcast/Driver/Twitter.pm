package Maximus::Class::Broadcast::Driver::Twitter;
use Moose;
use Net::Twitter;
use namespace::autoclean;
with 'Maximus::Role::Broadcast::Driver';

our $VERSION = '0.001';
$VERSION = eval{ $VERSION };

=head1 NAME

Maximus::Class::Broadcast::Driver::Twitter - Tweet broadcasts

=head1 SYNOPSIS

	use Maximus::Class::Broadcast::Driver::Twitter;
	my $driver = Maximus::Class::Broadcast::Driver::Twitter->new(
		username => 'maximus',
		password => 'secret',
	);
	
	# -or-
	
	use Net::Twitter;
	my $nt = Net::Twitter->new(
		traits => ['API::REST'],
		username => 'maximus',
		password => 'secret',
	);
	
	$driver = Maximus::Class::Broadcast::Driver::Twitter->new( nt => $nt);
	
	# Finally...
	my $msg = Maximus::Class::Broadcast::Message->new(text => 'Hello world!');
	$driver->say($msg);

=head1 DESCRIPTION

This driver is mainly for testing purposes. Any message passed to it will be
ignored. It does however count the number of times C<say> has been called.

=head1 ATTRIBUTES

=head2 nt

Net::Twitter object
=cut
has 'nt' => (
	isa => 'Net::Twitter',
	is => 'rw',
);

=head2 username

Read-Only, used for creating a Net::Twitter object
=cut
has 'username' => (
	isa => 'Str',
	is => 'ro',
);

=head2 password

Read-Only, used for creating a Net::Twitter object
=cut
has 'password' => (
	isa => 'Str',
	is => 'ro',
);

=head1 METHODS

=head2 say(L<Maximus::Class::Broadcast::Message> $msg)

Tweet the message
=cut
sub say {
	my($self, $msg) = @_;
	return $self->nt->update($msg->text);
}

=head2 BUILD

Allow the constructor to create a Net::Twitter object when none is passed
=cut
sub BUILD {
	my $self = shift;
	if($self->username && $self->password && !$self->nt) {
		$self->nt( Net::Twitter->new(
			traits => ['API::REST'],
			username => $self->username,
			password => $self->password,
		));
	}
}

=head1 AUTHOR

Christiaan Kras

=head1 LICENSE

Copyright (c) 2010 Christiaan Kras

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=cut

__PACKAGE__->meta->make_immutable;
1;