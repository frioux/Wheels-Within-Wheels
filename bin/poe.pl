use POE qw(Component::Client::HTTP);
use HTTP::Request;

POE::Component::Client::HTTP->spawn( Alias => 'useragent' );
POE::Session->create(
   inline_states => {
      _start => \&make_request,
      tick => \&make_request,
      response => sub { warn $_[ARG1][0]->content },
   }
);

POE::Kernel->run;

sub make_request {
   POE::Kernel->delay( tick => time() + 60 );
   POE::Kernel->post(
      'useragent', 'request', 'response',
      HTTP::Request->new(GET => 'http://git.shadowcat.co.uk/gitweb/'),
   );
}
