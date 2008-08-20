require 'builder'

class LocationReading

  attr_accessor :id
  attr_accessor :date
  attr_accessor :time
  attr_accessor :distance_from_home
  attr_accessor :lat
  attr_accessor :long


  def initialize(id, datetime, lat, long)
    self.id       = id.to_i
    self.lat      = lat.to_f
    self.long     = long.to_f
    date_s, self.time = datetime.split " " rescue nil
    unless date_s.nil?
      date_components = date_s.split '/'
      month = date_components[0].size == 1 ? "0#{date_components[0]}" : date_components[0]
      day = date_components[1].size == 1 ? "0#{date_components[1]}" : date_components[1]
      year = date_components[2].size == 2 ? "20#{date_components[2]}" : date_components[2]
      self.date = "#{month}/#{day}/#{year}"
    end
  end
  
  def to_xml options={ }
    atts = { :distance_from_home => distance_from_home, :lat => lat, :long => long }
    atts.merge!( :id => id, :date => date, :time => time ) unless options[:geo_only]
    
    options[:builder] ||= Builder::XmlBuilder.new
    options[:builder].location atts
  end
  
  def to_tab_delimited_line attrs
    values = attrs.inject([]) do |a, attribute|
      a << send( attribute )
    end
    values.join( "\t" ) << "\n"
  end
  
  def eql? other
    other.lat == self.lat && other.long == self.long
  end
  
  def hash
    lat.hash + long.hash
  end
  
end

