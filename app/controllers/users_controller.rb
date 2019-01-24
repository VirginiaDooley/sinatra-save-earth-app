class UsersController < ApplicationController

  get "/users" do
    erb :"/users/index.html"
  end

  #Create
  get "/users/signup" do
    erb :"users/signup.html"
  end

  post "/users/signup" do
  #does not let a user sign up with a empty field
    if params[:username] == "" || params[:password] == ""
      redirect 'users/failure.html'
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect '/users/show'
    end
  end

  #Read
  get "/users/show" do
    user = User.find(session[:user_id])
    erb :"/users/show.html"
  end

  get "/users/login" do
    erb :"users/login.html"
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "users/show"
	  else
	    redirect "users/failure"
	  end
  end

  #Update
  get "/users/:id/edit" do
    user = User.find(session[:user_id])
    session[:user_id] = user.id

    erb :"/users/edit.html"
  end

  #Patch
  patch "/users/:id" do
    user = User.find(session[:user_id])
    session[:user_id] = user.id
    user.username = params[:username]
    user.save

    redirect "/users/show"
  end

  #Delete
  # delete "/users/:id/delete" do
  #   user = User.find(session[:user_id])
  #   session[:user_id] = user.id
  #   user.delete
  #
  #   redirect "welcome"
  # end

  #Helpers to check current session
  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
end
