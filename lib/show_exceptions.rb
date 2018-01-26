require 'erb'

class ShowExceptions

  attr_reader :app
  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue Exception => e
    render_exception(e)
  end

  private

  def render_exception(e)
    path = "lib/templates/rescue.html.erb"
    template = File.read(path)
    body = ERB.new(template).result(binding)

    ['500', {'Content-type' => 'text/html'}, body]
  end

end
