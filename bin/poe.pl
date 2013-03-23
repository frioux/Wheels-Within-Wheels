use POE qw(Component::Client::HTTP);
use HTTP::Request;

POE::Component::Client::HTTP->spawn;
POE::Session->create(
   inline_states => {
      _start => sub { $_[KERNEL]->call($_[SESSION], 'tick') },
      tick => sub {
         $_[KERNEL]->alarm( tick => time() + 60 );
         $_[KERNEL]->post(
            'weeble', 'request', 'response',
            HTTP::Request->new(GET => 'http://git.shadowcat.co.uk/gitweb/'),
         );
      },
      response => sub { warn $_[-1][0]->content }, # why are there a ton of things in @_ ?
   }
);

POE::Kernel->run;
