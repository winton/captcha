module Captcha
  class Generator
    def initialize
      generate
    end
  
    def generate
      return unless Config.options
      return if Config.last_modified && Config.last_modified > Time.now - Config.options[:generate_every]
      path = Config.options[:destination]
      Config.captchas.each do |captcha|
        FileUtils.rm_f captcha
      end
      FileUtils.mkdir_p path
      (1..Config.options[:count]).each do |x|
        image = Image.new Config.options
        path = "#{Config.options[:destination]}/#{Cipher.encrypt(image.code)}.jpg"
        next if File.exists?(path)
        File.open(path, 'w') do |f|
          f << image.data
        end
      end
      GC.start
    end
  end
end