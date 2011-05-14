package Maximus::Class::Broadcast::Message;
use Moose;
use DateTime;
use namespace::autoclean;

has 'text' => (
    isa => 'Str',
    is  => 'ro',
);

has 'date' => (
    isa     => 'DateTime',
    is      => 'ro',
    default => sub { DateTime->now }
);

__PACKAGE__->meta->make_immutable;

=head1 NAME

Maximus::Class::Broadcast::Message - Message

=head1 SYNOPSIS

	use Maximus::Class::Broadcast::Message;
	my $msg = Maximus::Class::Broadcast::Message->new(text => 'Hello world!');

=head1 DESCRIPTION

Message class to be passed to a announcer and/or driver.

=head1 ATTRIBUTES

=head2 text

The actual message

=head2 date

The publication date and time

=head1 AUTHOR

Christiaan Kras

=head1 LICENSE

Copyright (c) 2010-2011 Christiaan Kras

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

1;
