require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'
require 'byebug'

class ControllerBase

  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = route_params.merge(req.params)
    session
    flash
    @already_built_response = false
    @@protect_from_forgery ||= false
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise "double render error" if already_built_response?

    @res.status = 302
    @res.set_header('location', url)

    @already_built_response = true

    @session.store_session(@res)
    @flash.store_flash(@res)

    nil
  end

  def render_content(content, content_type)
    raise "double render error" if already_built_response?

    @res.write(content)
    @res['Content-Type'] = content_type

    @already_built_response = true

    @session.store_session(@res)
    @flash.store_flash(@res)

    nil
  end

  def render(template_name)
    dir_path = File.dirname(__FILE__)
    template_fname = File.join(
      dir_path[0..-4], 'DemoGrills/app',
      "views", self.class.name.underscore, "#{template_name}.html.erb"
    )

    template_code = File.read(template_fname)

    render_content(
      ERB.new(template_code).result(binding),
      "text/html"
    )
  end

  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  def invoke_action(name)
    if protect_from_forgery && !(req.request_method == 'GET')
      check_authenticity_token
    else
      form_authenticity_token
    end

    self.send(name)
    render(name) unless already_built_response?
  end

  def form_authenticity_token
    @token ||= SecureRandom.urlsafe_base64
    res.set_cookie('authenticity_token',
      value: @token,
      path: '/'
    )
    @token
  end

  def check_authenticity_token
    cookie = @req.cookies['authenticity_token']
    unless cookie && cookie == params['authenticity_token']
      raise 'Invalid authenticity token'
    end
  end

  def protect_from_forgery
    @@protect_from_forgery
  end

  protected
  def self.protect_from_forgery
    @@protect_from_forgery = true
  end

  private
  attr_accessor :already_built_response
end
