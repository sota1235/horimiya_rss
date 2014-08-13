require 'sinatra'
require 'sinatra/base'

require_relative 'models/init'

class Server < Sinatra::Base
  get '/' do
    f = File::stat('./cache/rss.xml')
    ft = f.mtime.to_s.slice(0..18).gsub(/-|:/, ' ').split(' ').map{|i| i.to_i}
    n_time = Time.now
    f_time = Time.local(ft[0], ft[1], ft[2], ft[3], ft[4], ft[5])
    save_time = 60 * 30 # cacheをキープする時間

    content_type 'text/xml'
    if (n_time - f_time) >= save_time
      @body = make_rss
    else
      @body = File.open('./cache/rss.xml').read
    end
  end
end
