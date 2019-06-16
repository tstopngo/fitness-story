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
    redirect "/entries"
  end

  # GET: /entries/5
  get "/entries/:id" do
    erb :"/entries/show.html"
  end

  # GET: /entries/5/edit
  get "/entries/:id/edit" do
    erb :"/entries/edit.html"
  end

  # PATCH: /entries/5
  patch "/entries/:id" do
    redirect "/entries/:id"
  end

  # DELETE: /entries/5/delete
  delete "/entries/:id/delete" do
    redirect "/entries"
  end
end
