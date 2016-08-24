---
layout: post
title: "Add Rating Star to Rails app"
date: 2016-08-24 07:36:21 +0800
comments: true
categories:
---

This is how you add rating stars to your rails app

1. add this to application_helper.rb

```ruby
def star
  content_tag(:i, "", class: "fa fa-star")
end

def half_star
  content_tag(:i, "", class: "fa fa-star-half")
end

def stars_for_score(value)
  output = ""
  if (1..5).include?(value.floor)
    value.floor.times {output += star }
  end
  if value == (value.floor + 0.5) && value.to_i != 5
    output += half_star
  end
  output.html_safe
end
```

1. In review.rb model add

```
belongs_to :product

validates :rating, :user_id, :product_id, presence: true
validates :rating, numericality: { only_integer: true, :greater_than => 0,  :less_than_or_equal_to => 5}
```

1. Finally in product model add
```
def num_reviews
  reviews.count
end

def average_review_score
  reviews.average(:rating)
end
```

Now the basic structure is done, just add a form in the product show page where user and create a review rating.
