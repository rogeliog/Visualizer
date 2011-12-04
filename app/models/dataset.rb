class Dataset
  include Mongoid::Document

  field :name
  field :state_column_name
  field :default_column_name
  field :column_names
  field :content
  field :processing
  validates_presence_of :name, :state_column_name, :default_column_name, :processing
end
