# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

site = Site.create(:name => "Default", :layout => 'default')
domain = Domain.create(:name => "localhost", :site_id => site.id)
user = User.create(:email => "chris@chrisreister.com", :password => "change0", :password_confirmation => "change0", :username => "chris", :permission_mask => 255)

