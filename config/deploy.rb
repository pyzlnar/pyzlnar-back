# config valid only for current version of Capistrano
lock '3.7.2'

# Load config
set :config, YAML.load_file('config/secrets.yml')['capistrano']

set :application, 'pyzlnar'
set :repo_url, 'git@gitlab.com:pyzlnar/pyzlnar-back.git'
set :deploy_to,  fetch(:config)['paths']['back']
set :front_path, fetch(:config)['paths']['front']

set :format, :pretty
set :keep_releases, 2
set :pty,   true

# Puma
# To update these settings, run puma:config to rewrite the shared/puma.rb file
# cap <env> puma:config
# https://github.com/seuros/capistrano-puma/issues/155
set :puma_workers, 2
set :puma_threads, [4, 16]
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

# Linked files
append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
