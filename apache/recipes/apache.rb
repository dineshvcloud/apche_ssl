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
# start httpd service
service "httpd" do
    action [:enable,:start]
end

$ ps -ef | grep httpd

file '/var/www/html/index.html' do
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end
