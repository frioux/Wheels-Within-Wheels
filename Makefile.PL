use strict;
use warnings;

use inc::Module::Install;

version 1;

requires 'POE';
requires 'AnyEvent';
requires 'IO::Async';
requires 'Reflex';

requires 'Net::Async::HTTP';
requires 'AnyEvent::HTTP';
requires 'POE::Component::Client::HTTP';
requires 'Reflexive::Client::HTTP';

WriteAll;
