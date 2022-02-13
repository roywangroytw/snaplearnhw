module ApiV0
  class Base < Grape::API
    version 'v0', using: :path
    include ApiV0::ExceptionHandlers
    helpers ::ApiV0::Helpers
    use ApiV0::Auth::Middleware
    mount Ping
  end
end