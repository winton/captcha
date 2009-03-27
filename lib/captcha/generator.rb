module Captcha
  class Generator
    def initialize
      generate
    end
  
    def generate
      return unless Config.options
      return if Config.last_modified && Config.last_modified > Time.now - Config.options[:generate_every]
      path = Config.options[:destination]
      if File.exists?(path)
        FileUtils.rm_rf Config.options[:destination]
      end
      FileUtils.mkdir_p Config.options[:destination]
      (1..Config.options[:count]).each do |x|
        image = Image.new Config.options
        path = "#{Config.options[:destination]}/#{Cipher.encrypt(image.code)}.jpg"
        next if File.exists?(path)
        File.open(path, 'w') do |f|
          f << image.data
        end
      end
      Config.expire!
      GC.start
    end
  end
end