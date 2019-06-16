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
        if params.values.each.include?("")
          redirect "/entries/new"
        else
          net_calories = params[:food_calories].to_i - params[:workout_calories].to_i
          @entry = Entry.create(:workout_calories => params[:workout_calories].to_i, :food_calories => params[:food_calories].to_i, :net_calories => net_calories, :food => params[:food], :user_id => current_user.id)
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
      if params.values.each.include?("")
        redirect to "/entries/#{@entry.id}/edit"
      else
          if @entry && @entry.user == current_user
            @entry.update(:workout_calories => params[:workout_calories].to_i, :food_calories => params[:food_calories].to_i, :net_calories => (params[:food_calories].to_i-params[:workout_calories].to_i), :food => params[:food])
          end
      end
      redirect "/entries/#{@entry.id}"
    end
  end

  # DELETE: /entries/5/delete
  delete "/entries/:id/delete" do
    @entry = Entry.find_by_id(params[:id])
  if !logged_in?
    redirect '/login'
  else
    if @entry.user == current_user
      @entry.delete
    end
  redirect "/users/#{@entry.user.username}"
  end
    redirect "/entries"
  end
end
