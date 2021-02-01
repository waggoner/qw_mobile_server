rails_env = ENV['RAILS_ENV'] || "development"
app_name = 'mobile-api'
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }

if rails_env == 'development'
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 3000 }
  environment ENV.fetch("RAILS_ENV") { "development" }
else
  threads threads_count, threads_count
  environment rails_env
  shared_dir = "/home/deploy/apps/#{app_name}/shared"

  workers 2
  preload_app!

  # Set up socket location
  bind "unix://#{shared_dir}/sockets/puma.sock"

  # Logging
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}/pids/puma.pid"
  state_path "#{shared_dir}/pids/puma.state"
  #activate_control_app

  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end
end

plugin :tmp_restart