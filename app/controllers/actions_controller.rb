class ActionsController < ApplicationController

  get "/actions" do
    erb :"/actions/index.html"
  end

  get "/actions/new" do
    @users = User.all
    erb :"/actions/new.html"
  end

  post "/actions/create" do
    binding.pry
    action = Action.create(action_name: params[:action_name], status: params[:status])
    session[:action_id] = action.id

    redirect "/actions/#{action.id}"
  end

  get "/actions/:id" do
    action = Action.find(params[:id])
    erb :"/actions/show.html"
  end

  get "/actions/:id/edit" do
    erb :"/actions/edit.html"
  end

  patch "/actions/:id" do
    redirect '/actions/:id'
  end

  delete "/actions/:id/delete" do
    redirect '/actions'
  end
end
