package Maximus::Role::Form::Account::Username;
use HTML::FormHandler::Moose::Role;

has_field 'username' => (
    type             => 'Text',
    label            => 'Username',
    required         => 1,
    required_message => 'You must enter a username',
    minlength        => 3,
    maxlength        => 25,
);

no HTML::FormHandler::Moose::Role;

1;

