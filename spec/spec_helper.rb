# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'gotcms' }

require 'chef/application'

LOG_LEVEL = :fatal

REDHAT_OPTS = {
  platform: 'redhat',
  version: '6.3',
  log_level: LOG_LEVEL,
  file_cache_path: '/var/chef/cache'
}
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: LOG_LEVEL,
  file_cache_path: '/var/chef/cache'
}

shared_context 'gotcms_stubs' do
  before do
    stub_command('which php').and_return('/usr/bin/php')
    stub_command('/usr/sbin/apache2 -t').and_return(true)
    stub_command('/usr/sbin/httpd -t').and_return(true)
    stub_command('ls /var/lib/postgresql/9.1/main/recovery.conf')
      .and_return(true)
    stub_command('ls /var/lib/pgsql/data/recovery.conf').and_return(true)
  end
end
