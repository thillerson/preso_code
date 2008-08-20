module IDifier
  attr_accessor :id
  
  def id!
    self.id = Digest::SHA1.hexdigest( name )[0..8]
  end
  
end

class Category
  include IDifier
  
  attr_accessor :name
  attr_accessor :apps
  
  def initialize name, apps={}
    self.name = name
    self.apps = apps
    id!
  end
  
  def log_app app, date
    apps[date] ||= []
    apps[date] << app
  end

  def to_xml options={}
    options[:builder] ||= Builder::XmlMarkup.new
    options[:builder].category :id => id, :name => name do
      apps.keys.each do |date|
        options[:builder].date :date => "#{date.strftime( '%m/%d/%Y' )}" do
          apps[date].each do |app|
            app.to_xml options
          end
        end
      end
    end
  end
  
end

class App
  include IDifier

  attr_accessor :name
  attr_accessor :duration
  
  def initialize name, duration
    self.name = name
    self.duration = duration
    id!
  end
  
  def to_xml options
    options[:builder] ||= Builder::XmlMarkup.new
    options[:builder].app :id => id, :name => name, :duration => duration
  end
  
end

