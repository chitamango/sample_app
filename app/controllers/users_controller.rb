class UsersController < ApplicationController
  #check that an user must sign in before edit and update
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :signed_in_user_redirect, only: [:new, :create] 

  def new
      
  		  @user = User.new

  end

  def index
      #@users = User.all
      @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save.
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user

    else
      render 'new'
    end
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #handle a successfuk update

      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user


    else
        render 'edit'
    end


  end

  def destroy

     @user =  User.find(params[:id])

     if @user.admin?

      redirect_to root_path

     else

      @user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url

    end

  end

  private

    ##since need to use in micropost controller thus moved it to session helper

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def signed_in_user_redirect

      if signed_in?   
      
        redirect_to(root_path)

       end 

    end  


end
