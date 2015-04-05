# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
# Cookbook Name:: gotcms
# Recipe:: database
#
# Author:: Pierre Rambaud (<pierre.rambaud86@gmail.com>)
# Copyright 2014
#
# GotCms is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# GotCms is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with GotCms. If not, see <http://www.gnu.org/licenses/lgpl-3.0.html>.
#

::Chef::Recipe.send(:include, GotCms::Helpers)

db = node['gotcms']['db']

if db['driver'] == 'pdo_mysql'
  mysql_client 'default' do
    action :create
  end
  include_recipe 'php::module_mysql'
else
  include_recipe 'php::module_pgsql'
  include_recipe 'database::postgresql'
end

if localhost? db['host']
  if db['driver'] == 'pdo_mysql'
    mysql_service 'default' do
      initial_root_password node['gotcms']['mysql']['server_root_password']
      action [:create, :start]
    end

    connection_info = {
      host:     '127.0.0.1',
      username: 'root',
      password: node['gotcms']['mysql']['server_root_password'],
      socket:   '/var/run/mysql-default/mysqld.sock'
    }

    mysql_database db['name'] do
      connection connection_info
      action :create
    end

    mysql_database_user 'create-gotcmsuser' do
      username db['username']
      password db['password']
      host db['host']
      database_name db['name']
      connection connection_info
      action :create
    end

    mysql_database_user 'grant-gotcmsuser' do
      username db['username']
      password db['password']
      database_name db['name']
      privileges [:all]
      connection connection_info
      action :grant
    end
  else
    include_recipe 'postgresql::server'

    connection_info = {
      host:     '127.0.0.1',
      port:     5432,
      username: 'postgres',
      password: node['postgresql']['password']['postgres']
    }

    postgresql_database db['name'] do
      connection connection_info
      action :create
    end

    postgresql_database_user 'create-gotcmsuser' do
      username db['username']
      password db['password']
      host db['host']
      database_name db['name']
      connection connection_info
      action :create
    end

    postgresql_database_user 'grant-gotcmsuser' do
      username db['username']
      password db['password']
      database_name db['name']
      privileges [:all]
      connection connection_info
      action :grant
    end
  end
end
