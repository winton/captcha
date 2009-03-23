module Captcha
  module Action

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_captcha
        include Captcha::Action::InstanceMethods
      end
    end

    module InstanceMethods
      def new
        files = Dir["#{Captcha::Config.options[:destination]}/*.jpg"]
        session[:captcha] = File.basename(files[rand(files.length)], '.jpg')
        redirect_to(:action => :show)
      end
    
      def show
        new and return unless session[:captcha]
        send_file(
          "#{Captcha::Config.options[:destination]}/#{session[:captcha]}.jpg",
          :disposition => 'inline',
          :type => 'image/jpeg'
        )
      end
    end
  
  end
end