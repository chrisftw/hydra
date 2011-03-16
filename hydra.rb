require 'goliath'
require 'em-synchrony/em-http'
 
class Hydra < Goliath::API
  use Goliath::Rack::Params             # parse query & body params
  use Goliath::Rack::Formatters::JSON   # JSON output formatter
  use Goliath::Rack::Render             # auto-negotiate response format
  use Goliath::Rack::ValidationError    # catch and render validation errors
  use Goliath::Rack::Validation::RequiredParam, {:key => 'query'}
 
  #def response(env)
  #  gh = EM::HttpRequest.new("http://github.com/api/v2/json/repos/search/#{params['query']}").get
  #  logger.info "Received #{gh.response_header.status} from Github"
 
  #  [200, {'X-Goliath' => 'Proxy'}, gh.response]
  #end
end