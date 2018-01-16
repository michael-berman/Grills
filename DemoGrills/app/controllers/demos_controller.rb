require_relative '../../../lib/controller_base'

class DemoController < ControllerBase

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
