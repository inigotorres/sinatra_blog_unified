require 'peertransfer/settings'
require 'peertransfer/logger'

module MyApplication
  class << self
    def root
      File.dirname(__FILE__) + '/..'
    end

    def env
      Peertransfer::Settings.env
    end

    def logger
      return @logger if @logger

      log_path = File.join(root, 'log', "#{env}.log")
      @logger = Peertransfer::Logger.new(log_path)
    end

    def views_path
      root + '/app/views'
    end

    def public_folder
      root + '/public'
    end
  end
end
