class UsersController < ApplicationController

  # GET: /users
  # get "/users" do
  #   erb :"/users/index.html"
  # end

  #Create
  # GET: /users/signup
  get "/users/signup" do
    erb :"users/signup.html"
  end

  # POST: /users/signup
  post "users/signup" do
  # searches for User params and authenticates
    @user = User.find_by(email: params[:email], password: params[:password])

    if @user && @user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "/login"
	  else
	    redirect "/failure"
	  end
      redirect "/account"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/account.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
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
