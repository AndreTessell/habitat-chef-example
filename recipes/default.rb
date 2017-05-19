#
# Cookbook:: redis-chef-hab
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user 'hab'

group 'hab'

package 'jq'

hab_install 'install habitat'

hab_package 'core/redis'

hab_sup 'default' do
  peer node['hab']['peer'] unless node['hab']['peer'].nil?
end

hab_service 'core/redis' do
  topology 'leader'
  action [:unload, :load, :start]
end

execute 'echo \'protected-mode = "no"\' | hab config apply redis.default 1' do
  ignore_failure true
end
