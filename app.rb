require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'

class Gloo < Sinatra::Base
  # include DataMapper::Resource

  get '/' do
    # Bookmarks.all
    erb :index
  end

  get '/add-link' do
    erb :add_link
  end

  post '/link-form' do
    # Bookmarks.create(url: params[:url])
    redirect '/link_confirmation'
  end

  get '/link_confirmation' do
    erb :link_confirmation
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
