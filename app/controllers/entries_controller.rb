class EntriesController < ApplicationController

  # GET: /entries
  get "/entries" do
    @entries = Entry.all
    erb :"/entries/index.html"
  end

  # GET: /entries/new
  get "/entries/new" do
    if !logged_in?
      redirect "/login"
    else
      erb :"/entries/new.html"
    end
  end

  # POST: /entries
  post "/entries" do
    if !logged_in?
      redirect "/login"
    else
        if params.values.each.empty?
          redirect "/entries/new"
        else
          @entry = Entry.create(:workout_calories => params[:workout_calories], :food_calories => params[:food_calories], :net_calrories => (params[:food_calories]-params[:workout_calories]), :food => params[:food], :user_id => current_user.id)
          redirect "/entries/#{@entry.id}"
        end
      redirect "/entries"
    end
  end

  # GET: /entries/5
  get "/entries/:id" do
    if !logged_in?
      redirect "/login"
    else
      @entry = Entry.find_by_id(params[:id])
      erb :"/entries/show.html"
  end

  # GET: /entries/5/edit
  get "/entries/:id/edit" do
    if !logged_in?
    redirect '/login'
  else
    @entry = Entry.find_by_id(params[:id])
      if @entry && @entry.user == current_user
        erb :"/entries/edit.html"
      else
        redirect "/users/#{@entry.user.username}"
      end
    end
  end

  # PATCH: /entries/5
  patch "/entries/:id" do
    if !logged_in?
      redirect '/login'
    else
      @entry = Entry.find_by_id(params[:id])
      if params.values.each.empty?
        redirect to "/entries/#{@entry.id}/edit"
      else
          if @tweet && @tweet.user == current_user
            @tweet.update(:content => params[:content])
          end
      end
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  # DELETE: /entries/5/delete
  delete "/entries/:id/delete" do
    @tweet = Tweet.find_by_id(params[:id])
  if !logged_in?
    redirect '/login'
  else
    if @tweet.user == current_user
      @tweet.delete
    end
  redirect '/tweets'
  end
    redirect "/entries"
  end
end
