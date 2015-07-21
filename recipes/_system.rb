#
# Cookbook Name:: paramount
# Recipe:: _system
#
# Copyright (C) 2015 Michael Burns
# License:: Apache License, Version 2.0
#

# include_recipe 'locales'
include_recipe 'ntp'

automatic_updates 'default' do
  action :enable
end

include_recipe 'build-essential'
include_recipe 'packages'

include_recipe 'sysctl'
include_recipe 'ubuntu'

include_recipe 'sudo'
# include_recipe 'users'

include_recipe 'rsyslog'
# include_recipe 'libyaml'
# include_recipe 'djbdns::cache'
# include_recipe 'xml'

include_recipe 'openssh'

node.default['elkstack']['config']['backups']['enabled'] = false
# node.default['elasticsearch']['allocated_memory'] = ''
# node['elkstack']['config']['lumberjack_data_bag']['key'] = 'SSL CERT'

include_recipe 'elkstack'

include_recipe 'paramount::kibana'