# Grills

A light MVC framework inspired by Ruby on Rails and ActiveRecord,
where object relational mapping is used for associates and search queries,
views are rendered as templates using ERB templating and controllers are
instantiated from a controller base.

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
