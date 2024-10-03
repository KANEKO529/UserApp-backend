# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable,
        :confirmable # ← confirmableを追加する
  # usersテーブルを作った際のあったmigrationファイル内の
  # confirmableの部分が有効となるよという意味
  include DeviseTokenAuth::Concerns::User
end
