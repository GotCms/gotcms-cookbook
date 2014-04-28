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
  log_level: LOG_LEVEL
}
UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: LOG_LEVEL
}

shared_context 'gotcms_stubs' do
  before do
    stub_command('which php').and_return('/usr/bin/php')
  end
end
