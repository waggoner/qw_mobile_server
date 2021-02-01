set :application, "quantwrestling"

set :domain, '3.238.29.52'
set :deploy_to, '/home/deploy/apps/mobile-api'

set :branch, "master"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :ssh_options, { :forward_agent => true }

set :rails_env, :production

# Defaults to :db role
set :migration_role, :db

# Defaults to the primary :db server
# set :migration_servers, -> { primary(fetch(:migration_role)) }
set :migration_role, :app
set :stage, :production

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Defaults to [:web]
set :assets_roles, [:web, :app]

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
set :rails_assets_groups, :assets

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
set :keep_assets, 2

role :app, %w{3.238.29.52}
role :web, %w{3.238.29.52}
role :db,  %w{3.238.29.52}, :primary => true

set :ssh_options, {
  user: "deploy",
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true
}

server '3.238.29.52', user: 'deploy', roles: %w{web app db}, primary: true