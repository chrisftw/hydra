class GatherSite
  def initialize(app, message = "Gather Site")
    @app = app
  end
  
  def call(env)
    request = Rack::Request.new(env)
    domain_name = request.env["SERVER_NAME"]
    site = Site.current(domain_name)
    puts "RUNNING MIDDLEWARE"
    request.session["site"] = site
    @status, @headers, @response = @app.call(env)
    return [@status, @headers, self]
  end
  
  def each(&block)
    @response.each(&block)
  end
end
