class UsersController < ApplicationController

  #Create
  get "/users/signup" do
    erb :"users/signup.html"
  end

  post "/users/signup" do
    user = User.create(params)
    session[:user_id] = user.id
    redirect '/users'
  end

  #Read
  get "/users" do
    if logged_in?
      @user = current_user
      erb :"/users/index.html"
    else
      erb :"/users/failure.html"
    end
  end

  get "/users/login" do
    erb :"users/login.html"
  end

  post "/users/login" do
    user = User.find_by(username: params[:username])

	  if user && user.authenticate(params[:password])
	    session[:user_id] = user.id
	    redirect "users"
	  else
	    redirect "users/failure"
	  end
  end

  get '/users/:id' do
    if logged_in? && current_user
      erb :"/users/show.html"
    else
      redirect "/users/failure"
    end
  end

  #Update
  get "/users/:id/edit" do
    user = User.find(session[:user_id])
    session[:user_id] = user.id

    erb :"/users/edit.html"
  end

  patch "/users/:id" do
    user = User.find(session[:user_id])
    session[:user_id] = user.id
    user.username = params[:username]
    if user.save
      flash[:message] = "Your update was successful."
      redirect "/users/show"
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
