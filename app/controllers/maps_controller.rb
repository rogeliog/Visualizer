# encoding: utf-8
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

  def tiles
    # flip round the y coordinate for mapbox
    y = ((2**params[:zoom].to_f) - 1) - params[:row].to_f

    db = SQLite3::Database.new "#{Rails.root}/db/Mexico.mbtiles"
    rows = db.execute("select images.tile_data 
                       from map 
                       inner join images 
                       on (map.tile_id = images.tile_id) 
                       where zoom_level = #{params[:zoom]} AND 
                       tile_row = #{y} AND 
                       tile_column = #{params[:column]}")
    unless rows.empty?
      send_data rows[0][0], :type => 'image/png', :disposition => 'inline'
    end
  end

  def json_query
    data = [{:id=>"Nuevo Leon", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[25.7276624, -99.54509739999999]}, :properties=>{"Educación"=>26, "Salud"=>36}}, {:id=>"Sonora", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[29.2972247, -110.3308814]}, :properties=>{"Educación"=>28, "Salud"=>65}}, {:id=>"Yucatan", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[20.7098786, -89.0943377]}, :properties=>{"Educación"=>13, "Salud"=>11}}, {:id=>"DF", :type=>"Feature", :geometry=>{:type=>"Point", :coordinates=>[19.4326077, -99.133208]}, :properties=>{"Educación"=>19, "Salud"=>32}}]

    bb  = params[:bbox].split(',')
    lat = Range.new(*[bb[0], bb[2]].map(&:to_f).sort)
    lng = Range.new(*[bb[1], bb[3]].map(&:to_f).sort)

    data = data.select do |element|
      coordinates = element[:geometry][:coordinates]
      lat.include?(coordinates.first) && lng.include?(coordinates.last) 
    end

    render :json => {:type => 'FeatureCollection', :features => data}
  end
end
