class UsersController < ApplicationController

  def signup
    @user = User.new
  end

  def registering
    @user = User.new(permit_params)

    if @user.save
      user = User.login(permit_params)
      session[:session] = user.id
      ApiAccessToken.create(user: user)
      redirect_to '/', notice: "歡迎加入SnapLearn，開始你的學習之旅吧～"
    else
      render :signup, alert: "抱歉好像出錯了，請再嘗試一次"
    end
  end

  def login
    @user = User.new
  end

  def verifying

    if params[:user][:username] == "" || params[:user][:password] == ""
      redirect_to :login, alert: "帳號密碼必填唷!"
    else   
      user = User.login(permit_params)
      if user
        session[:session] = user.id
        redirect_to '/', notice: "登入成功"
      else
        redirect_to :login, alert: "帳號密碼組合不正確，請重新嘗試"
      end
    end

  end

  def logout
    session[:session] = nil
    redirect_to '/', notice: "登出成功，下次見!"
  end

  private

  def permit_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :course_creator)
  end

end
