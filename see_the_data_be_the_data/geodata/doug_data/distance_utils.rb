EARTH_RADIUS = 3_958.9

class Numeric
  def to_rad
    self * Math::PI / 180 
  end
end

# Haversine formula
def distance_between lat1, lon1, lat2, lon2
  dlon = (lon2 - lon1).to_rad
  dlat = (lat2 - lat1).to_rad
  lat1 = lat1.to_rad
  lat2 = lat2.to_rad
  
  a = (Math.sin(dlat/2.0)) ** 2.0 + Math.cos(lat1) * Math.cos(lat2) * (Math.sin(dlon/2.0)) ** 2.0
  c = 2 * Math.asin( [1.0, Math.sqrt(a)].min )
  EARTH_RADIUS * c
end
