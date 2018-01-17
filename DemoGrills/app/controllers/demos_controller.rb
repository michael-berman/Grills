require_relative '../../../lib/controller_base'
require_relative '../../../lib/orm/db_connection'
require_relative '../../../lib/orm/sql_object'
require_relative '../../../lib/orm/searchable'
require_relative '../../../lib/orm/associatable'
require_relative '../models/project'
require_relative '../models/step'


class DemoController < ControllerBase

  def index
    @projects= Project.all
    render :index
  end

end
