# Encoding: utf-8
#
# Cookbook Name:: elasticsearch
# Recipe:: default
#

include_recipe 'chef-sugar'

# see README.md and test/fixtures/cookbooks for more examples!
elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch' do
  type node['elasticsearch']['install_type'].to_sym # since TK can't symbol.
end
elasticsearch_configure 'elasticsearch' do
  configuration ({
    'cluster.name' => node['elasticsearch']['cluster']['name'],
    'node.name' => node['elasticsearch']['node']['name'],
    'indicies.memory.index_buffer_size' => node['elasticsearch']['node']['index_buffer_size'],
    'bootstrap.mlockall' => true,

		'cloud.aws.access_key' => node['elasticsearch']['aws']['access_key'],
		'cloud.aws.secret_key' => node['elasticsearch']['aws']['secret_key'],
		'discovery.type' => "ec2",
		'discovery.ec2.groups' => "elasticsearch cluster",
		'discovery.ec2.host_type' => "public_ip",
		'discovery.ec2.ping_timeout' => "30s",
		'discovery.ec2.availability_zones' => node['elasticsearch']['aws']['availability_zone'],
		'cloud.aws.region' => node['elasticsearch']['aws']['region'],
		'discovery.zen.ping.multicast.enabled' => false,
    'http.host' => 0,
	})
end

elasticsearch_service 'elasticsearch'

# by default, no plugins
elasticsearch_plugin 'kopf' do
	url 'lmenezes/elasticsearch-kopf'
	action :install
end

elasticsearch_plugin 'head' do
  url 'mobz/elasticsearch-head'
  action :install
end
elasticsearch_plugin 'swagger-ui' do
  url 'https://github.com/timschlechter/swagger-for-elasticsearch/raw/master/dist/swagger-for-elasticsearch-2.0.0.zip'
  action :install
end

elasticsearch_plugin 'HQ' do
  url 'royrusso/elasticsearch-HQ'
  action :install
end

elasticsearch_plugin 'AWS' do
  url 'cloud-aws'
  action :install
end
