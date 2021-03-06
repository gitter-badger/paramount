require 'chefspec'
require_relative 'spec_helper'

describe 'paramount::postfix' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge described_recipe }

  before do
    stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return true
    stub_command("psql -c 'SELECT lanname FROM pg_catalog.pg_language' postfix | grep '^ plpgsql$'").and_return true
    stub_command('which nginx').and_return true
    stub_command('test -d /etc/php5/fpm/pool.d || mkdir -p /etc/php5/fpm/pool.d').and_return true
  end

  %w(postgresql::server postfixadmin postfixadmin::map_files paramount::dkim).each do |recipe|
    it "includes #{recipe}" do
      expect(chef_run).to include_recipe recipe
    end
  end
end
