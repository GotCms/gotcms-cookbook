# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require_relative 'spec_helper'

describe 'gotcms::database' do
  include_context 'gotcms_stubs'

  describe 'Normal execution on Redhat' do
    let(:chef_run) { ChefSpec::Runner.new(REDHAT_OPTS).converge(described_recipe) }

    it 'includes recipes' do
      expect(chef_run).to include_recipe('mysql::client')
      expect(chef_run).to include_recipe('php::module_mysql')
      expect(chef_run).to include_recipe('mysql::server')
    end

    connection_info = {
      host: 'localhost',
      username: 'root',
      password: 'ilikerandompasswords'
    }

    it 'create database' do
      expect(chef_run).to create_database('gotcmsdb').with(
        connection: connection_info
      )
    end

    it 'create user' do
      expect(chef_run).to create_database_user('create-gotcmsuser').with(
        username:      'gotcmsuser',
        password:      nil,
        host:          'localhost',
        database_name: 'gotcmsdb',
        connection:    connection_info
        )

      expect(chef_run).to grant_database_user('grant-gotcmsuser').with(
        username:      'gotcmsuser',
        database_name: 'gotcmsdb',
        privileges:    [:all],
        connection:    connection_info
        )
    end
  end

  describe 'Override attributes on Redhat' do
    let(:chef_run) do
      ChefSpec::Runner.new(REDHAT_OPTS) do |node|
        node.set['gotcms']['db']['driver'] = 'pdo_pgsql'
        node.set['gotcms']['db']['host'] = '127.0.0.1'
        node.set['gotcms']['db']['username'] = 'got'
        node.set['gotcms']['db']['password'] = 'mypassword'
        node.set['postgresql']['password']['postgres'] = 'toor'
      end.converge(described_recipe)
    end

    it 'includes recipes' do
      expect(chef_run).to include_recipe('postgresql::client')
      expect(chef_run).to include_recipe('postgresql::server_redhat')
      expect(chef_run).to include_recipe('php::module_pgsql')
    end

    connection_info = {
      host: '127.0.0.1',
      port: 5432,
      username: 'postgres',
      password: 'toor'
    }

    it 'create database' do
      expect(chef_run).to create_database('gotcmsdb').with(
        connection: connection_info
      )
    end

    it 'create user' do
      expect(chef_run).to create_database_user('create-gotcmsuser').with(
        username:      'got',
        password:      'mypassword',
        host:          '127.0.0.1',
        database_name: 'gotcmsdb',
        connection:    connection_info
        )

      expect(chef_run).to grant_database_user('grant-gotcmsuser').with(
        username:      'got',
        database_name: 'gotcmsdb',
        privileges:    [:all],
        connection:    connection_info
        )
    end
  end
end
