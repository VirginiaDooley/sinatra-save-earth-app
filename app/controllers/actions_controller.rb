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
  get "/actions" do
    @actions = Action.all
    erb :"/actions/index.html"
  end

  get "/actions/:id" do
    @action = Action.find(params[:id])
    if logged_in?
      erb :"/actions/show.html"
    else
      redirect '/'
    end
  end

  #Update
  get "/actions/:id/edit" do
    @action = Action.find(params[:id])
    @users = User.all
    if logged_in? && @action.user == current_user
      erb :"/actions/edit.html"
    else
      redirect '/actions'
    end
  end

  patch "/actions/:id" do
    @action = Action.find(params[:id])
    if logged_in? && @action.user == current_user
      @action.update(params[:action])
      @action.save
      flash[:message] = "Your update was successful."
      redirect "/actions/#{@action.id}"
    else
      redirect "/actions/#{@action.id}/edit"
    end
  end

  #Delete
  delete "/actions/:id" do
    @action = Action.find_by_id(params[:id])
    if logged_in? && @action.user == current_user
      @action.delete
      redirect "/actions"
    else
      "This is not your action. You cannot delete it."
      redirect "/actions/#{@action.id}"
    end
  end

 end
