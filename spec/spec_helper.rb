# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
# spec_helper.rb
require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'gotcms' }

require 'chef/application'
