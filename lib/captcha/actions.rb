module CaptchaActions

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_captcha
      include CaptchaActions::InstanceMethods
    end
  end

  module InstanceMethods
    def index
      new unless session[:captcha]
      send_file "#{RAILS_ROOT}/public/images/captchas/#{session[:captcha]}.jpg", :type => 'image/jpeg', :disposition => 'inline'
    end

    def new
      files = Dir["#{RAILS_ROOT}/public/images/captchas/*.jpg"]
      session[:captcha] = File.basename(files[rand(files.length)], '.jpg')
      index
    end
  end
  
end