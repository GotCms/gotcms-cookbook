# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
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

class Chef
  class Resource::GotcmsRequest < Resource
    identity_attr :url

    def initialize(name, run_context=nil)
      super
      @resource_name = :http_request
      @message = name
      @url = nil
      @action = :get
      @headers = {}
      @should_redirect = nil
      @should_contains = nil
      @allowed_actions.push(:get, :put, :post, :delete, :head, :options)
    end

    def url(args=nil)
      set_or_return(
        :url,
        args,
        :kind_of => String
      )
    end

    def message(args=nil, &block)
      args = block if block_given?
      set_or_return(
        :message,
        args,
        :kind_of => Object
      )
    end

    def headers(args=nil)
      set_or_return(
        :headers,
        args,
        :kind_of => Hash
      )
    end
  end
end

class Chef
  class Provider::GotcmsRequest < Provider
    require 'tempfile'
    require 'chef/http/simple'

    attr_accessor :http

    def whyrun_supported?
      true
    end

    def load_current_resource
      @http = Gotcms::HTTP.new(@new_resource.url)
    end

    # Send a HEAD request to @new_resource.url, with ?message=@new_resource.message
    def action_head
      message = check_message(@new_resource.message)
      # CHEF-4762: we expect a nil return value from Chef::HTTP for a "200 Success" response
      # and false for a "304 Not Modified" response
      modified = @http.head(
        "#{@new_resource.url}?message=#{message}",
        @new_resource.headers
      )
      Chef::Log.info("#{@new_resource} HEAD to #{@new_resource.url} successful")
      Chef::Log.debug("#{@new_resource} HEAD request response: #{modified}")
      # :head is usually used to trigger notifications, which converge_by now does
      if modified != false
        converge_by("#{@new_resource} HEAD to #{@new_resource.url} returned modified, trigger notifications") {}
      end
    end

    # Send a GET request to @new_resource.url, with ?message=@new_resource.message
    def action_get
      converge_by("#{@new_resource} GET to #{@new_resource.url}") do

        message = check_message(@new_resource.message)
        body = @http.get(
          "#{@new_resource.url}?message=#{message}",
          @new_resource.headers
        )
        Chef::Log.info("#{@new_resource} GET to #{@new_resource.url} successful")
        Chef::Log.debug("#{@new_resource} GET request response: #{body}")
      end
    end

    # Send a PUT request to @new_resource.url, with the message as the payload
    def action_put
      converge_by("#{@new_resource} PUT to #{@new_resource.url}") do
        message = check_message(@new_resource.message)
        body = @http.put(
          @new_resource.url,
          message,
          @new_resource.headers
        )
        Chef::Log.info("#{@new_resource} PUT to #{@new_resource.url} successful")
        Chef::Log.debug("#{@new_resource} PUT request response: #{body}")
      end
    end

    # Send a POST request to @new_resource.url, with the message as the payload
    def action_post
      converge_by("#{@new_resource} POST to #{@new_resource.url}") do
        message = check_message(@new_resource.message)
        body = @http.post(
          @new_resource.url,
          message,
          @new_resource.headers
        )
        Chef::Log.info("#{@new_resource} POST to #{@new_resource.url} message: #{message.inspect} successful")
        Chef::Log.debug("#{@new_resource} POST request response: #{body}")
      end
    end

    # Send a DELETE request to @new_resource.url
    def action_delete
      converge_by("#{@new_resource} DELETE to #{@new_resource.url}") do
        body = @http.delete(
          @new_resource.url,
          @new_resource.headers
        )
        @new_resource.updated_by_last_action(true)
        Chef::Log.info("#{@new_resource} DELETE to #{@new_resource.url} successful")
        Chef::Log.debug("#{@new_resource} DELETE request response: #{body}")
      end
    end

    def check_message(message)
      if message.kind_of?(Proc)
        message.call
      else
        message
      end
    end
  end
end
