require 'sinatra/base'
ENV['RACK_ENV'] ||= 'development'
require_relative 'models/data_mapper_setup'
require 'sinatra/flash'


class BookmarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super_secret'
  register Sinatra::Flash

  get '/' do
    redirect(:links)
  end

  get '/links' do
    @links = Link.all
    flash[:signed_in]
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

  get '/sign-in' do
    erb :sign_in
  end

  post '/sign-in' do
    # p authenticated_user
    # p params
    if User.authenticate(email: params[:email], password: params[:password])
      session[:user_id] = authenticated_user.id
      flash.next[:signed_in] = "Successfully signed in as #{authenticated_user.email}"
       redirect '/links'
    else
      flash.now[:errors] = "Invalid email or password. Please try again."
      erb :sign_in
    end
  end

  get '/sign_up' do
    @user = User.new
    erb :sign_up
  end

  post '/sign_up' do
    @user = User.new(name: params[:name],
                     email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/links'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :sign_up
    end
  end

  helpers do
    def current_user
      @current_user = User.get(session[:user_id])
    end

  end

  private
  def authenticated_user
    User.authenticate(email: params[:email], password: params[:password])
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
