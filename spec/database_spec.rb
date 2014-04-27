# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require 'chefspec'

describe 'gotcms::database' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

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
