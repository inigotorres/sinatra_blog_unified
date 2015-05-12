require 'sinatra'
require 'rubygems'

require 'models/main_models.rb'

class BlogController < ApplicationController
  get '/blog/:url_title' do
    @b = BlogPost.first(url_title: params[:url_title])
    @comments_for_post = Comment.all(blog_post_id: @b.id)
    erb :post_view_single
  end

  post '/blog/leave_comment/:blog_post_id' do
    c = Comment.new
    c.blog_post_id = params[:blog_post_id]
    c.author = params[:author]
    c.content = params[:content]
    c.save

    blog_post = BlogPost.get(params[:blog_post_id])
    redirect "/blog/#{blog_post.url_title}"
  end
end
