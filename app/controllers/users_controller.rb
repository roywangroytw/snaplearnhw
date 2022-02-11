class UsersController < ApplicationController

  def signup
    @user = User.new
  end

  def registering
    @user = User.new(permit_parmas)

    if @user.save
      redirect_to '/', notice: "註冊成功!"
    else
      render :signup, alert: "抱歉好像出錯了，請再嘗試一次"
    end
  end

  def login
  end

  def verifying
  end

  def logout
  end

  private

  def permit_parmas
    params.require(:user).permit(:username, :password, :email, :course_creator)
  end

end
