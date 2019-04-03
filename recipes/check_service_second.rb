#
# Cookbook:: deployment_control_cookbook
# Recipe:: check_service_second
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
        Net::SCP.upload!("#{node['deployment_control_cookbook']['server_1']}", "username",
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
