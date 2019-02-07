class ActionsController < ApplicationController

  #Create
  get "/actions/new" do
    if logged_in?
      # @user = current_user
      erb :"/actions/new.html"
    else
      redirect "/"
    end
  end

  post "/actions/create" do
    #
    # @user = current_user
    # @actions = Action.all
    @action = Action.new(params[:action])
    @action.user = current_user
    if @action.save
      # @action.user << @action
      # session[:user_id] = @action.user_id
      flash[:message] = "You successfully created an action."
      redirect "/actions/#{@action.id}"
    else
      flash[:message] = "You cannot create a blank action. Please try again."
      redirect "/actions/new"
    end
  end

  #Read
  get "/actions" do
    @actions = Action.all
    erb :"/actions/index.html"
  end

  get "/actions/:id" do
    @action = Action.find(params[:id])
    if logged_in? && current_user
      erb :"/actions/show.html"
    else
      redirect "/actions"
    end
  end

  #Update
  get "/actions/:id/edit" do
    @action = Action.find(params[:id])
    @users = User.all
    if logged_in? && @action.user == current_user
      erb :"/actions/edit.html"
    else
      flash[:message] = "You cannot edit this action."
      redirect '/actions'
    end
  end

  patch "/actions/:id" do
    @action = Action.find(params[:id])
    @action.update(params[:action])
    @action.save
    flash[:message] = "Your update was successful."
    redirect "/actions/#{@action.id}"
  end

  #Delete
  delete "/actions/:id" do
    @action = Action.find_by_id(params[:id])
    if logged_in? && @action.user == current_user
      @action.delete
      flash[:message] = "Your action has been deleted."
      redirect "/actions"
    else
      redirect "/actions/#{@action.id}"
    end
  end

end
