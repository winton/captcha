module Captcha
  class Config
    
    PRODUCTION = defined?(RAILS_ENV) && RAILS_ENV == 'production' || RAILS_ENV == 'staging'
    ROOT = defined?(RAILS_ROOT) ? "#{RAILS_ROOT}/" : ''
    
    @@options = {
      :colors => {
        :background => '#FFFFFF',
        :font => '#080288'
      },
      # number of captcha images to generate
      :count => PRODUCTION ? 500 : 10,
      :destination => "#{ROOT}public/images/captchas",
      :dimensions => {
        # canvas height (px)
        :height => 32,
        # canvas width (px)
        :width => 110
      },
      :generate_every => PRODUCTION ? 24 * 60 * 60 : 10 ** 8,
      # http://www.imagemagick.org/RMagick/doc/image2.html#implode
      :implode => 0.2,
      :letters => {
        # text baseline (px)
        :baseline => 25,
        # number of letters in captcha
        :count => 6,
        :ignore => ['a','e','i','o','u','l','j','q'],
        # font size (pts)
        :points => 38,
        # width of a character (used to decrease or increase space between characters) (px)
        :width => 17
      },
      :ttf => File.expand_path("#{File.dirname(__FILE__)}/../../resources/captcha.ttf"),
      # http://www.imagemagick.org/RMagick/doc/image3.html#wave
      :wave => {
        # range is used for randomness (px)
        :wavelength => (40..70),
        # distance between peak and valley of sin wave (px)
        :amplitude => 3
      }
    }
    
    def initialize(options={})
      @@options.merge!(options)
    end
    
    def self.captchas_ordered_by_modified
      return unless @@options
      files_modified = Dir["#{@@options[:destination]}/*.jpg"].collect do |file|
        [ file, File.mtime(file) ]
      end
      # Youngest to oldest
      files_modified.sort! { |a, b| b[1] <=> a[1] }
      files_modified.collect { |f| f[0] }
    end
  
    def self.codes
      self.captchas_ordered_by_modified.collect do |f|
        File.basename f, '.jpg'
      end
    end
  
    def self.options
      @@options
    end
  
    def self.last_modified
      youngest = self.captchas_ordered_by_modified.first
      youngest ? File.mtime(youngest) : nil
    end
  end
end