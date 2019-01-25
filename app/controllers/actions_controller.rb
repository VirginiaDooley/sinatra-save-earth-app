class ActionsController < ApplicationController

  #Create
  get "/actions/new" do
    @users = User.all
    erb :"/actions/new.html"
  end

  post "/actions/create" do
    @action = Action.create(params[:action])
    actions = Action.all
    user = User.find(session[:user_id])
    user.id = @action.user_id
    if !params["action"]["action_name"].empty?
      user.actions << Action.create(action_name: params["action"]["action_name"], status: params["action"]["status"])
    end

    redirect "/actions/#{@action.id}"
  end

  get "/actions/:id" do
    @action = Action.find(params[:id])
    erb :"/actions/show.html"
  end

  #Update
  get "/actions/:id/edit" do
    @action = Action.find(params[:id])
    @users = User.all
    erb :"/actions/edit.html"
  end

  get "/actions" do
    @actions = Action.all
    erb :"/actions/index.html"
  end

  patch "/actions/:id" do
    redirect '/actions/:id'
  end

  #Delete
  delete "/actions/:id/delete" do
    redirect '/actions'
  end

end
