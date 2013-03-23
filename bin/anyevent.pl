use AnyEvent;
use AnyEvent::HTTP;

my $w = AnyEvent->condvar;
my $checkin = AnyEvent->timer(
   interval => 60,
   cb => sub {
      http_get(
         'http://git.shadowcat.co.uk/gitweb/',
         sub { warn $_[0] }
      )
   }
);

$w->recv;
