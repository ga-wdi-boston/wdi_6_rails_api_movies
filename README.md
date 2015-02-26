## Rails API

We are going to create a _lightweight_ Rails application that will provide [JSON](http://en.wikipedia.org/wiki/JSON#Data_types.2C_syntax_and_example) representations of it's resources.

This is a simple API for a Movie service. It will have Movies and Reviews.

## Objective

* Use the [Rails API Gem](https://github.com/rails-api/rails-api) to generate a minimal Rails app that will be used _only_ as an API.
* Configure each JSON Resource representation, attributes/properties, using the [Active Model Serializer](https://github.com/rails-api/active_model_serializers) gem. 
* Implement Cross-origin resource sharing, [CORS](http://en.wikipedia.org/wiki/Cross-origin_resource_sharing), so that Single Page Applications, [SPA](http://en.wikipedia.org/wiki/Single-page_application) can access this API.
	* SPA's created with Javascript Frameworks, (Angular, Ember, etc.), are all the rage now.
 

#### Demo - Code Along 

* Run this project, __this is the completed API we will be creating__.

	```
	rake db:create
	rake db:migrate
	rake db:seed
	rails server 
	```

* Install the Chrome Extensions, [JSON Prettfier](http://goo.gl/0ueVkS), [Postman Chrome Extension](http://goo.gl/daZ5Q) and [Postman Launcher](https://chrome.google.com/webstore/detail/postman-launcher/igofndmniooofoabmmpfonmdnhgchoka/related).  

* In Chrome go to [localhost](http://localhost:3000) to show all the Movies and their Review. 

### Lab

Using _curl_ or _postman_   
_For all the above view the rails server log and use the rails console to verify._
 
* Show all the movies
* Show the movie with id = 3
* Create a new movie.
* Delete an movie.

See "man curl", [Curl Cheat Sheet](curl_cheat.txt) and [Curl API](curl_for_api.txt) for curl info.

#### Demo


Your turn to Create a JSON API that will allow users to _Review_  _Movies_.

* cd into a directory that will contain this new app.

* Install the rails-api gem  
  ``gem install rails-api`` 

* Generate a "new_movies" Rails API app.  
  ``rails-api new movies_api -d postgresql -T``
    
  ``cd movies_api``
  
  ``bundle``  
  ``rake db:drop``  
  ``rake db:create``  

 * __Notice that this app is missing the below directories__.

	Show all the subdirectories.  
	```
	find . -type d
	```
	
	Rails API is missing these directories.  
	```
	app/assets/javascripts
	app/assets/stylesheets
	app/helpers
	app/views
	tmp
	vendor
	```

 * __The Gemfile is pretty bare.__

	Missing the sass-rails, coffee-rails, jquery-rails, turbolinks and jbuilder gems. 


 * __And this app is missing some Middleware.__

	```
	rake middleware | wc -l 
	``` 
	
	Only 19 Middleware as opposed to 24 in a full Rails app.
	

* Generate a Movie model.
  ``rails g model Movie title rating total_gross:integer description:text released_on:date``  
	

* Open up the app/controllers/movies_controller.rb

	Notice how 'thin' this controller is. Missing lots of code typically found in a controller.
	
   It has most of default actions, _missing new and edit_. BUT this app only provides a JSON "Representation" of the resource. Previously we where always outputting a HTML "Representation" of the resource.Review


* Generate a Review resource.  
  ``rails g model Review name stars:integer comment:text movie:belongs_to`` 

	Reviews are just a join model between a specific user and movie. The review only contains a body that holds the review content.

* Copy the seed file from this repos db/seeds.db to the movies_api/db/seeds.db.  

	``cp ../wdi_6_rails_lab_api/db/seeds.rb db/seeds.rb``  

* Add faker to the Gemfile, used to seed the DB, and bundle.  

	``gem faker``   

* Migrate and seed the DB.  
  ``rake db:migrate``  
  ``rake db:seed``
(make sure you set up the proper relationships before seeding!)
  

This will create 30 Users, 10 Movies	and and each Movie will have some Reviews. _Take a look at the seed file if your curious._

* Check out the routes.rb.  
Why don't we need the new and edit action?

	This is Movie resource is truely a RESTFUL resource. Not cluttered up with actions to create forms.

* Add a root route for movies index.  
  ``root 'movies#index'``

	Now we have a set of Users, Movies and Reviews.
	
* Start the server. And we see all the Movies!!!!



#### Lab  
* Check this API using _curl_ or _postman_ 
_For all the above view the rails server log and use the rails console to verify._
 
	* Show all the movies
	* Show the movie with id = 3
	* Create a new movie.
	* Delete an movie

	See "man curl", [Curl Cheat Sheet](curl_cheat.txt) and [Curl API](curl_for_api.txt) for curl info.

* Read [JSON API with rails-api and active_model_serializers](http://adamniedzielski.github.io/blog/2014/03/02/json-api-with-rails-api-and-active-model-serializers/).

* What is rails middleware? 
	
* Identify at least three reasons why one would prefer using rails-api over rails.


#### Demo
Change the JSON representation for Movies and Reviews.

* Add the active_model_serializers gem to the Gemfile and bundle.
	``gem 'active_model_serializers'`` 

* Generate a serializer for the Movie resource.  
	``rails g serializer movie``

* Add the title and body attributes in the serializer. 
  `attributes :id, :title, :body`

	This will constrain/limit the JSON returned for an Movie to show only the id , title, body. 

* restart server and got to the root.

	Notice that the updated_at and created_at columns are missing!
	We usually don't want to show these.

* Lets get rid of the root node in the JSON generated. 
	
 Add this to the Movies controller.
 
	```
	def default_serializer_options
    	{root: false}
	end
	```


* Lets embed reviews for each movie in the JSON.

Add this to the Movie serializer.  
	``has_many :reviews``

* Generate a serializer for review and add the body attribute.  
	``rails g serializer Review`` 

Now the review only show it's id and body.

* Lets show the review creator and user that reviewed. Add this to the Review serializer.  
	``attributes :id, :body, :creator``

	   ```
	   def creator
    	   "#{object.user.email}"
	   end
	   ```
	 
#### Lab 
Create a JSON API for a Song Playlist. A _Song_ will have a title, artist, duration and price. An _User_ will have a name and email. A _Playlist_ will be a join btw Songs and Users.

Use the curl command and the Chrome debugger to show the JSON returned from the Song Playlist API.


### Demo

Add the [CORS gem](https://github.com/cyu/rack-cors). This will allow HTTP Request from pages NOT served from this Rails App.

In the config/application.rb file add the below. This will allow all clients the ability to access this API.

```
 # Add Rack::Cors as middleware                                             
    # WARNING: Allow ALL cross site scripting                                  
    config.middleware.use Rack::Cors do
      allow do
        # WARNING: Allow ALL cross site scripting from ALL domains             
        origins '*'
        # WARNING: Allow ALL HTTP method                                       
        resource '*', :headers => :any, :methods => [:get, :post,:delete, :opt\
ions]
      end
    end

```

