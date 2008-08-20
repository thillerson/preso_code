#! /usr/bin/env ruby
require 'rubygems'
require 'yahoo/local_search'

sf_zips = %w{ 94102 94103 94104 94105 94107 94108 94109 94110 94111 94112 94114 94115 94116 94117 94118 94121 94122 94123 94124 94127 94129 94131 94132 94133 94134 }

searcher = Yahoo::LocalSearch.new 'MdEylgfV34FwTWjRKLazU3sdX47QGnG7GvUpq8DpsQP_GAj5ZVNRcTT0Gz3.n5s-'
f = File.open('bars_in_sf.xml', 'w+')
visited = {}

f.puts '<bars>'
sf_zips.each do |zipcode|
  bars = searcher.locate 'bar', zipcode, 20
  bars[0].each do |bar|
    f.puts "\t<bar title=\"#{bar.title}\" address=\"#{bar.address}\" lat=\"#{bar.latitude}\" long=\"#{bar.longitude}\" />" unless visited[bar.title]
    visited[bar.title] = true
  end
end
f.puts '</bars>'
