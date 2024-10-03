# config/application.rb は、Railsアプリケーションの全体的な設定を行うファイルです。
# このファイルにCORS設定を記載することで、
# アプリケーションの起動時に一度だけ読み込まれ
# 、すべてのリクエストに対して適用されるようになります。
# セッション管理やクッキーと連携するCORS設定は
# 、cors.rb よりも application.rb に記載する方が適切。


require_relative "boot"

require "rails/all"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # ここからコピペする
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options
    config.middleware.use ActionDispatch::Flash
    
    config.middleware.insert_before 0, Rack::Cors do
      allow do
      #  今回はRailsのポートが3001番、Reactのポートが3000番にするので、Reactのリクエストを許可するためにlocalhost:3000を設定
        origins 'localhost:3000'
        resource '*',
          :headers => :any,
          # この一文で、渡される、'access-token'、'uid'、'client'というheaders情報を用いてログイン状態を維持する。
          :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get, :post, :options, :delete, :put]
      end
    end
        # ここまで
  end
end
