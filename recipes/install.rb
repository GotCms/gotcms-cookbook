# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
# Cookbook Name:: gotcms
# Recipe:: install
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

install_url = "http://#{node['gotcms']['server_name']}/install"
headers_value = { 'Cookie' => 'PHPSESSID=installgotcms', 'Content-Type' => 'application/x-www-form-urlencoded' }
config = node['gotcms']['config']
db = node['gotcms']['db']

data = URI.encode_www_form('lang' => config['language'])
Chef::Log.info("Load url #{install_url}")
gotcms_request 'initialize' do
  url install_url
  message data
  headers headers_value
  action :post
end

Chef::Log.info("Load url #{install_url} with #{data} params")
gotcms_request 'lang' do
  url install_url
  message data
  headers headers_value
  should_redirect '/install/license'
  action :post
end

data = URI.encode_www_form('accept-license' => 1)
Chef::Log.info("Load url #{install_url}/license with #{data} params")
gotcms_request 'license' do
  url "#{install_url}/license"
  message data
  headers headers_value
  should_redirect '/install/check-server-configuration'
  action :post
end

Chef::Log.info("Load url #{install_url}/check-server-configuration")
gotcms_request 'check-config' do
  url "#{install_url}/check-server-configuration"
  headers headers_value
  should_redirect '/install/database-configuration'
  action :post
end

data = URI.encode_www_form(
  'dbname' => db['name'],
  'driver' => db['driver'],
  'hostname' => db['host'],
  'password' => db['password'],
  'username' => db['username']
)
Chef::Log.info("Load url #{install_url}/database-configuration with #{data} params")
gotcms_request 'check-database' do
  url "#{install_url}/database-configuration"
  message data
  headers headers_value
  should_redirect '/install/configuration'
  action :post
end

data = URI.encode_www_form(
  'admin_email' => config['admin_email'],
  'admin_firstname' => config['admin_firstname'],
  'admin_lastname' => config['admin_lastname'],
  'admin_login' => config['admin_login'],
  'admin_password' => config['admin_password'],
  'admin_passowrd_confirm' => config['admin_password'], # Fix in 1.4.0
  'admin_password_confirm' => config['admin_password'],
  'site_name' => config['website_name'],
  'template' => config['template']
)
Chef::Log.info("Load url #{install_url}/configuration with #{data} params")
gotcms_request 'configure' do
  url "#{install_url}/configuration"
  message data
  headers headers_value
  should_redirect '/install/complete'
  action :post
end

ajax_headers = headers_value.clone
ajax_headers['X-Requested-With'] = 'XMLHttpRequest'
%w(c-db i-d i-t c-uar it).each do |step|
  gotcms_request "complete-step-#{step}" do
    url "#{install_url}/complete"
    message URI.encode_www_form('step' => step)
    headers ajax_headers
    should_contains(/"success":true/)
    action :post
  end
end

gotcms_request 'complete-step-c-cf' do
  url "#{install_url}/complete"
  message URI.encode_www_form('step' => 'c-cf')
  headers ajax_headers
  should_contains(/"message":/)
  action :post
end
