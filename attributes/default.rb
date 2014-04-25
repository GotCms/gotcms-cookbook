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
default['gotcms']['parent_dir'] = '/var/www'
default['gotcms']['dir'] = "#{node['gotcms']['parent_dir']}/gotcms"

default['gotcms']['db']['driver'] = 'pdo_mysql'
default['gotcms']['db']['username'] = 'gotcmsuser'
default['gotcms']['db']['password'] = nil
default['gotcms']['db']['name'] = 'gotcmsdb'
default['gotcms']['db']['host'] = 'localhost'

default['gotcms']['server_name'] = node['fqdn']
default['gotcms']['server_aliases'] = [node['fqdn']]

default['gotcms']['language'] = 'en_GB'
