class ApplicationController < Sinatra::Base
  use Rack::MethodOverride

  set :views, MyApplication.views_path
  set :public_folder, MyApplication.public_folder
end
