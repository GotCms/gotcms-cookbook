# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require 'chefspec'

describe 'gotcms::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes recipes' do
    expect(chef_run).to include_recipe('php')
    expect(chef_run).to include_recipe('apache2')
    expect(chef_run).to include_recipe('apache2::mod_php5')
    expect(chef_run).to include_recipe('gotcms::database')
  end

  it 'create directory' do
    expect(chef_run).to create_directory('/var/www/gotcms').with(
      owner: 'www-data',
      group: 'www-data'
    )
  end

  it 'download archive' do
    expect(chef_run).to create_remote_file('/var/chef/cache/gotcms.tar.gz').with(
      source: 'https://github.com/GotCms/GotCms/archive/master.tar.gz'
    )
  end

  it 'extract archive' do
    expect(chef_run).to run_execute('extract-gotcms').with(
      command: 'tar xf /var/chef/cache/gotcms.tar.gz --strip-components 1 -C /var/www/gotcms',
      creates: '/var/www/gotcms/public/index.php'
    )
  end

  ['config/autoload', 'public/frontend', 'public/media', 'data/cache'].each do |path|
    it "prepare #{path} directory" do
      expect(chef_run).to create_directory("/var/www/gotcms/#{path}").with(
        recursive: true,
        mode: '775',
        owner: 'www-data',
        group: 'www-data'
      )
    end
  end
end
