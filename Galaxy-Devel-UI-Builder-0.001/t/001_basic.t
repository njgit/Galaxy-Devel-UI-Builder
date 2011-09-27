use Test::Spec;

use Data::Dumper;
use Galaxy::Devel::UI::Builder;


 describe "Builder" => sub {
    my $builder;
   
    before each => sub {
      $b = Galaxy::Devel::UI::Builder->new( id => '11', name => 'test') ;
    };
   
   it "should produce a command structure" => sub {     
      $b->cmd;
     warn $b->xml->sprint;
     ok(1);    
   };
   
   it "should produce a value" => sub {    
     $b->value;
     warn $b->xml->sprint;
     ok(1);  
   };
 
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