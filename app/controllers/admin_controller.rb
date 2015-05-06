require 'sinatra'
require 'rubygems'
require 'controllers/about_controller'

class AdminController < ApplicationController
  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end
  end

  get '/admin' do
    protected!

    erb :admin_page
  end

  get '/admin/view_messages' do
    protected!
  
    @messages = AboutController::Message.all :order => :id.desc
    erb :messages_view
  end
end
