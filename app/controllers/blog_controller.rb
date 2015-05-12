require 'sinatra'
require 'rubygems'

require 'models/main_models.rb'

class BlogController < ApplicationController
  get '/blog/:url_title' do
    @b = BlogPost.first(url_title: params[:url_title])
    erb :post_view_single
  end
end
