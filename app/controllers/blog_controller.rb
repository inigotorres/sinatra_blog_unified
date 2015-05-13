require 'sinatra'
require 'rubygems'
require 'pony'

require 'models/main_models.rb'

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
      Pony.mail to: 'itorres@peertransfer.com',
                from: 'no_response_please@peertransfer.com',
                subject: 'New comment in your blog',
                body: "New comment in your blog! Received at #{c.created_at} from #{c.author} on the post '#{blog_post.title}'."
    end
 
    redirect "/blog/#{blog_post.url_title}"
  end
end
