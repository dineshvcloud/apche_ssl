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
<head>
  <meta charset="utf-8">
  <title>Sample Deployment</title>
  <style>
    body {
      color: #ffffff;
      background-color: #0000ff;
      font-family: Arial, sans-serif;
      font-size: 16px;
    }
    
    h1 {
      font-size: 500%;
      font-weight: normal;
      margin-bottom: 0;
    }
    
    h2 {
      font-size: 200%;
      font-weight: normal;
      margin-bottom: 0;
    }
  </style>
</head>
<body>
  <div align="center">
    <h1>Congratulations!</h1>
    <h2>Site is up and running.</h2>
  </div>
</body>
</html>'
end
