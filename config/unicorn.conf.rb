# app_path = File.expand_path(File.join(File.dirname(__FILE__), '../../'))

# listen '127.0.0.1:4000'
# listen File.join(app_path, 'shared/unicorn.sock'), :backlog => 64

# worker_processes 2

# working_directory File.join(app_path, 'current')
# pid File.join(app_path, 'shared/unicorn.pid')
# stderr_path File.join(app_path, 'current/log/unicorn.log')
# stdout_path File.join(app_path, 'current/log/unicorn.log')

# set path to application
app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
working_directory app_dir


# Set unicorn options
worker_processes 2
preload_app true
#timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{shared_dir}/log/unicorn.stderr.log"
stdout_path "#{shared_dir}/log/unicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"
