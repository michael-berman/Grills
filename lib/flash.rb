require 'json'

class Flash

  attr_accessor :now

  def initialize(req)
    cookie = req.cookies['_rails_lite_app_flash']
    # TODO: change to grills app
    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def []=(key, value)
    @flash[key.to_s] = value
  end

  def store_flash(res)
    res.set_cookie('_rails_lite_app_flash',
      value: @flash.to_json,
      path: '/'
    )
  end

end
