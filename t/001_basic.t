use Test::Spec;

use Data::Dumper;
use Galaxy::Devel::UI::Builder;
use autobox::Core;

 describe "Builder" => sub {
    my ( $builder, $cmdstr, $taglist);
   
    before each => sub {
      $b = Galaxy::Devel::UI::Builder->new( id => '11', name => 'test') ;
    };
   
   it "should produce a command structure" => sub {     
     $b->cmd;
     $cmdstr = '<tool hidden="false" id="11" name="test" version="0.001">
  <command interpreter=""></command>
</tool>'; 
     is( $b->xml->sprint->strip, $cmdstr);
     
   };
   
   it "should produce a set of top level tags" => sub {    
     $b->cmd;
     $b->description;
     $b->inputs;
     $b->outputs;
     $b->tests;
    # warn $b->xml->sprint;     
     my $str =
'<tool hidden="false" id="11" name="test" version="0.001">
  <command interpreter=""></command>
  <description></description>
  <inputs/>
  <outputs/>
  <tests/>
</tool>'; 
     is($b->xml->sprint->strip,$str);
   };
   
   it "should have all the tags defined in tag_list" => sub {
     
     ok( $b->xml->sprint =~ m/tool/) ;
      $taglist = tag_list();
      $taglist->range(1, $taglist->length - 1 )
                ->foreach(       
                    sub { 
                         my $meth = $_[0];
                         $b->$meth;
                         ok($b->xml->sprint =~ m/$meth/, "should find $meth"); 
                    }  
                  );

   };
   
   it "should behave well with z and x methods" => sub {
      $b->cmd;
      $b->in;
      $b->param( name => 'this');
      $b->z->opt(name => 'a');
      $b->opt(name => 'b');
      $b->x->cond;
      $b->z->param;
      my $str = 
'<tool hidden="false" id="11" name="test" version="0.001">
  <command interpreter=""></command>
  <inputs>
    <param name="this">
      <option a="">name</option>
      <option b="">name</option>
    </param>
    <conditional>
      <param/>
    </conditional>
  </inputs>
</tool>';
     
      is( $b->xml->sprint->strip, $str);
   }
   
};

sub tag_list {
  my $v = [
          'tool',
          'description',
          'version_command',
          'command',
          'inputs',
          'repeat',
          'conditional',
          'when',
          'param',
          'validator',
          'option',
          'options',
          'column',
          'filter',
          'request_param_translation',
          'request_param',
          'append_param',
          'value',
          'value_translation',
          'value',
          'sanitizer',
          'valid',
          'add',
          'remove',
          'mapping',
          'add',
          'remove',
          'configfiles',
          'configfile',
          'outputs',
          'data',
          'change_format',
          'when',
          'actions',
          'tests',
          'test',
          'param',
          'output',
          'assert_contents',
          'page',
          'code',
          'requirements',
          'requirement',
          'help'
        ];
  }

runtests unless caller;

1;
=stuff
my $m = Galaxy::Devel::UI::Builder->new( id => '11', name => 'test') ;



$m->cmd;
$m->in;
  $m->param( name => 'this');
    $m->z->opt(name => 'a');
    $m->opt(name => 'b');
  $m->x->cond;
  $m->z->param;

# $m->z->opt( name => 'a' );
   # $m->opt( name => 'b');
# $m->x->cond;
# 
# $m->x->out;
# $m->help; 
warn $m->xml->sprint;
=cut

#ok(1);