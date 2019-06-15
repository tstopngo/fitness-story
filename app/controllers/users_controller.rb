class UsersController < ApplicationController

  # GET: /login
  get "/login" do
    if logged_in?
      redirect "/users/:id"
    else
      erb :"/users/login.html"
    end
  end

  # POST: /login
  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "users/#{@user.username}"
    else
      redirect "/login"
    end
  end

  # GET: /users/new
  get "/users/new" do
    if logged_in?
      redirect "/users/#{session[:user_id]}"
    else
      erb :"/users/new.html"
    end
  end

  # POST: /users/new
  post "/users/new" do
    @user = User.find_by(:username => params[:username], :email => params[:user])
    if @user
      redirect '/login'
    else
      if params.values.each.include?("")
        redirect '/signup'
      else
        @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password])
        session[:user_id] = @user.id
        @user.autenticate(params[:password])
        redirect "users/#{@user.username}"
      end
    end
  end

  # GET: /users/username
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end



end
