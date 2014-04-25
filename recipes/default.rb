#
# Cookbook Name:: gotcms
# Recipe:: default
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

include_recipe 'php'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'gotcms::database'

directory node['gotcms']['dir'] do
  owner node['apache']['user']
  group node['apache']['group']
  action :create
end


archive = 'gotcms.tar.gz'

remote_file "#{Chef::Config[:file_cache_path]}/#{archive}" do
  source node['gotcms']['url']
  action :create
end

execute "extract-gotcms" do
  command "tar xf #{Chef::Config[:file_cache_path]}/#{archive} --strip-components 1 -C #{node['gotcms']['dir']}"
  creates "#{node['gotcms']['dir']}/public/index.php"
end
