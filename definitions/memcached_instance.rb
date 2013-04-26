
define :memcached_instance, :variables => nil do
  include_recipe "memcached::default"

  node.memcached.instances.count = node.memcached.instances.count + 1

  service params[:name] do
    provider Chef::Provider::Service::Upstart
    supports [:status, :restart]
    service_name "memcached config=#{params[:name].gsub(' ', '_')}"
    subscribes :stop, resources(:template => node.memcached.default_config.to_s), :immediately
    subscribes :stop, "template[/etc/init/memcached.conf]", :immediately
    subscribes :start, "notify_hub[last_call]"
  end

  template (node.memcached.instances.conf_dir + params[:name].gsub(' ', '_')).to_s do
    source "memcached_conf.erb"
    cookbook "memcached"
    variables(params[:variables]) unless params[:variables].nil?
    notifies :stop, resources(:service => params[:name]), :immediately
  end
end

