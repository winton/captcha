# named capture.rb because of config/captcha.rb

Dir[File.expand_path('*/*.rb', File.dirname(__FILE__))].each do |f|
  require [ File.dirname(f), File.basename(f, '.rb') ].join('/')
end

ActionController::Base.send :include, CaptchaActions
Captcha.generate binding, true