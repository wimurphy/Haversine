# define class Haversine
module Haversine
  #Ignores coordinates which are greater than the max for latitude and longitude
  #If it was required, the method could be refactored to convert any excessive
  #variable to a valid version by taking the modulus
  def self.valid_coords(lat, long)
    lat.abs<=90 && long.abs<=180
  end

  def self.radify(degree)
    degree.to_f * Math::PI/180
  end

  def self.within_radial_distance(origin_latitude, origin_longitude, endpoint_latitude, endpoint_longitude, distance)
    return unless valid_coords(origin_latitude, origin_longitude) ||
                  valid_coords(endpoint_latitude, endpoint_longitude)
    #Central angle between two points on a sphere formula
    sine = Math::sin(radify(origin_latitude))*Math::sin(radify(endpoint_latitude))
    cose = Math::cos(radify(origin_latitude))*Math::cos(radify(endpoint_latitude))*
           Math::cos(radify(origin_longitude)-radify(endpoint_longitude))
    central_angle = Math::acos(sine + cose)

    radius_earth_km =  6371
    central_angle*radius_earth_km <= distance.abs ? true : false
  end
end