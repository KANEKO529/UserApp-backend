# サインアップ、サインイン、サインアウトを実行するAPIコントローラー
# 
# Auth::RegistrationsControllerクラスはDeviseTokenAuth::RegistrationsControllerを継承する
class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private

  def sign_up_params
    # サインアップ時に登録できるカラムを指定
    params.permit(:email, :password, :password_confirmation)
  end
end
