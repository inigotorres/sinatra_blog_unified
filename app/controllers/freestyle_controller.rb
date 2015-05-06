require 'sinatra'
require 'rubygems'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/main_database.db")

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
end
