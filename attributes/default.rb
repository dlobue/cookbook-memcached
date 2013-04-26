
require 'pathname'

default.memcached.servers = ['127.0.0.1']
default.memcached.port = 11211

default.memcached.conf_dir = Pathname.new '/etc/memcached'
default.memcached.default_config = Promise.new { memcached.conf_dir + 'memcached.conf' }
default.memcached.instances.conf_dir = Promise.new { memcached.conf_dir + 'conf.d' }
default.memcached.instances.count = 0


default.memcached.user = 'memcache'
default.memcached.max_mem = 256

