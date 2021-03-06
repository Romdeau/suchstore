worker_processes 2

working_directory "/opt/www/suchstore"

listen "/tmp/unicorn.suchstore.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30

pid "/tmp/unicorn.suchstore.pid"

stderr_path "/opt/www/enerleave.eneraque.com/log/unicorn.stderr.log"
stdout_path "/opt/www/enerleave.eneraque.com/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end
