---
layout: post
title: "jQuery-DOM manipulation"
date: 2016-09-05 08:50:22 +0800
comments: true
categories:
---

In this post, we'll about DOM manipulation and events.
  - change HTML content
  - listen to what a user does and react accordingly
  - animate content on the page

First, jQuery uses a selector which is something like `$('p')` to specify which element you want to manipulate. Following the selector, you use an action for the selector to follow, for example `$('p').hide();`.

You can use a DOM manipulation with an event. For example if a user clicks Show Tickets button, the element containing the tickets will show.

Here's demo[link](https://codepen.io/dannyhuang/pen/WGbRXZ)

```javascript
function showTicket() {
  $(this).closest('.card').find('.ticket').slideToggle();
}
$(document).ready(function(){
 $('.card').on('click', '.btn', showTicket);
```

####Couple things to be ware of

1. `$(document).ready()` means load jQuery after html document is ready. Sometimes you'll have an error because jQuery is loaded before HTML element, which means jQuery can't find element to manipulate.

2. `e.preventDefault();` This is to prevent browser from executing default event. You use this when submitting for or avoid browser to refresh from the top.

Here's an example[link](https://codepen.io/dannyhuang/pen/JRoEVv)
try the links at the bottom of the page. With preventDefault(), the page will stay at the original position.

```javascript
$('.card').on('click', '.expand', function(event){
 event.preventDefault();  $(this).closest('.card').find('.comments').slideToggle();
 });
```


### Reference:
http://www.w3schools.com/jquery/event_preventdefault.asp
https://api.jquery.com/event.preventdefault/
