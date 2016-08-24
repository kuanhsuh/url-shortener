---
layout: post
title: "Deployment part 4 Add Capistrano and Deploy Part 2"
date: 2016-08-24 07:19:15 +0800
comments: true
categories:
---
## Modify config/nginx.conf
1. Check if nginx is link to your app
  - login with root
  - `cd /etc/nginx/sites-enabled/`
  - `ls -la`

1. Create `config/nginx.conf` file

```ruby
upstream puma {
  server unix:///home/deploy/KaohsiungRubbishTruck/shared/tmp/sockets/KaohsiungRubbishTruck-puma.sock;
}

server {
  listen 80 default_server deferred;
  # server_name example.com;

  root /home/deploy/KaohsiungRubbishTruck/current/public;
  access_log /home/deploy/KaohsiungRubbishTruck/current/log/nginx.access.log;
  error_log /home/deploy/KaohsiungRubbishTruck/current/log/nginx.error.log info;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @puma;
  location @puma {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;

    proxy_pass http://puma;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 10M;
  keepalive_timeout 10;
}
```
## Add this to  `.gitignore` file

```ruby
/config/database.yml
/config/secrets.yml
```
Make a copy of these 2 files
- config/database.yml -> config/database.yml.sample
- config/secrets.yml -> config/secrets.yml.sample

1. `git add .` `git commit -m "ready to deploy"` `git push origin master`

## Modify config/database.yml

```ruby
 production:
-  <<: *default
-  database: db/production.sqlite3
+  adapter: mysql2
+  encoding: utf8
+  database: KaohsiungRubbishTruck
+  pool: 5
+  username: root
+  password:
+  socket: /var/run/mysqld/mysqld.sock
```

## Modify config/secrets.yml

```ruby
-  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
+  secret_key_base: e4a98dd1063a6765xxxxxxx # Copy the keys from test
```

## First Deploy
1. `$ cap production deploy:check`
1. `$ cap production deploy:upload` Upload database.yml and secrets.yml
1. `$ cap production deploy:initial`
1. ssh login with root and restart nginx `#$ sudo service nginx restart`
