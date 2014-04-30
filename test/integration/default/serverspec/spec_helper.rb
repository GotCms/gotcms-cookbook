# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  os = backend(Serverspec::Commands::Base).check_os
  c.inclusion_patterns = '**/*_' + os[:family].downcase + '_spec.rb'
end
