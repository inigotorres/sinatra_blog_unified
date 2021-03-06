require 'controllers/application_controller'
require 'controllers/freestyle_controller'
require 'controllers/about_controller'
require 'controllers/admin_controller'
require 'controllers/blog_controller'

module MyApplication
  class Dispatcher
    def call(env)
      path_info = env['PATH_INFO']

      app = FreestyleController.new
      app = AboutController.new if path_info =~ %r"/about"
      app = AdminController.new if path_info =~ %r"/admin"
      app = BlogController.new if path_info =~ %r"/blog"

      app.call(env)
    end
  end
end
