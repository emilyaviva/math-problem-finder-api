# This app runs in API-only mode
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end
