#
# Cookbook Name:: Logstash
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
script "download and install_Logstash public signing key" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
  EOH
end

script "creating logstash repo" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  cd /etc/yum.repos.d/
  touch logstash.repo
  cat <<EOT  >> logstash.repo
[logstash-2.3]
name=Logstash repository for 2.3.x packages
baseurl=http://packages.elastic.co/logstash/2.3/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
  EOH
end
script "install_logstash" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  yum install logstash -y
  EOH
end

service "logstash" do
	action [:enable, :start]
end
