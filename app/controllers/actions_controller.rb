class ActionsController < ApplicationController

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

  #Update
  get "/actions/:id/edit" do
    @action = Action.find(params[:id])
    @users = User.all
    erb :"/actions/edit.html"
  end

  get "/actions" do
    @user = User.find(session[:user_id])
    @actions = Action.all
    erb :"/actions/index.html"
  end

  get "/actions/:id" do
    @action = Action.find(params[:id])
    erb :"/actions/show.html"
  end

  patch "/actions/:id" do
    redirect '/actions/:id'
  end

  #Delete
  delete "/actions/:id/delete" do
    redirect '/actions'
  end

end
