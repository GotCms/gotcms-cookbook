name 'gotcms'
maintainer 'GotCms'
maintainer_email 'pierre.rambaud86@gmail.com'
license 'LGPLv3'
description 'Installs/Configures GotCms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.3'

recipe 'gotcms', 'Installs and configures GotCms LAMP stack on a single system'

depends 'apt'
depends 'apache2'
depends 'build-essential'
depends 'database'
depends 'hostsfile'
depends 'mysql'
depends 'php'
depends 'postgresql'
