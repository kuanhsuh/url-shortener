---
layout: post
title: "Sidekiq Setup Demo"
date: 2016-07-31 10:57:39 +0800
comments: true
categories:
---

Sidekiq is a simply background processing gem. Sidekiq uses threads to handle many jobs at the same time in the same process. So users don't have to wait in the frontend. Some example of sidekiq usage is send email-verification, calling 3rd party API, import or export large amount of datas.

### Setup
1. Install Redis Database，`$ brew install redis`
2. Start redis ，`$ brew services start redis`

### Rails App
1. Add `gem 'sidekiq'` in Gemfile
2. `$ bundle install`
3. create a workers folder and create my_test_worker.rb, `app/workers/my_test_worker.rb`

### Test sidekiq worker
1. open a new tab and enter `$ sidekiq` to start sidekiq
2. open a new tab and enter `$ rails console`
3. enter `MyTestWorker.perform_async`
4.  if the sidekiq server print out `do something` then sidekiq is working

#### In sidekiq tab

`2016-07-31T03:21:41.659Z 13485 TID-oxvsg88wk MyTestWorker JID-4f83f44a556132edbcd05df5 INFO: start
do something
2016-07-31T03:21:41.659Z 13485 TID-oxvsg88wk MyTestWorker JID-4f83f44a556132edbcd05df5 INFO: done: 0.0 sec`

#### Rails C
`MyTestWorker.perform_async
"4f83f44a556132edbcd05df5"`

### Add Web UI
1. Add `gem 'sinatra', :require => false` to Gemfile and bundle
2. change `routes.rb`

```ruby
require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
end
```

4. restart sidekiq server and restart rails s
5. now go to `http://localhost:3000/sidekiq`
6. You should see sidekiq panel

####Resource:
http://railscasts.com/episodes/366-sidekiq
https://github.com/mperham/sidekiq
https://github.com/kakas/Kaohsiung_Rails_Sidekiq_demo
