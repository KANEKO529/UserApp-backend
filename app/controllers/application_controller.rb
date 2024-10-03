class ApplicationController < ActionController::API
        
        # この一文で、SetUserByTokenという拡張機能を使える様になる。
        # これは、Cookie や CORS の設定ができるようになるということ。
        include DeviseTokenAuth::Concerns::SetUserByToken
end
