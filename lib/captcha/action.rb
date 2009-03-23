module Captcha
  module Action

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_captcha
        include Captcha::Action::InstanceMethods
        self.around_filter CaptchaFilter.new
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
  
    private
  
    class CaptchaFilter
      def before(controller)
        @captcha = session[:captcha]
      end
      def after(controller)
        if session[:captcha] != @captcha
          session[:captcha] = @captcha
        end
      end
    end
  
  end
end