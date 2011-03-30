class PublicSiteData
  def initialize(app, message = "Public Site Data")
    @app = app
  end
  
  def call(env)
    # get the site name from the other middleware
    request = Rack::Request.new(env)
    site_name = request.session["site"].name
    
    # check if there is a static file, if yes, return it.
    path = Rack::Utils.unescape(env["PATH_INFO"])
    if path != "/" && File.exists?("#{Rails.root}/sites/#{site_name}#{path}")
      return Rack::File.new("sites/#{site_name}").call(env)
    end
    @status, @headers, @response = @app.call(env)
    return [@status, @headers, self]
  end
  
  def each(&block)
    @response.each(&block)
  end
end
