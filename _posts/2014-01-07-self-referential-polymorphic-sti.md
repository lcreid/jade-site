---
layout: post
title: Self-Referential, Polymorphic, STI, Decorated, Many-to-Many Relationship in
  Rails 4
date: '2014-01-07T21:47:00.001-08:00'
author: Larry Reid
tags:
- Ruby on Rails
modified_time: '2014-01-07T21:51:40.159-08:00'
blogger_id: tag:blogger.com,1999:blog-5778824359157275227.post-583119077619162219
blogger_orig_url: http://technopragmatica.blogspot.com/2014/01/self-referential-polymorphic-sti.html
---

## Preamble   {#preamble}

I wanted to model connections à la connections in LinkedIn or Facebook
in a Rails application. This means a many-to-many association between
instances of the same class. That caused me some grief trying to get it
hooked up right because you can’t rely on Rails to figure everything
out.  
The other trick in my application is that the people involved in the
connections might be users who have registered to use the application,
or they might be people created by a registered user, but who aren’t
registered to user the application.   
Concretely, and hopefully more clearly, I have “users”, who have
registered, and I have people who can be involved connections. In my app
the people who aren’t registered users are “patients”.  
In the course of trying to get this all to work I stumbled across three
approaches to this type of problem:  
<ol><li>Polymorphic classes</li><li>Single Table Inheritance
(STI)</li><li>[Decorator pattern][1]</li></ol>The combination of the
many-to-many combined with the two classes took a lot of work to get
straight. The [Rails Guides][2] were a great starting point, but I find
that specifying Rails associations can be tricky if it’s not completely
straightforward, and especially when you start chaining them together.  
In the end, I decided to go with the Decorator pattern. But I’ll start
with the one I threw out first: Polymorphic.  
<h2 id=\"polymorphic\">Polymorphic</h2>I got pretty far with polymorphic
associations, but I couldn’t figure out how I was going to get a list of
all people (patients and users) connected to another person. I could
either get all patients or all users from the methods that the Rails
associations gave me, but not a list of all together.  
I realized in writing the preamble above that I probably should have
realized that what I was trying to model wasn’t really a polymorphic
situation. Polymorphic in the examples I saw was used to connect an
object to another object from any one of a number of unrelated classes.
Of course, hindsight is 20/20.  
[This post][3] convinced me that trying to get a list of all people
wasn’t going to come naturally from a polymorphic approach, so I stopped
pursuing it.  
<div class=\"se-section-delimiter\"></div><h2
id=\"single-table-inheritance\">Single Table Inheritance</h2>I got fired
up about single table inheritance (STI) as I was reading about how to
make the polymorphic approach work. A good brief write up is here:
[http://blog.thirst.co/post/14885390861/rails-single-table-inheritance][4].
The Railscast is here:
[http://railscasts.com/episodes/394-sti-and-polymorphic-associations][5]
(sorry, it’s a pro Railscast so it’s behind a paywall).  
Others say I shouldn’t do STI. People say it can cause problems. One
problem is if the type of an object will change, and change because of
user input, it’s hard to handle. The view and controller are fixed to a
certain object, so you can’t change the object type based on user input.

So here’s the code. First, create the models:  
<pre>`rails g model person name:string type:string provider:string
uid:stringrails g model link person_a:references person_b:references
b_is:string`</pre>person.rb  
<pre>`class Person < ActiveRecord::Base  has_many :links, foreign_key:
"person_a_id"  has_many :people, :through => :links, :source =>
\:person_b  scope :patients, -> { where(type: "Patient") }  scope :users,
-> { where(type: "User") }end`</pre>user.rb (obviously there will be
functionality here, but this is what I needed to get the associations to
work):  
<pre>`class User < Personend`</pre>patient.rb (as with user.rb,
functionality will come later):  
<pre>`class Patient < Personend`</pre>link.rb  
<pre>`class Link < ActiveRecord::Base  belongs_to :person_a, class_name:
"Person"  belongs_to :person_b, class_name: "Person"end`</pre>It was a
little hard to get the associations to work. The key to making the
`has_many :links,...` in `person.rb` work was the `, class_name:
"Person"` on the association in `link.rb`.   
With the above, I can do things like:  
<pre>`person =
Person.find(1).firstperson.people.first.nameperson.people.patients.first.nameperson.people.users.first.name`</pre>That’s
all pretty sweet, and I really considered using this approach. In fact,
I may return to it. There’s a lot left to do with my application.
However, I’m pretty sure that I will need to deal with cases like a
registered user corresponding to multiple patients (e.g. people get
created under different names). Eventually I need a way to consolidate
them.  
<h2 id=\"decorator\">Decorator</h2>In the end, perhaps the simplest was
the best. I just decorated a person with an instance of a user when the
person is a registered user. (This allows multiple people for a user,
which might be useful for consolidating duplicate people.)   
Here’s what I did:  
Generate the models:  
<pre>`rails g model link person_a:references person_b:references
b_is:stringrails g model person user:references name:stringrails g model
user uid:string name:string provider:string`</pre>person.rb  
<pre>`require 'person_helper'class Person < ActiveRecord::Base 
belongs_to :user  has_many :links, foreign_key: :person_a_id  has_many
\:people, through: :links, source: :person_b  include
PersonHelperend`</pre>I thought the person model should have `has_one`
instead of `belongs_to`, but that would put the foreign key in the wrong
model.  
user.rb  
<pre>`require 'person_helper'class User < ActiveRecord::Base  has_many
\:identities, class_name: "Person"  has_many :links, through: :identities
has_many :people, through: :links, :source => :person_b  include
PersonHelperend`</pre>lib/person\_helper.rb  
<pre>`module PersonHelper  def users    people.select { |person| !
person.user_id.nil? }  end  def patients    people.select { |person|
person.user_id.nil? }  endend`</pre>link.rb  
<pre>`class Link < ActiveRecord::Base  belongs_to :person_a, class_name:
"Person"  belongs_to :person_b, class_name: "Person"end`</pre>With the
above, I can do things like:  
<pre>`person =
Person.find(1).firstperson.people.first.nameperson.patients.first.nameperson.users.first.nameuser
= User.find(2).firstuser.users.first.name`</pre>Again, sweet. Same
number of files at the STI version. Instead of subclassing, common
functionality is handled by a mixin module.  
<h2 id=\"postscript\">Postscript</h2>Another thing people don’t seem to
like about STI is that it’s easy to end up with a big table full of all
sorts of columns used only in a few places. Most modern database
management systems aren’t going to waste a significant amount of space
for unused columns, so I’m not sure what the problem is.  
However, it got me thinking if there isn’t a way in Rails to have more
than one table under a model. Or more to the point, could you have a
table for the base model class, and a different table for each of the
subclasses, and have Rails manage all the saving a retrieving.  
I’m sure I’m not the first person to think of this. But I’m not going to
go looking for it right now.  
<h2 id=\"other-resources\">Other Resources</h2>Rails 4 guides on
associations:
[http://guides.rubyonrails.org/association\_basics.html][6] and
migrations: [http://guides.rubyonrails.org/migrations.html][7].  
Ryan Bates’ Railscast on self-referential associations:
[http://railscasts.com/episodes/163-self-referential-association][8],
and on polymorphic associations:
[http://railscasts.com/episodes/154-polymorphic-association][9].



[1]: http://en.wikipedia.org/wiki/Decorator_pattern
[2]: http://guides.rubyonrails.org/association_basics.html%20and%20migrations:%20http://guides.rubyonrails.org/migrations.html
[3]: http://www.brentmc79.com/posts/polymorphic-many-to-many-associations-in-rails
[4]: http://blog.thirst.co/post/14885390861/rails-single-table-inheritance
[5]: http://railscasts.com/episodes/394-sti-and-polymorphic-associations
[6]: http://guides.rubyonrails.org/association_basics.html
[7]: http://guides.rubyonrails.org/migrations.html
[8]: http://railscasts.com/episodes/163-self-referential-association
[9]: http://railscasts.com/episodes/154-polymorphic-association
