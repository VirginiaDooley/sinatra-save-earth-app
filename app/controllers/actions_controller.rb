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
    @user = current_user
    @action = Action.create(params[:action])
    @user.actions << @action
    session[:user_id] = @action.user_id
    redirect "/actions/#{@action.id}"
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
  get "/actions/:id/edit" do
    #need to replace session user_id with action id
    # @action = Action.find(session[:user_id])
    @action = Action.find(params[:id])
    @users = User.all
    erb :"/actions/edit.html"
  end

  patch "/actions/:id" do
    @action = Action.find(params[:id])
    @action.update(params[:action])
    @action.save
    redirect "/actions/#{@action.id}"
  end

  #Delete
  delete "/actions/:id/delete" do
    redirect '/actions'
  end

end
