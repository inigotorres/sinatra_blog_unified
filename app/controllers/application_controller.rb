class ApplicationController < Sinatra::Base
  set :views, MyApplication.views_path
  set :public_folder, MyApplication.public_folder
end
