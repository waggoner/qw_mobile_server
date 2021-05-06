# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :repo_url, 'git@github.com:waggoner/qw_mobile_server.git'

set :rbenv_ruby, '2.6.5'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'shared/pids', 'tmp/cache', 'shared/sockets')
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

task :reload_puma do
  on roles(:app) do
    puts "### => Phased restart of Puma server."
    execute "sudo /bin/systemctl restart puma.service"
  end
end

after "deploy:cleanup", "reload_puma"