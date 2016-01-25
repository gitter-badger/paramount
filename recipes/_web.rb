#
# Cookbook Name:: paramount
# Recipe:: _web
#
# Copyright (C) 2015 Michael Burns
# License:: Apache License, Version 2.0
#

include_recipe 'paramount::default'

include_recipe 'nginx'

service 'nginx' do
  action %i(enable start)
end

# include_recipe 'paramount::wallabag'
