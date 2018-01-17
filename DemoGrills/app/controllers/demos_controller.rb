require_relative '../../../lib/controller_base'
require_relative '../../../lib/orm/db_connection'
require_relative '../../../lib/orm/sql_object'
require_relative '../../../lib/orm/searchable'
require_relative '../../../lib/orm/associatable'


class DemoController < ControllerBase

  def index
    DBConnection.reset
    debugger
    render :index
  end

end
