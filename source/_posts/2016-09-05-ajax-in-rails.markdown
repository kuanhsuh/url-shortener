---
layout: post
title: "AJAX in rails"
date: 2016-09-05 08:24:12 +0800
comments: true
categories:
---

Today we'll talk about how Rails uses AJAX. Rails uses something called UJS(unobstrusive javascript), which you can find more here,
https://github.com/rails/jquery-ujs

Some of the method we are already using without noticing such as [data-confirm] and [data-disable-with] in our delete link. These methods are included in jquery ujs.

Today I want to talk about dynamically adding and deleting item using AJAX. In rails usually we submit request with HTTP but with AJAX we use XHR. Just like google map.

In our form view add remote: true

```ruby
<%= form_for Message.new, remote: true do |f| %>
<% end %>
```

In our controller in the create action add format.js

```ruby
def create
  @message = Message.new message_params
    if @message.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      raise "something is wrong"
    end
  end
```

Finally we need to create a create.js.erb

```ruby
$(".messages").html("<%= j render Message.all %>")
$("input#message_content").val('');
```

###Here's the code for destroy method

1. In the controller add format.js to destroy method

1. in the view add
`<%= link_to "delete", blog_comment_path(@blog, comment), method: :delete, remote: true%>`

1. destroy.js.erb
```ruby
# Method 1
$("#comment_<%= @comment.id %>").remove()
# Method 2
$(".message").html("<%= j render Message.all%>")
```
