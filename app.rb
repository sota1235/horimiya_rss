require 'sinatra'
require 'sinatra/base'

require_relative 'models/init'

class Server < Sinatra::Base
  get '/' do
    content_type 'text/xml'
    @body = make_rss
  end
end
