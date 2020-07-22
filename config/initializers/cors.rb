# Be sure to restart your server when you modify this file.
# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:8000'

    resource '*', headers: :any, methods: %i[get post put patch delete options head]
  end
end
