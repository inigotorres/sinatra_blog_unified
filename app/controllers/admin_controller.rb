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

  get '/admin/messages_view' do
    protected!

    @messages = Message.all order: :id.desc
    erb :messages_view
  end

  get '/admin/post_submit' do
    protected!

    erb :post_submit
  end

  get '/admin/posts_view' do
    protected!

    @blog_posts = BlogPost.all order: :id.desc
    erb :posts_view
  end

  get '/admin/post_edit/:id' do
    protected!

    @b = BlogPost.get params[:id]
    erb :post_edit
  end

  post '/admin/post_submit/post_sent' do
    protected!

    b = BlogPost.new
    b.title = params[:title]
    b.author = params[:author]
    b.content = params[:content]
    b.url_title = params[:title].downcase.gsub(" ","_")

    raise 'The post title has been already used for another entry.' unless b.save
    erb :post_submitted
  end

  put '/admin/post_edit/post_updated/:id' do
    protected!

    b = BlogPost.get params[:id]
    raise 'The post title has been already used for another entry.' unless b.update(
      title: params[:title], 
      author: params[:author], 
      content: params[:content], 
      url_title: params[:title].downcase.gsub(" ","_")
    )
    erb :post_updated
  end

  delete '/admin/message_delete/:id' do
    protected!

    m = Message.get params[:id]
    m.destroy
    redirect '/admin/messages_view'
  end

  delete '/admin/post_delete/:id' do
    protected!

    b = BlogPost.get params[:id]
    comments_for_b = Comment.all(blog_post_id: params[:id])

    b.destroy
    comments_for_b.each do |comment|
      comment.destroy
    end 
    redirect '/admin/posts_view'
  end

  delete '/admin/comment_delete/:id' do
    c = Comment.get params[:id]
    blog_post_id = c.blog_post_id

    c.destroy

    redirect "/admin/post_edit/#{blog_post_id}"
  end
end
