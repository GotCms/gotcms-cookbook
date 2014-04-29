require 'spec_helper'


describe file("/etc/apache2/site-enabled/gotcms.conf") do
  it { should be_file}
end

describe file("/var/www/gotcms") do
  it { should be_directory}
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('postgresql') do
  it { should be_enabled }
  it { should be_running }
end
