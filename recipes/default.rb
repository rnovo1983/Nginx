#
# Cookbook:: nginx
# Recipe:: default
# Auhor:: Roberto Novo
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe "dbase::default"

node['nginx']['packages_name'].each do |p|
     package p do
     action :install
   end
end

bash 'configure_one' do
  cwd '/var/www/'
  code <<-EOH
    sudo mkdir -p #{node['nginx']['site']['location']}
    sudo chown -R $USER:$USER #{node['nginx']['site']['location']}
    sudo chmod -R 755 *
    sudo rm -rf html
    EOH
end

bash 'git_clone' do
  cwd "#{node['nginx']['site']['location']}"
  code <<-EOH
  sudo [ -d #{node['nginx']['site']['git']['repo_name']} ] && sudo rm -rf #{node['nginx']['site']['git']['repo_name']}/
  sudo [ -h "index.html" ] && sudo rm -rf index.html
  sudo git clone #{node['nginx']['site']['git']['repository']}
  sudo ln -s #{node['nginx']['site']['git']['repo_name']}/index.html index.html
  EOH
end

#server block directives
template "/etc/nginx/sites-available/#{node['nginx']['site']['name']}" do
  source 'site-available.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    listening_port: node['nginx']['port'],
    root_location:  node['nginx']['site']['location'],
    indexes:        node['nginx']['site']['indexes'],
    server_name:    node['nginx']['site']['server_name']
  )
end

#server block directives
template "/etc/nginx/nginx.conf" do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    worker_processes:    node['nginx']['worker']['processes'],
    worker_connections:  node['nginx']['worker']['connections'],
    multi_accept:        node['nginx']['worker']['multi_accept']
  )
end

execute 'sites_enable' do
  cwd '/etc/nginx/sites-enabled'
  command "sudo ln -s /etc/nginx/sites-available/#{node['nginx']['site']['name']} /etc/nginx/sites-enabled/"
  not_if { File.exist?("/etc/nginx/sites-enabled/#{node['nginx']['site']['name']}") }
end


service 'nginx' do
    action [:restart, :enable]
end
