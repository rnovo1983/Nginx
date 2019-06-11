#nginx app configuration
default['nginx']['version']                       = '1.12.1'
default['nginx']['packages_name']                 = ['nginx','git', 'vim', 'telnet', 'net-tools']
default['nginx']['port']                          = '80'
default['nginx']['ulimit']                        = '1024'
default['nginx']['user']                          = 'nginx'

#github repository information
default['nginx']['site']['git']['repo_name']      = 'test_site'
default['nginx']['site']['git']['repository']     = 'https://github.com/rnovo1983/test_site.git'
default['nginx']['site']['git']['branch']         = 'master'

#site information
default['nginx']['site']['name']                  = 'example.local'
default['nginx']['site']['version']               = '1.0'
default['nginx']['site']['indexes']               = ['index.html','index.htm','index.nginx-debian.html']
default['nginx']['site']['server_name']           = ["#{node['nginx']['site']['name']}"]
default['nginx']['site']['location']              = "/var/www/#{node['nginx']['sitename']}#{node['nginx']['site']['version']}/html"
