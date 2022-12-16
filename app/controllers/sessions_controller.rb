class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     session[:user_id] = user.id
     flash[:notice] = "ログインに成功しました"
     redirect_to user
    else
     flash.now[:alert] = "入力情報に間違いが含まれます、もう一度お願いします"
     render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to root_path
  end

end
