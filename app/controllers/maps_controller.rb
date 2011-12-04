# encoding: utf-8
class MapsController < ApplicationController
  def index
    @datasets = Dataset.all
    render :show
  end

  def show
    @datasets = Dataset.all
    @dataset  = Dataset.find(params[:id])
    @attributes = @dataset.column_names
    render :show
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
<<<<<<< HEAD
    data = Dataset.find(params[:id]).content
=======
    data = Dataset.where(:processing => "f").first.content
>>>>>>> wip

    bb  = params[:bbox].split(',')
    lng = Range.new(*[bb[0], bb[2]].map(&:to_f).sort)
    lat = Range.new(*[bb[1], bb[3]].map(&:to_f).sort)

    data = data.select do |element|
      coordinates = element['geometry']['coordinates']
      lat.include?(coordinates.first) && lng.include?(coordinates.last) 
    end

    render :json => {:type => 'FeatureCollection', :features => data}
  end
end
