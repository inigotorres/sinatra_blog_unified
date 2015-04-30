require 'sinatra'
require 'rubygems'
class FreestyleController < ApplicationController
  get '/' do
    erb :main
  end
end
