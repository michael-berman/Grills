require_relative '../../../lib/orm/sql_object'

class Project < SQLObject
  has_many :steps
end
