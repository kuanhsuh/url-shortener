---
layout: post
title: "Install Guard Livereload"
date: 2016-08-18 10:02:19 +0800
comments: true
categories:
---

Guard livereload is a gem that automatically reloads your browswer everytime your app is saved. Here's how you setup

```ruby
group :development do
  gem 'guard'
  gem 'guard-livereload'
end
```
Run in your terminal
`bundle`
`bundle exec guard init`

You can modify the Guardfile.

```ruby
guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end
```

Install Chrome extension [here](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei/related)

Finally run `guard` and turn on the plugin in Chrome


Now your app should automatically reload!
