#
# Cookbook:: deployment_control_cookbook
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

## Checking the TAG
if tagged?("#{node['deployment_control_cookbook']['node_1']}")
  puts 'GOING TO REBOOT OWN KERNAL AS THIS IS THE FIRST SERVER IN THE QUEUE'
  sleep(5)
	include_recipe 'deployment_control_cookbook::after_reboot_first'
  sleep(5)

## Reboot the server from Chef Resource
  	include_recipe 'deployment_control_cookbook::reboot'

##Condition for second node
elsif tagged?("#{node['deployment_control_cookbook']['node_2']}")
require 'net/ping'
## Delete the existance file
if File.exist?(filename)
   file '/tmp/remote.txt' do
   action :delete
end
else
   puts 'File is missing'
end

sleep(1)

ruby_block "Make Server and service UP and Running" do
   block do

server_1 = "#{node['deployment_control_cookbook']['server_1']}"
@icmp = Net::Ping::ICMP.new(server_1)
retryary = []
pingfails = 0
repeat = 100
filename = '/tmp/remote.txt'
puts 'PING STARTED'
(1..repeat).each do
if @icmp.ping
  retryary << @icmp.duration
  puts "Ping in - #@{icmp.durtion}"
  puts "--- Host is running ---"
  sleep(2)
if File.exist?(filename)
puts '**Service is Running'
require 'net/smtp'

message = <<MESSAGE_END
From: Chef Developer <#{node['deployment_control_cookbook']['from_mail']}>
To: A Test User <#{node['deployment_control_cookbook']['to_mail']}>
MIME-Version: 1.0
Content-tpe: text/html
Subject: ** Service #{node['deployment_control_cookbook']['service_name']} is running­
<br>
<p><font face="Helvetica" color="Black" style="font-size:28px"><b>SERVICE : </b></font><font face="Helvetica" color="DeepSkyBlue" style="font-size:20px"> #{node['deployment_control_cookbook']['service_name']} is running­.</font></p>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">The Webservice is runnning and this is the end of the process for the server - #{node['deployment_control_cookbook']['server_1']}.</font>
<br>
<br>
<br>
<br>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">This is an automated email generted from running the cookbook</font><font face="Trebuchet MS" color="Black" style="font-size:12px"><b> [ -- deployment_control_cookbook -- ]</b></font></p>
MESSAGE_END

Net:SMTP.start('localhost') do |smtp|
   smtp.send_message message, "#{node['deployment_control_cookbook']['from_mail']}", "#{node['deployment_control_cookbook']['to_mail']}"
end

#reboot for second node
puts 'GOING TO REBOOT OWN KERNAL AS THIS IS THE FIRST SERVER IN THE QUEUE'
  sleep(5)
	run_context.include_recipe 'deployment_control_cookbook::after_reboot_second'
  sleep(5)
  	run_context.include_recipe 'deployment_control_cookbook::reboot'
break if File.exist?(filename)
end
else
   pingfails += 1
   puts "xx Host is Down xx"
   sleep(1)
if @icmp.ping == true
puts '**Server is up'
require 'net/smtp'

message = <<MESSAGE_END
From: Chef Developer <#{node['deployment_control_cookbook']['from_mail']}>
To: A Test User <#{node['deployment_control_cookbook']['to_mail']}>
MIME-Version: 1.0
Content-tpe: text/html
Subject: ** Service #{node['deployment_control_cookbook']['service_name']} is running­
<br>
<p><font face="Helvetica" color="Black" style="font-size:28px"><b>SERVICE : </b></font><font face="Helvetica" color="DeepSkyBlue" style="font-size:20px"> #{node['deployment_control_cookbook']['service_name']} is running­.</font></p>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">The server is up and runnning, you will receive another email for webservice status</br> If you don't receive any email for webservice then please contact the owner of the server.</font>
<br>
<br>
<br>
<br>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">This is an automated email generted from running the cookbook</font><font face="Trebuchet MS" color="Black" style="font-size:12px"><b> [ -- deployment_control_cookbook -- ]</b></font></p>
MESSAGE_END

Net:SMTP.start('localhost') do |smtp|
   smtp.send_message message, "#{node['deployment_control_cookbook']['from_mail']}", "#{node['deployment_control_cookbook']['to_mail']}"
end
end
if pingfails >= 10
  puts '** Server is down'
require 'net/smtp'

message = <<MESSAGE_END
From: Chef Developer <#{node['deployment_control_cookbook']['from_mail']}>
To: A Test User <#{node['deployment_control_cookbook']['to_mail']}>
MIME-Version: 1.0
Content-tpe: text/html
Subject: ** Service #{node['deployment_control_cookbook']['service_name']} is running­
<br>
<p><font face="Helvetica" color="Black" style="font-size:28px"><b>SERVICE : </b></font><font face="Helvetica" color="DeepSkyBlue" style="font-size:20px"> #{node['deployment_control_cookbook']['service_name']} is not running­.</font></p>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">Please contact the respective vendor to get the server up and running</font>
<br>
<br>
<br>
<br>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">This is an automated email generted from running the cookbook</font><font face="Trebuchet MS" color="Black" style="font-size:12px"><b> [ -- deployment_control_cookbook -- ]</b></font></p>
MESSAGE_END

Net:SMTP.start('localhost') do |smtp|
   smtp.send_message message, "#{node['deployment_control_cookbook']['from_mail']}", "#{node['deployment_control_cookbook']['to_mail']}"
end
  break
end
next if @icmp.ping == true && File.exist?(filename)

break if @icmp.ping == true && File.exist?(filename)

end
end

avg = retryary.inject(0) {|sum, i| sum + i}/(repeat - pingfails)
puts "Average round-trip is #{avg}\n"
puts "#{pingfails} packets were dropped"
end
end
else
  puts 'Server are not tagged'

#Send email to the user if it is not tagged
require 'net/smtp'

message = <<MESSAGE_END
From: Chef Developer <#{node['deployment_control_cookbook']['from_mail']}>
To: A Test User <#{node['deployment_control_cookbook']['to_mail']}>
MIME-Version: 1.0
Content-tpe: text/html
Subject: ** Server is not tagged­
<br>
<p><font face="Helvetica" color="Black" style="font-size:28px"><b>SERVICE : </b></font><font face="Helvetica" color="DeepSkyBlue" style="font-size:20px"> Either one or two servers are not tagged.</font></p>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">Please contact the respective team to get the server tagged</font>
<br>
<br>
<br>
<br>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">This is an automated email generted from running the cookbook</font><font face="Trebuchet MS" color="Black" style="font-size:12px"><b> [ -- deployment_control_cookbook -- ]</b></font></p>
MESSAGE_END

Net:SMTP.start('localhost') do |smtp|
   smtp.send_message message, "#{node['deployment_control_cookbook']['from_mail']}", "#{node['deployment_control_cookbook']['to_mail']}"
end
