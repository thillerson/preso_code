#!/usr/bin/env ruby
require 'rt_scraper'

email = ARGV[0]
pass = ARGV[1]

rt = RtScraper.new email, pass
fh = File.open("#{email}.xml", 'w+')
rt.rescue_time fh