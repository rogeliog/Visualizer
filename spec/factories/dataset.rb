#Setup Factory values
values = Hash.new
content = Array.new

['State1','State2'].each do |state|
  content << {"id"=>state, "type" => "Feature", "geometry" => { "type" => "Point", "coordinates"=>[-102.2912701 + rand(10), 21.8817964 + rand(10)]}, "properties"=>{"property_1"=>rand(10), "property_2"=>rand(10)}}
end

state_col = 'State'
default_col = 'Population'

column_names = [state_col, default_col, 'Column_1', 'Column_2'].each {|col| values.merge!("#{col}" => [rand(6), rand(7)+6])}

Factory.define :dataset do |f|
  f.sequence(:name)         {|n| "Ruby Gem#{n}" }
  f.description             'Foo Bar'
  f.state_column_name       state_col
  f.default_column_name     default_col
  f.column_names            column_names
  f.content                 content
  f.processing              't'
  f.values                  values
end

