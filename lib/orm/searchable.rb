require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    attribute_values = params.values
    key_finds = params.keys.map {|key| "#{key} = ? "}.join("AND ")
    results = DBConnection.execute(<<-SQL, *attribute_values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{key_finds}
    SQL

    results.map {|result| self.new(result)}
  end
end

class SQLObject
  extend Searchable
end
