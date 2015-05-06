require 'controllers/application_controller'
require 'controllers/freestyle_controller'
require 'controllers/about_controller'

module MyApplication
  class Dispatcher
    def call(env)
      path_info = env['PATH_INFO']

      app = FreestyleController.new
      app = AboutController.new if path_info =~ %r"/about"

      app.call(env)
    end
  end
end
