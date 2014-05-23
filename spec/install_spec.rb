# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require_relative 'spec_helper'

describe 'gotcms::install' do
  describe 'Normal execution' do
    let(:chef_run) { ChefSpec::Runner.new(UBUNTU_OPTS).converge(described_recipe) }

    it 'send http post to lang' do
      expect(chef_run).to post_gotcms_request('lang').with(
        url: 'http://fauxhai.local/install',
        message: 'lang=en_GB',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/license'
      )
    end

    it 'send http post to license' do
      expect(chef_run).to post_gotcms_request('license').with(
        url: 'http://fauxhai.local/install/license',
        message: 'accept-license=1',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/check-server-configuration'
      )
    end

    it 'send http post to check server configuration' do
      expect(chef_run).to post_gotcms_request('check-config').with(
        url: 'http://fauxhai.local/install/check-server-configuration',
        message: 'check-config',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/database-configuration'
      )
    end

    it 'send http post to check database configuration' do
      expect(chef_run).to post_gotcms_request('check-database').with(
        url: 'http://fauxhai.local/install/database-configuration',
        message: 'dbname=gotcmsdb&driver=pdo_mysql&hostname=localhost&password&username=gotcmsuser',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/configuration'
      )
    end

    it 'send http post to configure the cms' do
      expect(chef_run).to post_gotcms_request('configure').with(
        url: 'http://fauxhai.local/install/configuration',
        message: 'admin_email=demo%40got-cms.com&admin_firstname=GotCms&admin_lastname=GotCms&admin_login=demo&admin_password=demo&admin_passowrd_confirm=demo&admin_password_confirm=demo&site_name=GotCms&template=arcana',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/complete'
      )
    end
  end

  describe 'Override attributes' do
    let(:chef_run) do
      ChefSpec::Runner.new(UBUNTU_OPTS) do |node|
        node.set['gotcms']['config']['language'] = 'fr_FR'
        node.set['gotcms']['db']['driver'] = 'pdo_mysql'
        node.set['gotcms']['db']['username'] = 'got'
        node.set['gotcms']['db']['password'] = 'awesomepassword'
        node.set['gotcms']['db']['name'] = 'gotcmsdatabase'
        node.set['gotcms']['db']['host'] = 'localhost'
        node.set['gotcms']['config']['website_name'] = 'GotCms Website'
        node.set['gotcms']['config']['is_offline'] = true
        node.set['gotcms']['config']['admin_email'] = 'admin@got-cms.com'
        node.set['gotcms']['config']['admin_firstname'] = 'Got'
        node.set['gotcms']['config']['admin_lastname'] = 'Got'
        node.set['gotcms']['config']['admin_login'] = 'pierre'
        node.set['gotcms']['config']['admin_password'] = 'rambaud'
        node.set['gotcms']['config']['admin_password_confirm'] = 'rambaud'
        node.set['gotcms']['config']['template'] = 'silverblog'
      end.converge(described_recipe)
    end

    it 'send http post to lang' do
      expect(chef_run).to post_gotcms_request('lang').with(
        url: 'http://fauxhai.local/install',
        message: 'lang=fr_FR',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/license'
      )
    end

    it 'send http post to license' do
      expect(chef_run).to post_gotcms_request('license').with(
        url: 'http://fauxhai.local/install/license',
        message: 'accept-license=1',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/check-server-configuration'
      )
    end

    it 'send http post to check server configuration' do
      expect(chef_run).to post_gotcms_request('check-config').with(
        url: 'http://fauxhai.local/install/check-server-configuration',
        message: 'check-config',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/database-configuration'
      )
    end

    it 'send http post to check database configuration' do
      expect(chef_run).to post_gotcms_request('check-database').with(
        url: 'http://fauxhai.local/install/database-configuration',
        message: 'dbname=gotcmsdatabase&driver=pdo_mysql&hostname=localhost&password=awesomepassword&username=got',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/configuration'
      )
    end

    it 'send http post to configure the cms' do
      expect(chef_run).to post_gotcms_request('configure').with(
        url: 'http://fauxhai.local/install/configuration',
        message: 'admin_email=admin%40got-cms.com&admin_firstname=Got&admin_lastname=Got&admin_login=pierre&admin_password=rambaud&admin_passowrd_confirm=rambaud&admin_password_confirm=rambaud&site_name=GotCms+Website&template=silverblog',
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' },
        should_redirect: '/install/complete'
      )
    end

    it 'send ajax requests to complete install' do
      %w(c-db i-d i-t c-uar it).each do |step|
        expect(chef_run).to post_gotcms_request("complete-step-#{step}").with(
          url: 'http://fauxhai.local/install/complete',
          message: URI.encode_www_form('step' => step),
          headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded', 'X-Requested-With' => 'XMLHttpRequest' }
        )
      end

      expect(chef_run).to post_gotcms_request('complete-step-c-cf').with(
        url: 'http://fauxhai.local/install/complete',
        message: URI.encode_www_form('step' => 'c-cf'),
        headers: { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded', 'X-Requested-With' => 'XMLHttpRequest' }
      )
    end
  end
end
