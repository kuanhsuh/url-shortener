---
layout: post
title: "Omniauth-twitter-Part I"
date: 2016-07-22 10:17:07 +0800
comments: true
categories:
---

Omniauth_twitter gem allows you to login your web app with twitter account.
First you need to sign in to Twitter Applcation (https://apps.twitter.com/) to create new app and generate keys.

Create a new file config/initializers/omniauth.rb

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :twitter, "API_KEY", "API_SECRET"
    end

Then you need to restart server so new configuration will pick up. Now go to http://127.0.0.1:3000/auth/twitter and you should see twitter login page. Then you should see a routing error. To fix this we need to open our routes.rb and add

    GET '/auth/:provider/callback', to: 'sessions#create'

and create a session controller

    rails g controller sessions

Open controller and add this

    class SessionsController < ApplicationController
      def create
        render text: request.env["omniauth.auth"]
      end
    end

Now login again and you should see a bunch of information provided by twitter.
And now we need to create a user model and create user with the twitter info.

    rails g model user provider:string uid:string name:string
    rake db:migrate

and in our controller change the create method to

    def create
      auth = request.env["omniauth.auth"]
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
    end

And in our user model we add a new create_with_omniauth method

    def self.create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["user_info"]["name"]
      end
    end

Now we are signed in to our app with our twitter account. In our next section we'll add sign out and how to implement to our views

Reference
https://github.com/arunagw/omniauth-twitter
http://railscasts.com/episodes/241-simple-omniauth?view=asciicast
