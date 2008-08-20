require 'rubygems'
require 'mechanize'
require 'builder'
require 'date'
require 'logger'
require 'digest/sha1'
require 'classes'

LOG = Logger.new STDERR

class RtScraper
  
  TODAY     = Date.today
  BASE_URL  = "http://www.rescuetime.com"
  APPS_URL  = "/details/apps"
  Q         = "?view_type=date&"
  
  attr_accessor :categories
  
  def initialize email, password, start_date=Date.parse('07/29/2008')
    LOG.debug "Today is #{TODAY.to_s}. Scraping Rescue Time for #{email}"
    @e = email
    @p = password
    @d = start_date
    @w = WWW::Mechanize.new
    @w.user_agent_alias = 'Mac Safari'
    self.categories = {}
  end
  
  def rescue_time io=STDOUT
    login
    while page = page_for_date(@d) do
      LOG.debug("reached #{@d.to_s} - quitting") and break if @d > TODAY
      @d += 1
      next if (page/"center").inner_html == "Sorry - there are no Apps or Sites to display for this time period."
      scrape page
    end
    builder = Builder::XmlMarkup.new :target => io, :indent => 2
    builder.categories do
      categories.each do |a|
        key, category = a
        category.to_xml( {:builder => builder} )
      end
    end
  end
  
  def login
    LOG.debug "Logging in"
    page = @w.get "#{BASE_URL}"
    page.forms[0].email = @e
    page.forms[0].password = @p
    @w.submit page.forms[0]
  end
  
  def scrape page
    (page/"li[@class='detail_even']").each do |element|
      c = category( element )
      a = app( element )
      d = duration( element )
      categories[c] ||= Category.new( c )
      categories[c].log_app App.new(a, d), @d
      LOG.debug "#{a} in #{c} #{d}"
    end

    (page/"li[@class='detail_odd']").each do |element|
      c = category( element )
      a = app( element )
      d = duration( element )
      categories[c] ||= Category.new( c )
      categories[c].log_app App.new(a, d), @d
      LOG.debug "#{a} in #{c} #{d}"
    end
  end
  
  def page_for_date date
    LOG.debug "loading page for #{date.to_s}"
    page = @w.get "#{BASE_URL}#{APPS_URL}#{Q}#{q_for_date(date)}"
  end
  
  def q_for_date date
    "month=#{date.month}&year=#{date.year}&day=#{date.day}"
  end
  
  def app element
    (element/"strong").at("a").inner_html
  end
  
  def duration element
    duration_s = (element/"span[@class='duration]").inner_html
    duration_s.sub!(/\((.*)\)/) {|match| $1 }
    hours   = duration_s.match(/(\d*)h/).captures[0] rescue 0
    minutes = duration_s.match(/(\d*)m/).captures[0] rescue 0
    seconds = duration_s.match(/(\d*)s/).captures[0] rescue 0
    hours   = (hours.nil?) ? 0 : hours.to_i
    minutes = (minutes.nil?) ? 0 : minutes.to_i
    seconds = (seconds.nil?) ? 0 : seconds.to_i
    # return a duration in terms of seconds
    (hours * 3600) + (minutes * 60) + (seconds)
  end
  
  def category element
    element.search("span")[1].at("a").inner_html rescue "No Category"
  end
  
end