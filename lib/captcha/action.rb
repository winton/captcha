module Captcha
  module Action

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_captcha
        unless included_modules.include? InstanceMethods
          include InstanceMethods 
        end
        before_filter :assign_captcha
      end
    end

    module InstanceMethods
      private
      
      def assign_captcha
        unless session[:captcha] && Captcha::Config.exists?(session[:captcha])
          files = Captcha::Config.captchas
          session[:captcha] = File.basename(files[rand(files.length)], '.jpg')
        end
      end
      
      def reset_captcha
        session[:captcha] = nil
        assign_captcha
      end
    end
  
  end
end