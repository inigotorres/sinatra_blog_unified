require 'sinatra'
require 'rubygems'

require 'models/main_models.rb'

class AdminController < ApplicationController
  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
    end
  end

  get '/admin' do
    protected!

    erb :admin_page
  end

  get '/admin/view_messages' do
    protected!

    @messages = Message.all order: :id.desc
    erb :messages_view
  end

  get '/admin/submit_post' do
    protected!

    erb :post_submit
  end

  get '/admin/delete_post' do
    protected!

    @blog_posts = BlogPost.all order: :id.desc
    erb :post_delete
  end

  get '/admin/post_edit/:id' do
    protected!

    @b = BlogPost.get params[:id]
    erb :post_edit
  end

  post '/admin/submit_post/post_sent' do
    protected!

    b = BlogPost.new
    b.title = params[:title]
    b.author = params[:author]
    b.content = params[:content]

    erb :post_submitted if b.save
  end

  put '/admin/post_edit/post_updated/:id' do
    protected!

    b = BlogPost.get params[:id]
    if b.update(title: params[:title], author: params[:author], content: params[:content])
      erb :post_updated
    end
  end

  delete '/admin/message_delete/:id' do
    protected!

    m = Message.get params[:id]
    m.destroy
    redirect '/admin/view_messages'
  end

  delete '/admin/post_delete/:id' do
    protected!

    b = BlogPost.get params[:id]
    b.destroy
    redirect '/admin/delete_post'
  end
end
