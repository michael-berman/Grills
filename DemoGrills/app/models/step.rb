require_relative '../../../lib/orm/sql_object'

class Step < SQLObject
  belongs_to :project
end

Step.finalize!
