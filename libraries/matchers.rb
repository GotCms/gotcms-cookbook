# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# IgnoreMultilineLiterals
#
# Cookbook Name:: gotcms
# Library:: Matchers
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
if defined?(ChefSpec)
  def post_gotcms_request(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gotcms_request, :post, resource_name)
  end

  def get_gotcms_request(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gotcms_request, :get, resource_name)
  end

  def head_gotcms_request(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gotcms_request, :head, resource_name)
  end

  def delete_gotcms_request(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gotcms_request, :delete, resource_name)
  end

  def put_gotcms_request(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gotcms_request, :put, resource_name)
  end
end
