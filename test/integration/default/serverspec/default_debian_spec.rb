require 'spec_helper'

describe file('/etc/apache2/sites-enabled/gotcms.conf') do
  it { should be_file}
end

describe file("/var/www/gotcms") do
  it { should be_directory}
  it { should be_mode 775 }
end

describe service('apache2') do
  it { should be_enabled }
  it { should be_running }
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end
