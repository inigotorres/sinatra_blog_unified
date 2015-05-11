require 'sinatra'
require 'rubygems'

require 'models/main_models.rb'

class FreestyleController < ApplicationController
  get '/' do
    @blog_posts = BlogPost.all :order => :id.desc

    erb :main
  end
end
