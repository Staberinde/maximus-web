package Maximus::Schema::Result::Module;

# Created by DBIx::Class::Schema::Loader

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

Maximus::Schema::Result::Module

=cut

__PACKAGE__->table("module");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 scm_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 1

=head2 modscope_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 desc

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 scm_settings

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
    "id",
    {   data_type         => "integer",
        extra             => {unsigned => 1},
        is_auto_increment => 1,
        is_nullable       => 0,
    },
    "scm_id",
    {   data_type      => "integer",
        extra          => {unsigned => 1},
        is_foreign_key => 1,
        is_nullable    => 1,
    },
    "modscope_id",
    {   data_type      => "integer",
        extra          => {unsigned => 1},
        is_foreign_key => 1,
        is_nullable    => 0,
    },
    "name",
    {data_type => "varchar", is_nullable => 0, size => 45},
    "desc",
    {data_type => "varchar", is_nullable => 0, size => 255},
    "scm_settings",
    {data_type => "text", is_nullable => 0},
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("idx_module_1", ["modscope_id", "name"]);

=head1 RELATIONS

=head2 modscope

Type: belongs_to

Related object: L<Maximus::Schema::Result::Modscope>

=cut

__PACKAGE__->belongs_to(
    "modscope",
    "Maximus::Schema::Result::Modscope",
    {id => "modscope_id"}, {},
);

=head2 scm

Type: belongs_to

Related object: L<Maximus::Schema::Result::Scm>

=cut

__PACKAGE__->belongs_to(
    "scm",
    "Maximus::Schema::Result::Scm",
    {id        => "scm_id"},
    {join_type => "LEFT", on_update => 'SET NULL', on_delete => 'SET NULL'},
);

=head2 module_versions

Type: has_many

Related object: L<Maximus::Schema::Result::ModuleVersion>

=cut

__PACKAGE__->has_many(
    "module_versions",
    "Maximus::Schema::Result::ModuleVersion",
    {"foreign.module_id" => "self.id"}, {},
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-20 10:22:45

use JSON::Any;
__PACKAGE__->inflate_column(
    'scm_settings',
    {   inflate => sub { JSON::Any->jsonToObj(shift || '{}') },
        deflate => sub { JSON::Any->objToJson(shift || {}) },
    }
);

=head2 sqlt_deploy_hook

Force MySQL to use InnoDB and UTF-8

=cut

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    $sqlt_table->extra(
        mysql_table_type => 'InnoDB',
        mysql_charset    => 'utf8'
    );
}

sub module_versions_without_archive {
    return shift->search_related(
        'module_versions',
        undef,
        {   columns  => [qw/id version meta_data remote_location/],
            prefetch => 'module_dependencies',
        }
    );
}

sub module_versions_only_id_and_remote_location {
    my ($self, $version) = @_;
    return $self->search_related(
        'module_versions',
        {version => $version},
        {columns => [qw/id remote_location/]}
    );
}

__PACKAGE__->meta->make_immutable;
1;
