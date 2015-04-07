name 'gotcms'
maintainer 'GotCms'
maintainer_email 'pierre.rambaud86@gmail.com'
license 'LGPLv3'
description 'Installs/Configures GotCms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.3.0'

recipe 'gotcms', 'Installs and configures GotCms LAMP stack on a single system'

depends 'apt'
depends 'apache2'
depends 'build-essential', '~> 2.0'
depends 'database', '~> 4.0.2'
depends 'hostsfile'
depends 'mysql', '~> 6.0'
depends 'php'
depends 'postgresql'
depends 'mysql2_chef_gem'
