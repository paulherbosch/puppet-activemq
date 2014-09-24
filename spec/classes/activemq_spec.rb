#!/usr/bin/env rspec

require 'spec_helper'

describe 'activemq' do
  it { should contain_class 'activemq' }
end
