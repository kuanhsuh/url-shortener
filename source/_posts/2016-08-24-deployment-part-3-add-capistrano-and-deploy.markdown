---
layout: post
title: "Deployment part 3 Add Capistrano and Deploy"
date: 2016-08-24 07:02:18 +0800
comments: true
categories:
---

## Modify Gemfile to this, also comment out server related gem ex. Passenger, Unicon

```ruby
- gem 'sqlite3'
+ gem 'sqlite3', group: :development

- # gem 'therubyracer', platforms: :ruby
+ gem 'therubyracer', platforms: :ruby

+ group :development do
+   gem 'capistrano',         '~> 3.6.0', require: false
+   gem 'capistrano-rvm',     '~> 0.1',   require: false
+   gem 'capistrano-rails',   '~> 1.1.7', require: false
+   gem 'capistrano-bundler', '~> 1.1.4', require: false
+   gem 'capistrano3-puma',   '~> 1.2.1', require: false
+ end

+ gem 'puma'

+ group :production do
+   gem "mysql2"
+ end
```
1. Enter `bundle install` and `cap install`

1. Modify Capfile to following

```ruby
# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
```
This Capfile loads some pre-defined tasks in to your Capistrano configuration files to make your deployments hassle-free, such as automatically:

Selecting the correct Ruby
Pre-compiling Assets
Cloning your Git repository to the correct location
Installing new dependencies when your Gemfile has changed

### Rewrite config/deploy.rb
```ruby
# config valid only for current version of Capistrano

set :repo_url,        'git@github.com:kakas/KaohsiungRubbishTruck.git' # 改成你的
set :application,     'KaohsiungRubbishTruck' # 改成你的 appname
set :user,            'deploy' # 這個對應到我們剛剛增加的 user: deploy
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Upload to shared/config'
  task :upload do
    on roles (:app) do
      upload! "config/database.yml", "#{shared_path}/config/database.yml"
      upload! "config/secrets.yml",  "#{shared_path}/config/secrets.yml"
    end
  end

  before :starting,  :check_revision
  after  :finishing, :compile_assets
  after  :finishing, :cleanup
  after  :finishing, :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
```

## Modify config/deploy/production.rb
(Modify IP to your own)
```ruby
set :stage, :production
set :branch, :master

role :app, %w(deploy@xxx.xxx.xxx.xxx)
role :web, %w(deploy@xxx.xxx.xxx.xxx)
role :db, %w(deploy@xxx.xxx.xxx.xxx)

set :rails_env, "production"
set :puma_env, "production"
set :puma_config_file, "#{shared_path}/config/puma.rb"
set :puma_conf, "#{shared_path}/config/puma.rb"
```
