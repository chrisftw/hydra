class Admin::DomainsController < ApplicationController
  before_filter :requires_site_admin_login
  
  # GET /domains
  # GET /domains.xml
  def index
    @domains = Domain.all

    respond_to do |format|
      format.html # index.html.erb
   #   format.xml  { render :xml => @domains }
    end
  end

  # GET /domains/1
  # GET /domains/1.xml
  def show
    @domain = Domain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
   #   format.xml  { render :xml => @domain }
    end
  end

  # GET /domains/new
  # GET /domains/new.xml
  def new
    @domain = Domain.new
    @site_select = current_user.all_sites_select
    
    respond_to do |format|
      format.html # new.html.erb
   #   format.xml  { render :xml => @domain }
    end
  end

  # GET /domains/1/edit
  def edit
    @domain = Domain.find(params[:id])
    @site_select = current_user.all_sites_select
  end

  # POST /domains
  # POST /domains.xml
  def create
    params[:domain][:site_id] ||= uber_page_site.id
    @domain = Domain.new(params[:domain])
    
    respond_to do |format|
      if @domain.save
        format.html { redirect_to([:admin, @domain], :notice => 'Domain was successfully created.') }
     #   format.xml  { render :xml => @domain, :status => :created, :location => @domain }
      else
        format.html { render :action => "new" }
     #   format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /domains/1
  # PUT /domains/1.xml
  def update
    @domain = Domain.find(params[:id])
    puts params.inspect
    puts @domain.inspect
    params[:domain][:site_id] ||= uber_page_site.id
    respond_to do |format|
      if @domain.update_attributes(params[:domain])
        puts "----"
        puts @domain.inspect
        format.html { redirect_to([:admin, @domain], :notice => 'Domain was successfully updated.') }
      #  format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
     #   format.xml  { render :xml => @domain.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.xml
  def destroy
    @domain = Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to(admin_domains_url) }
    #  format.xml  { head :ok }
    end
  end
end
