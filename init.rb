require 'captcha'
if defined?(RAILS_ROOT) && File.exists?("#{RAILS_ROOT}/lib/captcha_config.rb")
  require "#{RAILS_ROOT}/lib/captcha_config"
end

ActionController::Base.send :include, Captcha::Action
ActiveRecord::Base.send :include, Captcha::Model