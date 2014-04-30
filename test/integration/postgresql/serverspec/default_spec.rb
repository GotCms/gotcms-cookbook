# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-
#
require 'spec_helper'

describe service('postgresql') do
  it { should be_enabled }
  it { should be_running }
end
