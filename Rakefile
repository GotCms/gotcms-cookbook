# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
# Cookbook Name:: gotcms
# Library:: HTTP
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

def bundle_exec(command)
  sh "bundle exec #{command}"
end

task :checkstyle do
  Rake::Task['foodcritic'].invoke
  Rake::Task['rubocop'].invoke
end

task :specs do
  Rake::Task['chefspec'].invoke
end

task :foodcritic do
  bundle_exec 'foodcritic -f any .'
end

task :rubocop do
  bundle_exec :rubocop
end

task :chefspec do
  bundle_exec 'rspec spec --color --format documentation'
end

task :kitchen do
  bundle_exec 'kitchen test'
end

task default: ['checkstyle', 'specs']
