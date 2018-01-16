class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method = pattern, http_method
    @controller_class, @action_name = controller_class, action_name
  end

  def matches?(req)
    !!(pattern =~ req.path) &&
      (http_method == req.request_method.downcase.to_sym)
  end

  def run(req, res)
    match_data = @pattern.match(req.path)

   route_params = Hash[match_data.names.zip(match_data.captures)]

   @controller_class
     .new(req, res, route_params)
     .invoke_action(action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    route = Route.new(pattern, method, controller_class, action_name)
    @routes << route
  end

  def draw(&proc)
    instance_eval(&proc)
  end

  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def match(req)
    @routes.each { |route| return route if route.matches?(req) }
    nil
  end

  def run(req, res)
    matched_route = match(req)

    if matched_route
      matched_route.run(req, res)
    else
      res.status = 404
    end

  end

end
