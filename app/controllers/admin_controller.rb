require 'sinatra'
require 'rubygems'
require 'controllers/about_controller'
require 'controllers/freestyle_controller'

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

  delete '/admin/delete/:id' do
    protected!
    
    m = AboutController::Message.get params[:id]
    m.destroy
    redirect '/admin/view_messages'
  end

  get '/admin/submit_post' do
    protected!

    erb :post_submit
  end

  post '/admin/submit_post/post_sent' do
    protected!

    b = FreeStyleController::Blog_Post.new
    b.title = params[:title]
    b.author = params[:author]
    b.content = params[:content]
    
    if b.save
      erb :post_submitted
    else
      erb :post_submission_error
    end
  end
end
