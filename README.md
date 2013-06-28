An engine gem to provide a RDBMS backed list of roles and their associated user.  This replaces the hydra default role mapper.


##Installing:

* Add: ```gem 'bpl-institution-management'``` to your Gemfile and then ```bundle install```
* ```rails generate roles```
* ```rake db:migrate```
* Add the following [cancan](https://github.com/ryanb/cancan) abilities:

```ruby
  # app/models/ability.rb
  TBA
```

##Testing:

* Install a system javascript runtime or uncomment therubyracer in spec/support/Gemfile
* Run ```rake generate spec``` to generate a test rails app at spec/internal and test it
