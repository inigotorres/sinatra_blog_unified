require 'sinatra'
require 'rubygems'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog_posts.db")

class FreestyleController < ApplicationController
  class Blog_Post
    include DataMapper::Resource
    property :id, Serial
    property :title, String, :required => true
    property :author, String, :required => true
    property :content, Text, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
  end

  DataMapper.finalize.auto_upgrade!

  get '/' do
    @blog_posts = Blog_Post.all :order => :id.desc

    erb :main
  end

  get '/submit_post' do
    erb :submit
  end

  post '/submit_post/post_sent' do
    b = Blog_Post.new
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
