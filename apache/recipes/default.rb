#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Install httpd package but dont start it
package "httpd" do
        action [:install]
end
# Install mod_ssl package to enable ssl module in apache
package "mod_ssl" do
        action [:install]
end
# Stop iptables service permanently
service "iptables" do
        action [:disable,:stop]
end
# Stop ip6tables service permanently 
service "ip6tables" do
        action [:disable,:stop]
end
# Create /etc/httpd/ssl directory on chef client
directory "#{node['apache']['dir']}/ssl" do
        action :create
        recursive true
        mode 0755
end
# Copy ssl certificates from certificates folder to clients /etc/httpd/ssl folder
remote_directory "#{node['apache']['dir']}/ssl" do
        source "certificates"
        files_owner "root"
        files_group "root"
        files_mode 00644
        owner "root"
        group "root"
        mode 0755
end
# This will make changes to ssl.conf 
template "/etc/httpd/conf.d/ssl.conf" do
        source "ssl.conf.erb"
        mode 0644
        owner "root"
        group "root"
        variables(
                :sslcertificate => "#{node['apache']['sslpath']}/sample_apache.com.crt",
                :sslkey => "#{node['apache']['sslpath']}/sample_apache.com.key",
                :sslcacertificate => "#{node['apache']['sslpath']}/sample_apache.com.ca-bundle",
                :servername => "#{node['apache']['servername']}"
        )
end
# change selinux security context for ssl certificates
execute "change_for_selinux" do
        command "chcon -Rv --type=httpd_sys_content_t /etc/httpd/ssl/"
        action :run
end
# start httpd service
service "httpd" do
    action [:enable,:start]
end

file '/var/www/html/index.html' do
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end
