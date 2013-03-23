use Reflex;
use Reflex::Interval;
use Reflexive::Client::HTTP;
use HTTP::Request;

my $ua = Reflexive::Client::HTTP->new;

# unlike the other examples, this one does not trigger immediately
my $ct = Reflex::Interval->new(
   interval    => 60,
   auto_repeat => 1,
   on_tick     => sub {
      $ua->request(
        HTTP::Request->new(GET => 'http://git.shadowcat.co.uk/gitweb/'),
        sub { warn $_->content }
      );
   },
);

Reflex->run_all;
