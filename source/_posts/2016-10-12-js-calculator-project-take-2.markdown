---
layout: post
title: "JS calculator project take 2"
date: 2016-10-12 10:50:35 +0800
comments: true
categories:
---

The main difference between the first attempt and second attempt is that second attempt I used the eval() function which can computate a  string.

[Here's documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval)

Now if input is validated (no duplicated operators, no duplicate periods), I can push input into an array. When  equal button is clicked, join the array and use eval() to calculate the value.

[Here's link to codepen.io](http://codepen.io/dannyhuang/pen/qaYgkB)

Hopefully you guys like this approach and let me know if there's any other thoughts or validations i haven't thought of.
