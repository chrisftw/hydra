class PageController < ApplicationController
  layout :get_layout
  
  def index
    puts "CONTROLLER PARAMS= #{params.inspect}"
    @page = Page.get_page(params[:page])
    @title = @page.title if @page
    puts "IN SHOW!!!"
    puts @page.inspect
    render :action => :error if @page.nil?
  end
  
  def error
    @page = Page.new(:title => "Error")
  end

  private
  def get_layout
    normal_layout = uber_page_site && uber_page_site.layout
    return normal_layout || "application"
  end

end
