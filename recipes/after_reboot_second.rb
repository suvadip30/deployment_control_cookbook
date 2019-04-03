#
# Cookbook:: deployment_control_cookbook
# Recipe:: after_reboot_second
#
# Copyright:: 2019, The Authors, All Rights Reserved.

template "/tmp/after_reboot.sh" do
 source "after_reboot_second.erb"
end

cron 'after_reboot noop' do
 time :reboot
 command "cd /tmp && after_reboot.sh"
 action :create
end
