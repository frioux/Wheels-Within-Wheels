use POE qw(Component::Client::HTTP);
use HTTP::Request;

POE::Component::Client::HTTP->spawn( Alias => 'useragent' );
POE::Session->create(
   inline_states => {
      _start => sub { $_[KERNEL]->call($_[SESSION], 'tick') },
      tick => sub {
         $_[KERNEL]->alarm( tick => time() + 60 );
         $_[KERNEL]->post(
            'useragent', 'request', 'response',
            HTTP::Request->new(GET => 'http://git.shadowcat.co.uk/gitweb/'),
         );
      },
      response => sub { warn $_[ARG1][0]->content },
   }
);

POE::Kernel->run;
