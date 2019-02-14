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
    if logged_in?
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
    if logged_in? && current_user.id == params[:id].to_i
      @user = User.find(params[:id])
      erb :"/users/show.html"
    else
      flash[:message] = "You cannot access accounts that do not belong to you."
      erb :"/users/index.html"
    end
  end

  get "/logout" do
    session.clear
    redirect '/'
  end

end
