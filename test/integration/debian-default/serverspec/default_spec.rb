# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
require 'spec_helper'

describe file('/etc/apache2/sites-enabled/gotcms.conf') do
  it { should be_file }
end

describe file('/var/www/gotcms') do
  it { should be_directory }
end

['config/autoload', 'public/frontend', 'public/media', 'data/cache'].each do |path|
  describe file('/var/www/gotcms/' + path) do
    it { should be_directory }
    it { should be_mode 775 }
  end
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end
