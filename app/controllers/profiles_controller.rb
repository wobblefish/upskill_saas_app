class ProfilesController < ApplicationController
  # GET request to users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # POST request to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile ( profile_params )
    if @profile.save
      flash[:success] = "Profile is updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET requests made to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PATCH to /users/:user_id/profile
  def update
    # Retrieve the user from the database
    @user = User.find( params[:user_id] )
    @profile = @user.profile
    # Mass assign edited profile attributes and save (Update)
    if @profile.update_attributes( profile_params )
      flash[:success] = "Profile updated!"
      # Redirect the user to their profile page
      redirect_to user_path(id: params[:user_id] )
    else
      render action: edit
    end
  end
  
  # Whitelisted profile fields
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
  
end