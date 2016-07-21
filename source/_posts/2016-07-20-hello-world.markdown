---
layout: post
title: "Rails Polymorphic Association"
date: 2016-07-20 16:53:03 +0800
comments: true
categories:
---

Polymorphic association is used when a model can belongs to one or more other model. For example, if you have a Article, Image, and Person model, and they all need comment functions. Instead of creating separate comment model for each type, you can have comment model with polymorphic associations.

Here are the steps for creating polymorphic model.

    rails g model comment content:text, commentable_id:integer, commentable_type:string

commentable_type and commentable_id is used to determine which model comment is asscoated with.

In the migration file change to this and run rake db:migrate

    class Comments < ActiveRecord::Migration
      def change
        create_table :comments do |t|
          t.text :content
          t.belongs_to :commentable, :polymorphic => true

          t.timestamps
        end
      end
    end    

In the Article, Image, Person model add

    has_many :comments, :as => :commentable

In the Comment model add

    belongs_to :commentable, :polymorphic => true

We are finish setting up Polymorphic association. In rails console, we can type

    a = Article.first
    comment = a.comments.create!(content: "Hello World")

Commentable type will automatically fill in with Article and now we can run a.comments or comment.commentable_type, comment.commentable_id


### Reference
http://railscasts.com/episodes/154-polymorphic-association-revised
http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
