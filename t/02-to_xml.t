use warnings ;
use strict;
use Test::More tests => 7;
use Config::Augeas;
use Config::Augeas::Exporter;
use File::Path;

# pseudo root were input config file are read
my $from_root = 'augeas-from/';

# pseudo root where config files are written by config-model
my $to_root = 'augeas-to/';

my $from_aug = Config::Augeas::Exporter->new(root => $from_root);

ok($from_aug, "Created new Augeas object for to_xml direction");

my $doc = $from_aug->to_xml();

ok($doc, "Got XML document");

my $canonical = $doc->findvalue('/augeas/files/file[@path="/etc/hosts"]/node[node[@label="ipaddr"]="192.168.0.1"]/node[@label="canonical"]');

is($canonical, 'bilbo', "Found canonical value from hosts in XML ($canonical)");

# Prepare fakeroot to write
rmtree($to_root);
mkpath($to_root.'etc/', { mode => 0755 }) || die "Can't mkpath:$!";

my $to_aug = Config::Augeas::Exporter->new(root => $to_root);

ok($to_aug, "Created new Augeas object for from_xml direction");

$to_aug->from_xml(xml => $doc);

ok($to_aug, "Wrote to Augeas from XML");

my $aug_check = Config::Augeas->new(root => $to_root);

ok($aug_check, "Created new Augeas object to check from_xml direction");

my $check_canonical = $aug_check->get('/files/etc/hosts/*[ipaddr="192.168.0.1"]/canonical');

is($check_canonical, 'bilbo', "Found canonical value from new hosts file ($check_canonical)");


# Cleanup
rmtree($to_root);

