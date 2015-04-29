require 'peertransfer/sinatra/logging'

class ApplicationController < Sinatra::Base
  register Peertransfer::Sinatra::Logging

  set :views, MyApplication.views_path
  set :public_folder, MyApplication.public_folder
  set :logger, MyApplication.logger

  not_found do
    html_path = File.join(settings.public_folder, '404.html')
    File.read(html_path)
  end

  error do
    raise request.env['sinatra.error'] if self.class.test?

    log_exception(request.env['sinatra.error'])
    File.read(File.join(settings.public_folder, '500.html'))
  end
end
