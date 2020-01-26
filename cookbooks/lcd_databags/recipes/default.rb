#
# Cookbook:: lcd_databags
# Recipe:: default
#
# Copyright:: 2020, Harish, All Rights Reserved.
#
admins = data_bag('admins')

admins.each do |login|
	admin = data_bag_item('admins', login)
	group admin['gid']
end
