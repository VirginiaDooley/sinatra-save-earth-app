class UsersController < ApplicationController

  #Create
  get "/users/signup" do
    erb :"users/signup.html"
  end

  post "/users/signup" do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect '/users'
    else
      user.errors.full_messages.uniq
    end
  end

  #Read
  get "/users" do
    if logged_in? && current_user
      erb :"/users/index.html"
    else
      redirect '/'
    end
  end

  get "/users/login" do
    erb :"users/login.html"
  end

  post "/users/login" do
    user = User.find_by(username: params[:username])
  	  if user && user.authenticate(params[:password])
  	    session[:user_id] = user.id
  	    redirect '/users'
  	  else
        flash[:message] = "Please try again."
        redirect '/users/login'
  	  end
  end

  get '/users/:id' do
    if logged_in? && current_user
      erb :"/users/show.html"
    else
      flash[:message] = "You cannot access user accounts that don't below to you."
      redirect '/'
    end
  end

  #Update
  get "/users/:id/edit" do
    @user = User.find(session[:user_id])
    session[:user_id] = @user.id
    if logged_in? && current_user
      erb :"/users/edit.html"
    else
      flash[:message] = "Don't you dare."
      redirect '/'
    end
  end

  patch "/users/:id" do
    user = User.find(session[:user_id])
    session[:user_id] = user.id
    user.username = params[:username]
    if logged_in? && current_user
    user.save
      flash[:message] = "Your update was successful."
      redirect '/users/show'
    else
      flash[:message] = "Your update was successful."
      redirect '/users/failure'
    end
  end

  get "/logout" do
    session.clear
    redirect '/'
  end

end
