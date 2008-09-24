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
    def new
      files = Dir["#{RAILS_ROOT}/#{CAPTCHAS.options[:destination]}/*.jpg"]
      @captcha = File.basename(files[rand(files.length)], '.jpg')
      show
    end
    
    def show
      new unless @captcha
      send_file "#{RAILS_ROOT}/#{CAPTCHAS.options[:destination]}/#{@captcha}.jpg", :type => 'image/jpeg', :disposition => 'inline'
    end
  end
  
end