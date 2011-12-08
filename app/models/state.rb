class State
  include Mongoid::Document

  field :address
  field :coords

  def self.geocode_blanks
    self.all.each do |state|
      if state['coords'].include? nil
        state['coords'] = Geocoder.coordinates("#{state.address}, Mexico").reverse
        state.save
      end
    end
  end
end
