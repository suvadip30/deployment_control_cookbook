#
# Cookbook:: deployment_control_cookbook
# Recipe:: check_service_first
#
# Copyright:: 2019, The Authors, All Rights Reserved.

file '/tmp/remote.txt' do
  content 'This is a file created after automated restart'
end

ruby_block "Check service" do
block do
repeat = 30
(1..repeat).each do
cmd = Mixlib::ShellOut.new("/etc/init.d/#{node['deployment_control_cookbook']['service_name']} status | grep running | tail -n1 | wc -l")
cmd.run_command
   if cmd.status[/1/]
     puts 'Service is running'
     sleep(2)
       next if cmd.stdout == '1'
       puts 'Transfering the remote file as server is up and running and Webservice is also running properly'
       sleep(2)

       require 'net/sleep'
        Net::SCP.upload!("#{node['deployment_control_cookbook']['server_2']}", "username",
        "/tmp/remote.txt", "/tmp/remote.txt",
        :ssh => { :password => "remote_pass" })
        sleep(2)
        break if cmd.stdout[/1/]
   else
      puts 'Service is not started'
      sleep(1)
   end
end
end
end

sleep(20)
require 'net/ping'
#delete the existance file
if File.exist?(filename)
   file '/tmp/remote.txt' do
     action :delete
   end
else
   puts 'Remote generated file is missing'
end

sleep(1)

ruby_block "Check host is running and service is up" do
  block do

   server_2 = "#{node['deployment_control_cookbook']['server_2']}"
   @icmp = Net::Ping::ICMP.new(server_2)
   retryary = []
   pingfails = 0
   repeat = 50
   filename = '/tmp/remote.txt'
   puts 'Ping started'
   (1..repeat).each do
   if @icmp.ping
      retryary << @icmp.duration
      puts "Ping in - #{@icmp.duration}"
      puts "-- Host is running --"
      sleep(2)
   if File.exist?(filename)
     puts '** Service is running'
require 'net/smtp'

message = <<MESSAGE_END
From: Chef Developer <#{node['deployment_control_cookbook']['from_mail']}>
To: A Test User <#{node['deployment_control_cookbook']['to_mail']}>
MIME-Version: 1.0
Content-tpe: text/html
Subject: ** Service #{node['deployment_control_cookbook']['service_name']} is running­
<br>
<p><font face="Helvetica" color="Black" style="font-size:28px"><b>SERVICE : </b></font><font face="Helvetica" color="DeepSkyBlue" style="font-size:20px"> #{node['deployment_control_cookbook']['service_name']} is running­.</font></p>
<p><font face="Trebuchet MS" color="DimGray" style="font-size:12px">The Webservice is runnning and this is the end of the process for the server - #{node['deployment_control_cookbook']['server_2']}.</font>
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
break if File.exist?(filename)
else
  pingfails += 1
  puts "xx Host is down xx"
  sleep(1)
if @icmp..ping == true
  puts "** Server is up"
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
Subject: ** Service #{node['deployment_control_cookbook']['service_name']} is not running­
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
