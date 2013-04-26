
include_recipe "memcached::default"

service "memcached" do
  provider Chef::Provider::Service::Upstart
  supports [ :status, :restart ]
  action :nothing
  subscribes :stop, resources(:template => node.memcached.default_config.to_s), :immediately
  subscribes :stop, "template[/etc/init/memcached.conf]", :immediately
  subscribes :start, "notify_hub[last_call]"
end

