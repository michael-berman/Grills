require_relative '../../../lib/controller_base'
require_relative '../../../lib/orm/db_connection'

class DemoController < ControllerBase

  def index
    DBConnection.reset
    debugger
    render :index
  end

  def about
    render :about
  end

  def resume
    render :resume
  end

end
