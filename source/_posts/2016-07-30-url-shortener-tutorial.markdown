---
layout: post
title: "URL-Shortener Tutorial"
date: 2016-07-30 09:25:13 +0800
comments: true
categories:
---
My goal is to make a simple version of bit.ly. So In my homepage there's a URL form and after submitting it I get a shortened link in a new page. If I click on the shortened link I'll get redirected to the original URL

Here we go.

1. we need to generate a scaffold link with url and slug

    rails g scaffold link url slug
    rake db:migrate

2. In our links controllers we only want the following actions: new, create, and show. so delete the other actions

3. we want to create a new action called temp that can how hold original URL and shortened url. The shortened url is our show page and in our show page we want to redirect to the original URL.

So In links controllers add:

    def temp
    end

    def show
      redirect to @link.url
    end

In routes.rb

    get "/temp/:id", to: 'links#temp', as: :temp

In view/temp.html.erb

    <p id="notice"><%= notice %></p>

    <h3>Your URL was shortened</h3>

    <p>The new short URL is <%= link_to "#{link_url(@link)}", link_path(@link) %></p>

    <p>The Url leads to <%= link_to @link.url, @link.url %></p>


4. Now we need to generate slug and change the routes. We need a method to generate slug. I use base36, You can find more info [here.](https://en.wikipedia.org/wiki/Senary#Base_36_as_senary_compression) . Basically it will convert a long number like 100000 into a short string "lfls"

In link model(link.rb)

    class Link < ActiveRecord::Base
      after_create :generate_slug

      def generate_slug
        self.slug = self.id.to_i.to_s(36).rjust(6, "0")
        self.save
      end

      def to_param
        slug
      end
    end

In routes.rb change to this now the param is identify by slug:

    resources :links, only: [:new, :create]
    root "links#new"
    get "/links/:slug", to: 'links#show', as: :link
    get "/temp/:slug", to: 'links#temp', as: :temp

In our controller change find by params[:id] to find by params[:slug]:

    @link = Link.find_by(slug: params[:slug])

That's it. Your URL shortener app should be working. Here's the link to the [source code.](https://github.com/kuanhsuh/url-shortener)
