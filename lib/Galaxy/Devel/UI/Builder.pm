use strict;
use warnings;
package Galaxy::Devel::UI::Builder;

#ABSTRACT: UI specification in perl for Galaxy Platform
use Moose;
use Moose::Util::TypeConstraints;
use MooseX::Aliases;
use XML::Twig;

enum 'BoolStr', [qw(true false)];

has xml => ( isa => 'XML::Twig', is => 'rw', lazy_build =>1);
has cursor => ( isa => 'XML::Twig::Elt', is => 'rw', lazy_build => 1);
has id => ( isa => 'Str', is => 'rw', required =>1 );
has name => ( isa => 'Str', is => 'rw', required => 1 );
has version => ( isa => 'Str', is => 'rw', default => sub { '0.001'  });
has hidden =>  ( isa => 'BoolStr', is => 'rw', default => sub { 'false' });

sub _build_xml {
	my $self = shift;
	my $root = XML::Twig::Elt->new('tool');
	$root->set_att( id => $self->id, name => $self->name, version => $self->version, hidden => $self->hidden );
	my $t = XML::Twig->new(pretty_print=>'indented');
        $t->set_root($root); 
        $t;  
}

#starts at the root
sub _build_cursor {
  my $self = shift;
  my $root = $self->xml->root;
  	
}  

sub z {
	my $self = shift;
	$self->cursor( $self->cursor->last_child );	
	return $self; 
}

sub x {
  my $self = shift;
   $self->cursor( $self->cursor->parent );	
  return $self; 
}

sub description {
  my $self = shift;
  my $desc = shift;
  my $p = XML::Twig::Elt->new('description');
  $p->set_text( $desc );
  $p->paste_last_child( $self->xml->root );   
}
alias desc => 'description';

sub command {
  my $self = shift;
  my $interpreter = shift;
  my $cmd_txt = shift;
  my $p = XML::Twig::Elt->new('command');
  $p->set_att( interpreter => $interpreter );
  $p->set_text( $cmd_txt );
  my $cursor = $p->paste_last_child( $self->xml->root );  
  $self->cursor( $cursor );
}
alias cmd => 'command';

sub inputs {
  my $self = shift;
  my $p = XML::Twig::Elt->new('inputs');
  my $cursor = $p->paste_last_child( $self->xml->root );  
  $self->cursor($cursor);
}
alias in => 'inputs';

sub repeat {
  my $self = shift;
   my @att = @_;
  my $p = XML::Twig::Elt->new('repeat');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor );   
}

sub version_command {
  my $self = shift;
    my @att = @_;
  my $p = XML::Twig::Elt->new('version_command');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor );   
}


sub outputs {
  my $self = shift;

  my $p = XML::Twig::Elt->new('outputs');
  my $cursor = $p->paste_last_child( $self->xml->root );
  $self->cursor($cursor);  
}
alias out => 'outputs';

sub data {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('data');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor );  
}

sub tests {
  my $self = shift;
  
  my $p = XML::Twig::Elt->new('tests');
  my $cursor = $p->paste_last_child( $self->xml->root );  
  $self->cursor($cursor);
}

sub test {
  my $self = shift;
  
  my $p = XML::Twig::Elt->new('test');
  $p->paste_last_child( $self->cursor );  
}

sub output {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('output');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor );  
}

# this has loads of sub tags that I have yet to put in
sub assert_contents {
  my $self = shift;

  my $p = XML::Twig::Elt->new('assert_contents');

  $p->paste_last_child( $self->cursor ); 
}

sub page {
  my $self = shift;   
  my $p = XML::Twig::Elt->new('page');

  $p->paste_last_child( $self->cursor ); 
}

sub code {
  my $self = shift;
    my @att = @_;   
  my $p = XML::Twig::Elt->new('code');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor ); 
}


sub requirements {
  my $self = shift;
      my @att = @_;   
  my $p = XML::Twig::Elt->new('requirements');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor ); 
}

sub requirement {
  my $self = shift;
      my @att = @_;   
  my $p = XML::Twig::Elt->new('requirement');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor ); 
}

sub conditional {

  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('conditional');
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor );  

}
alias cond => 'conditional';


#  Optionally contained within an <options> tag set 
sub column {
  my $self = shift;
   my @att = @_;
  my $p = XML::Twig::Elt->new('column');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );
}

# Optionally contained within an <options> tag set - 
sub filter {
  my $self = shift;
   my @att = @_;
  my $p = XML::Twig::Elt->new('filter');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );
   
}


#This tag set is used only in "data_source" tools ( the "tool_type" attribute value is "data_source" ). 
#This tag set is contained within the <param> tag set - it contains a set of <request_param> tags.

sub request_param_translation {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('request_param_translation');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}

# Contained within the <request_param_translation> tag set ( used only in "data_source" tools ) 

sub request_param {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('request_param');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}

sub append_param {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('append_param');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}
#This tag set is optionally contained within the <data> tag set and is the container tag set for the following <when> tag set.
sub change_format {
  my $self = shift;
   my @att = @_;
  my $p = XML::Twig::Elt->new('change_format');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}


sub value_translation {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('value_translation');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}

#contained within value_translation tag
sub value {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('value');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}


sub when {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('when');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
  #$self->cursor( $cursor);
}

sub param {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('param');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor ); 
  #$self->cursor($cursor)
}

#contained within a parameter
sub validator {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('validator');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}

#contained with in parameter
sub sanitizer {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('sanitizer');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  

}
#contained within the sanitizer
sub valid {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('valid');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  

}

#contained with in the valid tag set
sub add {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('add');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  

}
#contained with in the valid tag set
sub remove {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('remove');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}

