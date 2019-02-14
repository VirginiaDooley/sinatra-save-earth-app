class ActionsController < ApplicationController

  get "/actions/new" do
    if logged_in?
      erb :"/actions/new.html"
    else
      redirect "/"
    end
  end

  post "/actions" do
    @action = Action.new(params[:action])
    @action.user = current_user
    if @action.save
      flash[:message] = "You successfully created an action."
      redirect "/actions/#{@action.id}"
    else
      flash[:message] = "You cannot create a blank action. Please try again."
      erb :"/actions/new.html"
    end
  end

  get "/actions" do
    @actions = Action.all
    erb :"/actions/index.html"
  end

  get "/actions/:id" do
    @action = Action.find(params[:id])
    if logged_in? && @action.user == current_user
      erb :"/actions/show.html"
    else
      redirect '/actions'
    end
  end

  get "/actions/:id/edit" do
    @action = Action.find(params[:id])
    @users = User.all
    if logged_in? && @action.user == current_user
      erb :"/actions/edit.html"
    else
      flash[:message] = "You do not own this action."
      redirect '/users/show'
    end
  end

  patch "/actions/:id" do
    @action = Action.find(params[:id])
    @action.update(params[:action])
    if @action.save
      flash[:message] = "Your update was successful."
      redirect "/actions/#{@action.id}"
    else
      flash[:message] = "Please try again."
      erb :"/actions/edit.html"
    end
  end

  delete "/actions/:id" do
    @action = Action.find_by_id(params[:id])
    if @action.delete
      # logged_in? && @action.user == current_user

      flash[:message] = "Your action has been deleted."
      redirect "/actions"
    else
      redirect "/actions/#{@action.id}"
    end
  end

end
