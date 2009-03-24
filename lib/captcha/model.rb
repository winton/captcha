module Captcha
  module Model
    def self.included(base)
      base.extend ActMethods
    end
    
    module ActMethods
      def acts_as_captcha(validation_error="text does not match the text in the image.")
        extend ClassMethods
        include InstanceMethods
        attr_reader :captcha, :known_captcha
        cattr_accessor :captcha_validation_error
        self.captcha_validation_error = validation_error
        instance_variable_set(:@captcha_validation_error, validation_error)
        validate :captcha_must_match_known_captcha
      end
    end
  
    module ClassMethods
    end
  
    module InstanceMethods
      def captcha=(c)
        @captcha = c || ''
      end
      
      def known_captcha=(c)
        @known_captcha = c || ''
      end
      
      def captcha_must_match_known_captcha
        return true if self.captcha.nil? || self.known_captcha.nil?
        if self.captcha.strip.downcase != self.known_captcha.strip.downcase
          if self.captcha_validation_error.nil?
            self.errors.add_to_base("Enter the correct text in the image (6 characters)")
          else
            self.errors.add(:captcha, self.captcha_validation_error)
          end
        end
      end
    end
  end
end