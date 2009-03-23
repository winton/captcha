require 'captcha'
if File.exists?("#{RAILS_ROOT}/lib/captcha_config.rb")
  require "#{RAILS_ROOT}/lib/captcha_config"
end

ActionController::Base.send :include, Captcha::Action
Captcha::Generator.new