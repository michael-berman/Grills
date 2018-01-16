require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'

class PortfolioController < ControllerBase

  def index
    render :index
  end

  def about
    render :about
  end

  def resume
    render :resume
  end

end

router = Router.new
router.draw do
  get Regexp.new("^/$"), PortfolioController, :index
  get Regexp.new("^/about$"), PortfolioController, :about
  get Regexp.new("^/resume$"), PortfolioController, :resume
end

#Creating requests and responses
app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

#Creating a server
Rack::Server.start(
  app: app,
  Port: 3000
)
