# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
# Cookbook Name:: gotcms
# Attributes:: gotcms
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

default['gotcms']['version'] = 'master'
default['gotcms']['url'] = "https://github.com/GotCms/GotCms/archive/#{node['gotcms']['version']}.tar.gz"
default['gotcms']['parent_dir'] = node['apache']['docroot_dir']
default['gotcms']['dir'] = "#{node['gotcms']['parent_dir']}/gotcms"

default['gotcms']['db']['driver'] = 'pdo_mysql'
default['gotcms']['db']['username'] = 'gotcmsuser'
default['gotcms']['db']['password'] = nil
default['gotcms']['db']['name'] = 'gotcmsdb'
default['gotcms']['db']['host'] = 'localhost'

default['gotcms']['server_name'] = node['fqdn']
default['gotcms']['server_aliases'] = [node['fqdn']]

default['gotcms']['config']['language'] = 'en_GB'
default['gotcms']['config']['website_name'] = 'GotCms'
default['gotcms']['config']['is_offline'] = false
default['gotcms']['config']['admin_email'] = 'demo@got-cms.com'
default['gotcms']['config']['admin_firstname'] = 'GotCms'
default['gotcms']['config']['admin_lastname'] = 'GotCms'
default['gotcms']['config']['admin_login'] = 'demo'
default['gotcms']['config']['admin_password'] = 'demo'
default['gotcms']['config']['template'] = 'arcana'
