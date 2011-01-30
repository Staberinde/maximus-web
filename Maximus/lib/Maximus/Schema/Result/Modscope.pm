package Maximus::Schema::Result::Modscope;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Maximus::Schema::Result::Modscope

=cut

__PACKAGE__->table("modscope");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 45 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("uniq_name", ["name"]);

=head1 RELATIONS

=head2 modules

Type: has_many

Related object: L<Maximus::Schema::Result::Module>

=cut

__PACKAGE__->has_many(
  "modules",
  "Maximus::Schema::Result::Module",
  { "foreign.modscope_id" => "self.id" },
  {},
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2011-01-30 21:39:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cWOg5osbMP6hslyeYeCjlQ


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
