require 'JSON'
require './haversine.rb'

origin_lat = ARGV[0].to_f
origin_long = ARGV[1].to_f
distance_from_origin = ARGV[2].to_f
file_path = ARGV[3]

#Read in JSON from File (this could also be done with RestClient if file is hosted online)
file = File.read(file_path)
begin
  parsed_response = JSON.parse(file)
rescue
  #Script should be able to account for new line delimited json blobs
  parsed_response = JSON("[#{file.gsub("\n", ',')}]")
end

#Verify Customers are within the user defined distance
valid_customers = parsed_response.each_with_object([]) do |customer, array|
  next unless Haversine.within_radial_distance(origin_lat, origin_long, customer["latitude"], customer["longitude"], distance_from_origin)
  array << {id: customer["user_id"], name: customer["name"]}
end
valid_customers.sort_by! { |hash| hash[:id] }

#Output Ordered List JSON file & Console
File.open("valid_customers.json","w") do |f|
  f.write(valid_customers.to_json)
end
puts "Valid Customers" unless valid_customers.empty?
puts valid_customers