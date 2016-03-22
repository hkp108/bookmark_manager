require 'sinatra/base'
require './app/models/bookmarks'

class Gloo < Sinatra::Base
  # include DataMapper::Resource

  get '/' do
    @bookmarks = Bookmarks.all

    erb :index
  end

  get '/add-link' do
    erb :add_link
  end

  post '/link-form' do
    p params
    Bookmarks.create(url: params[:url], title: params[:title])
    redirect '/link_confirmation'
  end

  get '/link_confirmation' do
    erb :link_confirmation
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
