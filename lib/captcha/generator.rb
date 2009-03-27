module Captcha
  class Generator
    def initialize
      generate
    end
  
    def generate
      return unless Config.options
      return if Config.last_modified && Config.last_modified > Time.now - Config.options[:generate_every]
      FileUtils.mkdir_p Config.options[:destination]
      (1..Config.options[:count]).each do |x|
        c = Image.new Config.options
        File.open("#{Config.options[:destination]}/#{Cipher.encrypt(c.code)}.jpg", 'w') do |f|
          f << c.image
        end
      end
      destroy_if_over_limit
      GC.start
    end
    
    def destroy_if_over_limit
      if Config.codes.length >= Config.options[:count] * 3
        Config.captchas_ordered_by_modified[(Config.options[:count] * 2)..-1].each do |file|
          FileUtils.rm_f(file)
        end
      end
    end
  end
end