package Bio::RNASeq::GeneModelHandlers::OldChadoFormatGeneModelHandler;

# ABSTRACT: OldChadoFormat class for handling gene models where genes and exons are CDS features

=head1 SYNOPSIS
OldChadoFormat class for handling gene models where genes and exons are CDS features
	use Bio::RNASeq::GeneModelHandlers::OldChadoFormatGeneModelHandler;
	my $gene_model_handler = Bio::RNASeq::GeneModelHandlers::OldChadoFormatGeneModelHandler->new(

	  );
=cut

use Moose;
extends('Bio::RNASeq::GeneModelHandlers::GeneModelHandler');

has 'tags_of_interest' =>
  ( is => 'rw', isa => 'ArrayRef', default => sub { ['CDS'] } );

has 'tags_to_ignore' => 
(
    is      => 'rw',
    isa     => 'ArrayRef',
     default => sub { ['gap','sequence_feature','repeat_region','databank_entry','ncRNA','rRNA','tRNA'] }
  );

sub _build_gene_models {

    my ($self) = @_;

    my %features;

    while ( my $raw_feature = $self->_gff_parser->next_feature() ) {

        if ( $self->is_tag_of_interest( $raw_feature->primary_tag ) ) {

            my $feature_object =
              Bio::RNASeq::Feature->new( raw_feature => $raw_feature );

            if ( defined( $features{ $feature_object->gene_id } ) ) {
                $features{ $feature_object->gene_id }
                  ->add_discontinuous_feature($raw_feature, 1);
                  $features{ $feature_object->gene_id}->gene_id( $feature_object->gene_id);
              		
            }
            else {

                $features{ $feature_object->gene_id } = $feature_object;
            }

        }
    }
    return \%features;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
