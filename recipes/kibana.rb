#
# Cookbook Name:: paramount
# Recipe:: kibana
#
# Copyright (C) 2015 Michael Burns
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'kibana_lwrp'

# TODO : SSL cert

node.default['kibana']['webserver'] = ''
node.default['kibana']['user'] = 'kibana'

# TODO : create your own cookbook i.e. my-kibana
# copy the template for the webserver you wish to use to your cookbook
# modify the template as you see fit (add auth, setup ssl)
# use the appropriate webserver template attributes to point to your cookbook and template
# - https://github.com/lusis/chef-kibana#kibana_lwrpinstall

unless Chef::Config[:solo]
  es_server_results = search(:node, "roles:#{node['kibana']['es_role']} AND chef_environment:#{node.chef_environment}")
  unless es_server_results.empty?
    node.set['kibana']['es_server'] = es_server_results[0]['ipaddress']
  end
end

kibana_user node['kibana']['user'] do
  name node['kibana']['user']
  group node['kibana']['user']
  home node['kibana']['install_dir']
  action :create
end

kibana_install 'kibana' do
  user node['kibana']['user']
  group node['kibana']['user']
  install_dir node['kibana']['install_dir']
  install_type install_type
  action :create
end

docroot = "#{node['kibana']['install_dir']}/current/kibana"
kibana_config = "#{node['kibana']['install_dir']}/current/#{node['kibana'][install_type]['config']}"
es_server = "#{node['kibana']['es_scheme']}#{node['kibana']['es_server']}:#{node['kibana']['es_port']}"

template kibana_config do
  source node['kibana'][install_type]['config_template']
  cookbook node['kibana'][install_type]['config_template_cookbook']
  mode '0644'
  user node['kibana']['user']
  group node['kibana']['user']
  variables(
    index: node['kibana']['config']['kibana_index'],
    port: node['kibana']['java_webserver_port'],
    elasticsearch: es_server,
    default_route: node['kibana']['config']['default_route'],
    panel_names: node['kibana']['config']['panel_names']
  )
end

poise_service 'kibana' do
  command '/bin/kibana'
  user node['kibana']['user']
  directory "#{node['kibana']['install_dir']}/current"
end

kibana_web 'kibana' do
  type lazy { node['kibana']['webserver'] }
  docroot docroot
  es_server node['kibana']['es_server']
  kibana_port node['kibana']['java_webserver_port']
  template 'kibana-nginx_file.conf.erb'
  not_if { node['kibana']['webserver'] == '' }
end
