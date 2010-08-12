package Maximus::Task::Module::Update;
use Carp qw/confess/;
use IO::File;
use Moose;
use Maximus::Class::Module;

with 'Maximus::Role::Task';

=head1 NAME

Maximus::Task::Module::Update - Update module database

=head1 SYNOPSIS

	use Maximus::Class::Module;
	use Maximus::Task::Module::Update;
	my $mod = Maximus::Class::Module->new;
	my $task = Maximus::Task::Module::Update->new(mod => $mod);
	$task->init;
	$task->run;

=head1 DESCRIPTION

Update a module in the database.

=head1 ATTRIBUTES

=head2 mod

A I<Maximus::Class::Module> object
=cut
has 'mod' => (is => 'rw', isa => 'Maximus::Class::Module', required => 1);

=head1 METHODS

=head2 run

Run task
=cut
sub run {
	my $self = shift;
	
	my $fh = IO::File->new_tmpfile;
	
	$self->mod->source->prepare($self->mod);
	my $filename = $self->mod->source->archive(
		$self->mod,
		$fh,
	);

	1;
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

1;
