#    Copyright (c) 2011 Raphaël Pinson.
#
#    This library is free software; you can redistribute it and/or
#    modify it under the terms of the GNU Lesser Public License as
#    published by the Free Software Foundation; either version 2.1 of
#    the License, or (at your option) any later version.
#
#    Config-Model is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Lesser Public License for more details.
#
#    You should have received a copy of the GNU Lesser Public License
#    along with Config-Model; if not, write to the Free Software
#    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
#    02110-1301 USA

use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Config::Augeas::Exporter',
    license     => 'lgpl',
    requires    => {
        'Class::Accessor' => 0,
        'Config::Augeas'  => 0,
        'XML::LibXML'     => 0,
        'JSON'            => 0,
        'YAML'            => 0,
        'Encode'          => 0,
    },
    build_requires => {
        'Test::More'      => 0,
	'File::Path'      => 0
    },
    scripts => [
        'bin/aug2xml',
        'bin/xml2aug'
    ],
    create_readme      => 1,
    sign               => 1,
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
