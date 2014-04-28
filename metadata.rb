name 'gotcms'
maintainer 'GotCms'
maintainer_email 'pierre.rambaud86@gmail.com'
license 'LGPLv3'
description 'Installs/Configures GotCms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'gotcms', 'Installs and configures GotCms LAMP stack on a single system'

depends 'apache2'
depends 'database'
depends 'mysql'
depends 'php'
depends 'postgresql'
