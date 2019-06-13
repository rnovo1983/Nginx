#
# Cookbook:: nginx
# Recipe:: default
# Auhor:: Roberto Novo
# Copyright:: 2019, The Authors, All Rights Reserved.

#nginx app configuration
default['nginx']['version']                       = '1.14.0'
default['nginx']['packages_name']                 = ['nginx']
default['nginx']['port']                          = '80'

#nginx worker configuration
default['nginx']['worker']['processes']           = 'auto'
default['nginx']['worker']['connections']         = '2048'
default['nginx']['worker']['multi_accept']        = 'on'

#github repository information
default['nginx']['site']['git']['repo_name']      = 'test_site'
default['nginx']['site']['git']['branch']         = 'master'
default['nginx']['site']['git']['repository']     = 'https://github.com/rnovo1983/test_site.git'


#site information
default['nginx']['site']['name']                  = 'example.local'
default['nginx']['site']['version']               = '1.0'
default['nginx']['site']['indexes']               = ['index.html','index.htm','index.nginx-debian.html']
default['nginx']['site']['server_name']           = ["#{node['nginx']['site']['name']}","localhost"]
default['nginx']['site']['location']              = "/var/www/#{node['nginx']['sitename']}#{node['nginx']['site']['version']}/html"
