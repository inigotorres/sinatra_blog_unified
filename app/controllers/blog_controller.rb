require 'sinatra'
require 'rubygems'

require 'models/main_models.rb'
require 'lib/mailer.rb'

class BlogController < ApplicationController
  get '/blog/:url_title' do
    @b = BlogPost.first(url_title: params[:url_title])
    erb :post_view_single
  end

  post '/blog/leave_comment/:blog_post_id' do
    c = Comment.new
    c.blog_post_id = params[:blog_post_id]
    c.author = params[:author] unless params[:author].empty?
    c.content = params[:content]
    blog_post = BlogPost.get(params[:blog_post_id])
    blog_post.comments << c

    if blog_post.save
      Mailer::send_email('New comment in your blog', "New comment in your blog! Received at #{c.created_at} from #{c.author} on the post '#{blog_post.title}'.")
    end
 
    redirect "/blog/#{blog_post.url_title}"
  end
end
