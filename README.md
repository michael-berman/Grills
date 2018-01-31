# Grills

A light MVC framework inspired by Ruby on Rails and ActiveRecord,
where object relational mapping is used for associates and search queries,
views are rendered as templates using ERB templating and controllers are
instantiated from a controller base.

## How to use the script
First, make sure to clone the repo:

```
git clone https://github.com/michael-berman/Grills
```

Rename DemoGrills to the app name of your choice. Create your controllers and models in the app folder under the [appname] folder. To create controllers, make sure they inherit from ControllerBase:
```
require_relative '../../../lib/controller_base'
require_relative '../../../lib/orm/db_connection'
require_relative '../../../lib/orm/sql_object'
require_relative '../../../lib/orm/searchable'
require_relative '../../../lib/orm/associatable'

class DemoController < ControllerBase

  def index
    @projects= Project.all
    render :index
  end

end
```

To create models, create the model's parameters in SQL in the demo.sql file
and make sure the model files inherit from SQLObject:
```
require_relative '../../../lib/orm/sql_object'

class Project < SQLObject
  has_many :steps
end

Project.finalize!
```

To create views, make sure the folder inside views is the snake case form of the corresponding controller (in this case demo_controller).

### Demo the provided app

To demo the DemoGrills app, simply clone the repo and then type in the following within your terminal to run the server:

```
bundle exec ruby DemoGrills/demo_server.rb
```

Visit localhost:3000 to see the demo app in action.

## Features & Implementations

### Object Relational Mapping
Since the Grills ORM is inspired by the ActiveRecord framework in Rails, it converts SQL tables into an instance of the Grills::SQLObject class.

Methods of the Grills' ORM includes:
* CRUD:
  * #create
  * #update
* Associations:
    * ::belongs_to
    * ::has_many
* Queries:
    * ::where
    * ::all
    * ::find

### Controller & Views
A controller base was implemented similar to the Application Controller in the controllers design of Rails. Routes are created by a custom router, while the controllers reads the route in the request rendered by Rack and renders the corresponding template. Other implementations of the controller is that it can redirect to a url and render content to keep RESTful web API practices intact.

### Other Features
* Flash errors
* Storing cookies
* Exceptions and stack trace
* Add images, texts or zipped files
* CSRF protection

## Libraries & Technologies
* Puma - The server for an App
* Rack - Serves as the intermediate between requests and responses
* ERB - Renders templates with embedded Ruby
* SQL - Database for the ORM
* Active Support - Methods for various extensions

## Future Features
* Generation of framework in terminal
* Render forms in templates
