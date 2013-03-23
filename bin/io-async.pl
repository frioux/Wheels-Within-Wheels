use IO::Async::Timer::Periodic;
use IO::Async::Loop;
use Net::Async::HTTP;
use URI;

my $http = Net::Async::HTTP->new;
my $loop = IO::Async::Loop->new;
my $timer = IO::Async::Timer::Periodic->new(
   interval => 60,
   first_interval => 0,
   on_tick => sub {
      $http->GET(
         URI->new('http://git.shadowcat.co.uk/gitweb/'),
         on_response => sub { warn $_[0]->content }
      )
   },
);

$timer->start;
$loop->add($http);
$loop->add($timer);
$loop->run;
