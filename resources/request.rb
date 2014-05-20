# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
# Cookbook Name:: gotcms
# Resources:: Request
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

actions :get, :put, :post, :delete, :head, :options

attribute :url, kind_of: String, required: true
attribute :headers, kind_of: Hash
attribute :should_redirect, kind_of: String
attribute :should_contains, kind_of: [String, Hash]
attribute :message, kind_of: Object

def initialize(name, run_context = nil)
  super
  @message = name
  @url = nil
  @action = :get
  @headers = {}
  @should_redirect = nil
  @should_contains = nil
end
