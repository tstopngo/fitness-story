class UsersController < ApplicationController

  # GET: /login
  get "/login" do
    if logged_in?
      current_user
      redirect "/users/#{current_user.username}"
    else
      erb :"/users/login.html"
    end
  end

  get "/loginexisting" do
    if logged_in?
      current_user
      redirect "/users/#{current_user.username}"
    else
      erb :"/users/loginexisting.html"
    end
  end

  # POST: /login
  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "users/#{@user.username}"
    else
      redirect "/users/new"
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
    if params.values.each.include?("")
        redirect '/users/new'
    else
      if User.find_by_slug(params[:username]) || User.find_by(:email => params[:email])
          redirect '/loginexisting'
      else
        @user = User.create(:email => params[:email], :username => params[:username], :password => params[:password], :title => "Noob", :exp => 500)
        session[:user_id] = @user.id
        @user.authenticate(params[:password])
        redirect "users/#{@user.username}"
      end
    end
  end

  # GET: /users/username
  get "/users/:id" do
    if !logged_in?
      redirect '/'
    else
      @user = User.find_by_slug(params[:id])
      @entries = Entry.all.select{|entry| entry.user.id == @user.id}
      erb :"/users/show.html"
    end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    if !logged_in?
      redirect "/login"
    else
      @user = User.find_by_slug(params[:id])
      if @user == current_user
        erb :"/users/edit.html"
      else
        redirect "/users/#{@user.username}"
      end
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find_by_slug(params[:id])
      if params[:email].empty?
        redirect to "/users/#{@user.id}/edit"
      else
          if @user == current_user
            @user.update(:email => params[:email])
          end
      end
    redirect "/users/#{@user.username}"
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end



end
