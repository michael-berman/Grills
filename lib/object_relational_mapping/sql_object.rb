require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'

class SQLObject
  def self.columns

    if @columns.nil?
      columns = self.get_columns
      @columns = columns.first.map(&:to_sym)
    else
      @columns
    end

  end

  def self.finalize!

    self.columns

    @columns.each do |column|

      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end

    end

  end

  def self.table_name=(table_name)
    @table_name ||= "#{self.to_s.downcase}s"
  end

  def self.table_name

    if @table_name
      @table_name
    else
      @table_name = "#{self.to_s.downcase}s"
    end

  end

  def self.all
    raw_all = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(raw_all)
  end

  def self.parse_all(results)
    parsed = []
    results.each do |params|
      parsed << self.new(params)
    end
    parsed
  end

  def self.find(id)
    all = self.all
    all.each do |obj|
      return obj if obj.id == id
    end
    return nil
  end

  def initialize(params = {})
    params.keys.each do |attr_name|
      raise "unknown attribute '#{attr_name}'" if !self.class.columns.include?(attr_name.to_sym)
      self.send("#{attr_name.to_sym}=", params[attr_name])
    end
  end

  def attributes
    if @attributes.nil?
      @attributes = {}
    else
      @attributes
    end
  end

  def attribute_values
    @attributes.values
  end

  def insert
    column_names = self.class.columns.reject {|el| el == :id }
    .join(", ")
    question_marks = (["?"] * (self.class.columns.length - 1)).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    column_names = self.class.columns.map {|attr_name| "#{attr_name} = ?" }.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, self.id)
    UPDATE
      #{self.class.table_name}
    SET
      #{column_names}
    WHERE
      id = ?
    SQL
  end

  def save
    self.id ? update : insert
  end

  def self.get_columns
    DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
  end
end
