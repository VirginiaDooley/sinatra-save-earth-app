class ActionsController < ApplicationController

  # GET: /actions
  get "/actions" do
    @actions = Actions.all
    erb :"/actions/index.html"
  end

  # GET: /actions/new
  get "/actions/new" do
    @users = User.all
    erb :"/actions/new.html"
  end

  # POST: /actions
  post "/actions" do
    action = Action.create(action_name: params[:action_name], status: params[:status])
    session[:action_id] = action.id
    redirect "actions/#{@action.id}"
  end

  # GET: /actions/5
  get "/actions/:id" do
    erb :"/actions/show.html"
  end

  # GET: /actions/5/edit
  get "/actions/:id/edit" do
    erb :"/actions/edit.html"
  end

  # PATCH: /actions/5
  patch "/actions/:id" do
    redirect "/actions/:id"
  end

  # DELETE: /actions/5/delete
  delete "/actions/:id/delete" do
    redirect "/actions"
  end
end
