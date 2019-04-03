#
# Cookbook:: deployment_control_cookbook
# Recipe:: reboot
#
# Copyright:: 2019, The Authors, All Rights Reserved.

reboot 'Linux server on First state' do
  action :reboot_now
end