#contained with in the mapping tag set
sub mapping {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('mapping');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );
}

sub configfiles {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('configfiles');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor ); 
}

sub configfile {
  my $self = shift;
   my @att = @_;
  my $p = XML::Twig::Elt->new('configfile');
  $p->set_att( @att );
  my $cursor = $p->paste_last_child( $self->cursor );  
}


sub option {
  my $self = shift;
  my $txt = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('option');
  $p->set_text($txt);
  $p->set_att( @att );
  $p->paste_last_child( $self->cursor ); 
}
alias opt => 'option';

sub options {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('options');
  $p->set_att( @att );

  $p->paste_last_child( $self->cursor ); 
}
alias opts => 'options';

sub column {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('column');
  $p->set_att( @att );

  $p->paste_last_child( $self->cursor );  
}
alias col => 'column';


sub actions {
  my $self = shift;
  my @att = @_;
  my $p = XML::Twig::Elt->new('actions');
  $p->set_att( @att );

  $p->paste_last_child( $self->cursor );  
}


sub help {
 
  my $self = shift;
  my $txt = shift;
  my $p = XML::Twig::Elt->new('help');
  $p->set_text( $txt );
  my $cursor = $p->paste_last_child( $self->xml->root ); 
  $self->cursor($cursor);
}

1;

__END__

=SYNOPSIS

 my $g = Galaxy::Devel::UI::Builder->new(id=>"fa_gc_content_1", name=>"Compute GC contents");
 $g->desc("Compute GC content ");
 $g->cmd( "perl", 'testit.pl $input $output');
 
 $g->in;     # --- inputs   --- #
 $g->param( format=>"fasta", name=>"input", type=>"data", label=>"Source file");
 
 $g->out;    # --- outputs  --- #
 $g->data( format=>"tabular", name=>"output" );
                           
 $g->tests;  # ---  tests   --- #
 $g->test;
 $g->z->param(name=>"input", value=>"fa_gc_content_input.fa");
 $g->output( name=>"out_file1", file=>"fa_gc_content_output.txt");
     
             # ---  help    --- #    
 $g->help("This tool computes GC content from a FASTA file.");

 # print as string  
 print $g->xml->sprint;
 
 Produces Output:
 
 <tool hidden="false" id="fa_gc_content_1" name="Compute GC contents" version="0.001">
  <description>Compute GC content </description>
  <command interpreter="perl">testit.pl $input $output</command>
  <inputs>
    <param format="fasta" label="Source file" name="input" type="data"/>
  </inputs>
  <outputs>
    <data format="tabular" name="output"/>
  </outputs>
  <tests>
    <test>
      <param name="input" value="fa_gc_content_input.fa"/>
      <output file="fa_gc_content_output.txt" name="out_file1"/>
    </test>
  </tests>
  <help>This tool computes GC content from a FASTA file.</help>
</tool>
 
=cut 

=DESCRIPTION

 Galaxy is an open, web-based platform for data intensive biomedical research (galaxyproject.org). 
 
 A Galaxy Tool XML file is normally needed to accompany a Galaxy Tool application for specification of a generic galaxy
 user interface for the tool. This module allows for the specification of Galaxy Tool XML files using Perl.
 
 The module is essentially a wrapper around XML::Twig. Each method adds a twig to an xml tree, and sets the cursor
 following the examples outlined below. 
  
 The modules methods follow the tag sets at
 http://wiki.g2.bx.psu.edu/Admin/Tools/Tool%20Config%20Syntax#A.3Ctool.3E_tag_set
 
 A Galaxy Tool XML file is normally composed of an encompasing tool tag, and then several top level tags. Commonly used top level 
 tags are description, command, inputs, outputs, tests & help, as below:
 
 <tool ...
  <description ...
  <command ..
  <inputs ..
    .... under this tag specification of interface for input data
  <outputs ..
    ... under this tag specificication of output data
  <tests ..  
    ... specifies functional tests
  <help ..
 </tool>
    
 Walking through an example segment (see the synopsis):
 
 $g->tests; # Start Tests top level tag
 $g->test;  # test tag (nests automatically in tests)
 $g->z;     # indent, so next statement nests in test tag
 $g->param( name=>"input", value=>"fa_gc_content_input.fa");       # param must be nested inside test tag
 $g->output( name=>"out_file1", file=>"fa_gc_content_output.txt"); # output tag on same hierarchy as param, and follows param.
 
 contributes this to the XML file:
 ...
 <tests>
    <test>
      <param name="input" value="fa_gc_content_input.fa"/>
      <output file="fa_gc_content_output.txt" name="out_file1"/>
    </test>
  </tests>
 ...
 
 The "tests" method sets a top-level tag, which can be thought of as a "tests section" of your XML Tool file.
 The next statement following this top level tag, (that is not another top level tag), will be a child of this tag.
 In the example above, this is the "test" tag. 
 
 Any further tag statement will be a child of "tests", unless the indent operator z is used to nest in the preceeding tag. 
 In the example above this is used to nest the param tag. This might also be written:  
     
     $g->z->param( name=>"input", value=>"fa_gc_content_input.fa"); 
 
 The x operator reverses the indentation, i.e. it exits the current node and sets the cursor to the parent tag, and any further tags will be inserted
 last siblings of this parent tag.
 
 The use of another top level tag starts a new section of the document.
    
 NOTE: There is no verification that the correct options/attributes have been specified in each tag statement, nor whether 
 the correct tags have been nested within each other. You have to ensure this by following the galaxy tag set specification
 given above. There is a plan to add a form of checking in the future. 

 Aliases for some of the official tags:
 command: cmd, inputs: in, outputs: out, description: desc, conditional: cond, options: opts, option: opt
=cut


