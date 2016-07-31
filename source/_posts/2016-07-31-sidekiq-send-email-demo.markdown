---
layout: post
title: "Sidekiq Send Email Demo"
date: 2016-07-31 11:28:02 +0800
comments: true
categories:
---



#### First scaffold user with name and email

`rails g scaffold name email`

`rake db:migrate`

#### Generate Active Mailer

`rails g mailer Usermailer notify`

modify `app/mailers/user_mailer.rb`

```ruby
def notify(user)
  @user = user
  mail to: @user.email, subject: "Order shipped"
end
```

#### Create a sidekiq worker

1. Add `gem 'sidekiq'` in Gemfile
2. `$ bundle install`
3. create a workers folder and create send_email_worker.rb, `app/workers/send_email_worker.rb`

```ruby
def perform(user_id)
  user = User.find(user_id)
  UserMailer.notify(user).deliver
end
```

#### Modify users controller create action

```ruby
...
if @user.save
  SendEmailWorker.perform_async(@user.id)
  format.html { redirect_to users_url, notice: 'User was successfully created.' }
  format.json { render :show, status: :created, location: @user }
else
...
```

Now try to create a user and check your sidekiq server if the job has been processed.
Here's the source code.[Github Sidekiq Demo](https://github.com/kuanhsuh/sidekiq-email-demo)
