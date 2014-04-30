# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
require 'spec_helper'

describe file('/etc/httpd/sites-enabled/gotcms.conf') do
  it { should be_file }
end

describe file('/var/www/html/gotcms') do
  it { should be_directory }
  it { should be_mode 775 }
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end
