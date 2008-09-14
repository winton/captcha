require 'RMagick'

class Captcha
  
  include Magick
  attr_reader :code, :image
  
  def initialize(options)
    @code = generate_code options
    
    canvas = Magick::ImageList.new
    canvas.new_image(options[:width], options[:height]) { self.background_color = options[:colors][:background] }
    
    text = Magick::Draw.new
    text.font = File.expand_path options[:ttf]
    text.pointsize = options[:letters][:points]
    
    cur = 0
    @code.each { |c|
      text.annotate(canvas, 0, 0, cur, options[:letters][:baseline], c) { self.fill = options[:colors][:font] }
      cur += options[:letters][:width]
    }
    
    w = options[:wave][:wavelength]
    canvas = canvas.wave(options[:wave][:amplitude], rand(w.last - w.first) + w.first)
    canvas = canvas.implode(options[:implode])
    
    @code  = @code.to_s
    @image = canvas.to_blob { self.format = "JPG" }
  end
  
  def generate_code(options)
    chars = ('a'..'z').to_a - options[:letters][:ignore]
    code_array = []
    1.upto(options[:letters][:count]) { code_array << chars[rand(chars.length)] }
    code_array
  end
  
  def self.generate(bind, startup=false)
    options = nil
    if File.exists?('config/captcha.rb')
      options = eval(File.read('config/captcha.rb'), bind)
    end
    
    puts startup && !options[:generate_on_startup]
    return if startup && !options[:generate_on_startup]

    if options
      FileUtils.rm_rf options[:destination]
      FileUtils.mkdir_p options[:destination]
      (1..10).each do |x|
        c = Captcha.new options
        File.open("#{options[:destination]}/#{c.code}.jpg", 'w') do |f|
          f << c.image
        end
      end
      GC.start
    end
  end
end