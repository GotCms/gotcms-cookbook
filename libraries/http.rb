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

module Gotcms
  # GotCms Module
  class HTTP < ::Chef::HTTP
    # Send an HTTP HEAD request to the path
    #
    # === Parameters
    # path:: path part of the request URL
    def head(path, headers = {}, options = {})
      request(:HEAD, path, headers, options)
    end

    # Send an HTTP GET request to the path
    #
    # === Parameters
    # path:: The path to GET
    def get(path, headers = {}, options = {})
      request(:GET, path, headers, options)
    end

    # Send an HTTP PUT request to the path
    #
    # === Parameters
    # path:: path part of the request URL
    def put(path, json, headers = {}, options = {})
      request(:PUT, path, headers, options, json)
    end

    # Send an HTTP POST request to the path
    #
    # === Parameters
    # path:: path part of the request URL
    def post(path, json, headers = {}, options = {})
      request(:POST, path, headers, options, json)
    end

    # Send an HTTP DELETE request to the path
    #
    # === Parameters
    # path:: path part of the request URL
    def delete(path, headers = {}, options = {})
      request(:DELETE, path, headers, options)
    end

    # Makes an HTTP request to +path+ with the given +method+, +headers+, and
    # +data+ (if applicable).
    def request(method, path, headers = {}, options = {}, data = false)
      url = create_url(path)
      method, url, headers, data = apply_request_middleware(method, url, headers, data)

      response, rest_request, return_value, redirect_location = send_http_request(method, url, headers, data)
      if options.key?('should_redirect')
        if redirect_location != options['should_redirect']
          fail Chef::Exceptions::InvalidRedirect, "#{method} request was redirected from #{url} to #{redirect_location} instead of #{options['should_redirect']}."
        end
      end

      if options.key?('should_contains')
        if options['should_contains'].class != 'Array'
          options['should_contains'] = [options['should_contains']]
        end

        options['should_contains'].each do |content|
          if (content.class == String && return_value != content) || (content.class == Regexp && return_value !~ content)
            fail ArgumentError, "Response should contains: \"#{options['should_contains']}\", but only contains #{return_value}"
          end
        end
      end

      response, rest_request, return_value = apply_response_middleware(response, rest_request, return_value)
      response.error! unless success_response?(response)
      return_value
    rescue => exception
      log_failed_request(response, return_value) unless response.nil?

      if exception.respond_to?(:chef_rest_request=)
        exception.chef_rest_request = rest_request
      end
      raise
    end

    # Runs a synchronous HTTP request, with no middleware applied (use #request
    # to have the middleware applied). The entire response will be loaded into memory.
    def send_http_request(method, url, headers, body, &response_handler)
      headers = build_headers(method, url, headers, body)

      retrying_http_errors(url) do
        client = http_client(url)
        return_value = nil
        if block_given?
          request, response = client.request(method, url, body, headers, &response_handler)
        else
          request, response = client.request(method, url, body, headers) { |r| r.read_body }
          return_value = response.read_body
        end
        @last_response = response

        redirect_location = redirected_to(response)
        if response.kind_of?(Net::HTTPSuccess)
          [response, request, return_value]
        elsif response.kind_of?(Net::HTTPNotModified) # Must be tested before Net::HTTPRedirection because it's subclass.
          [response, request, false]
        elsif redirect_location
          if [:GET, :HEAD].include?(method)
            follow_redirect do
              send_http_request(method, create_url(redirect_location), headers, body, &response_handler)
            end
          else
            [response, request, return_value, redirect_location]
          end
        else
          [response, request, nil]
        end
      end
    end
  end
end
