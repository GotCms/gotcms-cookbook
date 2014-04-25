#
# Cookbook Name:: gotcms
# Library:: Helpers
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

module GotCms
  module Helpers
    def is_localhost?(host)
      if host == 'localhost' || host == '127.0.0.1' || host == '::1'
        true
      else
        require 'socket'
        require 'resolv'
        Socket.ip_address_list.map { |a| a.ip_address }.include? Resolv.getaddress host
      end
    end

    def self.make_db_query(user, pass, query)
      %< --user=#{user} --password="#{pass}" --execute="#{query}">
    end
  end
end
