class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end
  #

  def changed
    puts('sign in and out user here')
  end

  protected

  def after_resetting_password_path_for(resource)
    changed_user_password_path
  end

end
