require 'rubygems'
require 'builder'
require 'location'
require 'distance_utils'
require 'date'

DISTANCE_THRESHOLDS = [0..1, 1.00001..5, 5.00001..10, 10.00001..20, 20.00001..50, 50.00001..100, 100.0001..1000, 1000.0001..5000]
HOME = LocationReading.new(0, nil, 37.7502, -122.411)

@locations = []
@lat_long_frequencies = {}
@greatest_distances_per_day = {}
@distance_frequencies = Hash.new 0

def visited_location location
  @lat_long_frequencies[location] = visited_location?(location) ? @lat_long_frequencies[location] + 1 : 1
end

def visited_location? location
  @lat_long_frequencies[location]
end

def log_distance distance
  DISTANCE_THRESHOLDS.each do |threshold|
    @distance_frequencies[threshold] += 1 if threshold.include?(distance)
  end
end

def builder
  @builder = Builder::XmlMarkup.new :indent => 2
end

def load_readings
  readings = File.new('data/doug_locations_jan-may.csv').readlines("\r")

  readings.each do |reading|
    @locations << location = LocationReading.new( *reading.chop.split(',') )
    location.distance_from_home = distance_between location.lat, location.long, HOME.lat, HOME.long
    visited_location location
    log_distance location.distance_from_home
    greatest_so_far = @greatest_distances_per_day[location.date]
    @greatest_distances_per_day[location.date] = location if greatest_so_far.nil? || greatest_so_far.distance_from_home < location.distance_from_home
  end
  @sorted_frequencies = @lat_long_frequencies.sort { |a,b| b[1]<=>a[1] }
  @distances = @greatest_distances_per_day.sort { |a,b| Date.parse(a[1].date) <=> Date.parse(b[1].date) }
end

def dump_all_locations
  all_locations = builder.locations do | builder |
    @locations.each{ |location| location.to_xml( :builder => builder )  }
  end

  File.new('xml/all_locations.xml', 'w+').puts all_locations
end

def dump_unique_locations
  unique_locations = builder.locations do | builder |
    @lat_long_frequencies.each{ |entry| entry[0].to_xml( { :builder => builder, :geo_only => false } ) }
  end

  File.new('xml/unique_locations.xml', 'w+').puts unique_locations
end

def dump_frequency_distributions
  frequency_distributions = builder.frequencies do | builder |
    @sorted_frequencies.each do |entry|
      location, frequency = entry
      builder.frequency :lat => location.lat, :long => location.long, :frequency => frequency, :distance_from_home => location.distance_from_home
    end
  end

  File.new('xml/frequency_distributions.xml', 'w+').puts frequency_distributions
end

def dump_distance_frequencies
  distance_frequencies = builder.frequencies do | builder |
    @distance_frequencies.each do |entry|
      distance_range, frequency = entry
      builder.frequency :range => distance_range.end, :frequency => frequency
    end
  end

  File.new('xml/distance_distributions.xml', 'w+').puts distance_frequencies
end

def dump_tab_delimited_distances
  tab_delim_distances = @distances.inject("date\tdistance\n") do |t, entry|
    date, location = entry
    t << location.to_tab_delimited_line( [:date, :distance_from_home] )
  end

  File.new( "tabs/greatest_distances.tsv", "w+" ).puts tab_delim_distances
end

def dump_tab_delimited_distance_frequencies
  tab_delim_distances = @distance_frequencies.inject("range\tfrequency\n") do |t, entry|
    distance_range, frequency = entry
    t << "#{distance_range.end}\t#{frequency}\n"
  end

  File.new( "tabs/distance_frequencies.tsv", "w+" ).puts tab_delim_distances
end

def dump_all
  dump_all_locations
  dump_unique_locations
  dump_frequency_distributions
  dump_distance_frequencies
  
  dump_tab_delimited_distances
  dump_tab_delimited_distance_frequencies
end

load_readings
dump_all
