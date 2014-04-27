# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'gotcms' }

require 'chef/application'
