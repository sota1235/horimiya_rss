require 'sinatra'
require 'sinatra/base'
require 'haml'

class Server < Sinatra::Base
  get '/' do
    haml :index
  end
end
