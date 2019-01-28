class ActionsController < ApplicationController

  #Create
  get "/actions/new" do
    if logged_in?
      @user = current_user
      erb :"/actions/new.html"
    else
      redirect 'users/failure.html'
    end
  end

  post "/actions/create" do
    @action = Action.create(params[:action])

    redirect "/actions/#{@action.id}"

  end

  #Update
  get "/actions/:id/edit" do
    @action = Action.find(session[:user_id])

    erb :"/actions/edit.html"
  end

  #Read
  get "/actions/:id" do
    @action = Action.find(params[:id])
    erb :"/actions/show.html"
  end

  get "/actions" do
    @actions = Action.all
    erb :"/actions/index.html"
  end

  #Update
  patch "/actions/:id" do
    @action = Action.find(params[:id])
      @action.update(params[:action])
    redirect "/actions/#{@action.id}"
  end

  #Delete
  delete "/actions/:id/delete" do
    redirect '/actions'
  end

end
