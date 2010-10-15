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
#      flash fails!
#      flash[:success] = "Welcome" 
      #If save succeeded, redirect to user_path 
      # Note: Rspec only recognizes  user_path(@user), used @user here.
      redirect_to @user
    else
      @title = "Sign Up"
      @user.password = nil
      @user.password_confirmation = nil
      render :new
    end
  end
  
end
