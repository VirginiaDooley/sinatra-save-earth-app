class ActionsController < ApplicationController

  get "/actions" do
    erb :"/actions/index.html"
  end

  #Create
  get "/actions/new" do
    @users = User.all
    erb :"/actions/new.html"
  end

  post "/actions/create" do
    action = Action.create(action_name: params[:action_name], status: params[:status])
    session[:action_id] = action.id

    redirect "/actions/#{action.id}"
  end

  #Read
  get "/actions/:id" do
    action = Action.find(params[:id])
    @actions = Action.all
    erb :"/actions/show.html"
  end

  #Update
  get "/actions/:id/edit" do
    erb :"/actions/edit.html"
  end

  patch "/actions/:id" do
    redirect '/actions/:id'
  end

  #Delete
  delete "/actions/:id/delete" do
    redirect '/actions'
  end
end
