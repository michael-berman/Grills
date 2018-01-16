require 'json'

class Session

  def initialize(req)
    # TODO: Change into grills app
    cookie = req.cookies['_rails_lite_app']
    if cookie
      @cookie_data = JSON.parse(cookie)
    else
      @cookie_data = {}
    end
  end

  def [](key)
    @cookie_data[key]
  end

  def []=(key, val)
    @cookie_data[key] = val
  end

  def store_session(res)
    cookie = { path: '/', value: @cookie_data.to_json }
    res.set_cookie('_rails_lite_app', cookie)
    # TODO: change into grills app name
  end
end
