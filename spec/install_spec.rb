# encoding: UTF-8
# coding: UTF-8
# -*- coding: UTF-8 -*-

require_relative 'spec_helper'

describe 'gotcms::install' do
  describe 'Normal execution' do
    let(:chef_run) { ChefSpec::Runner.new(UBUNTU_OPTS).converge(described_recipe) }

    it 'send http post to lang' do
      expect(chef_run).to post_gotcms_request('lang').with(
        url: 'http://fauxhai.local/install',
        message: 'lang=en_GB',
        headers: {"Cookie"=>"PHPSESSID=installgotcms", "Content-Type"=>"application/x-www-form-urlencoded", "X-Requested-With"=>"XMLHttpRequest"},
        should_redirect: '/install/license'
      )
    end
  end

  describe 'Override attributes' do
    let(:chef_run) do
      ChefSpec::Runner.new(UBUNTU_OPTS) do |node|
        node.set['gotcms']['config']['language'] = 'fr_FR'
      end.converge(described_recipe)
    end

    it 'send http post to lang' do
      expect(chef_run).to post_gotcms_request('lang').with(
        url: 'http://fauxhai.local/install',
        message: 'lang=fr_FR',
        headers: {"Cookie"=>"PHPSESSID=installgotcms", "Content-Type"=>"application/x-www-form-urlencoded", "X-Requested-With"=>"XMLHttpRequest"},
        should_redirect: '/install/license'
      )
    end
  end
end
