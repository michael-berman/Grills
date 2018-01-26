# Grills

A light MVC framework inspired by Ruby on Rails and ActiveRecord,
where object relational mapping is used for associates and search queries,
views are rendered as templates using ERB templating and controllers are
instantiated from a controller base.

## Features & Implementations

### ORM
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

### Views


### Controller

## Libraries & Technologies
* Puma
* Rack
* ERB
* SQL

## Future Features
* Generation of framework in terminal
* Render forms in templates
