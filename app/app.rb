require 'sinatra/base'
ENV['RACK_ENV'] ||= 'development'
require_relative 'models/data_mapper_setup'


class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super_secret'

  get '/' do
    redirect(:links)
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/add_link' do
    erb(:add_link)
  end

  post '/add_link' do

    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split(",").each do |tag_name|
      tag = Tag.create(name: tag_name)
      link.tags << tag
      link.save
    end
    redirect(:links)
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    user = User.create(name: params[:name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/links'
    else
      redirect '/sign_up'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
