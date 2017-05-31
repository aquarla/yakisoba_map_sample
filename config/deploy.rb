# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "yakisoba_map"
set :repo_url, "aquarla@aquarla.net:git/yakisoba-map.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/usr/share/nginx/yakisoba_map"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
set :default_env, { 
  YAKISOBA_DATABASE_PASSWORD: ENV['YAKISOBA_DATABASE_PASSWORD'],
  SECRET_KEY_BASE: ENV['SECRET_KEY_BASE'],
  DISABLE_DATABASE_ENVIRONMENT_CHECK: ENV['DISABLE_DATABASE_ENVIRONMENT_CHECK'],
}

# Default value for keep_releases is 5
# set :keep_releases, 5

# Rbenv settings
set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :unicorn_pid, '/tmp/unicorn.pid'

# after 'deploy', 'deploy:sitemap:refresh'
after 'deploy', 'unicorn:restart'

namespace :deploy do
  desc 'db_seed'
  task :db_seed do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  desc 'db_migrate_reset'
  task :db_migrate_reset do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:migrate:reset'
        end
      end
    end
  end
end
