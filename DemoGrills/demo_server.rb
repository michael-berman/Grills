require 'rack'
require_relative './../lib/router'
require_relative './app/controllers/demos_controller'

router = Router.new
router.draw do
  get Regexp.new("^/$"), DemoController, :index
end

DBConnection.instance

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
