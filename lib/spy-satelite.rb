require 'pusher'

module Rack
  class SpySatelite
    def initialize(app, args)
      
      puts args.inspect
      
      Pusher.app_id = args[:id]
      Pusher.key    = args[:key]
      Pusher.secret = args[:secret]

      @app = app       
    end                

    def call(env)
      lat = rand(180)-90
      long = rand(360)
      Pusher['visitors'].trigger('new-visit', {:lat => lat, :long => long})
      @app.call(env)   
    end                
  end
end