
package "memcached" do
  action :upgrade
end

service "dist_memcached" do
  supports [ :status ]
  service_name "memcached"
  action :stop
end

directory node.memcached.conf_dir.to_s
directory node.memcached.instances.conf_dir.to_s

template "/etc/init/memcached.conf" do
  source "memcached_upstart.conf.erb"
end

template node.memcached.default_config.to_s do
  source "memcached_conf.erb"
end

