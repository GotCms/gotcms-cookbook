# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require_relative 'spec_helper'

describe 'gotcms::default' do
  include_context 'gotcms_stubs'

  describe 'Normal execution' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU_OPTS).converge(described_recipe)
    end

    it 'includes recipes' do
      expect(chef_run).to include_recipe('apt')
      expect(chef_run).to include_recipe('php')
      expect(chef_run).to include_recipe('apache2')
      expect(chef_run).to include_recipe('apache2::mod_php5')
      expect(chef_run).to include_recipe('gotcms::database')
      expect(chef_run).to include_recipe('gotcms::install')
    end

    it 'install php extensions' do
      expect(chef_run).to install_package('php5-gd')
    end

    it 'restart apache2' do
      expect(chef_run).to restart_service('apache2')
    end

    it 'create directory' do
      expect(chef_run).to create_directory('/var/www/gotcms')
        .with(owner: 'www-data',
              group: 'www-data')
    end

    it 'download archive' do
      expect(chef_run)
        .to create_remote_file_if_missing('/var/chef/cache/gotcms.tar.gz')
        .with(source: 'https://github.com/GotCms/GotCms/archive/master.tar.gz')
    end

    it 'change mod/owner' do
      expect(chef_run).to run_execute('recursively changing mod/owner')
        .with(command: 'chown -R www-data:www-data /var/www/gotcms')
    end

    it 'extract archive' do
      expect(chef_run).to run_execute('extract-gotcms')
        .with(command: 'tar xf /var/chef/cache/gotcms.tar.gz' \
              ' --strip-components 1 -C /var/www/gotcms',
              creates: '/var/www/gotcms/public/index.php')
    end

    it 'changes /etc/hosts' do
      expect(chef_run).to append_hostsfile_entry('127.0.0.1')
        .with(hostname: 'fauxhai.local',
              aliases: ['fauxhai.local'])
    end
  end

  describe 'Override attributes' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(UBUNTU_OPTS) do |node|
        node.set['gotcms']['parent_dir'] = '/home/got'
        node.set['gotcms']['server_name'] = 'got-cms.com'
        node.set['apache']['group'] = 'got'
        node.set['apache']['user'] = 'got'
      end.converge(described_recipe)
    end

    it 'includes recipes' do
      expect(chef_run).to include_recipe('apt')
      expect(chef_run).to include_recipe('php')
      expect(chef_run).to include_recipe('apache2')
      expect(chef_run).to include_recipe('apache2::mod_php5')
      expect(chef_run).to include_recipe('gotcms::database')
    end

    it 'create directory' do
      expect(chef_run).to create_directory('/home/got/gotcms')
        .with(owner: 'got',
              group: 'got')
    end

    it 'download archive' do
      expect(chef_run)
        .to create_remote_file_if_missing('/var/chef/cache/gotcms.tar.gz')
        .with(source: 'https://github.com/GotCms/GotCms/archive/master.tar.gz')
    end

    it 'change mod/owner' do
      expect(chef_run).to run_execute('recursively changing mod/owner')
        .with(command: 'chown -R got:got /home/got/gotcms')
    end

    it 'extract archive' do
      expect(chef_run).to run_execute('extract-gotcms')
        .with(command: 'tar xf /var/chef/cache/gotcms.tar.gz' \
              ' --strip-components 1 -C /home/got/gotcms',
              creates: '/home/got/gotcms/public/index.php')
    end

    it 'changes /etc/hosts' do
      expect(chef_run).to append_hostsfile_entry('127.0.0.1')
        .with(hostname: 'got-cms.com',
              aliases: ['fauxhai.local'])
    end
  end
end
