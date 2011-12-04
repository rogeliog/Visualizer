class MapsController < ApplicationController
  def show
    @datasets = Dataset.all
    @name = 'Chino'
    @attributes = ['Educacion', 'Salud', 'Delitos', 'Arrestos', 'IPods robados']
    @states = ['Nuevo Leon', 'Sonora', 'Yucatan', 'DF'].map do |state|
      lat,long = Geocoder.coordinates("#{state}, Mexico")
      {:name => state, :lat => 1, :long => 2, :attributes => {"Educacion" => rand(40) + 10, "Salud" => rand(60) + 10 }}
    end
  end

end
