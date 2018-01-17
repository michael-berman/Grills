require 'active_support/inflector'
require_relative 'db_connection'
require_relative 'searchable'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    self.class_name.downcase + "s"
  end
end

class BelongsToOptions < AssocOptions
  attr_reader :foreign_key, :primary_key, :class_name
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key].nil? ? "#{name}_id".to_sym :
      options[:foreign_key]
    @primary_key = options[:primary_key].nil? ? :id :
      options[:primary_key]
    @class_name = options[:class_name].nil? ?
      name[0].upcase + name[1..-1] : options[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key].nil? ?
      "#{self_class_name.downcase}_id".to_sym : options[:foreign_key]
    @primary_key = options[:primary_key].nil? ?
      :id : options[:primary_key]
    @class_name = options[:class_name].nil? ?
      name[0].upcase + name[1..-2] : options[:class_name]
  end
end

module Associatable
  def belongs_to(name, options = {})
    self.assoc_options[name] = BelongsToOptions.new(name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      key_val = self.send(options.foreign_key)
      options.model_class.where(options.primary_key => key_val)[0]
    end

  end

  def has_many(name, options = {})
    self.assoc_options[name] = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options = self.class.assoc_options[name]
      key_val = self.send(options.primary_key)
      options.model_class.where(options.foreign_key => key_val)
    end

  end

  def assoc_options
    @assoc_options ||= {}
    @assoc_options
  end
end

class SQLObject
  extend Associatable
end
