require 'sinatra'
require 'rubygems'
require 'data_mapper'
require 'pony'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/main_database.db")

class AboutController < ApplicationController
  class Message
    include DataMapper::Resource
    property :id, Serial
    property :name, Text
    property :email, Text, :required => true
    property :subject, Text
    property :content, Text, :required => true
    property :created_at, DateTime
  end

  DataMapper.finalize.auto_upgrade!

  get '/about' do
    erb :about
  end

  post '/about/message_sent' do
    m = Message.new
    m.name = params[:name]
    m.email = params[:email]
    m.subject = params[:subject]
    m.content = params[:content]

    if m.save
      Pony.mail :to => 'itorres@peertransfer.com', 
		:from => 'no_response_please@peertransfer.com', 
		:subject => 'New message in your blog',
		:body => "New message in your blog! Received at #{m.created_at} from #{m.name} with email #{m.email} and subject #{m.subject}"
      erb :message_sent
    else
      erb :message_send_error
    end
  end
end
