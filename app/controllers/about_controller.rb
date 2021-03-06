require 'sinatra'
require 'rubygems'

require 'lib/mailer.rb'
require 'models/main_models.rb'

class AboutController < ApplicationController
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
      Mailer::send_email('New message in your blog',  "New message in your blog! Received at #{m.created_at} from #{m.name} with email #{m.email} and subject #{m.subject}")
      erb :message_sent
    end
  end
end
