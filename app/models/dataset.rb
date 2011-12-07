class Dataset
  include Mongoid::Document

  field :name
  field :description
  field :state_column_name
  field :default_column_name
  field :column_names
  field :content
  field :processing
  field :values

  validates_presence_of :name, :state_column_name, :default_column_name, :processing


  def add matcher_1, matcher_2, name = nil
    min=0
    max=0
    name = "#{matcher_1}/#{matcher_2}" if name.blank?
    deep_copy = self.content.deep_copy

    deep_copy.each do |element|
      result = parse_result(element['properties']["#{matcher_1}"], element['properties']["#{matcher_2}"])
      max = result if result > max
      min = result if result < min
      element['properties'].merge!("#{name}" => result)
    end
    deep_copy_values = self.values.deep_copy
    deep_copy_values.merge!("#{name}" => [min,max])

    self.values = deep_copy_values
    self.content = deep_copy
    self.column_names << name
    self.save!
  end

  def parse_result(matcher_1,matcher_2)
    if matcher_1.to_s.match(/^[\d]+(\.[\d]+){0,1}$/) and  matcher_2.to_s.match(/^[\d]+(\.[\d]+){0,1}$/) and !matcher_2.to_f.zero?
      (matcher_1.to_f/matcher_2.to_f).round(3) rescue 0.0
    else
      0.0
    end
  end

end

class Object
  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
end

