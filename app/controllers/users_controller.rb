class UsersController < ApplicationController

  get "/users" do
    if logged_in?
      erb :"/users/index.html"
    else
      erb :"/users/failure.html"
    end
  end

  #Create
  get "/users/signup" do
    erb :"users/signup.html"
  end

  post "/users/signup" do
  #does not let a user sign up with a empty field
    if params[:username] == "" || params[:password] == ""
      redirect 'users/failure'
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect '/users'
    end
  end

  #Read

  get "/users/login" do
    erb :"users/login.html"
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "users"
	  else
	    redirect "users/failure"
	  end
  end

  get '/users/:id' do
   # @user = User.find(session[:user_id])
   erb :"/users/show.html"
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
    #ADD FLASH MESSAGE HERE TO CONFIRM EDIT
    redirect "/users/show"
  end

  get "/logout" do
   session.clear
   redirect "/"
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
