---
layout: post
title: "Jquery-Traversing"
date: 2016-09-05 08:49:55 +0800
comments: true
categories:
---

**Here are the 5 main things Jquery is build to do**

  - find elements in an HTML document
  - change HTML content
  - listen to what a user does and react accordingly
  - animate content on the page
  - talk over the network to fetch new content

Today we'll be talking about the first part, finding elements in an HTML document(Traversing). Traversing means travel through or finding the HTML element.

**First we need to understand ancestors, descendents, siblings and filters**

  - ancestor is the element above the current element
    - ancestor api: parent()
  - descendent is the element below the current elements
    - decendent api: children(), find()
  - siblings are elements that are same level as current element.
    - siblings api: siblings(), next(), prev()
  - filtering allow you to select elements that match or do not match certain criteria
    - filter api: filter(), first(),last(),not()

  Here's a picture for [illustration](http://www.w3schools.com/jquery/jquery_traversing.asp)

### Here is Demo code,[link](https://codepen.io/dannyhuang/pen/ORPRZp)
In this code I have 3 blocks and after clicking "Go Somewhere Button" the price will show. There are 3 identical .btn class. Hence if we didn't use traversing method, all 3 links will show if we click on any of the buttons. In this case we use .closest method(we can also use parent).

```javascript
var vocation = $(this).closest('.card');
```

I added two buttons above to filter out expiring and on-sale events. First, all onsale or expiring to each block, and here's the code to filter.

```javascript
  $('#filters').on('click','.onsale-filter', function(){
     $('.highlight').removeClass('highlight');
     $('.card').filter('.onsale').addClass('highlight');
  });
  $('#filters').on('click', '.expiring-filter', function(){
    $('.highlight').removeClass('highlight');
    $('.card').filter('.expiring').addClass('highlight');
  });
```

That's basically it for Jquery Traversing. Here are some references:

1. http://www.w3schools.com/jquery/jquery_traversing.asp
1. https://api.jquery.com/category/traversing/
