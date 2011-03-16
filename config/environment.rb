# Load the rails application
require File.expand_path('../application', __FILE__)

require "#{Rails.root}/middleware/init"

# Initialize the rails application
Hydra::Application.initialize!
