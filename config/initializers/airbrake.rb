if Peertransfer::Settings[:errors][:api_key].present?
  require 'airbrake'

  settings = Peertransfer::Settings[:errors]

  Airbrake.configure do |config|
    config.api_key = settings[:api_key]
    config.environment_name = MyApplication.env

    if settings[:host].present?
      config.host = settings[:host]
    end

    if (secure = settings[:secure]).present?
      config.secure = secure.is_a?(String) ? secure.to_boolean : secure
    end
  end
end
