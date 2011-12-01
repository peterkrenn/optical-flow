worker_processes 2
working_directory '/home/ubuntu/optical-flow'

preload_app true

timeout 30

listen '/home/ubuntu/optical-flow/tmp/sockets/unicorn.sock', :backlog => 64

pid '/home/ubuntu/optical-flow/tmp/pids/unicorn.pid'

stderr_path '/home/ubuntu/optical-flow/log/unicorn.stderr.log'
stdout_path '/home/ubuntu/optical-flow/log/unicorn.stdout.log'

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
