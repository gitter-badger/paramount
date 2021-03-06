require 'chefspec'
require_relative 'spec_helper'

describe 'paramount::prosody' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge described_recipe }

  it 'includes prosody' do
    expect(chef_run).to include_recipe 'prosody'
  end
end
