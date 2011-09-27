use Test::Spec;

use Data::Dumper;
use Galaxy::Devel::UI::Builder;
use autobox::Core;

 describe "Builder" => sub {
    my ( $builder, $cmdstr);
   
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
     my $str ='<tool hidden="false" id="11" name="test" version="0.001">
  <command interpreter=""></command>
  <description></description>
  <inputs/>
  <outputs/>
  <tests/>
</tool>'; 
     is($b->xml->sprint->strip,$str);
   };
   
   it "should should produce a " => sub {
     
     ok( /tool/ =~ $b->xml->sprint);
         
   }
   
};

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