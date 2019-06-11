## Configure Nginx User
bash 'nginx_user' do
  cwd '/var/www/'
  code <<-EOH
    sudo adduser #{node['nginx']['user']}
    sudo usermod -aG sudo #{node['nginx']['user']}
    EOH
end
