class UsersController < ApplicationController

  #Create
  # GET: /users/signup
  get "/users/signup" do
    erb :"users/signup.html"
  end

  # POST: /users/signup
  post "/users/signup" do
  # searches for User params and authenticates
    # user = User.find_by(username: params[:username], password: params[:password])
    # session[:user_id] = user.id
    # if user && user.authenticate(params[:password])
	  #   session[:user_id] = user.id
	  #   redirect "users/login"
	  # else
	  #   redirect "users/failure"
	  # end
    #   redirect "users/account"

    if params[:username] == "" || params[:password] == ""
      redirect 'users/failure.html'
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect '/users/account'
    end
  end

  # GET: /users/account/5
  get "/users/account" do
    user = User.find(session[:user_id])
    erb :"/users/account.html"
  end

  get "/users/login" do
    erb :login
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "users/account"
	  else
	    redirect "users/failure"
	  end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
