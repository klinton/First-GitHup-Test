class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @title = "Sign Up"
  end

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #If save succeeded, redirect to user_path 
      # Note: Rspec only recognizes  user_path(@user), used @user here.
      flash[:success] = "Welcome to the SampleApp!" 
      redirect_to @user
    else
      @title = "Sign Up"
      render :new
    end
  end
  
end
