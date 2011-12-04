class Dataset
  include Mongoid::Document

  field :name
  field :state_column_name
  field :default_column_name
  field :column_names
  field :content
  field :processing
  field :values

  validates_presence_of :name, :state_column_name, :default_column_name, :processing


  def add matcher_1, matcher_2, name = nil
    name = "#{matcher_1}/#{matcher_2}" if name.blank?
    deep_copy = self.content.deep_copy

    deep_copy.each do |element|
      element['properties'].merge!("#{name}" => ((element['properties'][matcher_1].to_f/element['properties'][matcher_2].to_f).round(3) rescue 0)) 
    end
    self.content = deep_copy
    self.save!
    self.column_names << name
    self.save!
  end

  def max
    max= Hash.new
    self.content.each do |element|
      element['properties'].each do |property|
        max["#{property[0]}"] = property[1].to_i  if (property[1].to_i > max["#{property[0]}"].to_i or max["#{property[0]}"].blank?)
      end
    end
    max
  end

end

class Object
  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
end

