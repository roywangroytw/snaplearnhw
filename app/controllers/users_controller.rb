class UsersController < ApplicationController

  def signup
    @user = User.new
  end

  def registering
    @user = User.new(permit_params)

    if @user.save
      redirect_to '/', notice: "註冊成功!"
    else
      render :signup, alert: "抱歉好像出錯了，請再嘗試一次"
    end
  end

  def login
    @user = User.new
  end

  def verifying
    user = User.login(permit_params)
    if user
      session[:session] = user.id
      redirect_to '/', notice: "登入成功"
    else
      render :login, alert: "帳號密碼組合不正確，請重新嘗試"
    end
  end

  def logout
  end

  private

  def permit_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :course_creator)
  end

end
